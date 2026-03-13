"""Guest trace v2: retry ReadFile in a loop, handle 1450 gracefully."""
import ctypes, ctypes.wintypes, time, sys, os, struct

k32 = ctypes.windll.kernel32
LOG = r"C:\Tools\c2_trace2.log"
DEV = r"\\.\Global\c2channel"

GENERIC_RW = 0xC0000000
OPEN_EXISTING = 3
FILE_FLAG_OVERLAPPED = 0x40000000
ERROR_IO_PENDING = 997

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

if os.path.exists(LOG):
    os.remove(LOG)

log("=== C2 TRACE v2 START ===")
log(f"Opening {DEV} with OVERLAPPED")
h = k32.CreateFileW(DEV, GENERIC_RW, 0, None, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, None)
err = k32.GetLastError()
log(f"handle={h} err={err}")
if h == -1:
    log("FATAL: Cannot open"); sys.exit(1)

buf = ctypes.create_string_buffer(4096)
bytes_read = ctypes.wintypes.DWORD(0)

for attempt in range(60):  # 60 attempts, ~60s total
    ovl = OVERLAPPED()
    evt = k32.CreateEventW(None, True, False, None)
    ovl.hEvent = evt

    ok = k32.ReadFile(h, buf, 4096, ctypes.byref(bytes_read), ctypes.byref(ovl))
    err = k32.GetLastError()

    if ok:
        data = buf.raw[:bytes_read.value]
        log(f"[{attempt}] ReadFile immediate: {bytes_read.value} bytes: {data!r}")
        # Send response
        resp = b'{"status":"trace_pong"}\n'
        bw = ctypes.wintypes.DWORD(0)
        k32.WriteFile(h, resp, len(resp), ctypes.byref(bw), None)
        log(f"Wrote response: {bw.value} bytes")
        k32.CloseHandle(evt)
        break
    elif err == ERROR_IO_PENDING:
        wr = k32.WaitForSingleObject(evt, 2000)
        if wr == 0:  # SIGNALED
            ok2 = k32.GetOverlappedResult(h, ctypes.byref(ovl), ctypes.byref(bytes_read), False)
            err2 = k32.GetLastError()
            if bytes_read.value > 0:
                data = buf.raw[:bytes_read.value]
                log(f"[{attempt}] Got data: {bytes_read.value} bytes: {data!r}")
                resp = b'{"status":"trace_pong"}\n'
                ovl2 = OVERLAPPED()
                ovl2.hEvent = k32.CreateEventW(None, True, False, None)
                bw = ctypes.wintypes.DWORD(0)
                k32.WriteFile(h, resp, len(resp), ctypes.byref(bw), ctypes.byref(ovl2))
                if k32.GetLastError() == ERROR_IO_PENDING:
                    k32.WaitForSingleObject(ovl2.hEvent, 5000)
                    k32.GetOverlappedResult(h, ctypes.byref(ovl2), ctypes.byref(bw), False)
                log(f"Wrote response: {bw.value} bytes")
                k32.CloseHandle(ovl2.hEvent)
                k32.CloseHandle(evt)
                break
            else:
                log(f"[{attempt}] Signaled but 0 bytes, err={err2}")
        else:
            log(f"[{attempt}] Wait timeout/err={wr}")
            k32.CancelIoEx(h, ctypes.byref(ovl))
    elif err == 1450:
        if attempt % 10 == 0:
            log(f"[{attempt}] err=1450 (no host connected), retrying...")
    else:
        log(f"[{attempt}] ReadFile err={err}")

    k32.CloseHandle(evt)
    time.sleep(1)
else:
    log("GAVE UP after 60 attempts")

k32.CloseHandle(h)
log("=== C2 TRACE v2 END ===")
