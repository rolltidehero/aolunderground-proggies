"""
Guest agent for Windows 10 VM. Listens on virtio-serial for commands.
Runs as a startup task. No network required.

Usage:
  python agent.py                  # SYSTEM agent on c2channel
  python agent.py c2guichannel     # GUI agent on c2guichannel (run as lab user)
"""
import json, os, subprocess, sys, time, logging, traceback

CHANNEL = sys.argv[1] if len(sys.argv) > 1 else "c2channel"
LOG_PATH = r"C:\Tools\agent_%s_%d.log" % (CHANNEL, os.getpid())
CONFIG_PATH = r"C:\Tools\agent_config.json"
DEVICE_PATH = r"\\.\Global\%s" % CHANNEL
DEFAULT_VBD = r"C:\Tools\VBDecompiler\VB Decompiler.exe"

logging.basicConfig(filename=LOG_PATH, level=logging.DEBUG,
                    format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger("agent")


def load_config():
    cfg = {"vb_decompiler": DEFAULT_VBD}
    if os.path.exists(CONFIG_PATH):
        try:
            with open(CONFIG_PATH) as f:
                cfg.update(json.load(f))
        except Exception:
            pass
    return cfg


def open_device():
    """Open virtio-serial device using ctypes. Retry until available."""
    import ctypes, ctypes.wintypes
    k32 = ctypes.windll.kernel32
    GENERIC_RW = 0xC0000000
    OPEN_EXISTING = 3
    FILE_FLAG_OVERLAPPED = 0x40000000
    while True:
        h = k32.CreateFileW(DEVICE_PATH, GENERIC_RW, 0, None,
                            OPEN_EXISTING, FILE_FLAG_OVERLAPPED, None)
        if h != -1 and h != 0xFFFFFFFF:
            log.info("Device opened: %s handle=%d", DEVICE_PATH, h)
            return h
        err = k32.GetLastError()
        log.debug("Waiting for device: err=%d", err)
        time.sleep(2)


def read_command(handle, buf):
    """Read one JSON-newline command. Returns (cmd_dict, remaining_buf)."""
    import ctypes, ctypes.wintypes
    k32 = ctypes.windll.kernel32

    class OVERLAPPED(ctypes.Structure):
        _fields_ = [("Internal", ctypes.POINTER(ctypes.c_ulong)),
                     ("InternalHigh", ctypes.POINTER(ctypes.c_ulong)),
                     ("Offset", ctypes.wintypes.DWORD),
                     ("OffsetHigh", ctypes.wintypes.DWORD),
                     ("hEvent", ctypes.wintypes.HANDLE)]

    ERROR_IO_PENDING = 997
    rbuf = ctypes.create_string_buffer(4096)
    br = ctypes.wintypes.DWORD(0)

    while b"\n" not in buf:
        ovl = OVERLAPPED()
        evt = k32.CreateEventW(None, True, False, None)
        ovl.hEvent = evt
        try:
            ok = k32.ReadFile(handle, rbuf, 4096, ctypes.byref(br), ctypes.byref(ovl))
            err = k32.GetLastError()
            if ok:
                if br.value > 0:
                    buf += rbuf.raw[:br.value]
                continue
            if err == ERROR_IO_PENDING:
                wr = k32.WaitForSingleObject(evt, 5000)
                if wr == 0:  # SIGNALED
                    br.value = 0
                    k32.GetOverlappedResult(handle, ctypes.byref(ovl), ctypes.byref(br), False)
                    if br.value > 0:
                        buf += rbuf.raw[:br.value]
                        continue
                    # 0 bytes + signaled = 1450 (no host), retry
                else:
                    k32.CancelIoEx(handle, ctypes.byref(ovl))
            elif err == 1450:
                pass  # no host connected, retry
            else:
                log.error("ReadFile unexpected err=%d", err)
            time.sleep(1)
        finally:
            k32.CloseHandle(evt)
    line, buf = buf.split(b"\n", 1)
    return json.loads(line), buf


def send_response(handle, resp):
    import ctypes, ctypes.wintypes

    class OVERLAPPED(ctypes.Structure):
        _fields_ = [("Internal", ctypes.POINTER(ctypes.c_ulong)),
                     ("InternalHigh", ctypes.POINTER(ctypes.c_ulong)),
                     ("Offset", ctypes.wintypes.DWORD),
                     ("OffsetHigh", ctypes.wintypes.DWORD),
                     ("hEvent", ctypes.wintypes.HANDLE)]

    k32 = ctypes.windll.kernel32
    data = json.dumps(resp).encode() + b"\n"
    bw = ctypes.wintypes.DWORD(0)
    ovl = OVERLAPPED()
    evt = k32.CreateEventW(None, True, False, None)
    ovl.hEvent = evt
    ok = k32.WriteFile(handle, data, len(data), ctypes.byref(bw), ctypes.byref(ovl))
    err = k32.GetLastError()
    if not ok and err == 997:  # ERROR_IO_PENDING
        k32.WaitForSingleObject(evt, 5000)
        k32.GetOverlappedResult(handle, ctypes.byref(ovl), ctypes.byref(bw), False)
    k32.CloseHandle(evt)
    log.debug("Sent %d bytes", bw.value)


# --- Command handlers ---

def handle_ping(cmd, cfg):
    return {"status": "pong"}


def handle_decompile(cmd, cfg):
    """Decompile via GUI automation + plugin extraction.
    Writes args JSON, runs vbd_helper.py as lab user in interactive session."""
    target = cmd["target"]
    output = cmd["output"]
    vbd = cfg["vb_decompiler"]
    if not os.path.exists(vbd):
        return {"status": "error", "msg": f"VB Decompiler not found at {vbd}"}
    if not os.path.exists(target):
        return {"status": "error", "msg": f"Target not found: {target}"}
    os.makedirs(output, exist_ok=True)

    args_file = r"C:\Tools\vbd_args.json"
    result_file = r"C:\Tools\vbd_result.json"
    try: os.remove(result_file)
    except: pass

    # Write args for helper
    with open(args_file, "w") as f:
        json.dump({"target": target, "output": output, "vbd": vbd,
                    "use_plugin": cmd.get("use_plugin", True)}, f)

    # Run helper as lab user in interactive session
    subprocess.run(["schtasks", "/run", "/tn", "VBDHelper"],
                    capture_output=True, timeout=10)

    # Wait for result file (up to 5 min)
    for i in range(300):
        if os.path.exists(result_file):
            time.sleep(1)
            try:
                with open(result_file) as f:
                    return json.load(f)
            except Exception:
                pass
        time.sleep(1)

    subprocess.run(["taskkill", "/f", "/im", "VB Decompiler.exe"],
                    capture_output=True, timeout=5)
    return {"status": "error", "msg": "timeout waiting for decompile result"}


_procs = {}

def handle_run(cmd, cfg):
    target = cmd["target"]
    try:
        p = subprocess.Popen(target, shell=False)
        _procs[p.pid] = p
        return {"status": "running", "pid": p.pid}
    except Exception as e:
        return {"status": "error", "msg": str(e)}


def handle_kill(cmd, cfg):
    pid = cmd["pid"]
    try:
        subprocess.run(["taskkill", "/PID", str(pid), "/F", "/T"],
                       capture_output=True, timeout=10)
        _procs.pop(pid, None)
        return {"status": "killed"}
    except Exception as e:
        return {"status": "error", "msg": str(e)}


def handle_shell(cmd, cfg):
    try:
        r = subprocess.run(cmd["command"], shell=True,
                           capture_output=True, text=True, timeout=120)
        return {"status": "ok", "returncode": r.returncode,
                "stdout": r.stdout[-2000:], "stderr": r.stderr[-2000:]}
    except subprocess.TimeoutExpired:
        return {"status": "error", "msg": "timeout"}
    except Exception as e:
        return {"status": "error", "msg": str(e)}


def handle_list_processes(cmd, cfg):
    try:
        r = subprocess.run(["tasklist", "/FO", "CSV"],
                           capture_output=True, text=True, timeout=30)
        lines = r.stdout.strip().split("\n")
        procs = []
        if len(lines) > 1:
            for line in lines[1:]:
                parts = line.strip().strip('"').split('","')
                if len(parts) >= 2:
                    procs.append({"name": parts[0], "pid": parts[1]})
        return {"status": "ok", "processes": procs}
    except Exception as e:
        return {"status": "error", "msg": str(e)}


def handle_shutdown(cmd, cfg):
    os.system("shutdown /s /t 5")
    return {"status": "shutting_down"}


HANDLERS = {
    "ping": handle_ping,
    "decompile": handle_decompile,
    "run": handle_run,
    "kill": handle_kill,
    "shell": handle_shell,
    "list_processes": handle_list_processes,
    "shutdown": handle_shutdown,
}


def main():
    cfg = load_config()
    log.info("Agent starting. Config: %s", cfg)

    while True:
        handle = None
        try:
            handle = open_device()
            buf = b""
            while True:
                cmd, buf = read_command(handle, buf)
                action = cmd.get("action", "")
                log.info("Command: %s", action)
                handler = HANDLERS.get(action)
                if handler:
                    try:
                        resp = handler(cmd, cfg)
                    except Exception as e:
                        log.error("Handler error: %s", traceback.format_exc())
                        resp = {"status": "error", "msg": str(e)}
                else:
                    resp = {"status": "error", "msg": f"unknown action: {action}"}
                send_response(handle, resp)
                log.info("Response: %s %s", resp.get("status"), resp.get("msg",""))
        except Exception as e:
            log.error("Main loop error: %s", traceback.format_exc())
            if handle:
                try:
                    import ctypes
                    ctypes.windll.kernel32.CloseHandle(handle)
                except Exception:
                    pass
            time.sleep(5)


if __name__ == "__main__":
    main()
