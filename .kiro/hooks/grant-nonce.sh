#!/usr/bin/env bash
# userPromptSubmit hook: write a fresh nonce on every user message.
set -euo pipefail
NONCE_DIR="${KIRO_NONCE_DIR:-/dev/shm/kiro-hooks}"
SESSION_ID="${KIRO_SESSION_ID:-$PPID}"
mkdir -p "$NONCE_DIR"
echo "fresh" > "${NONCE_DIR}/nonce-${SESSION_ID}"
# Clean stale nonce files from dead sessions
for f in "${NONCE_DIR}"/nonce-*; do
  [[ -f "$f" ]] || continue
  _pid="${f##*nonce-}"
  [[ "$_pid" =~ ^[0-9]+$ ]] || continue
  kill -0 "$_pid" 2>/dev/null || rm -f "$f"
done
exit 0
