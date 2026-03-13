#!/bin/bash
set -euo pipefail

QMP_SOCK="/tmp/vm-qmp.sock"

if [ ! -S "$QMP_SOCK" ]; then
    echo "VM not running (no QMP socket)"
    exit 0
fi

echo "Sending ACPI powerdown..."
echo '{"execute":"qmp_capabilities"}' | socat - "UNIX-CONNECT:$QMP_SOCK" > /dev/null 2>&1 || true
echo '{"execute":"system_powerdown"}' | socat - "UNIX-CONNECT:$QMP_SOCK" > /dev/null 2>&1 || true

# Wait up to 60s
for i in $(seq 1 60); do
    if ! pgrep -f "qemu-system.*win10-analysis" > /dev/null 2>&1; then
        echo "VM stopped cleanly."
        rm -f "$QMP_SOCK" /tmp/vm-c2.sock
        exit 0
    fi
    sleep 1
done

echo "VM didn't stop gracefully. Force killing..."
echo '{"execute":"quit"}' | socat - "UNIX-CONNECT:$QMP_SOCK" > /dev/null 2>&1 || true
sleep 2
pkill -f "qemu-system.*win10-analysis" 2>/dev/null || true
rm -f "$QMP_SOCK" /tmp/vm-c2.sock
echo "VM killed."
