#!/usr/bin/env python3
r"""One-time guest setup for virtiofs shared directory.

Run this from the host after VM boots. It uses QGA to:
1. Copy viofs driver files from the virtio-win USB disk (D:\) to guest
2. Install the viofs driver via pnputil
3. Download and install WinFSP (or use a pre-staged installer)
4. Register and start the VirtioFsSvc service
5. Configure mount point E:\ via registry

Prerequisites:
- VM running with virtiofs QEMU args
- QGA responding on /tmp/vm-qga.sock
- Virtio-win ISO contents accessible at D:\ in guest (USB share disk)
- WinFSP installer staged at D:\input\WinFsp.msi
"""
import sys, socket, json, time, base64

QGA_SOCK = "/tmp/vm-qga.sock"

def qga_cmd(sock, cmd, args=None):
    req = {"execute": cmd}
    if args:
        req["arguments"] = args
    sock.sendall(json.dumps(req).encode() + b"\n")
    buf = b""
    while True:
        buf += sock.recv(8192)
        try:
            return json.loads(buf)
        except json.JSONDecodeError:
            continue

def guest_exec(sock, path, args=None, wait=True):
    ea = {"path": path, "capture-output": True}
    if args:
        ea["arg"] = args
    resp = qga_cmd(sock, "guest-exec", ea)
    pid = resp["return"]["pid"]
    if not wait:
        return pid, None, None
    for _ in range(120):
        time.sleep(1)
        st = qga_cmd(sock, "guest-exec-status", {"pid": pid})
        if st["return"].get("exited"):
            out = base64.b64decode(st["return"].get("out-data", "")).decode(errors="replace")
            err = base64.b64decode(st["return"].get("err-data", "")).decode(errors="replace")
            rc = st["return"].get("exitcode", -1)
            return rc, out, err
    return -1, "", "timeout"

def main():
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(QGA_SOCK)
    s.settimeout(30)

    # Sync
    s.sendall(b'\xff' * 4 + b'\n')
    try: s.recv(4096)
    except: pass

    print("1. Installing viofs driver from D:\\...")
    rc, out, err = guest_exec(s, "pnputil.exe", ["/add-driver", "D:\\viofs\\w10\\x86\\viofs.inf", "/install"])
    print(f"   pnputil: rc={rc}\n   {out.strip()}")

    print("2. Installing WinFSP...")
    rc, out, err = guest_exec(s, "msiexec.exe", ["/i", "D:\\input\\WinFsp.msi", "/quiet", "/norestart", "ADDLOCAL=Core"])
    print(f"   WinFSP: rc={rc}")

    print("3. Creating VirtIO-FS directory...")
    guest_exec(s, "cmd.exe", ["/c", "mkdir", "C:\\Program Files\\VirtIO-FS"])

    print("4. Copying virtiofs.exe...")
    rc, out, err = guest_exec(s, "cmd.exe", ["/c", "copy", "D:\\viofs\\w10\\x86\\virtiofs.exe", "C:\\Program Files\\VirtIO-FS\\virtiofs.exe"])
    print(f"   copy: rc={rc} {out.strip()}")

    print("5. Registering VirtioFsSvc service...")
    rc, out, err = guest_exec(s, "sc.exe", ["create", "VirtioFsSvc",
        'binPath=C:\\Program Files\\VirtIO-FS\\virtiofs.exe',
        "start=auto", "depend=VirtioFsDrv"])
    print(f"   sc create: rc={rc} {out.strip()}")

    print("6. Setting mount point E:\\ via registry...")
    rc, out, err = guest_exec(s, "reg.exe", ["add", "HKLM\\Software\\VirtIO-FS",
        "/v", "MountPoint", "/t", "REG_SZ", "/d", "E:", "/f"])
    print(f"   reg: rc={rc} {out.strip()}")

    print("7. Starting VirtioFsSvc...")
    rc, out, err = guest_exec(s, "sc.exe", ["start", "VirtioFsSvc"])
    print(f"   sc start: rc={rc} {out.strip()}")

    print("8. Verifying E:\\ is accessible...")
    time.sleep(2)
    rc, out, err = guest_exec(s, "cmd.exe", ["/c", "dir", "E:\\"])
    print(f"   dir E:\\: rc={rc}\n   {out.strip()}")

    s.close()
    print("\nDone. Drop files into ~/malware-lab/share/ and they appear at E:\\ in the guest.")

if __name__ == "__main__":
    main()
