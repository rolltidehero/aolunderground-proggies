"""Host-side virtio-serial client. JSON-newline protocol over Unix socket."""
import socket, json, time, logging

log = logging.getLogger(__name__)


class VirtioSerialClient:
    def __init__(self, sock_path="/tmp/vm-c2.sock"):
        self.sock_path = sock_path
        self.sock = None
        self._buf = b""

    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.connect(self.sock_path)
        self.sock.settimeout(120)
        return self

    def send_command(self, action, **kwargs):
        msg = {"action": action, **kwargs}
        data = json.dumps(msg).encode() + b"\n"
        self.sock.sendall(data)
        # Read response
        while b"\n" not in self._buf:
            chunk = self.sock.recv(4096)
            if not chunk:
                raise ConnectionError("C2 socket closed")
            self._buf += chunk
        line, self._buf = self._buf.split(b"\n", 1)
        return json.loads(line)

    def ping(self):
        return self.send_command("ping")

    def decompile(self, exe_path, output_dir, use_plugin=False):
        return self.send_command("decompile", target=exe_path, output=output_dir, use_plugin=use_plugin)

    def run_exe(self, exe_path):
        return self.send_command("run", target=exe_path)

    def kill_process(self, pid):
        return self.send_command("kill", pid=pid)

    def shell(self, command):
        return self.send_command("shell", command=command)

    def list_processes(self):
        return self.send_command("list_processes")

    def shutdown_guest(self):
        return self.send_command("shutdown")

    def wait_for_agent(self, timeout=180):
        deadline = time.time() + timeout
        while time.time() < deadline:
            try:
                self.connect()
                r = self.ping()
                if r.get("status") == "pong":
                    log.info("Agent online")
                    return True
            except Exception:
                pass
            finally:
                if self.sock:
                    self.sock.close()
                    self.sock = None
                    self._buf = b""
            time.sleep(2)
        raise TimeoutError(f"Agent not online after {timeout}s")

    def close(self):
        if self.sock:
            self.sock.close()
            self.sock = None
