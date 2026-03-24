#!/bin/bash
set -euo pipefail

LAB="$HOME/malware-lab"
ISO="$LAB/iso/Win10.iso"

if [ -f "$ISO" ]; then
    echo "Win10 ISO already exists at $ISO"
    exit 0
fi

echo "=== Downloading Windows 10 ISO via Mido ==="
MIDO_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/ElliotKillick/Mido.git "$MIDO_DIR"
cd "$MIDO_DIR"
chmod +x Mido.sh

if ./Mido.sh win10x64; then
    mv *.iso "$ISO"
    echo "Downloaded to $ISO"
else
    echo "Mido failed. Download manually and place at: $ISO"
    echo "https://www.microsoft.com/en-us/software-download/windows10ISO"
fi

rm -rf "$MIDO_DIR"
