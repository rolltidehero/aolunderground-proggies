#!/usr/bin/env python3
"""Window state diff engine and screenshot crop utilities.

Provides runtime window enumeration, state diffing, and QMP-based
screenshot capture with PIL cropping to exact GetWindowRect coordinates.

Usage as module:
    from window_diff import WindowDiff
    wd = WindowDiff()
    before = wd.snapshot()
    # ... do something ...
    after = wd.snapshot()
    diff = wd.diff(before, after)
"""
import json, logging, os, re, socket, subprocess, time, base64
from pathlib import Path

log = logging.getLogger(__name__)

SCREEN_W, SCREEN_H = 1280, 800
QMP_SOCK = '/tmp/vm-qmp.sock'
QGA_SOCK = '/tmp/vm-qga.sock'
CURSOR_PARK = (SCREEN_W - 1, SCREEN_H - 1)

VB6_CLASSES = frozenset({
    'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT6MDIForm',
    'ThunderRT5FormDC', 'ThunderRT5Form',
    'ThunderFormDC', 'ThunderForm',
})

PYTHON_GUEST = r'C:\Program Files\Python313-32\python.exe'
ENUM_SCRIPT_GUEST = r'C:\work\enum_windows.py'
ENUM_RESULT_GUEST = r'C:\work\windows.json'

ENUM_SCRIPT = r'''import ctypes, json
u32 = ctypes.windll.user32
class RECT(ctypes.Structure):
    _fields_ = [("left", ctypes.c_long), ("top", ctypes.c_long),
                ("right", ctypes.c_long), ("bottom", ctypes.c_long)]
results = []
def cb(hwnd, _):
    if not u32.IsWindowVisible(hwnd):
        return 1
    buf = ctypes.create_unicode_buffer(256)
    u32.GetClassNameW(hwnd, buf, 256)
    cls = buf.value
    u32.GetWindowTextW(hwnd, buf, 256)
    title = buf.value
    rc = RECT()
    u32.GetWindowRect(hwnd, ctypes.byref(rc))
    w = rc.right - rc.left
    h = rc.bottom - rc.top
    if w > 5 and h > 5:
        results.append({"class": cls, "title": title,
                        "x": rc.left, "y": rc.top, "w": w, "h": h})
    return 1
CB = ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
u32.EnumWindows(CB(cb), 0)
with open("C:\\work\\windows.json", "w") as f:
    json.dump(results, f)
'''


class _BufSock:
    """Socket wrapper with read buffer."""
    __slots__ = ('sock', '_buf')
    def __init__(self, sock):
        self.sock = sock
        self._buf = b''
    def sendall(self, data): return self.sock.sendall(data)
    def recv(self, n): return self.sock.recv(n)
    def close(self): return self.sock.close()
    def settimeout(self, t): return self.sock.settimeout(t)


def _qga_connect():
    _t0 = time.monotonic()
    raw = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    raw.connect(QGA_SOCK)
    raw.settimeout(10)
    s = _BufSock(raw)
    sync_id = int(time.time() * 1000) % 100000
    s.sendall(json.dumps({'execute': 'guest-sync', 'arguments': {'id': sync_id}}).encode() + b'\n')
    while True:
        while b'\n' in s._buf:
            line, s._buf = s._buf.split(b'\n', 1)
            line = line.strip()
            if not line: continue
            try:
                resp = json.loads(line)
            except json.JSONDecodeError: continue
            if resp.get('return') == sync_id:
                log.debug('_qga_connect: synced elapsed=%.3fs', time.monotonic() - _t0)
                return s
        chunk = s.recv(65536)
        if not chunk: raise ConnectionError("QGA closed during sync")
        s._buf += chunk


def _qga_send_recv(sock, msg):
    sock.sendall(json.dumps(msg).encode() + b'\n')
    while True:
        while b'\n' in sock._buf:
            line, sock._buf = sock._buf.split(b'\n', 1)
            line = line.strip()
            if not line: continue
            return json.loads(line)
        chunk = sock.recv(65536)
        if not chunk: raise ConnectionError("QGA closed")
        sock._buf += chunk


def _qga_write_file(guest_path, data):
    _t0 = time.monotonic()
    s = _qga_connect()
    r = _qga_send_recv(s, {'execute': 'guest-file-open', 'arguments': {'path': guest_path, 'mode': 'w'}})
    if 'error' in r:
        s.close()
        raise RuntimeError(f'guest-file-open error: {r["error"]}')
    handle = r['return']
    _qga_send_recv(s, {'execute': 'guest-file-write', 'arguments': {
        'handle': handle, 'buf-b64': base64.b64encode(data).decode()}})
    _qga_send_recv(s, {'execute': 'guest-file-close', 'arguments': {'handle': handle}})
    s.close()
    log.debug('_qga_write_file: %s %d bytes elapsed=%.3fs', guest_path, len(data), time.monotonic() - _t0)


def _qga_read_file(guest_path):
    _t0 = time.monotonic()
    s = _qga_connect()
    r = _qga_send_recv(s, {'execute': 'guest-file-open', 'arguments': {'path': guest_path, 'mode': 'r'}})
    if 'error' in r:
        s.close()
        raise RuntimeError(f'guest-file-open error: {r["error"]}')
    handle = r['return']
    data = b''
    while True:
        r = _qga_send_recv(s, {'execute': 'guest-file-read', 'arguments': {'handle': handle, 'count': 65536}})
        chunk = base64.b64decode(r['return']['buf-b64']) if r['return'].get('buf-b64') else b''
        data += chunk
        if r['return'].get('eof', False) or not chunk: break
    _qga_send_recv(s, {'execute': 'guest-file-close', 'arguments': {'handle': handle}})
    s.close()
    log.debug('_qga_read_file: %s %d bytes elapsed=%.3fs', guest_path, len(data), time.monotonic() - _t0)
    return data.decode(errors='replace')


def _gui_launch(cmdline):
    """Launch process in session 1 via QGA + s1launch_sys.py."""
    _t0 = time.monotonic()
    S1LAUNCH = r'C:\Tools\s1launch_sys.py'
    s = _qga_connect()
    r = _qga_send_recv(s, {'execute': 'guest-exec', 'arguments': {
        'path': PYTHON_GUEST, 'arg': [S1LAUNCH, cmdline], 'capture-output': True}})
    if 'error' in r:
        s.close()
        log.error('_gui_launch: exec error=%s', r['error'])
        return {'returncode': -1, 'stdout': '', 'stderr': str(r['error'])}
    pid = r['return']['pid']
    # Poll for completion
    for _ in range(200):
        for __ in range(100): time.sleep(0.01)
        try:
            r = _qga_send_recv(s, {'execute': 'guest-exec-status', 'arguments': {'pid': pid}})
        except Exception: continue
        if 'error' in r: continue
        ret = r['return']
        if ret.get('exited', False):
            stdout = base64.b64decode(ret.get('out-data', '')).decode(errors='replace') if ret.get('out-data') else ''
            stderr = base64.b64decode(ret.get('err-data', '')).decode(errors='replace') if ret.get('err-data') else ''
            s.close()
            log.debug('_gui_launch: done rc=%d elapsed=%.3fs', ret.get('exitcode', -1), time.monotonic() - _t0)
            return {'returncode': ret.get('exitcode', -1), 'stdout': stdout, 'stderr': stderr}
    s.close()
    log.error('_gui_launch: timeout cmdline=%s', cmdline[:80])
    return {'returncode': -1, 'stdout': '', 'stderr': 'timeout'}


def _c2gui_shell(command):
    """Run shell command in session 1."""
    _t0 = time.monotonic()
    seq = int(time.time() * 1000) % 100000
    out_file = rf'C:\work\_sh_out_{seq}.txt'
    bat_file = rf'C:\work\_sh_cmd_{seq}.bat'
    bat = f'@echo off\r\n{command} > {out_file} 2>&1\r\n'
    _qga_write_file(bat_file, bat.encode())
    _gui_launch(f'cmd.exe /c {bat_file}')
    try:
        out = _qga_read_file(out_file)
    except Exception:
        out = ''
    log.debug('_c2gui_shell: cmd=%s out=%d chars elapsed=%.3fs',
              command[:60], len(out), time.monotonic() - _t0)
    return out


class QMP:
    """QMP client for screendump and mouse input."""
    _sock = None
    _buf = b''
    _last_x, _last_y = SCREEN_W // 2, SCREEN_H // 2

    @staticmethod
    def _ensure():
        if QMP._sock is None:
            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
            s.connect(QMP_SOCK)
            s.settimeout(5)
            QMP._sock = s
            QMP._buf = b''
            QMP._read()
            QMP._sock.sendall(json.dumps({"execute": "qmp_capabilities"}).encode() + b'\n')
            QMP._read()

    @staticmethod
    def _read():
        while True:
            while b'\n' in QMP._buf:
                line, QMP._buf = QMP._buf.split(b'\n', 1)
                line = line.strip()
                if not line: continue
                msg = json.loads(line)
                if 'event' in msg: continue
                return msg
            chunk = QMP._sock.recv(4096)
            if not chunk: raise ConnectionError("QMP closed")
            QMP._buf += chunk

    @staticmethod
    def _cmd(execute, arguments=None):
        QMP._ensure()
        msg = {"execute": execute}
        if arguments: msg["arguments"] = arguments
        try:
            QMP._sock.sendall(json.dumps(msg).encode() + b'\n')
            return QMP._read()
        except (BrokenPipeError, ConnectionResetError, OSError):
            QMP._sock = None
            QMP._buf = b''
            QMP._ensure()
            QMP._sock.sendall(json.dumps(msg).encode() + b'\n')
            return QMP._read()

    @staticmethod
    def move(x, y):
        QMP._cmd("input-send-event", {"events": [
            {"type": "abs", "data": {"axis": "x", "value": int(x * 32767 / SCREEN_W)}},
            {"type": "abs", "data": {"axis": "y", "value": int(y * 32767 / SCREEN_H)}},
        ]})
        QMP._last_x, QMP._last_y = x, y

    @staticmethod
    def click(x, y):
        QMP.move(x, y)
        time.sleep(0.1)
        QMP._cmd("input-send-event", {"events": [
            {"type": "btn", "data": {"down": True, "button": "left"}}]})
        time.sleep(0.05)
        QMP._cmd("input-send-event", {"events": [
            {"type": "btn", "data": {"down": False, "button": "left"}}]})

    @staticmethod
    def screendump(path):
        QMP._cmd("screendump", {"filename": path})
        time.sleep(0.15)

    @staticmethod
    def park_cursor():
        QMP.move(*CURSOR_PARK)


class WindowDiff:
    """Window state snapshot and diff engine."""

    def __init__(self):
        self._enum_deployed = False

    def _deploy_enum(self):
        if self._enum_deployed:
            return
        _c2gui_shell(r'if not exist C:\work mkdir C:\work')
        _qga_write_file(ENUM_SCRIPT_GUEST, ENUM_SCRIPT.encode())
        self._enum_deployed = True
        log.debug('WindowDiff: enum script deployed')

    def snapshot(self):
        """Enumerate all visible windows. Returns list of {class, title, x, y, w, h}.
        Filters out system/transient windows (console, taskbar, tooltips)."""
        _t0 = time.monotonic()
        self._deploy_enum()
        _c2gui_shell(rf'if exist "{ENUM_RESULT_GUEST}" del /f /q "{ENUM_RESULT_GUEST}"')
        _c2gui_shell(rf'"{PYTHON_GUEST}" {ENUM_SCRIPT_GUEST}')
        try:
            data = _qga_read_file(ENUM_RESULT_GUEST)
            windows = json.loads(data)
        except Exception as exc:
            log.warning('WindowDiff.snapshot: failed exc=%s', exc)
            windows = []
        # Filter out system/transient windows
        SKIP = {'ConsoleWindowClass', 'Progman', 'Shell_TrayWnd', 'tooltips_class32',
                'TaskManagerWindow', 'DV2ControlHost', 'Button'}
        windows = [w for w in windows if w['class'] not in SKIP]
        log.debug('WindowDiff.snapshot: %d windows elapsed=%.3fs', len(windows), time.monotonic() - _t0)
        return windows

    @staticmethod
    def diff(before, after):
        """Diff two window snapshots. Returns {new, changed, gone}."""
        _t0 = time.monotonic()

        def key(w):
            return (w['class'], w['title'])

        before_map = {}
        for w in before:
            k = key(w)
            before_map.setdefault(k, []).append(w)

        after_map = {}
        for w in after:
            k = key(w)
            after_map.setdefault(k, []).append(w)

        new = []
        changed = []
        gone = []

        for k, wins in after_map.items():
            if k not in before_map:
                new.extend(wins)
            else:
                # Check for rect changes
                for aw in wins:
                    matched = False
                    for bw in before_map[k]:
                        if abs(aw['x'] - bw['x']) < 5 and abs(aw['y'] - bw['y']) < 5:
                            matched = True
                            if abs(aw['w'] - bw['w']) > 5 or abs(aw['h'] - bw['h']) > 5:
                                changed.append(aw)
                            break
                    if not matched:
                        new.append(aw)

        for k in before_map:
            if k not in after_map:
                gone.extend(before_map[k])

        log.debug('WindowDiff.diff: new=%d changed=%d gone=%d elapsed=%.3fs',
                  len(new), len(changed), len(gone), time.monotonic() - _t0)
        return {'new': new, 'changed': changed, 'gone': gone}

    @staticmethod
    def find_vb_forms(windows):
        """Filter to just VB6 form windows (not VB Decompiler)."""
        return [w for w in windows
                if w['class'] in VB6_CLASSES
                and 'VB Decompiler' not in w.get('title', '')
                and w['x'] >= 0]


def capture_cropped(rect, output_path, tmp_dir='/tmp/walkthrough'):
    """QMP screendump → PIL crop to rect → save PNG.
    Returns True if valid image saved, False if crop was bad."""
    _t0 = time.monotonic()
    os.makedirs(tmp_dir, exist_ok=True)
    ppm = os.path.join(tmp_dir, f'_crop_{int(time.time()*1000)}.ppm')

    QMP.screendump(ppm)

    # Clamp rect to screen bounds
    x0 = max(rect['x'], 0)
    y0 = max(rect['y'], 0)
    x1 = min(rect['x'] + rect['w'], SCREEN_W)
    y1 = min(rect['y'] + rect['h'], SCREEN_H)

    if x1 <= x0 or y1 <= y0:
        log.warning('capture_cropped: zero-size crop rect=%r', rect)
        try: os.unlink(ppm)
        except: pass
        return False

    from PIL import Image
    img = Image.open(ppm)
    cropped = img.crop((x0, y0, x1, y1))

    # Validate: reject all-black or all-single-color
    extrema = cropped.getextrema()
    if all(mn == mx for mn, mx in extrema):
        log.warning('capture_cropped: single-color image, rejecting output=%s', output_path)
        try: os.unlink(ppm)
        except: pass
        return False

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    cropped.save(output_path)
    try: os.unlink(ppm)
    except: pass

    log.debug('capture_cropped: %s rect=(%d,%d,%d,%d) size=%dx%d elapsed=%.3fs',
              output_path, x0, y0, x1, y1, cropped.width, cropped.height, time.monotonic() - _t0)
    return True


def capture_context(main_rect, child_rect, output_path, pad=15, tmp_dir='/tmp/walkthrough'):
    """Capture bounding box of main + child rects."""
    x0 = min(main_rect['x'], child_rect['x']) - pad
    y0 = min(main_rect['y'], child_rect['y']) - pad
    x1 = max(main_rect['x'] + main_rect['w'], child_rect['x'] + child_rect['w']) + pad
    y1 = max(main_rect['y'] + main_rect['h'], child_rect['y'] + child_rect['h']) + pad
    combined = {'x': x0, 'y': y0, 'w': x1 - x0, 'h': y1 - y0}
    return capture_cropped(combined, output_path, tmp_dir)


def capture_full_screen(output_path, tmp_dir='/tmp/walkthrough'):
    """Capture full screen as a frame (for animation)."""
    return capture_cropped({'x': 0, 'y': 0, 'w': SCREEN_W, 'h': SCREEN_H}, output_path, tmp_dir)


# ── Dismiss helpers ──────────────────────────────────────────────────

DISMISS_SCRIPT = r'''import ctypes
u32 = ctypes.windll.user32
dismissed = []
def cb(hwnd, _):
    if not u32.IsWindowVisible(hwnd):
        return 1
    buf = ctypes.create_unicode_buffer(256)
    u32.GetClassNameW(hwnd, buf, 256)
    if buf.value != "#32770":
        return 1
    u32.GetWindowTextW(hwnd, buf, 256)
    title = buf.value
    for btn_id in [6, 1, 7, 2]:
        btn = u32.GetDlgItem(hwnd, btn_id)
        if btn:
            u32.SendMessageW(hwnd, 0x0111, btn_id, btn)
            dismissed.append(f"{title} (btn={btn_id})")
            break
    else:
        u32.PostMessageW(hwnd, 0x0010, 0, 0)
        dismissed.append(f"{title} (WM_CLOSE)")
    return 1
CB = ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
u32.EnumWindows(CB(cb), 0)
print("\n".join(dismissed))
'''
DISMISS_GUEST = r'C:\work\dismiss_msgbox.py'

CLOSE_FORM_SCRIPT = r'''import win32gui, win32con, sys
keep = sys.argv[1]
form_classes = {"ThunderRT6FormDC", "ThunderRT6Form", "ThunderRT5FormDC", "ThunderRT5Form"}
closed = []
def cb(h, _):
    if not win32gui.IsWindowVisible(h):
        return True
    cls = win32gui.GetClassName(h)
    t = win32gui.GetWindowText(h)
    if cls in form_classes and t != keep:
        win32gui.PostMessage(h, win32con.WM_CLOSE, 0, 0)
        closed.append(t)
    return True
win32gui.EnumWindows(cb, None)
print("\n".join(closed))
'''
CLOSE_FORM_GUEST = r'C:\work\close_form.py'

MOVE_CHILD_SCRIPT = r'''import win32gui, sys
keep = sys.argv[1]
tx, ty = int(sys.argv[2]), int(sys.argv[3])
form_classes = {"ThunderRT6FormDC", "ThunderRT6Form", "ThunderRT5FormDC", "ThunderRT5Form"}
found = []
def cb(h, _):
    if not win32gui.IsWindowVisible(h):
        return True
    cls = win32gui.GetClassName(h)
    t = win32gui.GetWindowText(h)
    if cls in form_classes and t != keep:
        r = win32gui.GetWindowRect(h)
        win32gui.MoveWindow(h, tx, ty, r[2]-r[0], r[3]-r[1], True)
        found.append(t)
    return True
win32gui.EnumWindows(cb, None)
print("\n".join(found))
'''
MOVE_CHILD_GUEST = r'C:\work\move_child.py'

_helpers_deployed = False

def deploy_helpers():
    global _helpers_deployed
    if _helpers_deployed: return
    _t0 = time.monotonic()
    _c2gui_shell(r'if not exist C:\work mkdir C:\work')
    _qga_write_file(DISMISS_GUEST, DISMISS_SCRIPT.encode())
    _qga_write_file(CLOSE_FORM_GUEST, CLOSE_FORM_SCRIPT.encode())
    _qga_write_file(MOVE_CHILD_GUEST, MOVE_CHILD_SCRIPT.encode())
    _helpers_deployed = True
    log.debug('deploy_helpers: done elapsed=%.3fs', time.monotonic() - _t0)


def dismiss_msgboxes():
    """Dismiss all visible #32770 MsgBox dialogs."""
    deploy_helpers()
    out = _c2gui_shell(rf'"{PYTHON_GUEST}" {DISMISS_GUEST}')
    titles = [t.strip() for t in out.strip().split('\n') if t.strip()]
    if titles:
        log.info('dismiss_msgboxes: dismissed %s', titles)
    return titles


def close_child_forms(keep_title):
    """Close all VB6 child forms except keep_title."""
    deploy_helpers()
    out = _c2gui_shell(rf'"{PYTHON_GUEST}" {CLOSE_FORM_GUEST} "{keep_title}"')
    closed = [t.strip() for t in out.strip().split('\n') if t.strip()]
    if closed:
        log.info('close_child_forms: closed %s', closed)
    return closed


def move_child_form(keep_title, tx, ty):
    """Move child forms to (tx, ty). Returns list of moved titles."""
    deploy_helpers()
    out = _c2gui_shell(rf'"{PYTHON_GUEST}" {MOVE_CHILD_GUEST} "{keep_title}" {tx} {ty}')
    moved = [t.strip() for t in out.strip().split('\n') if t.strip()]
    if moved:
        log.debug('move_child_form: moved %s to (%d,%d)', moved, tx, ty)
    return moved


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG,
                        format='%(asctime)s.%(msecs)03d [%(levelname)-8s] %(name)s: %(message)s',
                        datefmt='%H:%M:%S')
    wd = WindowDiff()
    print('Taking snapshot...')
    windows = wd.snapshot()
    forms = wd.find_vb_forms(windows)
    print(f'\n{len(windows)} windows, {len(forms)} VB6 forms:')
    for w in forms:
        print(f'  {w["class"]}: "{w["title"]}" at {w["x"]},{w["y"]} {w["w"]}x{w["h"]}')
    if forms:
        print(f'\nCapturing main form...')
        ok = capture_cropped(forms[0], '/tmp/test_crop.png')
        print(f'Crop: {"OK" if ok else "FAILED"} → /tmp/test_crop.png')
