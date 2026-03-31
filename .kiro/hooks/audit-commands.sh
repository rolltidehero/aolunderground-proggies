#!/usr/bin/env bash
# postToolUse hook: append every bash command + exit status to audit log.
set -euo pipefail
AUDIT_DIR="${KIRO_AUDIT_DIR:-/tmp}"
INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')
[[ "$TOOL" != "execute_bash" && "$TOOL" != "shell" ]] && exit 0

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' | head -c 500)
SUCCESS=$(echo "$INPUT" | jq -r '.tool_response.success // empty')
printf '%s | %s | %s\n' "$(date -Iseconds)" "$SUCCESS" "$CMD" >> "${AUDIT_DIR}/.kiro-command-audit.log"
exit 0
