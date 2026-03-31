#!/usr/bin/env bash
# preToolUse hook: blocks fs_write of Bash scripts that violate bash.md steering rules.
# Runs BEFORE the file is written. Exit 0 = allow, Exit 2 = block.
#
# Enforces every structurally-checkable rule from bash.md:
#
# Script Header (MANDATORY):
#   1.  #!/usr/bin/env bash shebang
#   2.  set -euo pipefail
#
# Required Elements:
#   3.  Usage/help function (--help or -h handling)
#   4.  Trap for cleanup on EXIT
#   5.  Trap for INT/TERM (interrupt handling)
#
# Error Handling:
#   6.  cleanup() function defined
#
# Style:
#   7.  No backtick command substitution (use $())
#   8.  No single-bracket conditionals (use [[ ]])
#
# Only fires on .sh file creation. Non-bash writes pass through.
set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  fs_write|write) ;;
  *) exit 0 ;;
esac

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only check bash files
case "$FILE_PATH" in
  *.sh|*.bash) ;;
  *) exit 0 ;;
esac

# Resolve content for all mutation commands
case "$COMMAND" in
  create)
    CONTENT=$(echo "$INPUT" | jq -r '.tool_input.file_text // empty')
    ;;
  str_replace|append|insert)
    if [[ -f "$FILE_PATH" ]]; then
      CONTENT=$(printf '%s' "$INPUT" | python3 "$(dirname "$0")/resolve-content.py") || { echo "BLOCKED: failed to compute edited content for $FILE_PATH" >&2; exit 2; }
    else
      exit 0
    fi
    ;;
  *) exit 0 ;;
esac

[[ -z "$CONTENT" ]] && exit 0

# Write content to temp file to avoid SIGPIPE with large files
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT
printf '%s\n' "$CONTENT" > "$TMPFILE"

VIOLATIONS=""

# ============================================================
# SCRIPT HEADER (MANDATORY)
# ============================================================

# 1. Shebang: #!/usr/bin/env bash
FIRST_LINE=$(head -1 "$TMPFILE")
if ! grep -qP '^#!/usr/bin/env bash|^#!/bin/bash' <<< "$FIRST_LINE"; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] '#!/usr/bin/env bash' shebang as first line (bash.md: Script Header)"
fi

# 2. set -euo pipefail
if ! grep -qP '^\s*set\s+-euo\s+pipefail' "$TMPFILE"; then
  # Also accept split form
  if ! grep -qP '^\s*set\s+.*-e' "$TMPFILE" || ! grep -qP '^\s*set\s+.*-u' "$TMPFILE" || ! grep -qP '^\s*set\s+-o\s+pipefail' "$TMPFILE"; then
    VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'set -euo pipefail' (bash.md: Script Header MANDATORY)"
  fi
fi

# ============================================================
# REQUIRED ELEMENTS
# ============================================================

# 3. Usage/help function (--help or -h handling)
#    Require actual flag handling patterns, not just the word "help" in a comment
if ! grep -qP '(--help|-h\)|-h\|--help|--help\||-h \)|-h\b.*\)|usage\(\)|show_usage|print_usage|display_help)' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] usage/help function accessible via --help or -h (bash.md: Required Elements)"
fi

# 4. Trap for cleanup on EXIT
if ! grep -qP '^\s*trap\s+.*EXIT' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'trap cleanup EXIT' — trap for cleanup on exit (bash.md: Required Elements)"
fi

# 5. Trap for INT/TERM (interrupt handling)
if ! grep -qP '^\s*trap\s+.*(INT|TERM)' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'trap ... INT TERM' — trap for interrupt handling (bash.md: Error Handling)"
fi

# ============================================================
# ERROR HANDLING
# ============================================================

# 6. cleanup() function defined (only if trap references cleanup)
if grep -qP '^\s*trap\s+.*cleanup.*EXIT' "$TMPFILE" && ! grep -qP '^\s*(cleanup\s*\(\)|function\s+cleanup)' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] cleanup() function — referenced in trap but not defined (bash.md: Error Handling)"
fi

# ============================================================
# STYLE
# ============================================================

# 7. No backtick command substitution (use $())
BACKTICK_LINES=$(grep -nP '`[^`]+`' "$TMPFILE" | grep -vP '^\d+:\s*#' || true)
if [[ -n "$BACKTICK_LINES" ]]; then
  BT_COUNT=$(wc -l <<< "$BACKTICK_LINES")
  FIRST_BT=$(head -1 <<< "$BACKTICK_LINES" | sed 's/^[[:space:]]*//' | cut -c1-80)
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] ${BT_COUNT} backtick command substitution(s) — use \$() instead. First: '${FIRST_BT}' (bash.md: Style)"
fi

# 8. No single-bracket conditionals (use [[ ]])
#    Match lines starting with if/elif/while/until followed by [ but not [[
#    Also match standalone [ ... ] test commands
#    Exclude comment lines and [ inside strings (printf, echo)
SINGLE_BRACKET=$(grep -nP '^\s*(if|elif|while|until)\s+\[\s+[^[]' "$TMPFILE" | grep -vP '^\d+:\s*#' || true)
# Also catch standalone: [ -f foo ] && ...
SB_STANDALONE=$(grep -nP '^\s*\[\s+[^[]' "$TMPFILE" | grep -vP '^\d+:\s*#' || true)
SINGLE_BRACKET="${SINGLE_BRACKET}${SB_STANDALONE}"
SINGLE_BRACKET=$(echo "$SINGLE_BRACKET" | sed '/^$/d' | sort -t: -k1,1n -u || true)
if [[ -n "$SINGLE_BRACKET" ]]; then
  SB_COUNT=$(wc -l <<< "$SINGLE_BRACKET")
  FIRST_SB=$(head -1 <<< "$SINGLE_BRACKET" | sed 's/^[[:space:]]*//' | cut -c1-80)
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] ${SB_COUNT} single-bracket conditional(s) — use [[ ]] instead. First: '${FIRST_SB}' (bash.md: Style)"
fi

# ============================================================
# ANTI-PATTERNS (FORBIDDEN — from BashPitfalls)
# ============================================================

# 9. No parsing ls output (BashPitfalls #1)
if grep -qP 'for\s+\w+\s+in\s+\$\(ls\b' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] 'for x in \$(ls ...)' — never parse ls output, use globs (BashPitfalls #1)"
fi

# 10. No read without -r (BashPitfalls)
READ_NO_R=$(grep -nP '^\s*read\s+(?!.*-r)' "$TMPFILE" | grep -vP '^\d+:\s*#' || true)
if [[ -n "$READ_NO_R" ]]; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] 'read' without -r flag — backslashes will be mangled. Use 'read -r' (BashPitfalls)"
fi

# 11. No printf "$var" format string injection (BashPitfalls #32)
if grep -qP '^\s*printf\s+"?\$\w' "$TMPFILE"; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] 'printf \"\$var\"' — format string injection. Use 'printf \"%s\" \"\$var\"' (BashPitfalls #32)"
fi

# 12. No multi-line embedded Python in bash — write a .py file instead
#     Detects: python3 -c with import on next line (multi-line -c string)
#     Heredocs (python3 << EOF) are allowed — they're lintable and readable
EMBEDDED_PY=$(awk '
  /python3? -c/ { cline=NR; next }
  cline && NR==cline+1 && /^[[:space:]]*(import |from )/ { print cline; exit }
' "$TMPFILE")
if [[ -n "$EMBEDDED_PY" ]]; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] multi-line embedded Python in bash at line ${EMBEDDED_PY} — write a .py file instead (bash.md: Anti-Patterns)"
fi

# ============================================================
# RESULT
# ============================================================

if [[ -z "$VIOLATIONS" ]]; then
  exit 0
fi

VIOLATION_COUNT=$(echo -e "$VIOLATIONS" | grep -c '\[' || echo "0")

cat >&2 << BLOCKED
BLOCKED by enforce-bash-steering hook.

File: $FILE_PATH
Violations: $VIOLATION_COUNT
$(echo -e "$VIOLATIONS")

Fix ALL violations before writing this file.

Reference: .kiro/steering/bash.md — these rules are MANDATORY for every
Bash script. Required elements:

  Header:    #!/usr/bin/env bash + set -euo pipefail
  Required:  usage/help function, trap cleanup EXIT, trap INT TERM
  Errors:    cleanup() function defined
  Style:     No backticks (use \$()), no [ ] (use [[ ]]),
             quote all variable expansions
BLOCKED
exit 2
