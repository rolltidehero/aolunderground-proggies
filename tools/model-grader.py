#!/usr/bin/env python3
"""model-grader.py — Run N Bedrock models as code review critics, then Opus 4.6 Extended grades them.

Usage:
    python3 tools/model-grader.py --file path/to/code.py [--tier big|small|all] [--dry-run]
"""
from __future__ import annotations

import argparse
import json
import logging
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path

import requests

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from generic_claude_api import get_config

logger = logging.getLogger(__name__)

BIG_MODELS = [
    ("mistral.mistral-large-3-675b-instruct", "Mistral-Large-3"),
    ("qwen.qwen3-coder-next", "Qwen3-Coder-Next"),
    ("qwen.qwen3-32b-v1:0", "Qwen3-32B"),
    ("openai.gpt-oss-120b-1:0", "GPT-oss-120B"),
    ("moonshotai.kimi-k2.5", "Kimi-K2.5"),
    ("minimax.minimax-m2.5", "MiniMax-M2.5"),
    ("zai.glm-5", "GLM-5"),
    ("google.gemma-3-27b-it", "Gemma-3-27B"),
    ("mistral.devstral-2-123b", "Devstral-2-123B"),
]

SMALL_MODELS = [
    ("qwen.qwen3-coder-30b-a3b-v1:0", "Qwen3-Coder-30B"),
    ("openai.gpt-oss-20b-1:0", "GPT-oss-20B"),
    ("google.gemma-3-12b-it", "Gemma-3-12B"),
    ("google.gemma-3-4b-it", "Gemma-3-4B"),
    ("mistral.ministral-3-14b-instruct", "Ministral-14B"),
    ("mistral.ministral-3-8b-instruct", "Ministral-8B"),
    ("mistral.ministral-3-3b-instruct", "Ministral-3B"),
    ("nvidia.nemotron-super-3-120b", "Nemotron-Super-120B"),
    ("nvidia.nemotron-nano-3-30b", "Nemotron-Nano-30B"),
    ("zai.glm-4.7-flash", "GLM-4.7-Flash"),
    ("moonshot.kimi-k2-thinking", "Kimi-K2-Thinking"),
]

KAGI_MODELS = [
    ("grok-4-20-thinking", "Grok-4.20"),
    ("gpt-5-4", "GPT-5.4"),
    ("gemini-3-pro", "Gemini-3-Pro"),
]

REVIEWER_MODEL = "us.anthropic.claude-opus-4-6-v1"
CONVERSE_TIMEOUT = 120
PROMPTS_DIR = Path(__file__).resolve().parents[1] / "prompts"

# Models that need a specific region (not available in all regions)
MODEL_REGION_OVERRIDES = {
    "qwen.qwen3-coder-next": "us-east-1",
}


def setup_logging(verbose: bool = False) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def extract_converse_text(content_blocks: list[dict]) -> str:
    """Extract text from Converse API response content blocks."""
    parts = []
    for block in content_blocks:
        if "text" in block:
            parts.append(block["text"])
        elif "reasoningContent" in block:
            rt = block["reasoningContent"].get("reasoningText", {})
            if "text" in rt:
                parts.append(rt["text"])
    return "\n".join(parts)


def call_bedrock_converse(model_id: str, system_prompt: str,
                          user_prompt: str, max_tokens: int = 4096) -> dict:
    """Call a Bedrock model via the Converse API with bearer token."""
    token = get_config("AWS_BEARER_TOKEN_BEDROCK")
    if not token:
        return {"text": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": 0, "error": "No AWS_BEARER_TOKEN_BEDROCK"}

    default_region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
    region = MODEL_REGION_OVERRIDES.get(model_id, default_region)
    url = f"https://bedrock-runtime.{region}.amazonaws.com/model/{model_id}/converse"

    body = {
        "system": [{"text": system_prompt}],
        "messages": [{"role": "user", "content": [{"text": user_prompt}]}],
        "inferenceConfig": {"maxTokens": max_tokens},
    }
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}",
    }

    t0 = time.time()
    try:
        resp = requests.post(url, json=body, headers=headers, timeout=CONVERSE_TIMEOUT)
        elapsed = time.time() - t0
        if resp.status_code != 200:
            return {"text": "", "input_tokens": 0, "output_tokens": 0,
                    "elapsed_s": elapsed, "error": f"HTTP {resp.status_code}: {resp.text[:200]}"}
        data = resp.json()
        content = data.get("output", {}).get("message", {}).get("content", [])
        usage = data.get("usage", {})
        return {
            "text": extract_converse_text(content),
            "input_tokens": usage.get("inputTokens", 0),
            "output_tokens": usage.get("outputTokens", 0),
            "elapsed_s": elapsed,
            "error": None,
        }
    except requests.exceptions.ReadTimeout:
        return {"text": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": time.time() - t0, "error": "TIMEOUT"}
    except Exception as e:
        return {"text": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": time.time() - t0, "error": f"{type(e).__name__}: {str(e)[:100]}"}


def call_opus_extended_thinking(system_prompt: str, user_prompt: str,
                                max_tokens: int = 16000,
                                thinking_budget: int = 10000) -> dict:
    """Call Opus 4.6 with extended thinking via Anthropic Messages API on Bedrock."""
    token = get_config("AWS_BEARER_TOKEN_BEDROCK")
    if not token:
        return {"text": "", "thinking": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": 0, "error": "No AWS_BEARER_TOKEN_BEDROCK"}

    default_region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
    url = f"https://bedrock-runtime.{default_region}.amazonaws.com/model/{REVIEWER_MODEL}/invoke"

    body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": max_tokens,
        "thinking": {
            "type": "enabled",
            "budget_tokens": thinking_budget,
        },
        "system": system_prompt,
        "messages": [{"role": "user", "content": user_prompt}],
    }
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}",
    }

    t0 = time.time()
    try:
        resp = requests.post(url, json=body, headers=headers, timeout=300)
        elapsed = time.time() - t0
        if resp.status_code != 200:
            return {"text": "", "thinking": "", "input_tokens": 0, "output_tokens": 0,
                    "elapsed_s": elapsed,
                    "error": f"HTTP {resp.status_code}: {resp.text[:300]}"}
        data = resp.json()
        usage = data.get("usage", {})
        thinking_text = ""
        response_text = ""
        for block in data.get("content", []):
            if block.get("type") == "thinking":
                thinking_text += block.get("thinking", "")
            elif block.get("type") == "text":
                response_text += block.get("text", "")
        return {
            "text": response_text,
            "thinking": thinking_text,
            "input_tokens": usage.get("input_tokens", 0),
            "output_tokens": usage.get("output_tokens", 0),
            "elapsed_s": elapsed,
            "error": None,
        }
    except requests.exceptions.ReadTimeout:
        return {"text": "", "thinking": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": time.time() - t0, "error": "TIMEOUT (300s)"}
    except Exception as e:
        return {"text": "", "thinking": "", "input_tokens": 0, "output_tokens": 0,
                "elapsed_s": time.time() - t0, "error": f"{type(e).__name__}: {str(e)[:200]}"}


def run_critic(model_id: str, label: str, system_prompt: str,
               user_prompt: str, output_dir: Path, use_kagi: bool = False) -> dict:
    """Run one critic model. Saves result to disk. Returns result dict."""
    logger.info("Starting critic: %s%s", label, " (Kagi)" if use_kagi else "")

    if use_kagi:
        result = call_kagi_model(model_id, system_prompt, user_prompt)
    else:
        result = call_bedrock_converse(model_id, system_prompt, user_prompt)

    result["model_id"] = model_id
    result["label"] = label
    out_file = output_dir / f"critic_{label}.txt"
    out_file.write_text(result["text"] or f"ERROR: {result['error']}", encoding="utf-8")
    status = "OK" if not result["error"] else f"FAIL: {result['error']}"
    logger.info("  %s: %s | %d chars | %.1fs | in=%d out=%d",
                label, status, len(result["text"]), result["elapsed_s"],
                result["input_tokens"], result["output_tokens"])
    return result


def call_kagi_model(model_id: str, system_prompt: str, user_prompt: str) -> dict:
    """Call a model via Kagi Assistant API. Returns same dict format as call_bedrock_converse."""
    from tools.lib.kagi_client import send_and_scrape, load_session

    t0 = time.time()
    try:
        session = load_session()
        prompt = f"{system_prompt}\n\n{user_prompt}"
        text = send_and_scrape(prompt, model_id, session, internet=False)
        elapsed = time.time() - t0
        return {
            "text": text,
            "input_tokens": 0,  # Kagi doesn't report tokens
            "output_tokens": 0,
            "elapsed_s": elapsed,
            "error": None if text and len(text) > 50 else "Empty or too short response",
        }
    except Exception as e:
        return {
            "text": "",
            "input_tokens": 0,
            "output_tokens": 0,
            "elapsed_s": time.time() - t0,
            "error": f"{type(e).__name__}: {str(e)[:100]}",
        }


def run_all_critics(models: list[tuple[str, str]], system_prompt: str,
                    user_prompt: str, output_dir: Path,
                    use_kagi: bool = False) -> list[dict]:
    """Run all critic models in parallel."""
    results = []
    with ThreadPoolExecutor(max_workers=len(models)) as pool:
        futures = {
            pool.submit(run_critic, mid, label, system_prompt, user_prompt,
                        output_dir, use_kagi): label
            for mid, label in models
        }
        for f in as_completed(futures):
            results.append(f.result())
    return results


def build_grader_prompt(code: str, filename: str, critic_results: list[dict]) -> str:
    """Build the user prompt for the Opus 4.6 grader."""
    reviews = []
    for r in critic_results:
        if r["error"]:
            reviews.append(f"=== {r['label']} ===\nERROR: {r['error']}\n")
        else:
            reviews.append(f"=== {r['label']} ===\n{r['text']}\n")
    return (
        f"FILE UNDER REVIEW: {filename}\n\n"
        f"CODE:\n{code}\n\n"
        f"{'='*60}\n"
        f"CRITIC REVIEWS FROM {len(critic_results)} MODELS:\n"
        f"{'='*60}\n\n"
        + "\n\n".join(reviews)
    )


def main() -> int:
    parser = argparse.ArgumentParser(description="Multi-model code review grader")
    parser.add_argument("--file", "-f", type=Path, required=True,
                        help="Python file to review")
    parser.add_argument("--tier", choices=["big", "small", "all", "kagi"], default="big",
                        help="Model tier to test (default: big)")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args()

    setup_logging(args.verbose)

    if not args.file.exists():
        logger.error("File not found: %s", args.file)
        return 1

    code = args.file.read_text(encoding="utf-8")
    filename = args.file.name
    logger.info("File: %s (%d lines, %d chars)", filename, code.count("\n"), len(code))

    models = BIG_MODELS if args.tier == "big" else SMALL_MODELS if args.tier == "small" else KAGI_MODELS if args.tier == "kagi" else BIG_MODELS + SMALL_MODELS
    use_kagi = args.tier == "kagi"

    critic_prompt = (PROMPTS_DIR / "code-review-critic-system_toon.txt").read_text(encoding="utf-8")
    grader_prompt = (PROMPTS_DIR / "code-review-model-grader-system_toon.txt").read_text(encoding="utf-8")

    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output_dir = Path(f"debug/model-grader/{ts}_{filename}")
    output_dir.mkdir(parents=True, exist_ok=True)

    if args.dry_run:
        print(f"File:    {filename} ({code.count(chr(10))} lines)")
        print(f"Tier:    {args.tier}")
        print(f"Models:  {len(models)}")
        for mid, label in models:
            print(f"  - {label} ({mid})")
        print(f"Output:  {output_dir}")
        return 0

    (output_dir / "code.py").write_text(code, encoding="utf-8")

    critic_user_prompt = f"Review this Python file: {filename}\n\nCODE:\n{code}"

    logger.info("Running %d critics in parallel...", len(models))
    t0 = time.time()
    critic_results = run_all_critics(models, critic_prompt, critic_user_prompt, output_dir, use_kagi)
    critic_elapsed = time.time() - t0

    ok = [r for r in critic_results if not r["error"]]
    failed = [r for r in critic_results if r["error"]]
    logger.info("Critics done: %d OK, %d failed in %.1fs", len(ok), len(failed), critic_elapsed)
    for r in failed:
        logger.warning("  FAILED: %s — %s", r["label"], r["error"])

    if not ok:
        logger.error("All critics failed.")
        return 1

    # Opus 4.6 Extended Thinking grading
    logger.info("Sending %d critic reviews to Opus 4.6 Extended Thinking for grading...", len(ok))
    grader_user = build_grader_prompt(code, filename, ok)
    (output_dir / "grader_input.txt").write_text(grader_user, encoding="utf-8")

    t1 = time.time()
    grader_result = call_opus_extended_thinking(grader_prompt, grader_user)
    grader_elapsed = time.time() - t1

    if grader_result["error"]:
        logger.error("Grader failed: %s", grader_result["error"])
        (output_dir / "grader_error.txt").write_text(grader_result["error"], encoding="utf-8")
        return 1

    (output_dir / "grader_output.txt").write_text(grader_result["text"], encoding="utf-8")
    (output_dir / "grader_thinking.txt").write_text(grader_result["thinking"], encoding="utf-8")
    logger.info("Grader done in %.1fs (%d chars response, %d chars thinking)",
                grader_elapsed, len(grader_result["text"]), len(grader_result["thinking"]))

    print(f"\n{'='*60}")
    print(f"MODEL GRADING RESULTS — {filename}")
    print(f"{'='*60}")
    print(f"Critics: {len(ok)} OK, {len(failed)} failed | {critic_elapsed:.0f}s")
    print(f"Grader:  Opus 4.6 Extended | {grader_elapsed:.0f}s")
    print(f"Output:  {output_dir}")
    print(f"{'='*60}\n")
    print(grader_result["text"])

    meta = {
        "timestamp": ts,
        "file": str(args.file),
        "tier": args.tier,
        "models_attempted": len(models),
        "models_ok": len(ok),
        "models_failed": len(failed),
        "critic_elapsed_s": round(critic_elapsed, 1),
        "grader_elapsed_s": round(grader_elapsed, 1),
        "grader_input_tokens": grader_result["input_tokens"],
        "grader_output_tokens": grader_result["output_tokens"],
        "total_elapsed_s": round(time.time() - t0, 1),
        "critic_results": [
            {"label": r["label"], "model_id": r["model_id"],
             "chars": len(r["text"]), "elapsed_s": round(r["elapsed_s"], 1),
             "input_tokens": r["input_tokens"], "output_tokens": r["output_tokens"],
             "error": r["error"]}
            for r in critic_results
        ],
    }
    (output_dir / "metadata.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        logger.warning("Interrupted")
        sys.exit(130)
