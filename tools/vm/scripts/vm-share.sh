#!/bin/bash
set -euo pipefail
# Sync files to/from the VM shared disk image
# Usage: vm-share.sh push file1 [file2 ...]   — copy files to share
#        vm-share.sh pull                      — list files on share
#        vm-share.sh pull file                 — copy file from share
# NOTE: VM must be stopped OR image not in use

IMG="$HOME/malware-lab/share.img"

case "${1:-}" in
    push)
        shift
        sudo mount -o loop "$IMG" /mnt
        for f in "$@"; do sudo cp "$f" /mnt/; done
        ls -la /mnt/
        sudo umount /mnt
        ;;
    pull)
        sudo mount -o loop,ro "$IMG" /mnt
        if [ -n "${2:-}" ]; then
            cp "/mnt/$2" .
        else
            ls -la /mnt/
        fi
        sudo umount /mnt
        ;;
    *)
        echo "Usage: $0 push file1 [file2 ...] | pull [file]"
        exit 1
        ;;
esac
