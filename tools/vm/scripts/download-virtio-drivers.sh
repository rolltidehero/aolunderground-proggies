#!/bin/bash
set -euo pipefail

LAB="$HOME/malware-lab"
ISO="$LAB/iso/virtio-win.iso"

if [ -f "$ISO" ]; then
    echo "virtio-win ISO already exists at $ISO"
    exit 0
fi

echo "=== Downloading virtio-win drivers ==="
wget -O "$ISO" \
    "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"

SIZE=$(stat -c%s "$ISO")
if [ "$SIZE" -lt 400000000 ]; then
    echo "WARNING: ISO seems too small ($SIZE bytes). Re-download."
    rm -f "$ISO"
    exit 1
fi
echo "Downloaded to $ISO ($SIZE bytes)"
