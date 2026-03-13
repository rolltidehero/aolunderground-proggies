"""QMP (QEMU Machine Protocol) client. JSON over Unix socket."""
import socket, json, time, logging

log = logging.getLogger(__name__)


class QMPClient:
    def __init__(self, sock_path="/tmp/vm-qmp.sock"):
        self.sock_path = sock_path
        self.sock = None
        self._buf = b""

    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.connect(self.sock_path)
        self.sock.settimeout(10)
        greeting = self._read_json()
        log.debug("QMP greeting: %s", greeting)
        self._send({"execute": "qmp_capabilities"})
        resp = self._read_response()
        log.debug("Capabilities: %s", resp)
        return self

    def execute(self, command, **arguments):
        msg = {"execute": command}
        if arguments:
            msg["arguments"] = arguments
        self._send(msg)
        return self._read_response()

    def screendump(self, filename):
        return self.execute("screendump", filename=filename)

    def send_key(self, keys):
        """keys: list of qcode strings like ['ctrl','a']"""
        key_list = [{"type": "qcode", "data": k} for k in keys]
        return self.execute("send-key", keys=key_list)

    def send_mouse_move(self, x, y, screen_w=1280, screen_h=800):
        qx = int(x / screen_w * 32767)
        qy = int(y / screen_h * 32767)
        return self.execute("input-send-event", events=[
            {"type": "abs", "data": {"axis": "x", "value": qx}},
            {"type": "abs", "data": {"axis": "y", "value": qy}},
        ])

    def send_mouse_click(self, x, y, button="left"):
        self.send_mouse_move(x, y)
        time.sleep(0.05)
        self.execute("input-send-event", events=[
            {"type": "btn", "data": {"down": True, "button": button}},
        ])
        time.sleep(0.05)
        self.execute("input-send-event", events=[
            {"type": "btn", "data": {"down": False, "button": button}},
        ])

    def send_text(self, text):
        """Type text character by character via key events."""
        SHIFT_CHARS = '~!@#$%^&*()_+{}|:"<>?'
        SHIFT_MAP = dict(zip(SHIFT_CHARS, '`1234567890-=[]\\;\',./?'))
        SPECIAL = {' ': 'spc', '\n': 'ret', '\t': 'tab', '-': 'minus',
                   '=': 'equal', '[': 'bracket_left', ']': 'bracket_right',
                   '\\': 'backslash', ';': 'semicolon', "'": 'apostrophe',
                   ',': 'comma', '.': 'dot', '/': 'slash', '`': 'grave_accent'}
        for ch in text:
            if ch in SHIFT_CHARS:
                base = SHIFT_MAP[ch]
                qcode = SPECIAL.get(base, base)
                self.send_key(['shift', qcode])
            elif ch in SPECIAL:
                self.send_key([SPECIAL[ch]])
            elif ch.isupper():
                self.send_key(['shift', ch.lower()])
            elif ch.isalnum():
                self.send_key([ch.lower()])
            else:
                log.warning("Unmapped char: %r", ch)
            time.sleep(0.05)

    def power_down(self):
        return self.execute("system_powerdown")

    def quit(self):
        return self.execute("quit")

    def close(self):
        if self.sock:
            self.sock.close()
            self.sock = None

    # --- internal ---
    def _send(self, obj):
        data = json.dumps(obj).encode() + b"\n"
        self.sock.sendall(data)

    def _read_json(self):
        while b"\n" not in self._buf:
            chunk = self.sock.recv(4096)
            if not chunk:
                raise ConnectionError("QMP socket closed")
            self._buf += chunk
        line, self._buf = self._buf.split(b"\n", 1)
        return json.loads(line)

    def _read_response(self):
        """Read until we get a return/error, skipping async events."""
        while True:
            msg = self._read_json()
            if "event" in msg:
                log.debug("QMP event: %s", msg["event"])
                continue
            return msg
