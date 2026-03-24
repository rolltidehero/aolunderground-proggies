#!/bin/bash
# Launch the decompiler VM using the gold image with decompiler + crack.
# This is a thin wrapper around launch-vm.sh that overrides the disk path.
set -euo pipefail

export MALWARE_LAB_DISK="$HOME/malware-lab/win10-x86-qga-c2-gold-image-with-decompiler-and-crack.qcow2"

if [ ! -f "$MALWARE_LAB_DISK" ]; then
    echo "ERROR: Decompiler disk not found: $MALWARE_LAB_DISK"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/launch-vm.sh" "${1:-run}"
