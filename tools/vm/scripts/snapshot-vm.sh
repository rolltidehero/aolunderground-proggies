#!/bin/bash
set -euo pipefail

DISK="$HOME/malware-lab/win10-analysis.qcow2"
ACTION="${1:-list}"
NAME="${2:-}"

if pgrep -f "qemu-system.*win10-analysis" > /dev/null 2>&1; then
    echo "ERROR: VM is running. Stop it first."
    exit 1
fi

case "$ACTION" in
    create)
        [ -z "$NAME" ] && { echo "Usage: $0 create <name>"; exit 1; }
        qemu-img snapshot -c "$NAME" "$DISK"
        echo "Snapshot '$NAME' created."
        ;;
    restore)
        [ -z "$NAME" ] && { echo "Usage: $0 restore <name>"; exit 1; }
        qemu-img snapshot -a "$NAME" "$DISK"
        echo "Snapshot '$NAME' restored."
        ;;
    list)
        qemu-img snapshot -l "$DISK"
        ;;
    delete)
        [ -z "$NAME" ] && { echo "Usage: $0 delete <name>"; exit 1; }
        qemu-img snapshot -d "$NAME" "$DISK"
        echo "Snapshot '$NAME' deleted."
        ;;
    *)
        echo "Usage: $0 {create|restore|list|delete} [name]"
        exit 1
        ;;
esac
