#!/usr/bin/env python3
"""code-review.py — Bedrock-powered code review using Opus 4.6 Extended Thinking.

Sends a Python file to Claude Opus 4.6 with extended thinking and the full
reviewer prompt. Returns TOON-formatted findings with drop-in code fixes.
Optionally verifies fixes compile via py_compile.

Usage:
    python3 tools/code-review.py --file script.py
    python3 tools/code-review.py --file script.py --verify
    python3 tools/code-review.py --file script.py --context lib/utils.py lib/models.py
    python3 tools/code-review.py --file script.py --dry-run
"""
from __future__ import annotations

import argparse
import json
import logging
import os
import re
import subprocess
import sys
import tempfile
import time
from datetime import datetime, timezone
from pathlib import Path

import requests

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from generic_claude_api import get_config

logger = logging.getLogger(__name__)

REVIEWER_MODEL = "us.anthropic.claude-opus-4-6-v1"
PROMPTS_DIR = Path(__file__).resolve().parents[1] / "prompts"
REVIEWER_PROMPT_FILE = "python-code-review_toon.txt"
MAX_FILE_CHARS = 50_000
LANG_MAP = {".py": "Python", ".sh": "Bash", ".ps1": "PowerShell"}


def setup_logging(verbose: bool = False) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def call_opus(system_prompt: str, user_prompt: str,
              max_tokens: int = 16000, thinking_budget: int = 10000) -> dict:
    """Call Opus 4.6 Extended Thinking via Bedrock."""
    token = get_config("AWS_BEARER_TOKEN_BEDROCK")
    if not token:
        return {"text": "", "thinking": "", "elapsed_s": 0,
                "input_tokens": 0, "output_tokens": 0,
                "error": "No AWS_BEARER_TOKEN_BEDROCK"}

    region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
    url = f"https://bedrock-runtime.{region}.amazonaws.com/model/{REVIEWER_MODEL}/invoke"

    body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": max_tokens,
        "thinking": {"type": "enabled", "budget_tokens": thinking_budget},
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
            return {"text": "", "thinking": "", "elapsed_s": elapsed,
                    "input_tokens": 0, "output_tokens": 0,
                    "error": f"HTTP {resp.status_code}: {resp.text[:300]}"}
        data = resp.json()
        usage = data.get("usage", {})
        thinking, text = "", ""
        for block in data.get("content", []):
            if block.get("type") == "thinking":
                thinking += block.get("thinking", "")
            elif block.get("type") == "text":
                text += block.get("text", "")
        return {
            "text": text, "thinking": thinking, "elapsed_s": elapsed,
            "input_tokens": usage.get("input_tokens", 0),
            "output_tokens": usage.get("output_tokens", 0),
            "error": None,
        }
    except requests.exceptions.ReadTimeout:
        return {"text": "", "thinking": "", "elapsed_s": time.time() - t0,
                "input_tokens": 0, "output_tokens": 0, "error": "TIMEOUT (300s)"}
    except Exception as e:
        return {"text": "", "thinking": "", "elapsed_s": time.time() - t0,
                "input_tokens": 0, "output_tokens": 0,
                "error": f"{type(e).__name__}: {str(e)[:200]}"}


def verify_fixes(source: str, review_text: str) -> list[dict]:
    """Apply each fix and check if the result compiles. Returns per-finding results."""
    findings = re.split(r'^=F\d+=\s*$', review_text, flags=re.MULTILINE)
    results = []
    patched = source

    for i, finding in enumerate(findings[1:], 1):
        title_m = re.search(r'title:\s*(.+)', finding)
        current_m = re.search(r'===CURRENT_CODE===\s*\n(.*?)===FIXED_CODE===', finding, re.DOTALL)
        fixed_m = re.search(r'===FIXED_CODE===\s*\n(.*?)(?=\n=F\d+=|\n=END=|\Z)', finding, re.DOTALL)
        title = title_m.group(1).strip() if title_m else "?"

        if not current_m or not fixed_m:
            results.append({"id": f"F{i}", "title": title, "status": "NO_CODE_BLOCKS"})
            continue

        current = current_m.group(1).strip()
        fixed = fixed_m.group(1).strip()

        if current not in patched:
            results.append({"id": f"F{i}", "title": title, "status": "NOT_FOUND"})
            continue

        patched = patched.replace(current, fixed, 1)
        results.append({"id": f"F{i}", "title": title, "status": "APPLIED"})

    # Compile check
    with tempfile.NamedTemporaryFile(suffix=".py", mode="w", delete=False, encoding="utf-8") as tmp:
        tmp.write(patched)
        tmp_path = tmp.name

    try:
        r = subprocess.run([sys.executable, "-m", "py_compile", tmp_path],
                           capture_output=True, text=True, timeout=10)
        compiles = r.returncode == 0
        compile_error = r.stderr.strip()[:200] if not compiles else ""
    except subprocess.TimeoutExpired:
        compiles = False
        compile_error = "py_compile timed out"
    finally:
        Path(tmp_path).unlink(missing_ok=True)

    return results, compiles, compile_error


def main() -> int:
    parser = argparse.ArgumentParser(description="Bedrock code review — Opus 4.6 Extended Thinking")
    parser.add_argument("--file", "-f", type=Path, required=True, help="Python file to review")
    parser.add_argument("--context", nargs="+", type=Path, default=[],
                        help="Additional context files (dependencies, imports)")
    parser.add_argument("--verify", action="store_true", help="Verify fixes compile via py_compile")
    parser.add_argument("--thinking-budget", type=int, default=10000,
                        help="Extended thinking token budget (default: 10000)")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("-o", "--output", type=Path, help="Save review output to file")
    args = parser.parse_args()

    setup_logging(args.verbose)

    if not args.file.exists():
        logger.error("File not found: %s", args.file)
        return 1

    code = args.file.read_text(encoding="utf-8")
    filename = args.file.name
    lang = LANG_MAP.get(args.file.suffix.lower(), "Unknown")

    if len(code) > MAX_FILE_CHARS:
        logger.error("%s is %d chars (limit: %d)", filename, len(code), MAX_FILE_CHARS)
        return 1

    logger.info("File: %s (%d lines, %d chars, %s)", filename, code.count("\n"), len(code), lang)

    # Load reviewer prompt
    prompt_path = PROMPTS_DIR / REVIEWER_PROMPT_FILE
    if not prompt_path.exists():
        logger.error("Reviewer prompt not found: %s", prompt_path)
        return 1
    system_prompt = prompt_path.read_text(encoding="utf-8")

    # Build user prompt
    context_section = ""
    for ctx_path in args.context:
        if not ctx_path.exists():
            logger.error("Context file not found: %s", ctx_path)
            return 1
        ctx_code = ctx_path.read_text(encoding="utf-8")
        context_section += f"\n# === DEPENDENCY: {ctx_path.name} ===\n{ctx_code}\n"
        logger.info("Context: %s (%d lines)", ctx_path.name, ctx_code.count("\n"))

    user_prompt = f"Review this {lang} file: {filename}\n"
    if context_section:
        user_prompt += f"\nCONTEXT FILES (dependencies, for reference only — review the main file):\n{context_section}\n"
    user_prompt += f"\nMAIN FILE TO REVIEW:\n{code}"

    # Output directory
    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output_dir = Path(f"debug/code-review/{ts}_{filename}")
    output_dir.mkdir(parents=True, exist_ok=True)

    if args.dry_run:
        print(f"File:     {filename} ({code.count(chr(10))} lines, {lang})")
        print(f"Context:  {len(args.context)} files")
        print(f"Model:    Opus 4.6 Extended Thinking (budget: {args.thinking_budget})")
        print(f"Prompt:   {prompt_path.name}")
        print(f"Verify:   {args.verify}")
        print(f"Output:   {output_dir}")
        return 0

    # Save inputs
    (output_dir / "code.py").write_text(code, encoding="utf-8")
    (output_dir / "prompt.txt").write_text(user_prompt, encoding="utf-8")

    # Call Opus
    logger.info("Calling Opus 4.6 Extended Thinking (budget: %d)...", args.thinking_budget)
    result = call_opus(system_prompt, user_prompt,
                       thinking_budget=args.thinking_budget)

    if result["error"]:
        logger.error("Review failed: %s", result["error"])
        return 1

    # Save outputs
    (output_dir / "review.txt").write_text(result["text"], encoding="utf-8")
    (output_dir / "thinking.txt").write_text(result["thinking"], encoding="utf-8")

    logger.info("Review done in %.1fs | in=%d out=%d | %d chars",
                result["elapsed_s"], result["input_tokens"],
                result["output_tokens"], len(result["text"]))

    # Optional: save to specified output file
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(result["text"], encoding="utf-8")
        logger.info("Saved to %s", args.output)

    # Verify fixes
    if args.verify:
        logger.info("Verifying fixes compile...")
        fix_results, compiles, compile_error = verify_fixes(code, result["text"])
        for fr in fix_results:
            status_icon = "✓" if fr["status"] == "APPLIED" else "✗"
            print(f"  {status_icon} {fr['id']}: {fr['status']} — {fr['title']}")
        if compiles:
            print(f"  py_compile: ✓ PASSES")
        else:
            print(f"  py_compile: ✗ FAILS — {compile_error}")

        (output_dir / "verify.json").write_text(
            json.dumps({"fixes": fix_results, "compiles": compiles,
                        "compile_error": compile_error}, indent=2),
            encoding="utf-8")

    # Print review
    print(f"\n{'='*60}")
    print(f"CODE REVIEW — {filename}")
    print(f"{'='*60}")
    print(f"Model:  Opus 4.6 Extended Thinking | {result['elapsed_s']:.0f}s")
    print(f"Output: {output_dir}")
    print(f"{'='*60}\n")
    print(result["text"])

    # Save metadata
    meta = {
        "timestamp": ts,
        "file": str(args.file),
        "lines": code.count("\n"),
        "chars": len(code),
        "language": lang,
        "context_files": [str(p) for p in args.context],
        "model": REVIEWER_MODEL,
        "thinking_budget": args.thinking_budget,
        "elapsed_s": round(result["elapsed_s"], 1),
        "input_tokens": result["input_tokens"],
        "output_tokens": result["output_tokens"],
        "response_chars": len(result["text"]),
        "thinking_chars": len(result["thinking"]),
    }
    (output_dir / "metadata.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        logger.warning("Interrupted")
        sys.exit(130)
