#!/usr/bin/env bash
# preToolUse hook: blocks dangerous commands unless a fresh nonce exists.
# One dangerous command per user message. Second+ without user input = blocked.
#
# Exit 0 = allow, Exit 2 = block (STDERR returned to agent as error)
set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  execute_bash|shell) ;;
  *) exit 0 ;;
esac

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[[ -z "$CMD" ]] && exit 0

FIRST_LINE=$(echo "$CMD" | sed '/^\s*$/d' | head -1)

# --- ALWAYS ALLOW: safe read-only commands ---
SAFE_RE='^(ls|cat|head|tail|wc|echo|pwd|file|which|whoami|hostname|id|ps|pgrep|kill|mkdir|chmod|chown|mv|cp|rm|ln|touch|grep|rg|awk|sed|sort|cut|uniq|tr|jq|diff|md5sum|sha256sum|base64|date|sleep|stat|readlink|realpath|sqlite3|df|free)\b'
if echo "$FIRST_LINE" | grep -qP "$SAFE_RE"; then
  exit 0
fi

# --- ALWAYS ALLOW: git operations ---
if echo "$FIRST_LINE" | grep -qP '^git (status|branch|log|diff|stash|show|rev-parse|config|remote|add|commit|checkout|merge|push|pull)'; then
  exit 0
fi

# --- ALWAYS ALLOW: reading log/tmp files ---
if echo "$FIRST_LINE" | grep -qP '^(cat|tail|head|less|wc) /tmp'; then
  exit 0
fi

# --- ALWAYS ALLOW: repo scripts ---
if echo "$FIRST_LINE" | grep -qP '(python3?|bash)\s+.*/git/aolunderground-proggies/'; then
  exit 0
fi

# --- ALWAYS ALLOW: nohup of repo scripts ---
if echo "$FIRST_LINE" | grep -qP '^nohup\s+bash\s+-c' && echo "$FIRST_LINE" | grep -qP '/git/aolunderground-proggies/'; then
  exit 0
fi

# ============================================================
# DANGEROUS COMMAND DETECTION
# ============================================================
DANGEROUS=0
REASON=""

# Killing all wineuser processes (banned by steering)
echo "$CMD" | grep -qiP 'kill.*\$\(pgrep -u wineuser\)' && DANGEROUS=1 && REASON="mass wineuser kill"
echo "$CMD" | grep -qiP 'pkill -u wineuser' && DANGEROUS=1 && REASON="pkill wineuser"

# Deleting archive directories
echo "$CMD" | grep -qiP 'rm\s+(-rf?|--recursive).*proggies-(sorted|by-version)' && DANGEROUS=1 && REASON="archive deletion"
echo "$CMD" | grep -qiP 'rm\s+(-rf?|--recursive).*/programs/AOL' && DANGEROUS=1 && REASON="archive deletion"

# Modifying gold VM images directly
echo "$CMD" | grep -qiP '(qemu-img|dd|cp|mv|rm).*gold-image' && DANGEROUS=1 && REASON="gold image modification"

# QMP system_reset/system_powerdown (could lose VM state)
echo "$CMD" | grep -qiP 'system_reset|system_powerdown' && DANGEROUS=1 && REASON="VM power control"

# Database destructive ops
echo "$CMD" | grep -qiP 'sqlite3.*proggie_db.*DROP|DELETE FROM' && DANGEROUS=1 && REASON="database destructive op"

# Force push
echo "$CMD" | grep -qiP 'git push.*--force' && DANGEROUS=1 && REASON="force push"

# --- Not dangerous, allow ---
[[ "$DANGEROUS" -eq 0 ]] && exit 0

# ============================================================
# NONCE CHECK
# ============================================================
NONCE_DIR="${KIRO_NONCE_DIR:-/dev/shm/kiro-hooks}"
SESSION_ID="${KIRO_SESSION_ID:-$PPID}"
NONCE_FILE="${NONCE_DIR}/nonce-${SESSION_ID}"

if [[ -f "$NONCE_FILE" ]] && [[ "$(cat "$NONCE_FILE" 2>/dev/null)" = "fresh" ]]; then
  echo "used" > "$NONCE_FILE"
  exit 0
fi

if [[ -f "$NONCE_FILE" ]] && [[ "$(cat "$NONCE_FILE" 2>/dev/null)" = "used" ]]; then
  cat >&2 << 'BLOCKED'
BLOCKED: Multiple dangerous commands without user input.

You already ran one dangerous command this turn. The user must
send another message before you can run more destructive commands.

Do NOT retry. Present your results and wait for the user.
BLOCKED
  exit 2
fi

cat >&2 << 'BLOCKED'
BLOCKED: No user authorization this turn.

Dangerous commands require the user to have sent a message this turn.
Present what you want to do and wait for user input.
BLOCKED
exit 2
