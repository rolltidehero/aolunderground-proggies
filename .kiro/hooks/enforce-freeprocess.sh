#!/usr/bin/env bash
# preToolUse hook: blocks fs_write calls that write Python with hardcoded time.sleep waits.
# Exit 0 = allow, Exit 2 = block (STDERR returned to LLM).

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  fs_write|write) ;;
  *) exit 0 ;;
esac

PATH_VAL=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
[[ "$PATH_VAL" != *.py ]] && exit 0

CONTENT=$(echo "$INPUT" | jq -r '.tool_input.file_text // .tool_input.new_str // empty')
[ -z "$CONTENT" ] && exit 0

# Use python to check — reliable float parsing
BANNED=$(python3 -c "
import re, sys
content = sys.stdin.read()
bad = []
for m in re.finditer(r'time\.sleep\(\s*([0-9.]+)\s*\)', content):
    val = float(m.group(1))
    if val > 0.2:
        bad.append(f'time.sleep({m.group(1)})')
print('\n'.join(bad))
" <<< "$CONTENT")

if [ -n "$BANNED" ]; then
  echo "BLOCKED: Python code contains hardcoded time.sleep() waits." >&2
  echo "" >&2
  echo "Violations found:" >&2
  echo "$BANNED" | while read -r line; do
    echo "  $line" >&2
  done
  echo "" >&2
  echo "MANDATORY RULE: Write all wait/poll code like an AOL proggie." >&2
  echo "Use FreeProcess polling with time.sleep(0) yields." >&2
  echo "NEVER use time.sleep(N) where N > 0.2 to wait for a condition." >&2
  echo "" >&2
  echo "Allowed: time.sleep(0), time.sleep(0.05), time.sleep(0.1)" >&2
  echo "Allowed: time.sleep(0.2) ONLY for animation frame timing" >&2
  echo "Banned:  time.sleep(0.3+) as wait-for-condition" >&2
  exit 2
fi

exit 0
