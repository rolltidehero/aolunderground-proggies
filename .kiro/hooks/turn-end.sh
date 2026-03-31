#!/usr/bin/env bash
# stop hook: clear THIS session's nonce so next turn starts clean.
set -euo pipefail
NONCE_DIR="${KIRO_NONCE_DIR:-/dev/shm/kiro-hooks}"
SESSION_ID="${KIRO_SESSION_ID:-$PPID}"
rm -f "${NONCE_DIR}/nonce-${SESSION_ID}"
exit 0
