#!/usr/bin/env bash
# preToolUse hook: blocks fs_write of Python files that violate python.md steering rules.
# Exit 0 = allow, Exit 2 = block.
#
# Enforces structurally-checkable rules from python.md:
#   1.  from __future__ import annotations
#   2.  import argparse (CLI scripts only)
#   3.  def main() -> int (CLI scripts only)
#   4.  if __name__ == "__main__" guard (CLI scripts only)
#   5.  except KeyboardInterrupt handler (CLI scripts only)
#   6.  logger = logging.getLogger(__name__)
#   7.  No print() calls
#   8.  All def statements have return type annotations
#   9.  No bare except: clauses
#  10.  No silently swallowed exceptions (except ...: pass)
#  11.  No import * wildcard imports
#  12.  No os.system() or subprocess with shell=True
#  13.  No eval() or exec() calls
#  14.  No mutable default arguments
#  15.  No os.path usage (use pathlib)
#  16.  encoding="utf-8" on read_text/write_text/open calls
#  17.  No hardcoded credentials
#  18.  No f-strings in logger calls
set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  fs_write|write) ;;
  *) exit 0 ;;
esac

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

case "$FILE_PATH" in
  *.py|*.pyw) ;;
  *) exit 0 ;;
esac

BASENAME=$(basename "$FILE_PATH")
case "$BASENAME" in
  test_*|*_test.py|conftest.py|__init__.py|setup.py) exit 0 ;;
esac

IS_LIB=0
case "$FILE_PATH" in
  */lib/*) IS_LIB=1 ;;
esac

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

VIOLATIONS=""

# 1. from __future__ import annotations
if ! echo "$CONTENT" | grep -qP '^from __future__ import annotations'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'from __future__ import annotations'"
fi

if [[ "$IS_LIB" -eq 0 ]]; then

# 2. import argparse
if ! echo "$CONTENT" | grep -qP '^\s*(import argparse|from argparse)'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'import argparse' — every CLI script must use argparse"
fi

# 3. def main() -> int
if ! echo "$CONTENT" | grep -qP '^\s*def main\s*\(.*\)\s*->\s*int\s*:'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'def main() -> int:' entry point"
fi

# 4. if __name__ == "__main__" guard
if ! echo "$CONTENT" | grep -qP 'if\s+__name__\s*==\s*["\x27]__main__["\x27]'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] if __name__ == '__main__' guard"
fi

# 5. except KeyboardInterrupt handler
if ! echo "$CONTENT" | grep -qP 'except\s+KeyboardInterrupt'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'except KeyboardInterrupt' handler"
fi

fi  # end CLI-specific checks

# 6. logger = logging.getLogger
if ! echo "$CONTENT" | grep -qP '^\s*logger\s*=\s*logging\.getLogger'; then
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] 'logger = logging.getLogger(__name__)'"
fi

# 7. No print() calls (unless # stdout-ok declared)
if ! echo "$CONTENT" | grep -qP '^\s*#\s*stdout-ok' && echo "$CONTENT" | grep -qP '^\s*print\s*\('; then
  PRINT_COUNT=$(echo "$CONTENT" | grep -cP '^\s*print\s*\(' || true)
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] ${PRINT_COUNT} print() call(s) — use logger.info/warning/error"
fi

# 8. All def statements must have return type annotations
TOTAL_DEFS=$(echo "$CONTENT" | grep -cP '^\s*def\s+' || true)
if [ "${TOTAL_DEFS:-0}" -gt 0 ]; then
  MISSING_HINTS=$(echo "$CONTENT" | grep -P '^\s*def\s+\w+\s*\([^)]*\)\s*:' | grep -vP '\->' | head -5 || true)
  if [ -n "$MISSING_HINTS" ]; then
    MISSING_COUNT=$(echo "$MISSING_HINTS" | wc -l)
    FIRST_BAD=$(echo "$MISSING_HINTS" | head -1 | sed 's/^[[:space:]]*//' | cut -c1-80)
    VIOLATIONS="${VIOLATIONS}\n  [MISSING] ${MISSING_COUNT} function(s) lack return type hints. First: '${FIRST_BAD}'"
  fi
fi

# 9. No bare except: clauses
if echo "$CONTENT" | grep -qP '^\s*except\s*:'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] bare 'except:' — always catch specific exceptions"
fi

# 10. No silently swallowed exceptions
SWALLOWED=$(echo "$CONTENT" | awk '/^[[:space:]]*except[[:space:]].*:[[:space:]]*$/ { saw=NR; next }
  saw && NR==saw+1 && /^[[:space:]]*pass[[:space:]]*$/ { print NR; exit }
  { saw=0 }')
if [[ -n "$SWALLOWED" ]]; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] silently swallowed exception (except ...: pass) at line ${SWALLOWED}"
fi

# 11. No import * wildcard imports
if echo "$CONTENT" | grep -qP '^\s*from\s+\S+\s+import\s+\*'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] 'from X import *' wildcard import"
fi

# 12. No os.system() or subprocess with shell=True
if echo "$CONTENT" | grep -qP 'os\.system\s*\('; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] os.system() — use subprocess.run() with argument lists"
fi
if echo "$CONTENT" | grep -qP 'subprocess\.(call|run|Popen)\s*\(.*shell\s*=\s*True'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] subprocess with shell=True — use argument lists"
fi

# 13. No eval() or exec() calls
if echo "$CONTENT" | grep -qP '(?<!\w)(eval|exec)\s*\('; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] eval()/exec() call"
fi

# 14. No mutable default arguments
if echo "$CONTENT" | grep -qP '^\s*def\s+.*=\s*(\[\]|\{\})'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] mutable default argument (def f(x=[]) or def f(x={}))"
fi

# 15. No os.path usage (use pathlib)
if echo "$CONTENT" | grep -qP '(import os\.path|os\.path\.)'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] os.path usage — use pathlib.Path"
fi

# 16. encoding="utf-8" on read_text/write_text/open calls
JOINED=$(echo "$CONTENT" | awk '
  /[,(]\s*$/ { buf = buf $0 " "; next }
  { if (buf) { print buf $0; buf="" } else { print } }
  END { if (buf) print buf }
')

BAD_IO=$(echo "$JOINED" | grep -nP '\.(read_text|write_text)\s*\(' | grep -vP 'encoding' || true)
if [ -n "$BAD_IO" ]; then
  BAD_IO_COUNT=$(echo "$BAD_IO" | wc -l)
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] encoding='utf-8' on ${BAD_IO_COUNT} read_text/write_text call(s)"
fi

BAD_OPEN=$(echo "$JOINED" | grep -nP '\bopen\s*\(' | grep -vP 'encoding|"rb"|"wb"|'"'"'rb'"'"'|'"'"'wb'"'"'' || true)
if [ -n "$BAD_OPEN" ]; then
  BAD_OPEN_COUNT=$(echo "$BAD_OPEN" | wc -l)
  VIOLATIONS="${VIOLATIONS}\n  [MISSING] encoding='utf-8' on ${BAD_OPEN_COUNT} open() call(s)"
fi

# 17. No hardcoded credentials
if echo "$CONTENT" | grep -qiP '(password|passwd|secret|api_key|token)\s*=\s*["\x27][^"\x27]{4,}["\x27]'; then
  SUSPECT=$(echo "$CONTENT" | grep -inP '(password|passwd|secret|api_key|token)\s*=\s*["\x27][^"\x27]{4,}["\x27]' | grep -vP '(help=|#|description|\.get\(|\.add_argument)' || true)
  if [ -n "$SUSPECT" ]; then
    VIOLATIONS="${VIOLATIONS}\n  [SECURITY] possible hardcoded credential detected"
  fi
fi

# 18. No f-strings in logger calls
if echo "$CONTENT" | grep -qP 'logger\.(debug|info|warning|error|critical|exception)\s*\(\s*f["\x27]'; then
  VIOLATIONS="${VIOLATIONS}\n  [FORBIDDEN] f-string in logger call — use logger.info('msg: %s', val)"
fi

if [ -z "$VIOLATIONS" ]; then
  exit 0
fi

VIOLATION_COUNT=$(echo -e "$VIOLATIONS" | grep -c '\[' || echo "0")

cat >&2 << BLOCKED
BLOCKED by enforce-python-steering hook.

File: $FILE_PATH
Violations: $VIOLATION_COUNT
$(echo -e "$VIOLATIONS")

Fix ALL violations before writing this file.
Reference: .kiro/steering/python.md
BLOCKED
exit 2
