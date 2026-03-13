"""Minimal C2 channel trace test. Run on guest to diagnose virtio-serial I/O."""
import ctypes, ctypes.wintypes, time, sys, os, struct

k32 = ctypes.windll.kernel32
LOG = r"C:\Tools\c2_trace.log"
DEV = r"\\.\Global\c2channel"

GENERIC_RW = 0xC0000000
OPEN_EXISTING = 3
FILE_FLAG_OVERLAPPED = 0x40000000
WAIT_OBJECT_0 = 0
WAIT_TIMEOUT = 258
ERROR_IO_PENDING = 997
INFINITE = 0xFFFFFFFF

class OVERLAPPED(ctypes.Structure):
    _fields_ = [("Internal", ctypes.POINTER(ctypes.c_ulong)),
                ("InternalHigh", ctypes.POINTER(ctypes.c_ulong)),
                ("Offset", ctypes.wintypes.DWORD),
                ("OffsetHigh", ctypes.wintypes.DWORD),
                ("hEvent", ctypes.wintypes.HANDLE)]

def log(msg):
    ts = time.strftime("%H:%M:%S", time.localtime())
    ms = int((time.time() % 1) * 1000)
    line = f"[{ts}.{ms:03d}] {msg}\n"
    sys.stderr.write(line)
    sys.stderr.flush()
    with open(LOG, "a") as f:
        f.write(line)

# Clear old log
if os.path.exists(LOG):
    os.remove(LOG)

log("=== C2 TRACE TEST START ===")

# --- Test 1: Open with OVERLAPPED ---
log(f"Opening {DEV} with FILE_FLAG_OVERLAPPED")
h = k32.CreateFileW(DEV, GENERIC_RW, 0, None, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, None)
err = k32.GetLastError()
log(f"CreateFileW: handle={h} err={err}")
if h == -1 or h == 0xFFFFFFFF:
    log("FATAL: Cannot open device")
    sys.exit(1)

# --- Test 2: Overlapped read ---
log("Starting overlapped ReadFile loop (waiting for host data)...")
buf = ctypes.create_string_buffer(4096)
ovl = OVERLAPPED()
evt = k32.CreateEventW(None, True, False, None)
log(f"Event handle: {evt}")
ovl.hEvent = evt

bytes_read = ctypes.wintypes.DWORD(0)
ok = k32.ReadFile(h, buf, 4096, ctypes.byref(bytes_read), ctypes.byref(ovl))
err = k32.GetLastError()
log(f"ReadFile: ok={ok} bytes_read={bytes_read.value} err={err}")

if not ok and err == ERROR_IO_PENDING:
    log("ReadFile returned ERROR_IO_PENDING (expected for overlapped)")
    log("Waiting for data with WaitForSingleObject(5s timeout)...")
    for i in range(12):  # 12 x 5s = 60s total
        wr = k32.WaitForSingleObject(evt, 5000)
        log(f"WaitForSingleObject: result={wr} (0=SIGNALED, 258=TIMEOUT)")
        if wr == WAIT_OBJECT_0:
            ok2 = k32.GetOverlappedResult(h, ctypes.byref(ovl), ctypes.byref(bytes_read), False)
            err2 = k32.GetLastError()
            log(f"GetOverlappedResult: ok={ok2} bytes={bytes_read.value} err={err2}")
            if bytes_read.value > 0:
                data = buf.raw[:bytes_read.value]
                log(f"DATA RECEIVED ({bytes_read.value} bytes): {data!r}")
                # Echo it back
                resp = b'{"status":"trace_pong"}\n'
                ovl2 = OVERLAPPED()
                ovl2.hEvent = k32.CreateEventW(None, True, False, None)
                bw = ctypes.wintypes.DWORD(0)
                ok3 = k32.WriteFile(h, resp, len(resp), ctypes.byref(bw), ctypes.byref(ovl2))
                err3 = k32.GetLastError()
                log(f"WriteFile: ok={ok3} written={bw.value} err={err3}")
                if not ok3 and err3 == ERROR_IO_PENDING:
                    k32.WaitForSingleObject(ovl2.hEvent, 5000)
                    k32.GetOverlappedResult(h, ctypes.byref(ovl2), ctypes.byref(bw), False)
                    log(f"WriteFile completed: written={bw.value}")
                k32.CloseHandle(ovl2.hEvent)
            break
        elif wr == WAIT_TIMEOUT:
            log(f"Still waiting... (attempt {i+1}/12)")
        else:
            log(f"WaitForSingleObject unexpected: {wr}, GetLastError={k32.GetLastError()}")
            break
elif ok:
    log(f"ReadFile returned immediately! bytes={bytes_read.value}")
    data = buf.raw[:bytes_read.value]
    log(f"DATA: {data!r}")
else:
    log(f"ReadFile FAILED with err={err}")

# --- Test 3: Try synchronous (no overlapped) ---
log("--- Now testing SYNCHRONOUS open ---")
k32.CloseHandle(evt)
k32.CloseHandle(h)

log(f"Opening {DEV} WITHOUT overlapped flag")
h2 = k32.CreateFileW(DEV, GENERIC_RW, 0, None, OPEN_EXISTING, 0, None)
err = k32.GetLastError()
log(f"CreateFileW sync: handle={h2} err={err}")
if h2 != -1 and h2 != 0xFFFFFFFF:
    log("Sync open succeeded. Trying blocking ReadFile (10s alarm)...")
    # We can't set a timeout on sync ReadFile easily, so just try it
    # and hope the host sends data within a few seconds
    buf2 = ctypes.create_string_buffer(4096)
    br2 = ctypes.wintypes.DWORD(0)
    # Use a thread with timeout
    import threading
    result = [None, None]
    def do_read():
        ok = k32.ReadFile(h2, buf2, 4096, ctypes.byref(br2), None)
        result[0] = ok
        result[1] = k32.GetLastError()
    t = threading.Thread(target=do_read)
    t.start()
    t.join(timeout=15)
    if t.is_alive():
        log("Sync ReadFile BLOCKED for 15s (host data not arriving)")
        # Cancel the I/O
        k32.CancelIoEx(h2, None)
        t.join(timeout=2)
    else:
        log(f"Sync ReadFile: ok={result[0]} err={result[1]} bytes={br2.value}")
        if br2.value > 0:
            log(f"SYNC DATA: {buf2.raw[:br2.value]!r}")
    k32.CloseHandle(h2)
else:
    log(f"Sync open failed err={err}")

log("=== C2 TRACE TEST END ===")
