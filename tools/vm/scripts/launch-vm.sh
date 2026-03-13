#!/bin/bash
set -euo pipefail

MODE="${1:-run}"  # "install" or "run"

LAB="$HOME/malware-lab"
DISK="${MALWARE_LAB_DISK:-$LAB/win10-analysis.qcow2}"
WIN_ISO="$LAB/iso/Win10.iso"
VIRTIO_ISO="$LAB/iso/virtio-win.iso"
UNATTEND_IMG="$LAB/iso/unattend.img"
SHARE_IMG="$LAB/share.img"
SHARE_DIR="$LAB/share"          # virtiofs shared directory (live, no VM stop needed)
QMP_SOCK="/tmp/vm-qmp.sock"
C2_SOCK="/tmp/vm-c2.sock"
C2GUI_SOCK="/tmp/vm-c2gui.sock"
QGA_SOCK="/tmp/vm-qga.sock"
VIRTIOFS_SOCK="/tmp/vm-virtiofs.sock"

# Check KVM
if [ ! -e /dev/kvm ]; then
    echo "ERROR: /dev/kvm not found. Enable SVM in BIOS."
    exit 1
fi

# Check disk
if [ ! -f "$DISK" ]; then
    echo "ERROR: Disk not found at $DISK. Run create-vm-disk.sh first."
    exit 1
fi

# Clean stale sockets
rm -f "$QMP_SOCK" "$C2_SOCK" "$C2GUI_SOCK" "$QGA_SOCK" "$VIRTIOFS_SOCK"

# Create share directory if needed
mkdir -p "$SHARE_DIR"

# Start virtiofsd for live file sharing
if [ "$MODE" != "install" ]; then
    echo "Starting virtiofsd for $SHARE_DIR ..."
    /usr/libexec/virtiofsd \
        --socket-path="$VIRTIOFS_SOCK" \
        --shared-dir "$SHARE_DIR" \
        --sandbox none \
        --log-level warn &
    VIRTIOFSD_PID=$!
    disown $VIRTIOFSD_PID
    # Wait for socket to appear
    for i in $(seq 1 20); do
        [ -S "$VIRTIOFS_SOCK" ] && break
        sleep 0.1
    done
    if [ ! -S "$VIRTIOFS_SOCK" ]; then
        echo "ERROR: virtiofsd failed to start"
        kill $VIRTIOFSD_PID 2>/dev/null
        exit 1
    fi
    echo "virtiofsd running (PID $VIRTIOFSD_PID)"
fi

# Build QEMU args
ARGS=(
    -enable-kvm
    -cpu host
    -m 2G
    -smp 2
    # Shared memory backend required for virtiofs
    -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm,share=on
    -numa node,memdev=mem
    -drive "file=$DISK,format=qcow2,if=virtio"
    -nic none
    -device virtio-serial-pci
    -chardev "socket,path=$C2_SOCK,server=on,wait=off,id=c2chan"
    -device "virtserialport,chardev=c2chan,name=c2channel"
    -chardev "socket,path=$C2GUI_SOCK,server=on,wait=off,id=c2gui"
    -device "virtserialport,chardev=c2gui,name=c2guichannel"
    -chardev "socket,path=$QGA_SOCK,server=on,wait=off,id=qga0"
    -device "virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"
    -drive "file=$SHARE_IMG,format=raw,if=none,id=sharedisk"
    -device usb-storage,drive=sharedisk,removable=on
    -boot "order=c,strict=on"
    -qmp "unix:$QMP_SOCK,server,nowait"
    -display none
    -vnc :1
    -vga virtio
    -usb -device usb-tablet
    -daemonize
    # No -bios: SeaBIOS (QEMU default) for 32-bit Windows compatibility
)

# Add virtiofs args only in run mode (virtiofsd must be running)
if [ "$MODE" != "install" ]; then
    ARGS+=(
        -chardev "socket,id=virtiofs0,path=$VIRTIOFS_SOCK"
        -device "vhost-user-fs-pci,queue-size=1024,chardev=virtiofs0,tag=share"
    )
fi

if [ "$MODE" = "install" ]; then
    if [ ! -f "$WIN_ISO" ]; then
        echo "ERROR: Win10 ISO not found at $WIN_ISO"
        exit 1
    fi
    ARGS+=(-cdrom "$WIN_ISO")
    if [ -f "$VIRTIO_ISO" ]; then
        ARGS+=(-drive "file=$VIRTIO_ISO,media=cdrom,index=1")
    fi
    if [ -f "$UNATTEND_IMG" ]; then
        ARGS+=(-drive "file=$UNATTEND_IMG,format=raw,if=floppy,index=0")
    fi
    ARGS+=(-boot d)
    echo "Launching VM in INSTALL mode (VNC at localhost:5900)"
else
    echo "Launching VM in RUN mode"
fi

qemu-system-x86_64 "${ARGS[@]}"

echo "VM started. QMP: $QMP_SOCK  C2: $C2_SOCK  C2GUI: $C2GUI_SOCK  QGA: $QGA_SOCK"
echo "VNC: vncviewer localhost:5901"
echo "Live share: $SHARE_DIR -> guest drive (virtiofs tag=share)"
