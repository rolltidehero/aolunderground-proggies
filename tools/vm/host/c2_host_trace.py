"""Host-side C2 socket trace test. Full instrumentation."""
import socket, json, time, sys, os, select, errno

SOCK = "/tmp/vm-c2.sock"
LOG = "/tmp/c2_host_trace.log"

def log(msg):
    ts = time.strftime("%H:%M:%S", time.localtime())
    ms = int((time.time() % 1) * 1000)
    line = f"[{ts}.{ms:03d}] {msg}"
    print(line, flush=True)
    with open(LOG, "a") as f:
        f.write(line + "\n")

if os.path.exists(LOG):
    os.remove(LOG)

log("=== HOST C2 TRACE START ===")
log(f"Socket path: {SOCK}")

# Check socket exists
if not os.path.exists(SOCK):
    log(f"FATAL: {SOCK} does not exist")
    sys.exit(1)

st = os.stat(SOCK)
log(f"Socket stat: mode={oct(st.st_mode)} uid={st.st_uid} gid={st.st_gid}")

# Connect
log("Connecting...")
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.settimeout(10)
try:
    s.connect(SOCK)
    log("Connected OK")
except Exception as e:
    log(f"Connect FAILED: {e}")
    sys.exit(1)

# Check socket state
log(f"Socket fileno={s.fileno()} family={s.family} type={s.type}")

# Send ping
msg = json.dumps({"action": "ping"}) + "\n"
log(f"Sending {len(msg)} bytes: {msg!r}")
try:
    sent = s.send(msg.encode())
    log(f"send() returned {sent}")
except Exception as e:
    log(f"send() FAILED: {e}")
    sys.exit(1)

# Wait for response with select
log("Waiting for response with select()...")
for i in range(20):  # 20 x 1s = 20s
    r, w, x = select.select([s], [], [s], 1.0)
    if r:
        log(f"select: socket readable after {i+1}s")
        try:
            data = s.recv(4096)
            log(f"recv() returned {len(data)} bytes: {data!r}")
            if data:
                log(f"RESPONSE: {data.decode(errors='replace')}")
            else:
                log("recv() returned empty = connection closed by peer")
            break
        except Exception as e:
            log(f"recv() FAILED: {e}")
            break
    elif x:
        log(f"select: socket in error state after {i+1}s")
        break
    else:
        log(f"select: timeout ({i+1}/20)")

    # Check if socket is still connected
    try:
        err = s.getsockopt(socket.SOL_SOCKET, socket.SO_ERROR)
        if err:
            log(f"SO_ERROR = {err} ({os.strerror(err)})")
    except:
        pass
else:
    log("TIMEOUT: No response after 20s")

# Try sending a second message
log("Sending second ping...")
try:
    s.send((json.dumps({"action": "ping"}) + "\n").encode())
    log("Second send OK")
    r, _, _ = select.select([s], [], [], 5.0)
    if r:
        data = s.recv(4096)
        log(f"Second recv: {data!r}")
    else:
        log("Second recv: TIMEOUT")
except Exception as e:
    log(f"Second send/recv FAILED: {e}")

s.close()
log("=== HOST C2 TRACE END ===")
