#!/usr/bin/env python3
r"""Push a file to the running VM via QEMU Guest Agent.

Usage: python3 push_file.py <local_path> <guest_path>
Example: python3 push_file.py ./app.exe 'C:\Users\lab\Desktop\app.exe'
"""
import sys, socket, json, base64, os

QGA_SOCK = "/tmp/vm-qga.sock"
CHUNK = 1024 * 1024  # 1MB chunks

def qga_cmd(sock, cmd, args=None):
    req = {"execute": cmd}
    if args:
        req["arguments"] = args
    sock.sendall(json.dumps(req).encode() + b"\n")
    buf = b""
    while True:
        buf += sock.recv(4096)
        try:
            return json.loads(buf)
        except json.JSONDecodeError:
            continue

def push_file(local_path, guest_path):
    data = open(local_path, "rb").read()
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(QGA_SOCK)
    s.settimeout(30)

    # Sync first (flush any stale responses)
    qga_cmd(s, "guest-sync", {"id": 54321})

    resp = qga_cmd(s, "guest-file-open", {"path": guest_path, "mode": "wb"})
    if "error" in resp:
        # Retry once after a brief pause (stale handle from previous run)
        s.close()
        import time; time.sleep(2)
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.connect(QGA_SOCK)
        s.settimeout(30)
        qga_cmd(s, "guest-sync", {"id": 54322})
        resp = qga_cmd(s, "guest-file-open", {"path": guest_path, "mode": "wb"})
    handle = resp["return"]

    for i in range(0, len(data), CHUNK):
        chunk = base64.b64encode(data[i:i+CHUNK]).decode()
        qga_cmd(s, "guest-file-write", {"handle": handle, "buf-b64": chunk})

    qga_cmd(s, "guest-file-close", {"handle": handle})
    s.close()
    print(f"Pushed {len(data)} bytes -> {guest_path}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <local_path> <guest_path>")
        sys.exit(1)
    push_file(sys.argv[1], sys.argv[2])
