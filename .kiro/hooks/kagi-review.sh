#!/usr/bin/env bash
# postToolUse hook: run kagi multi-model review on new scripts.
# Fires after fs_write creates a new .py, .sh, or .ps1 file.
# Non-blocking — results printed as warning, does not block the write.
set -uo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  fs_write|write) ;;
  *) exit 0 ;;
esac

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
FILEPATH=$(echo "$INPUT" | jq -r '.tool_input.path // empty')

# Only trigger on create (new files)
[[ "$CMD" != "create" ]] && exit 0
[[ -z "$FILEPATH" ]] && exit 0

# Only for supported languages
case "$FILEPATH" in
  *.py|*.sh|*.ps1) ;;
  *) exit 0 ;;
esac

# Skip small files (<50 lines) — not worth reviewing
LINE_COUNT=$(wc -l < "$FILEPATH" 2>/dev/null || echo 0)
[[ "$LINE_COUNT" -lt 50 ]] && exit 0

# Warn on large files (>95000 chars) but continue — models may truncate
CHAR_COUNT=$(wc -c < "$FILEPATH" 2>/dev/null || echo 0)
if [[ "$CHAR_COUNT" -gt 95000 ]]; then
  echo "WARNING: $BASENAME is ${CHAR_COUNT} chars (>95000). Models may truncate. Consider splitting." >&2
fi

# Skip large files (>100000 chars) — exceeds Kagi limit
CHAR_COUNT=$(wc -c < "$FILEPATH" 2>/dev/null || echo 0)
[[ "$CHAR_COUNT" -gt 100000 ]] && exit 0

# Skip test files
BASENAME=$(basename "$FILEPATH")
case "$BASENAME" in
  test_*|*_test.py|conftest.py|__init__.py) exit 0 ;;
esac

# Skip if no kagi session
[[ ! -f "$HOME/.secrets/kagi_session.txt" ]] && exit 0

# Run review in background — don't block the agent
REPO_ROOT=$(git -C "$(dirname "$FILEPATH")" rev-parse --show-toplevel 2>/dev/null || echo "")
[[ -z "$REPO_ROOT" ]] && exit 0

REVIEW_SCRIPT="$REPO_ROOT/tools/kagi-review.py"
[[ ! -f "$REVIEW_SCRIPT" ]] && exit 0

# Run with nohup, save output for the agent to check
TRACE_DIR="$HOME/traces/kagi-review"
mkdir -p "$TRACE_DIR"
OUTFILE="$TRACE_DIR/$(date -u +%Y%m%dT%H%M%SZ)-$(basename "$FILEPATH").txt"

nohup bash -c "cd '$REPO_ROOT' && PYTHONPATH=. python3 '$REVIEW_SCRIPT' -f '$FILEPATH' -q > '$OUTFILE' 2>&1" &

echo "Kagi review started for $BASENAME (PID $!, results: $OUTFILE)" >&2
exit 0
