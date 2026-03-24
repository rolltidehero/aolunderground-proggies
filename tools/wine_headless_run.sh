#!/usr/bin/env bash
# wine_headless_run.sh — Run a Wine GUI app headlessly with AHK automation
# Usage: wine_headless_run.sh <work_dir> <exe> <arg> [ahk_script]
set -euo pipefail

WORK_DIR="$1"
EXE="$2"
ARG="${3:-}"
AHK_SCRIPT="${4:-}"
AHK_EXE="/tmp/ahk/AutoHotkeyU32.exe"
DISPLAY_NUM=":99"
LOG_DIR="/tmp/wine_headless"
TIMEOUT=120

mkdir -p "$LOG_DIR"

cleanup() {
    echo "Cleaning up..."
    DISPLAY=$DISPLAY_NUM wineserver -k 2>/dev/null || true
    pkill -f "Xvfb $DISPLAY_NUM" 2>/dev/null || true
    sleep 1
}
trap cleanup EXIT

# Kill stale processes
pkill -f "Xvfb $DISPLAY_NUM" 2>/dev/null || true
sleep 1

# Start Xvfb
Xvfb $DISPLAY_NUM -screen 0 800x600x24 &
XVFB_PID=$!
sleep 1

if ! kill -0 $XVFB_PID 2>/dev/null; then
    echo "ERROR: Xvfb failed to start"
    exit 1
fi
echo "Xvfb started on $DISPLAY_NUM (pid $XVFB_PID)"

# Launch the Wine app
cd "$WORK_DIR"
DISPLAY=$DISPLAY_NUM wine "$EXE" "$ARG" &
WINE_PID=$!
echo "Wine started: $EXE $ARG (pid $WINE_PID)"

# Launch AHK automation if script provided
if [[ -n "$AHK_SCRIPT" && -f "$AHK_EXE" ]]; then
    # Convert to Windows path for AHK
    AHK_WIN_PATH=$(DISPLAY=$DISPLAY_NUM winepath -w "$AHK_SCRIPT" 2>/dev/null || echo "")
    if [[ -n "$AHK_WIN_PATH" ]]; then
        DISPLAY=$DISPLAY_NUM wine "$AHK_EXE" "$AHK_WIN_PATH" &
        echo "AHK automation started: $AHK_SCRIPT"
    else
        echo "WARNING: Could not convert AHK script path, running without automation"
    fi
fi

# Monitor loop — screenshot + OCR logging for human observation
ELAPSED=0
SHOT=0
while kill -0 $WINE_PID 2>/dev/null; do
    if (( ELAPSED >= TIMEOUT )); then
        echo "TIMEOUT after ${TIMEOUT}s — killing"
        kill $WINE_PID 2>/dev/null || true
        break
    fi

    sleep 5
    ELAPSED=$((ELAPSED + 5))
    SHOT=$((SHOT + 1))

    # Screenshot + OCR for logging only
    SFILE="$LOG_DIR/shot_$(printf '%03d' $SHOT).png"
    DISPLAY=$DISPLAY_NUM import -window root "$SFILE" 2>/dev/null || continue
    echo "--- screenshot $SHOT (${ELAPSED}s) ---"
    tesseract "$SFILE" stdout 2>/dev/null || true

    # Log visible windows
    DISPLAY=$DISPLAY_NUM xdotool search --onlyvisible --name "" 2>/dev/null | while read -r wid; do
        name=$(DISPLAY=$DISPLAY_NUM xdotool getwindowname "$wid" 2>/dev/null || true)
        [[ -n "$name" ]] && echo "  window: $name"
    done
done

wait $WINE_PID 2>/dev/null || true
echo "Wine process exited"

# Check for output
echo "--- Output check ---"
ls -la "$WORK_DIR"/ 2>/dev/null | tail -20
