#!/usr/bin/env bash
# preToolUse hook: blocks execute_bash calls that run long-running commands
# without nohup. Exit 0 = allow, Exit 2 = block (STDERR returned to LLM).
#
# Requires: bash, jq
# Platform: Linux, macOS, Windows (Git Bash / WSL)
set -euo pipefail

# Skip enforcement on Windows (nohup not reliable)
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
  exit 0
fi

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  execute_bash|shell) ;;
  *) exit 0 ;;
esac

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[[ -z "$CMD" ]] && exit 0

SAFE_PATTERNS=(
  '^ls\b' '^cat\b' '^head\b' '^tail\b' '^wc\b' '^echo\b' '^pwd$'
  '^file\b' '^which\b' '^whoami$' '^hostname$' '^uname\b' '^id$'
  '^ps\b' '^pgrep\b' '^pkill\b' '^kill\b' '^jobs$'
  '^mkdir\b' '^chmod\b' '^chown\b' '^mv\b' '^cp\b' '^rm\b' '^ln\b' '^touch\b'
  '^git (status|branch|log|diff|stash|show|rev-parse|config|remote -v)'
  '^git checkout\b' '^git switch\b' '^git stash\b'
  '^python3? -m py_compile\b' '^python3? -c\b' '^python3? --version'
  '^readlink\b' '^realpath\b' '^basename\b' '^dirname\b' '^stat\b'
  '^date\b' '^env$' '^printenv\b' '^export\b'
  '^sed\b' '^awk\b' '^cut\b' '^sort\b' '^uniq\b' '^tr\b' '^tee\b'
  '^diff\b' '^md5sum\b' '^sha256sum\b' '^base64\b'
  '^jq\b' '^column\b' '^printf\b'
  '^sleep [0-5]$'
  '^find\b.*-maxdepth [12]\b'
)

LONG_PATTERNS=(
  '^(sudo )?(apt|apt-get|dpkg|yum|dnf|pacman|snap|brew|choco|winget)\b'
  '^pip3? install\b'
  '^npm (install|ci|test|run)\b' '^yarn\b' '^pnpm\b'
  '^cargo (build|test|install)\b' '^make\b' '^cmake\b'
  '^git (push|pull|fetch|clone|merge|rebase)\b'
  '^(python3?|bash|sh|perl|ruby|node) [^ ]'
  '^nmap\b' '^masscan\b' '^smbclient\b' '^rpcclient\b'
  '^curl\b' '^wget\b' '^scp\b' '^rsync\b' '^ssh\b'
  '^pytest\b' '^python3? -m pytest\b'
  '^docker\b' '^docker-compose\b' '^podman\b'
  '^hashcat\b' '^john\b'
  '^terraform\b' '^ansible\b' '^kubectl\b'
)

# Already wrapped in nohup — allow
if echo "$CMD" | head -1 | grep -qE '^\s*nohup\b'; then
  exit 0
fi

# Check ALL lines, not just the first — multi-line commands must not
# hide long-running tools behind an innocuous first line.
while IFS= read -r line; do
  # Strip leading whitespace and trailing whitespace
  stripped=$(echo "$line" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
  # Skip blanks and comments
  [[ -z "$stripped" || "$stripped" == \#* ]] && continue
  # Extract first command on this line (before pipe/semicolon/&&/||)
  LINE_CMD=$(echo "$stripped" | sed 's/\s*[|;&].*//')

  # Also extract commands inside $() or `` subshells and var assignments
  # e.g. result=$(bash foo.sh) → bash foo.sh
  #      VAR=$(python3 script.py) → python3 script.py
  SUBCMDS=()
  while IFS= read -r subcmd; do
    [[ -n "$subcmd" ]] && SUBCMDS+=("$subcmd")
  done < <(echo "$stripped" | grep -oP '\$\(\s*\K[^)]+' | sed 's/\s*[|;&].*//')
  # Also handle var=cmd pattern: VAR=value cmd args
  ASSIGN_CMD=$(echo "$LINE_CMD" | sed -n 's/^[A-Za-z_][A-Za-z_0-9]*=\S*\s\+//p')

  is_safe=false
  for pattern in "${SAFE_PATTERNS[@]}"; do
    if echo "$LINE_CMD" | grep -qE "$pattern"; then
      is_safe=true
      break
    fi
  done
  $is_safe && continue

  # Collect all command variants to check: the line itself, subshells, assignments
  ALL_CMDS=("$LINE_CMD")
  for sc in "${SUBCMDS[@]}"; do ALL_CMDS+=("$sc"); done
  [[ -n "${ASSIGN_CMD:-}" ]] && ALL_CMDS+=("$ASSIGN_CMD")

  for check_cmd in "${ALL_CMDS[@]}"; do
    # Check safe patterns first
    cmd_safe=false
    for pattern in "${SAFE_PATTERNS[@]}"; do
      if echo "$check_cmd" | grep -qE "$pattern"; then
        cmd_safe=true
        break
      fi
    done
    $cmd_safe && continue

    for pattern in "${LONG_PATTERNS[@]}"; do
      if echo "$check_cmd" | grep -qE "$pattern"; then
        cat >&2 <<'FEEDBACK'
BLOCKED: This command may run for more than 2 seconds and must use nohup.

MANDATORY pattern:
  nohup bash -c '<command>' > /tmp2/trace-<name>.log 2>&1 &
  echo "PID: $!"

Then check results in a SEPARATE tool call:
  tail -50 /tmp2/trace-<name>.log
FEEDBACK
        echo "Blocked line: $check_cmd" >&2
        exit 2
      fi
    done
  done
done <<< "$CMD"

# Check for bare backgrounding without nohup
while IFS= read -r line; do
  trimmed=$(echo "$line" | sed 's/[[:space:]]*$//')
  [[ -z "$trimmed" || "$trimmed" == \#* ]] && continue
  if [[ "$trimmed" == *'&' && "$trimmed" != *'&&' ]]; then
    if ! echo "$trimmed" | grep -q 'nohup'; then
      cat >&2 <<'FEEDBACK'
BLOCKED: Command backgrounds a process without nohup.

MANDATORY pattern:
  nohup command < /dev/null > /tmp2/trace-<name>.log 2>&1 &
FEEDBACK
      exit 2
    fi
  fi
done <<< "$CMD"

# Unknown command — allow (avoid false positives)
exit 0
