#!/bin/bash
set -euo pipefail

echo "=== Installing host dependencies ==="

sudo apt update
sudo apt install -y qemu-system-x86 qemu-utils ovmf socat curl wget jq

# virtiofsd may not be available on older distros
if apt-cache show virtiofsd &>/dev/null; then
    sudo apt install -y virtiofsd
    echo "virtiofsd: installed"
else
    echo "virtiofsd: not available, will use 9p fallback"
fi

# KVM group access
sudo usermod -aG kvm "$USER" 2>/dev/null || true
sudo usermod -aG libvirt "$USER" 2>/dev/null || true

# Create directory structure
LAB="$HOME/malware-lab"
mkdir -p "$LAB"/{share/{input,output,recordings,tasks},iso}

# Verify KVM
if [ -e /dev/kvm ]; then
    echo "KVM: ready"
else
    echo "WARNING: /dev/kvm not found. Enable SVM/VT-x in BIOS."
fi

echo "=== Done. Log out and back in for group changes. ==="
