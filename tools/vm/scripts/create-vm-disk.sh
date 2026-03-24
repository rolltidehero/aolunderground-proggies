#!/bin/bash
set -euo pipefail

LAB="$HOME/malware-lab"
DISK="$LAB/win10-analysis.qcow2"

if [ -f "$DISK" ]; then
    echo "Disk already exists at $DISK"
    exit 0
fi

echo "=== Creating 80G qcow2 disk ==="
qemu-img create -f qcow2 "$DISK" 80G
echo "Created $DISK"
