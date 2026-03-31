#!/usr/bin/env python3
# generic_claude_api.py — Generic Claude API caller with prompt caching support
# Supports Anthropic API, AWS Bedrock (standard auth), and Bedrock API Keys
# Accepts any prompt file and input file, outputs Claude's response.

import os
import sys
import logging
import argparse
import datetime
import json
from pathlib import Path
from dotenv import load_dotenv
import time
import requests


# -------------------------------------------------
# Logging
# -------------------------------------------------

def init_logger(log_name="claude_api"):
    logger = logging.getLogger(log_name)
    logger.setLevel(logging.DEBUG)
    logger.handlers.clear()

    ch = logging.StreamHandler(sys.stdout)
    ch.setLevel(logging.INFO)
    ch.setFormatter(logging.Formatter("%(asctime)s %(levelname)s %(message)s"))
    logger.addHandler(ch)

    log_dir = Path("log") / log_name
    log_dir.mkdir(parents=True, exist_ok=True)

    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    fh = logging.FileHandler(log_dir / f"{ts}_{log_name}.log", encoding="utf-8")
    fh.setLevel(logging.DEBUG)
    fh.setFormatter(logging.Formatter("%(asctime)s %(levelname)s %(message)s"))
    logger.addHandler(fh)

    return logger


logger = init_logger()

# -------------------------------------------------
# Load Config from .env.attackforge (JSON) or environment
# -------------------------------------------------

def load_config():
    """Load config from .env.attackforge JSON file or environment variables"""
    load_dotenv()  # Also load standard .env if present
    
    config = {}
    
    # Try to load from .env.attackforge JSON file
    env_files = [
        Path(".env.attackforge"),
        Path(__file__).parent.parent / "viewer" / ".env.attackforge",
        Path.home() / ".env.attackforge",
    ]
    
    for env_file in env_files:
        if env_file.exists():
            try:
                with open(env_file) as f:
                    config = json.load(f)
                logger.debug("Loaded config from %s", env_file)
                break
            except json.JSONDecodeError:
                logger.warning("Failed to parse %s as JSON", env_file)
    
    # Environment variables override file config
    for key in ["ANTHROPIC_API_KEY", "AWS_BEARER_TOKEN_BEDROCK", "AWS_REGION", "AWS_DEFAULT_REGION", "LLM_PROVIDER"]:
        env_val = os.getenv(key)
        if env_val:
            config[key] = env_val
    
    return config


CONFIG = None

def get_config(key, default=None):
    global CONFIG
    if CONFIG is None:
        CONFIG = load_config()
    return CONFIG.get(key, os.getenv(key, default))


# -------------------------------------------------
# Provider Detection
# -------------------------------------------------

def get_provider():
    """Detect which provider to use based on config"""
    provider = get_config("LLM_PROVIDER", "").lower()
    if provider in ["bedrock", "aws", "bedrock-apikey"]:
        return "bedrock-apikey" if get_config("AWS_BEARER_TOKEN_BEDROCK") else "bedrock"
    if provider in ["anthropic", "claude"]:
        return "anthropic"
    
    # Auto-detect based on available credentials
    if get_config("AWS_BEARER_TOKEN_BEDROCK"):
        return "bedrock-apikey"
    if get_config("ANTHROPIC_API_KEY"):
        return "anthropic"
    if os.getenv("AWS_ACCESS_KEY_ID") or os.getenv("AWS_PROFILE"):
        return "bedrock"
    
    raise RuntimeError("No LLM provider configured. Set ANTHROPIC_API_KEY, AWS_BEARER_TOKEN_BEDROCK, or AWS credentials.")

# -------------------------------------------------
# Anthropic API Client
# -------------------------------------------------

def call_anthropic(system_prompt: str, user_prompt: str, model: str, max_tokens: int, 
                   json_output: bool = False, toon_output: bool = False, debug_mode: bool = False, use_cache: bool = False):
    import anthropic
    api_key = get_config("ANTHROPIC_API_KEY")
    if not api_key:
        raise RuntimeError("Missing ANTHROPIC_API_KEY")

    client = anthropic.Anthropic(api_key=api_key)
    logger.info("Calling Anthropic API model=%s", model)

    if use_cache:
        system_content = [{"type": "text", "text": system_prompt, "cache_control": {"type": "ephemeral"}}]
    else:
        system_content = system_prompt

    api_start = time.time()
    response = client.messages.create(
        model=model,
        system=system_content,
        max_tokens=max_tokens,
        messages=[{"role": "user", "content": user_prompt}],
    )
    api_duration = time.time() - api_start

    if hasattr(response, 'usage'):
        logger.info("Input tokens: %d", response.usage.input_tokens)
        logger.info("Output tokens: %d", response.usage.output_tokens)
        logger.info("Total tokens: %d", response.usage.input_tokens + response.usage.output_tokens)

    logger.info("Duration: %.2f seconds", api_duration)
    return extract_text_content(response, toon_output)

# -------------------------------------------------
# AWS Bedrock with API Key (Bearer Token)
# -------------------------------------------------

def call_bedrock_apikey(system_prompt: str, user_prompt: str, model: str, max_tokens: int,
                        json_output: bool = False, toon_output: bool = False, debug_mode: bool = False, use_cache: bool = False):
    api_key = get_config("AWS_BEARER_TOKEN_BEDROCK")
    if not api_key:
        raise RuntimeError("Missing AWS_BEARER_TOKEN_BEDROCK")
    
    # Map model names to Bedrock model IDs
    bedrock_models = {
        "claude-3-5-sonnet-20241022": "us.anthropic.claude-3-5-sonnet-20241022-v2:0",
        "claude-sonnet-4-5-20250929": "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
        "claude-sonnet-4-20250514": "us.anthropic.claude-sonnet-4-20250514-v1:0",
        "claude-opus-4-20250514": "us.anthropic.claude-opus-4-20250514-v1:0",
        "claude-3-opus-20240229": "us.anthropic.claude-3-opus-20240229-v1:0",
        "claude-3-sonnet-20240229": "us.anthropic.claude-3-sonnet-20240229-v1:0",
        "claude-3-haiku-20240307": "us.anthropic.claude-3-haiku-20240307-v1:0",
    }
    
    bedrock_model_id = bedrock_models.get(model, model)
    region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
    
    # Bedrock invoke endpoint
    url = f"https://bedrock-runtime.{region}.amazonaws.com/model/{bedrock_model_id}/invoke"
    
    logger.info("Calling Bedrock API Key endpoint")
    logger.info("Region: %s", region)
    logger.info("Model: %s", bedrock_model_id)
    
    request_body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": max_tokens,
        "system": system_prompt,
        "messages": [{"role": "user", "content": user_prompt}]
    }
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}",
    }
    
    api_start = time.time()
    
    try:
        response = requests.post(url, headers=headers, json=request_body, timeout=300)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        logger.error("Bedrock API request failed: %s", e)
        if hasattr(e, 'response') and e.response is not None:
            logger.error("Response status: %s", e.response.status_code)
            logger.error("Response body: %s", e.response.text[:500])
        raise
    
    api_duration = time.time() - api_start
    response_body = response.json()
    
    input_tokens = response_body.get('usage', {}).get('input_tokens', 0)
    output_tokens = response_body.get('usage', {}).get('output_tokens', 0)
    
    logger.info("Input tokens: %d", input_tokens)
    logger.info("Output tokens: %d", output_tokens)
    logger.info("Total tokens: %d", input_tokens + output_tokens)
    logger.info("Duration: %.2f seconds", api_duration)
    
    content = response_body.get('content', [])
    text = content[0].get('text', '') if content else str(response_body)
    
    return strip_formatting(text, toon_output)

# -------------------------------------------------
# AWS Bedrock with Standard Auth (boto3)
# -------------------------------------------------

def call_bedrock_boto(system_prompt: str, user_prompt: str, model: str, max_tokens: int,
                      json_output: bool = False, toon_output: bool = False, debug_mode: bool = False, use_cache: bool = False):
    import boto3
    
    bedrock_models = {
        "claude-3-5-sonnet-20241022": "us.anthropic.claude-3-5-sonnet-20241022-v2:0",
        "claude-sonnet-4-5-20250929": "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
        "claude-sonnet-4-20250514": "us.anthropic.claude-sonnet-4-20250514-v1:0",
        "claude-opus-4-20250514": "us.anthropic.claude-opus-4-20250514-v1:0",
        "claude-3-opus-20240229": "us.anthropic.claude-3-opus-20240229-v1:0",
        "claude-3-sonnet-20240229": "us.anthropic.claude-3-sonnet-20240229-v1:0",
        "claude-3-haiku-20240307": "us.anthropic.claude-3-haiku-20240307-v1:0",
    }
    
    bedrock_model_id = bedrock_models.get(model, model)
    region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
    
    logger.info("Calling Bedrock (boto3) model=%s", bedrock_model_id)
    
    client = boto3.client('bedrock-runtime', region_name=region)
    
    request_body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": max_tokens,
        "system": system_prompt,
        "messages": [{"role": "user", "content": user_prompt}]
    }
    
    api_start = time.time()
    response = client.invoke_model(
        modelId=bedrock_model_id,
        contentType="application/json",
        accept="application/json",
        body=json.dumps(request_body)
    )
    api_duration = time.time() - api_start
    
    response_body = json.loads(response['body'].read())
    
    input_tokens = response_body.get('usage', {}).get('input_tokens', 0)
    output_tokens = response_body.get('usage', {}).get('output_tokens', 0)
    
    logger.info("Input tokens: %d", input_tokens)
    logger.info("Output tokens: %d", output_tokens)
    logger.info("Duration: %.2f seconds", api_duration)
    
    content = response_body.get('content', [])
    text = content[0].get('text', '') if content else str(response_body)
    
    return strip_formatting(text, toon_output)


# -------------------------------------------------
# Helpers
# -------------------------------------------------

def strip_formatting(text, toon_output=False):
    """Strip markdown fences and TOON preamble"""
    text = text.strip()
    if text.startswith("```json"):
        text = text[7:]
    elif text.startswith("```"):
        text = text[3:]
    if text.endswith("```"):
        text = text[:-3]
    text = text.strip()
    
    if toon_output:
        equal_pos = text.find('=')
        if equal_pos > 0:
            text = text[equal_pos:]
    
    return text


def extract_text_content(response, toon_output=False):
    """Extract text content from Anthropic API response"""
    if hasattr(response, "content") and response.content:
        item = response.content[0]
        if hasattr(item, "text"):
            text = item.text
        elif isinstance(item, dict):
            text = item.get("text", str(item))
        else:
            text = str(item)
        return strip_formatting(text, toon_output)
    return str(response)


# -------------------------------------------------
# Unified Call Function
# -------------------------------------------------

def call_claude(system_prompt: str, user_prompt: str, model: str, max_tokens: int, 
                json_output: bool = False, toon_output: bool = False, debug_mode: bool = False, use_cache: bool = False):
    
    if json_output:
        user_prompt = user_prompt + "\n\nIMPORTANT: Output ONLY valid JSON with no preamble, explanation, or markdown formatting."
    
    if toon_output:
        user_prompt = user_prompt + "\n\nCRITICAL: Output must start with '=' character. No preamble, no markdown, no text before or after the TOON format."
    
    provider = get_provider()
    logger.info("Using provider: %s", provider)
    
    if provider == "bedrock-apikey":
        return call_bedrock_apikey(system_prompt, user_prompt, model, max_tokens, json_output, toon_output, debug_mode, use_cache)
    elif provider == "bedrock":
        return call_bedrock_boto(system_prompt, user_prompt, model, max_tokens, json_output, toon_output, debug_mode, use_cache)
    else:
        return call_anthropic(system_prompt, user_prompt, model, max_tokens, json_output, toon_output, debug_mode, use_cache)


def call_claude_with_conversation(system_prompt: str, messages: list, model: str, max_tokens: int,
                                   json_output: bool = False, toon_output: bool = False, debug_mode: bool = False, use_cache: bool = False):
    """
    Call Claude with full conversation history (for iterative revisions)
    
    Args:
        system_prompt: System prompt text
        messages: List of message dicts with 'role' and 'content' keys
                  e.g., [{"role": "user", "content": "..."}, {"role": "assistant", "content": "..."}, ...]
        model: Model name
        max_tokens: Max response tokens
        json_output: Whether to request JSON output
        toon_output: Whether to request TOON output
        debug_mode: Debug flag
        use_cache: Whether to use prompt caching
    
    Returns:
        str: Claude's response text
    """
    logger.info("Calling Claude with conversation history (%d messages)", len(messages))
    
    # Add output format instructions to last user message
    if messages and messages[-1]['role'] == 'user':
        if json_output:
            messages[-1]['content'] += "\n\nIMPORTANT: Output ONLY valid JSON with no preamble, explanation, or markdown formatting."
        if toon_output:
            messages[-1]['content'] += "\n\nCRITICAL: Output must start with '=' character. No preamble, no markdown, no text before or after the TOON format."
    
    provider = get_provider()
    logger.info("Using provider: %s", provider)
    
    # Call appropriate provider with conversation history
    if provider == "anthropic":
        import anthropic
        api_key = get_config("ANTHROPIC_API_KEY")
        if not api_key:
            raise RuntimeError("Missing ANTHROPIC_API_KEY")
        
        client = anthropic.Anthropic(api_key=api_key)
        logger.info("Calling Anthropic API model=%s with conversation", model)
        
        if use_cache:
            system_content = [{"type": "text", "text": system_prompt, "cache_control": {"type": "ephemeral"}}]
        else:
            system_content = system_prompt
        
        api_start = time.time()
        response = client.messages.create(
            model=model,
            system=system_content,
            max_tokens=max_tokens,
            messages=messages,
        )
        api_duration = time.time() - api_start
        
        if hasattr(response, 'usage'):
            logger.info("Input tokens: %d", response.usage.input_tokens)
            logger.info("Output tokens: %d", response.usage.output_tokens)
            logger.info("Total tokens: %d", response.usage.input_tokens + response.usage.output_tokens)
        
        logger.info("Duration: %.2f seconds", api_duration)
        return extract_text_content(response, toon_output)
    
    elif provider == "bedrock-apikey":
        api_key = get_config("AWS_BEARER_TOKEN_BEDROCK")
        if not api_key:
            raise RuntimeError("Missing AWS_BEARER_TOKEN_BEDROCK")
        
        bedrock_models = {
            "claude-3-5-sonnet-20241022": "us.anthropic.claude-3-5-sonnet-20241022-v2:0",
            "claude-sonnet-4-5-20250929": "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
            "claude-sonnet-4-20250514": "us.anthropic.claude-sonnet-4-20250514-v1:0",
            "claude-opus-4-20250514": "us.anthropic.claude-opus-4-20250514-v1:0",
        }
        
        bedrock_model_id = bedrock_models.get(model, model)
        region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
        url = f"https://bedrock-runtime.{region}.amazonaws.com/model/{bedrock_model_id}/invoke"
        
        logger.info("Calling Bedrock API Key endpoint with conversation")
        logger.info("Region: %s", region)
        logger.info("Model: %s", bedrock_model_id)
        
        request_body = {
            "anthropic_version": "bedrock-2023-05-31",
            "max_tokens": max_tokens,
            "system": system_prompt,
            "messages": messages
        }
        
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}",
        }
        
        api_start = time.time()
        response = requests.post(url, headers=headers, json=request_body, timeout=300)
        response.raise_for_status()
        api_duration = time.time() - api_start
        
        response_body = response.json()
        input_tokens = response_body.get('usage', {}).get('input_tokens', 0)
        output_tokens = response_body.get('usage', {}).get('output_tokens', 0)
        
        logger.info("Input tokens: %d", input_tokens)
        logger.info("Output tokens: %d", output_tokens)
        logger.info("Total tokens: %d", input_tokens + output_tokens)
        logger.info("Duration: %.2f seconds", api_duration)
        
        content = response_body.get('content', [])
        text = content[0].get('text', '') if content else str(response_body)
        
        return strip_formatting(text, toon_output)
    
    else:  # bedrock boto3
        import boto3
        
        bedrock_models = {
            "claude-3-5-sonnet-20241022": "us.anthropic.claude-3-5-sonnet-20241022-v2:0",
            "claude-sonnet-4-5-20250929": "us.anthropic.claude-sonnet-4-5-20250929-v1:0",
            "claude-sonnet-4-20250514": "us.anthropic.claude-sonnet-4-20250514-v1:0",
            "claude-opus-4-20250514": "us.anthropic.claude-opus-4-20250514-v1:0",
        }
        
        bedrock_model_id = bedrock_models.get(model, model)
        region = get_config("AWS_REGION", get_config("AWS_DEFAULT_REGION", "us-east-1"))
        
        logger.info("Calling Bedrock (boto3) with conversation model=%s", bedrock_model_id)
        
        client = boto3.client('bedrock-runtime', region_name=region)
        
        request_body = {
            "anthropic_version": "bedrock-2023-05-31",
            "max_tokens": max_tokens,
            "system": system_prompt,
            "messages": messages
        }
        
        api_start = time.time()
        response = client.invoke_model(
            modelId=bedrock_model_id,
            contentType="application/json",
            accept="application/json",
            body=json.dumps(request_body)
        )
        api_duration = time.time() - api_start
        
        response_body = json.loads(response['body'].read())
        
        input_tokens = response_body.get('usage', {}).get('input_tokens', 0)
        output_tokens = response_body.get('usage', {}).get('output_tokens', 0)
        
        logger.info("Input tokens: %d", input_tokens)
        logger.info("Output tokens: %d", output_tokens)
        logger.info("Duration: %.2f seconds", api_duration)
        
        content = response_body.get('content', [])
        text = content[0].get('text', '') if content else str(response_body)
        
        return strip_formatting(text, toon_output)


# -------------------------------------------------
# CLI
# -------------------------------------------------

def parse_args():
    p = argparse.ArgumentParser(description="Generic Claude API caller supporting Anthropic and AWS Bedrock")
    
    p.add_argument("--system-prompt", required=True, help="Path to system prompt file")
    p.add_argument("--output", required=True, help="Output file for response")
    
    input_group = p.add_mutually_exclusive_group(required=True)
    input_group.add_argument("--user-prompt", help="Path to user prompt file")
    input_group.add_argument("--input", help="Path to input file")
    input_group.add_argument("--conversation-history-file", help="Path to conversation history JSON file (for iterative revisions)")
    
    p.add_argument("--user-template", help="Template for user prompt")
    p.add_argument("--model", default=os.getenv("CLAUDE_MODEL", "claude-3-5-sonnet-20241022"),
                   help="Model to use (default: claude-3-5-sonnet-20241022)")
    p.add_argument("--max-tokens", type=int, default=4096)
    p.add_argument("--log-name", default="claude_api")
    p.add_argument("--quiet", action="store_true")
    p.add_argument("--json-output", action="store_true")
    p.add_argument("--toon-output", action="store_true")
    p.add_argument("--debug", action="store_true")
    p.add_argument("--use-cache", action="store_true")
    
    return p.parse_args()


def main():
    script_start = time.time()
    args = parse_args()
    
    if args.log_name != "claude_api":
        global logger
        logger = init_logger(args.log_name)
    
    if args.quiet and not args.debug:
        logging.getLogger(args.log_name).handlers[0].setLevel(logging.ERROR)

    system_prompt = Path(args.system_prompt).read_text(encoding="utf-8")

    # NEW: Check if conversation history mode is being used
    if args.conversation_history_file:
        logger.info("Using conversation history mode")
        conversation_history_path = Path(args.conversation_history_file)
        if not conversation_history_path.exists():
            logger.error("Conversation history file not found: %s", args.conversation_history_file)
            sys.exit(1)
        
        # Load conversation history JSON
        # Expected format: [{"role": "user", "content": "..."}, {"role": "assistant", "content": "..."}, ...]
        try:
            with open(conversation_history_path, 'r', encoding='utf-8') as f:
                messages = json.load(f)
            
            if not isinstance(messages, list):
                logger.error("Conversation history must be a JSON array of messages")
                sys.exit(1)
            
            logger.info("Loaded conversation history with %d messages", len(messages))
            
            # Call with conversation history
            response = call_claude_with_conversation(system_prompt, messages, args.model, args.max_tokens,
                                                     args.json_output, args.toon_output, args.debug, args.use_cache)
        except Exception as e:
            logger.error("Conversation history API call failed: %s", e, exc_info=True)
            sys.exit(1)
    
    else:
        # ORIGINAL: Single-shot mode (existing behavior)
        if args.user_prompt:
            user_prompt = Path(args.user_prompt).read_text(encoding="utf-8")
        else:
            input_content = Path(args.input).read_text(encoding="utf-8")
            template = args.user_template or "{input}"
            user_prompt = template.format(input=input_content)

        try:
            response = call_claude(system_prompt, user_prompt, args.model, args.max_tokens, 
                                  args.json_output, args.toon_output, args.debug, args.use_cache)
        except Exception as e:
            logger.error("API call failed: %s", e, exc_info=True)
            sys.exit(1)

    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    
    raw_path = output_path.parent / f"{output_path.stem}.raw{output_path.suffix}"
    raw_path.write_text(response, encoding="utf-8")
    output_path.write_text(response, encoding="utf-8")
    
    logger.info("Done in %.1fs", time.time() - script_start)
    print(str(output_path.resolve()))

if __name__ == "__main__":
    main()
