#!/usr/bin/env bash
# preToolUse hook: blocks execute_bash calls that background a process without nohup.
# Exit 0 = allow, Exit 2 = block (STDERR returned to LLM).

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

# Only inspect shell/execute_bash calls
case "$TOOL" in
  execute_bash|shell) ;;
  *) exit 0 ;;
esac

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$CMD" ] && exit 0

# Detect bare backgrounding: line ends with & but doesn't use nohup
# We check each line that ends with & (trimmed)
while IFS= read -r line; do
  trimmed=$(echo "$line" | sed 's/[[:space:]]*$//')
  # Skip empty lines and comments
  [[ -z "$trimmed" || "$trimmed" == \#* ]] && continue
  # Check if line ends with & (backgrounding)
  if [[ "$trimmed" == *'&' && "$trimmed" != *'&&' ]]; then
    # Allow if line contains nohup
    if ! echo "$trimmed" | grep -q 'nohup'; then
      echo "BLOCKED: Command backgrounds a process without nohup." >&2
      echo "Line: $trimmed" >&2
      echo "" >&2
      echo "MANDATORY RULE: All backgrounded commands MUST use:" >&2
      echo "  nohup command < /dev/null > /path/to/output.log 2>&1 &" >&2
      echo "Then check the log in a SEPARATE tool call." >&2
      exit 2
    fi
  fi
done <<< "$CMD"

exit 0
