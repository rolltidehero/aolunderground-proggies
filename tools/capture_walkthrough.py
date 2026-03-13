#!/usr/bin/env python3
"""Capture screenshot walkthrough for a VB proggie running in the VM.

Reads decompiled metadata to discover menus, forms, and dialogs.
Uses C2/QGA to get runtime window positions.
Drives QMP mouse to navigate every menu/submenu, captures each state.
Builds animated GIF + individual screenshots.

Usage:
    python3 tools/capture_walkthrough.py <zip_stem> [<exe_name>]

Requires: VM running, proggie launched and visible, VBD minimized.
"""
import sys, os, json, re, time, socket, subprocess, logging, base64, struct
from pathlib import Path

logging.basicConfig(level=logging.INFO, format='%(message)s')
log = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'
QMP_SOCK = '/tmp/vm-qmp.sock'
QGA_SOCK = '/tmp/vm-qga.sock'
SCREEN_W, SCREEN_H = 1280, 800
GIF_CANVAS = (480, 320)
TWIPS_PER_PX = 15


# ── QMP ──────────────────────────────────────────────────────────────

class QMP:
    _sock = None

    @staticmethod
    def _ensure_connected():
        if QMP._sock is None:
            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
            s.connect(QMP_SOCK)
            s.settimeout(5)
            s.sendall(json.dumps({"execute": "qmp_capabilities"}).encode() + b'\n')
            time.sleep(0.1)
            s.recv(4096)
            QMP._sock = s

    @staticmethod
    def _cmd(execute, arguments=None):
        QMP._ensure_connected()
        msg = {"execute": execute}
        if arguments: msg["arguments"] = arguments
        try:
            QMP._sock.sendall(json.dumps(msg).encode() + b'\n')
            time.sleep(0.05)
            QMP._sock.recv(4096)
        except (BrokenPipeError, ConnectionResetError, OSError):
            QMP._sock = None
            QMP._ensure_connected()
            QMP._sock.sendall(json.dumps(msg).encode() + b'\n')
            time.sleep(0.05)
            QMP._sock.recv(4096)

    _last_x, _last_y = SCREEN_W // 2, SCREEN_H // 2

    @staticmethod
    def move(x, y):
        QMP._cmd("input-send-event", {"events": [
            {"type": "abs", "data": {"axis": "x", "value": int(x * 32767 / SCREEN_W)}},
            {"type": "abs", "data": {"axis": "y", "value": int(y * 32767 / SCREEN_H)}},
        ]})
        QMP._last_x, QMP._last_y = x, y

    @staticmethod
    def smooth_move(x, y, steps=12, step_delay=0.02):
        """Move cursor from current position to (x,y) in steps."""
        sx, sy = QMP._last_x, QMP._last_y
        for i in range(1, steps + 1):
            t = i / steps
            # ease-out cubic for natural deceleration
            t = 1 - (1 - t) ** 3
            cx = int(sx + (x - sx) * t)
            cy = int(sy + (y - sy) * t)
            QMP.move(cx, cy)
            time.sleep(step_delay)

    @staticmethod
    def click(x, y):
        QMP.move(x, y)
        time.sleep(0.1)
        QMP._cmd("input-send-event", {"events": [
            {"type": "btn", "data": {"down": True, "button": "left"}},
        ]})
        time.sleep(0.05)
        QMP._cmd("input-send-event", {"events": [
            {"type": "btn", "data": {"down": False, "button": "left"}},
        ]})

    @staticmethod
    def key(k):
        QMP._cmd("input-send-event", {"events": [
            {"type": "key", "data": {"down": True, "key": {"type": "qcode", "data": k}}},
            {"type": "key", "data": {"down": False, "key": {"type": "qcode", "data": k}}},
        ]})

    @staticmethod
    def type_text(text):
        """Type a string via QMP key events. Handles uppercase via shift."""
        _QCODE = {c: c for c in 'abcdefghijklmnopqrstuvwxyz0123456789'}
        _QCODE.update({' ': 'spc', '-': 'minus', '=': 'equal', '.': 'dot',
                       ',': 'comma', '/': 'slash', ';': 'semicolon',
                       '\\': 'backslash', ':': ('shift', 'semicolon'),
                       '_': ('shift', 'minus'), '[': 'bracket_left',
                       ']': 'bracket_right', "'": 'apostrophe'})
        for ch in text:
            upper = ch.isupper()
            qc = _QCODE.get(ch.lower() if ch.isalpha() else ch)
            if not qc:
                continue
            # Handle shift+key combos (e.g. ':' = shift+semicolon)
            if isinstance(qc, tuple):
                upper = True
                qc = qc[1]
            events = []
            if upper:
                events.append({"type": "key", "data": {"down": True, "key": {"type": "qcode", "data": "shift"}}})
            events.append({"type": "key", "data": {"down": True, "key": {"type": "qcode", "data": qc}}})
            events.append({"type": "key", "data": {"down": False, "key": {"type": "qcode", "data": qc}}})
            if upper:
                events.append({"type": "key", "data": {"down": False, "key": {"type": "qcode", "data": "shift"}}})
            QMP._cmd("input-send-event", {"events": events})
            time.sleep(0.02)

    @staticmethod
    def screenshot(path):
        QMP._cmd("screendump", {"filename": path})
        time.sleep(0.1)  # let file write complete


# ── QGA ──────────────────────────────────────────────────────────────


C2GUI_SOCK = '/tmp/vm-c2gui.sock'
S1LAUNCH = r'C:\Tools\s1launch_sys.py'
PYTHON_GUEST = r'C:\Program Files\Python313-32\python.exe'
ENUM_SCRIPT_GUEST = r'C:\work\enum_windows.py'
ENUM_RESULT_GUEST = r'C:\work\windows.json'

# Script deployed to guest for window enumeration
ENUM_SCRIPT = '''import ctypes, json
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
    if w > 10 and h > 10:
        results.append({"class": cls, "title": title, "x": rc.left, "y": rc.top, "w": w, "h": h})
    return 1

CB = ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
u32.EnumWindows(CB(cb), 0)
with open("C:\\\\work\\\\windows.json", "w") as f:
    json.dump(results, f)
'''

MOVE_CHILD_SCRIPT = r'''import win32gui, win32con, win32api, sys, ctypes
keep = sys.argv[1]
tx, ty = int(sys.argv[2]), int(sys.argv[3])
# Only move actual VB6 forms, NOT #32770 MsgBoxes
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

# Dismiss all visible #32770 MsgBoxes by sending WM_COMMAND IDYES/IDOK
DISMISS_MSGBOX_SCRIPT = r'''import ctypes, ctypes.wintypes
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
    # Try IDYES(6), IDOK(1), IDNO(7), IDCANCEL(2) — send WM_COMMAND to dialog
    for btn_id in [6, 1, 7, 2]:
        btn = u32.GetDlgItem(hwnd, btn_id)
        if btn:
            u32.SendMessageW(hwnd, 0x0111, btn_id, btn)  # WM_COMMAND
            dismissed.append(f"{title} (btn={btn_id})")
            break
    else:
        u32.PostMessageW(hwnd, 0x0010, 0, 0)  # WM_CLOSE
        dismissed.append(f"{title} (WM_CLOSE)")
    return 1
CB = ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
u32.EnumWindows(CB(cb), 0)
print("\n".join(dismissed))
'''
DISMISS_MSGBOX_GUEST = r'C:\work\dismiss_msgbox.py'

# Close all VB6 child forms except the main form (WM_CLOSE)
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

_enum_deployed = False
_move_child_deployed = False
_dismiss_msgbox_deployed = False
_close_form_deployed = False


def _free_process(n=100):
    """Yield CPU n times without arbitrary delay — the AOL proggie way."""
    for _ in range(n):
        time.sleep(0)


def _qga_send_recv(sock, msg):
    """Send a QGA command and recv the response. No sleeps — recv blocks."""
    sock.sendall(json.dumps(msg).encode() + b'\n')
    # recv blocks until data arrives (up to socket timeout)
    return json.loads(sock.recv(65536))


def _qga_connect():
    """Connect to QGA and sync. Returns socket."""
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(QGA_SOCK)
    s.settimeout(10)
    _qga_send_recv(s, {'execute': 'guest-sync', 'arguments': {'id': int(time.time() * 1000) % 100000}})
    return s


def _qga_poll_exec(sock, pid, safety_max=200):
    """Poll guest-exec-status until exited=True. FreeProcess yield between polls."""
    for attempt in range(safety_max):
        _free_process(100)
        r = _qga_send_recv(sock, {'execute': 'guest-exec-status', 'arguments': {'pid': pid}})
        ret = r['return']
        if ret.get('exited', False):
            stdout = base64.b64decode(ret.get('out-data', '')).decode(errors='replace') if ret.get('out-data') else ''
            stderr = base64.b64decode(ret.get('err-data', '')).decode(errors='replace') if ret.get('err-data') else ''
            return {'status': 'ok', 'returncode': ret.get('exitcode', -1),
                    'stdout': stdout, 'stderr': stderr, 'exited': True}
    log.error(f'guest-exec pid={pid} never exited after {safety_max} polls')
    return {'status': 'timeout', 'returncode': -1, 'stdout': '', 'stderr': '', 'exited': False}


def _qga_exec(cmd, args, safety_max=200):
    """Run a command via QGA and poll for completion. Retries on connect error."""
    for attempt in range(3):
        try:
            s = _qga_connect()
            r = _qga_send_recv(s, {'execute': 'guest-exec', 'arguments': {
                'path': cmd, 'arg': args, 'capture-output': True
            }})
            if 'error' in r:
                s.close()
                log.warning(f'QGA exec error (attempt {attempt}): {r["error"]}')
                _free_process(100)
                continue
            pid = r['return']['pid']
            result = _qga_poll_exec(s, pid, safety_max)
            s.close()
            return result
        except Exception as e:
            log.warning(f'QGA exec error (attempt {attempt}): {e}')
            try: s.close()
            except: pass
            _free_process(100)
    return {'status': 'error', 'returncode': -1, 'stdout': '', 'stderr': 'QGA exec failed', 'exited': True}


def _gui_launch(cmdline):
    """Launch a process in session 1 via QGA → s1launch_sys.py. Polls for completion."""
    s = _qga_connect()
    r = _qga_send_recv(s, {'execute': 'guest-exec', 'arguments': {
        'path': PYTHON_GUEST, 'arg': [S1LAUNCH, cmdline], 'capture-output': True
    }})
    pid = r['return']['pid']
    result = _qga_poll_exec(s, pid)
    s.close()
    stdout = result.get('stdout', '')
    log.debug(f's1launch: {stdout.strip()}')
    return {'status': 'ok'}


def _qga_read_file(guest_path):
    """Read a file from the guest via QGA. Retries on error."""
    for attempt in range(3):
        try:
            s = _qga_connect()
            r = _qga_send_recv(s, {'execute': 'guest-file-open', 'arguments': {'path': guest_path, 'mode': 'r'}})
            if 'error' in r:
                s.close()
                log.warning(f'QGA file-open error (attempt {attempt}): {r["error"]}')
                _free_process(100)
                continue
            handle = r['return']
            data = b''
            while True:
                r = _qga_send_recv(s, {'execute': 'guest-file-read', 'arguments': {'handle': handle, 'count': 65536}})
                chunk = base64.b64decode(r['return']['buf-b64']) if r['return'].get('buf-b64') else b''
                data += chunk
                if r['return'].get('eof', False) or not chunk:
                    break
            _qga_send_recv(s, {'execute': 'guest-file-close', 'arguments': {'handle': handle}})
            s.close()
            return data.decode(errors='replace')
        except Exception as e:
            log.warning(f'QGA read error (attempt {attempt}): {e}')
            try: s.close()
            except: pass
            _free_process(100)
    log.error(f'QGA read failed after 3 attempts: {guest_path}')
    return ''


def _qga_write_file(guest_path, data):
    """Write data to a file on the guest via QGA. Retries on error."""
    for attempt in range(3):
        try:
            s = _qga_connect()
            r = _qga_send_recv(s, {'execute': 'guest-file-open', 'arguments': {'path': guest_path, 'mode': 'w'}})
            if 'error' in r:
                s.close()
                log.warning(f'QGA file-open error (attempt {attempt}): {r["error"]}')
                _free_process(100)
                continue
            handle = r['return']
            _qga_send_recv(s, {'execute': 'guest-file-write', 'arguments': {'handle': handle, 'buf-b64': base64.b64encode(data).decode()}})
            _qga_send_recv(s, {'execute': 'guest-file-close', 'arguments': {'handle': handle}})
            s.close()
            return
        except Exception as e:
            log.warning(f'QGA write error (attempt {attempt}): {e}')
            try: s.close()
            except: pass
            _free_process(100)
    log.error(f'QGA write failed after 3 attempts: {guest_path}')


_SHELL_OUT = r'C:\work\_shell_out.txt'
_SHELL_BAT = r'C:\work\_shell_cmd.bat'
_shell_seq = 0

def c2gui(action, **kwargs):
    """Run commands in session 1 via QGA + s1launch_sys.py.

    Shell commands: write .bat → s1launch → poll for s1launch exit →
    poll for output file existence → read output. No hardcoded waits.
    """
    if action == 'run':
        target = kwargs['target']
        _gui_launch(f'"{target}"')
        return {'status': 'running', 'pid': 0}
    elif action == 'shell':
        global _shell_seq
        _shell_seq += 1
        out_file = rf'C:\work\_shell_out_{_shell_seq}.txt'
        bat_file = rf'C:\work\_shell_cmd_{_shell_seq}.bat'
        command = kwargs['command']
        bat_content = f'@echo off\r\n{command} > {out_file} 2>&1\r\n'
        _qga_write_file(bat_file, bat_content.encode())
        _gui_launch(f'cmd.exe /c {bat_file}')
        # Poll for output file to exist and have content
        for attempt in range(200):
            _free_process(100)
            try:
                s = _qga_connect()
                r = _qga_send_recv(s, {'execute': 'guest-file-open', 'arguments': {'path': out_file, 'mode': 'r'}})
                if 'error' in r:
                    s.close()
                    continue  # file not ready yet — keep polling
                handle = r['return']
                r2 = _qga_send_recv(s, {'execute': 'guest-file-read', 'arguments': {'handle': handle, 'count': 65536}})
                _qga_send_recv(s, {'execute': 'guest-file-close', 'arguments': {'handle': handle}})
                s.close()
                chunk = base64.b64decode(r2['return']['buf-b64']) if r2['return'].get('buf-b64') else b''
                if chunk:
                    return {'status': 'ok', 'returncode': 0, 'stdout': chunk.decode(errors='replace'), 'stderr': ''}
            except Exception:
                try: s.close()
                except: pass
        # Final attempt — command may have produced empty output
        try:
            out = _qga_read_file(out_file)
        except Exception:
            out = ''
        return {'status': 'ok', 'returncode': 0, 'stdout': out, 'stderr': ''}
    else:
        raise ValueError(f'Unknown c2gui action: {action}')


def deploy_enum_script():
    """Write the window enumeration script to the guest (one-time)."""
    global _enum_deployed
    if _enum_deployed:
        return
    _qga_write_file(ENUM_SCRIPT_GUEST, ENUM_SCRIPT.encode())
    _enum_deployed = True


def deploy_move_child_script():
    """Write the child form mover script to the guest (one-time)."""
    global _move_child_deployed
    if _move_child_deployed:
        return
    _qga_write_file(MOVE_CHILD_GUEST, MOVE_CHILD_SCRIPT.encode())
    _move_child_deployed = True


def deploy_dismiss_msgbox_script():
    """Write the MsgBox dismisser script to the guest (one-time)."""
    global _dismiss_msgbox_deployed
    if _dismiss_msgbox_deployed:
        return
    _qga_write_file(DISMISS_MSGBOX_GUEST, DISMISS_MSGBOX_SCRIPT.encode())
    _dismiss_msgbox_deployed = True


def deploy_close_form_script():
    """Write the child form closer script to the guest (one-time)."""
    global _close_form_deployed
    if _close_form_deployed:
        return
    _qga_write_file(CLOSE_FORM_GUEST, CLOSE_FORM_SCRIPT.encode())
    _close_form_deployed = True


def dismiss_msgboxes():
    """Dismiss all visible #32770 MsgBox dialogs. Returns list of dismissed titles."""
    deploy_dismiss_msgbox_script()
    r = c2gui("shell", command=rf'python {DISMISS_MSGBOX_GUEST}')
    stdout = r.get('stdout', '').strip()
    if stdout:
        titles = [t.strip() for t in stdout.split('\n') if t.strip()]
        if titles:
            log.info(f'  Dismissed MsgBoxes: {titles}')
        return titles
    return []


def move_child_form(keep_title, tx, ty):
    """Move any child form/dialog to (tx, ty). Retries with FreeProcess. Returns child title."""
    deploy_move_child_script()
    for attempt in range(5):
        r = c2gui("shell", command=(
            rf'python {MOVE_CHILD_GUEST} '
            rf'"{keep_title}" {tx} {ty}'
        ))
        stdout = r.get('stdout', '').strip()
        if stdout:
            return stdout.split('\n')[0].strip()
        _free_process(100)
    return ''


def get_window_rects():
    """Enumerate visible windows via C2 GUI agent (session 1)."""
    deploy_enum_script()
    r = c2gui("shell", command=rf'python {ENUM_SCRIPT_GUEST}')
    if r.get('returncode') != 0:
        log.warning(f'Enum script failed: {r.get("stderr", "")[:200]}')
        return []
    try:
        data = _qga_read_file(ENUM_RESULT_GUEST)
        return json.loads(data)
    except Exception as e:
        log.warning(f'Failed to read window rects: {e}')
        return []


# ── Frame capture ────────────────────────────────────────────────────

class FrameCapture:
    def __init__(self, tmp_dir='/tmp/walkthrough'):
        self.tmp_dir = Path(tmp_dir)
        self.tmp_dir.mkdir(exist_ok=True)
        self.frames = []  # (png_path, label, delay_cs, win_rect_or_None)
        self.dialog_crops = {}  # caption -> crop geometry

    def capture(self, label, delay_cs=200, win_rect=None):
        n = len(self.frames)
        ppm = self.tmp_dir / f'frame_{n:03d}.ppm'
        png = self.tmp_dir / f'frame_{n:03d}.png'
        QMP.screenshot(str(ppm))
        subprocess.run(['convert', str(ppm), str(png)], capture_output=True)
        ppm.unlink(missing_ok=True)
        self.frames.append((png, label, delay_cs, win_rect))
        log.info(f'  frame {n}: {label}')
        return png

    _ref_screenshot = None  # reference "bad" screenshot for spot-checking

    def set_reference(self, label):
        """Store a reference screenshot (e.g. disclaimer) for duplicate detection."""
        for png, l, _, _ in self.frames:
            if l == label:
                self._ref_screenshot = png
                return

    def spot_check(self, label):
        """Compare latest capture against reference. Warns if identical."""
        if not self._ref_screenshot or not self.frames:
            return True
        latest = self.frames[-1][0]
        result = subprocess.run(['cmp', '-s', str(self._ref_screenshot), str(latest)],
                                capture_output=True)
        if result.returncode == 0:
            log.warning(f'  SPOT-CHECK FAIL: {label} is identical to reference!')
            return False
        return True

    @staticmethod
    def _rect_to_crop(rect, pad=15, screen_w=1280, screen_h=800):
        """Convert a window rect dict to ImageMagick crop geometry with padding."""
        x0 = max(rect['x'] - pad, 0)
        y0 = max(rect['y'] - pad, 0)
        x1 = min(rect['x'] + rect['w'] + pad, screen_w)
        y1 = min(rect['y'] + rect['h'] + pad, screen_h)
        return f'{x1 - x0}x{y1 - y0}+{x0}+{y0}'

    def build_gif(self, output_path, default_crop, main_rect=None):
        """Build GIF with per-frame adaptive cropping.
        Frames with a stored win_rect get cropped to a bbox that includes
        both that rect AND main_rect (so the main form is always visible).
        Others use default_crop."""
        if not self.frames:
            return
        cw, ch = GIF_CANVAS
        args = ['convert']
        for png, label, delay_cs, win_rect in self.frames:
            out = self.tmp_dir / f'gif_{png.stem}.png'
            if win_rect and main_rect:
                crop = self._combined_crop(main_rect, win_rect)
            elif win_rect:
                crop = self._rect_to_crop(win_rect)
            else:
                crop = default_crop
            cmd = ['convert', str(png)]
            if crop:
                cmd.extend(['-crop', crop, '+repage'])
            cmd.extend(['-resize', f'{cw}x{ch}', '-gravity', 'center',
                        '-background', 'black', '-extent', f'{cw}x{ch}', str(out)])
            subprocess.run(cmd, capture_output=True)
            args.extend(['-delay', str(delay_cs), str(out)])
        args.extend(['-loop', '0', str(output_path)])
        subprocess.run(args, capture_output=True)
        sz = os.path.getsize(output_path)
        log.info(f'GIF: {output_path} ({sz} bytes, {len(self.frames)} frames)')

    @staticmethod
    def _combined_crop(main_rect, child_rect, pad=15, screen_w=1280, screen_h=800):
        """Crop geometry that includes both main form and child form."""
        x0 = min(main_rect['x'], child_rect['x']) - pad
        y0 = min(main_rect['y'], child_rect['y']) - pad
        x1 = max(main_rect['x'] + main_rect['w'], child_rect['x'] + child_rect['w']) + pad
        y1 = max(main_rect['y'] + main_rect['h'], child_rect['y'] + child_rect['h']) + pad
        x0, y0 = max(x0, 0), max(y0, 0)
        x1, y1 = min(x1, screen_w), min(y1, screen_h)
        return f'{x1 - x0}x{y1 - y0}+{x0}+{y0}'

    def save_crop(self, output_path, label, crop):
        for png, l, _, wr in self.frames:
            if l == label:
                if crop:
                    subprocess.run(['convert', str(png), '-crop', crop, '+repage',
                                    str(output_path)], capture_output=True)
                else:
                    subprocess.run(['cp', str(png), str(output_path)], capture_output=True)
                return True
        return False

    @staticmethod
    def detect_cutoff(gif_path, min_edge_pct=0.4):
        """Heuristic cutoff detection on GIF frames.
        Flags frames where near-white content (>200 brightness) spans >40%
        of an edge — indicating the crop cut through a form's interior
        (VB6 form backgrounds are typically light gray ~240).
        Window title bars and custom skins are colored (<200), so they
        don't trigger this.
        Returns list of (frame_index, edge_description)."""
        from PIL import Image
        results = []
        gif = Image.open(gif_path)
        idx = 0
        while True:
            try:
                gif.seek(idx)
            except EOFError:
                break
            frame = gif.convert('RGB')
            w, h = frame.size
            edges = []
            for name, coords, span in [
                ('TOP', [(x, 0) for x in range(w)], w),
                ('BOTTOM', [(x, h - 1) for x in range(w)], w),
                ('LEFT', [(0, y) for y in range(h)], h),
                ('RIGHT', [(w - 1, y) for y in range(h)], h),
            ]:
                white = sum(1 for c in coords if min(frame.getpixel(c)) > 200)
                if white > span * min_edge_pct:
                    edges.append(f'{name}({white}px)')
            if edges:
                results.append((idx, ' '.join(edges)))
            idx += 1
        return results


# ── Menu tree ────────────────────────────────────────────────────────

class MenuNode:
    def __init__(self, name, caption):
        self.name = name
        self.caption = caption
        self.children = []
        self.is_separator = (caption == '-')
    def __repr__(self):
        kids = f' [{len(self.children)}]' if self.children else ''
        return f'{self.caption}{kids}'


def parse_menu_tree(menus):
    """Parse flat menu list into tree using name hierarchy."""
    by_name = {}
    roots = []
    for m in menus:
        node = MenuNode(m['name'], m['caption'])
        by_name[m['name']] = node
        parts = m['name'].rsplit('_', 1)
        if len(parts) == 2 and parts[0] in by_name:
            by_name[parts[0]].children.append(node)
        else:
            roots.append(node)
    return roots


def parse_menu_tree_from_frm(frm_path):
    """Parse menu hierarchy from .frm indentation (reliable)."""
    text = frm_path.read_text(errors='replace')
    stack = []  # (indent, MenuNode)
    roots = []
    caption = None
    for line in text.split('\n'):
        stripped = line.strip().rstrip('\r')
        m = re.match(r'Begin Menu (\S+)', stripped)
        if m:
            indent = len(line) - len(line.lstrip())
            name = m.group(1)
            caption = None  # will be set by next Caption= line
            node = MenuNode(name, '')
            node._indent = indent
            # Pop stack to find parent
            while stack and stack[-1][0] >= indent:
                stack.pop()
            if stack:
                stack[-1][1].children.append(node)
            else:
                roots.append(node)
            stack.append((indent, node))
        cm = re.match(r'Caption\s*=\s*"([^"]*)"', stripped)
        if cm and stack:
            stack[-1][1].caption = cm.group(1)
            stack[-1][1].is_separator = (cm.group(1) == '-')
    return roots


def find_menu_actions(zip_stem, exe_name):
    """Scan _Click functions to classify menu item actions."""
    actions = {}
    # Try old layout: modules/*_Click.vb
    funcs_dir = REPO / 'decompiled' / zip_stem / exe_name / 'modules'
    if funcs_dir.exists():
        for vb_file in funcs_dir.rglob('*_Click.vb'):
            match = re.match(r'\d+_(.+)_Click$', vb_file.stem)
            if not match:
                continue
            name = match.group(1)
            code = vb_file.read_text(errors='replace')
            actions[name] = _classify_click(name, code)
    # Try new layout: metadata.json code_breakdown
    if not actions:
        meta_path = REPO / 'decompiled' / zip_stem / exe_name / 'metadata.json'
        if meta_path.exists():
            meta = json.loads(meta_path.read_text())
            for fn in meta.get('code_breakdown', {}).get('app_functions', []):
                m = re.match(r'(\w+)_Click\(\)', fn['name'])
                if not m:
                    continue
                name = m.group(1)
                actions[name] = _classify_click(name, fn.get('code', ''))
    return actions


def _classify_click(name, code):
    if re.search(r'\.Show\b', code):
        return 'show_form'
    if re.search(r'MsgBox\b|vbInformation|vbCritical', code):
        return 'msgbox'
    if code.count('vbCrLf') >= 2:
        return 'msgbox'
    if re.search(r'\.Hide\b|Unload\b', code):
        return 'hide'
    return 'action'


def extract_greet_names(zip_stem, exe_name):
    """Extract greet names from Timer code in decompiled source."""
    funcs_dir = REPO / 'decompiled' / zip_stem / exe_name / 'modules'
    names = []
    seen = set()
    for vb_file in funcs_dir.rglob('*Timer*_Timer.vb'):
        code = vb_file.read_text(errors='replace')
        for m in re.finditer(r'var_18 = "([^"]+)"', code):
            n = m.group(1)
            if n not in seen:
                seen.add(n)
                names.append(n)
    return names


# ── Form position from .frm ─────────────────────────────────────────

def read_frm_controls(frm_path):
    """Parse .frm file to get control positions in twips."""
    controls = {}
    current = None
    text = frm_path.read_text(errors='replace')
    for line in text.split('\n'):
        line = line.strip().rstrip('\r')
        m = re.match(r'Begin (\S+) (\S+)', line)
        if m:
            current = {'type': m.group(1), 'name': m.group(2)}
            continue
        if line == 'End' and current:
            controls[current['name']] = current
            current = None
            continue
        if current:
            m = re.match(r'(\w+)\s*=\s*(.+)', line)
            if m:
                key, val = m.group(1), m.group(2).strip()
                try:
                    current[key] = int(val)
                except ValueError:
                    current[key] = val.strip("'").strip()
    return controls


# ── Walkthrough engine ───────────────────────────────────────────────

MENU_ITEM_H = 22  # pixels per regular menu item
MENU_SEP_H = 10   # pixels per separator


def _launch_proggie(zip_stem, exe_name):
    """Push exe + deps to VM and launch. Returns True on success."""
    import sqlite3
    db = sqlite3.connect(str(DB_PATH))
    row = db.execute('''SELECT e.exe_path, p.aol_version FROM exes e
                        JOIN proggies p ON e.proggie_id=p.id
                        WHERE p.zip_stem=? AND e.exe_name=?''', (zip_stem, exe_name)).fetchone()
    db.close()
    if not row:
        log.error(f'Exe not found in DB: {zip_stem}/{exe_name}')
        return False
    extracted = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / '_extracted' / zip_stem
    local_exe = extracted / exe_name
    if not local_exe.exists():
        log.error(f'Exe not found: {local_exe}')
        return False
    guest_exe = rf'C:\work\{exe_name}'
    c2gui("shell", command=r"if not exist C:\work mkdir C:\work")
    sys.path.insert(0, str(REPO / 'tools' / 'vm' / 'host'))
    from push_file import push_file
    try:
        push_file(str(local_exe), guest_exe)
    except Exception as e:
        log.warning(f'Push failed ({e}), exe may already be on VM')
    for f in extracted.iterdir():
        if f.suffix.lower() in ('.dll', '.ocx') and f.name.lower() != exe_name.lower():
            try:
                push_file(str(f), rf'C:\work\{f.name}')
            except Exception:
                pass
    c2gui("run", target=guest_exe)
    return True


def extract_form_secrets(zip_stem, exe_name):
    """Extract passwords from decompiled source and exe strings.

    Returns dict mapping menu item caption → password string.
    """
    secrets = {}
    # Check decompiled forms for TextBox comparison patterns
    cleaned = REPO / 'decompiled' / zip_stem / exe_name / 'cleaned'
    if cleaned.exists():
        for frm in cleaned.glob('*.frm'):
            src = frm.read_text(errors='replace')
            for m in re.finditer(r'If\b.*Text\d*\.Text\s*=\s*"([^"]+)"', src):
                cap_m = re.search(r'Caption\s*=\s*"([^"]+)"', src)
                if cap_m:
                    secrets[cap_m.group(1)] = m.group(1)

    # Scan exe binary for password patterns
    exe_path = REPO / 'programs/AOL/proggies-sorted-deduped/_extracted' / zip_stem / exe_name
    if exe_path.exists():
        try:
            raw = subprocess.run(['strings', '-el', str(exe_path)],
                                 capture_output=True, text=True, timeout=10).stdout
            lines = raw.splitlines()
            for i, line in enumerate(lines):
                lo = line.lower()
                # "type my first name" pattern — name is a few lines after
                if 'type' in lo and 'first name' in lo:
                    for j in range(i + 1, min(len(lines), i + 5)):
                        w = lines[j].strip()
                        if w and w[0].isupper() and w.isalpha() and 3 <= len(w) <= 15:
                            for k in range(i - 1, max(0, i - 10), -1):
                                cap = lines[k].strip()
                                if cap and "'" not in cap and len(cap) < 40 and not cap.startswith(('http', '/', '<')):
                                    secrets[cap] = w
                                    break
                            break
                # "secret area" caption followed by a short name = password
                if 'secret' in lo and 'area' in lo and i + 1 < len(lines):
                    nxt = lines[i + 1].strip()
                    if nxt and nxt[0].isupper() and nxt.isalpha() and 3 <= len(nxt) <= 15:
                        secrets[line.strip()] = nxt
        except Exception:
            pass

    return secrets


def run_walkthrough(zip_stem, exe_name, meta):
    """Main walkthrough logic. Uses runtime window detection for all positions."""
    t_start = time.time()
    fc = FrameCapture()
    form_secrets = extract_form_secrets(zip_stem, exe_name)
    if form_secrets:
        log.info(f'Form secrets: {list(form_secrets.keys())}')

    # Launch the proggie if not already running
    windows = get_window_rects()
    vb6_classes = {'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT5FormDC', 'ThunderRT5Form'}
    proggie_wins = [w for w in windows
                    if w['class'] in vb6_classes and 'VB Decompiler' not in w.get('title', '')
                    and w['x'] >= 0]
    if not proggie_wins:
        log.info('Proggie not running, launching...')
        if not _launch_proggie(zip_stem, exe_name):
            sys.exit(1)
        # Poll for window to appear — FreeProcess yield between checks
        for attempt in range(100):
            _free_process(100)
            windows = get_window_rects()
            proggie_wins = [w for w in windows
                            if w['class'] in vb6_classes and 'VB Decompiler' not in w.get('title', '')
                            and w['x'] >= 0]
            if proggie_wins:
                break
            if attempt % 10 == 0:
                log.info(f'  Waiting for proggie window... ({attempt}/100)')

    # Get runtime window positions
    log.info('Getting window positions from guest...')
    if not proggie_wins:
        prog_name = meta.get('project', {}).get('name', '')
        proggie_wins = [w for w in windows if prog_name and prog_name in w.get('title', '')]
    if not proggie_wins:
        log.error('Could not find proggie window. Visible windows:')
        for w in windows:
            if w['w'] > 10 and w['h'] > 10:
                log.error(f'  {w["class"]}: "{w["title"]}" at {w["x"]},{w["y"]} {w["w"]}x{w["h"]}')
        sys.exit(1)

    main_win = proggie_wins[0]
    fx, fy, fw, fh = main_win['x'], main_win['y'], main_win['w'], main_win['h']
    log.info(f'Main form: "{main_win["title"]}" at {fx},{fy} {fw}x{fh}')

    # Dismiss any startup MsgBoxes (e.g. bodini Disclaimer)
    dismiss_msgboxes()

    main_form_data = None
    startup = meta.get('project', {}).get('Startup', '').strip('"')
    for form in meta['forms']:
        if form['name'].lower() == startup.lower():
            main_form_data = form
            break
    if not main_form_data:
        # Fall back to matching window title
        for form in meta['forms']:
            if form['name'].lower() in main_win.get('title', '').lower():
                main_form_data = form
                break
    if not main_form_data:
        main_form_data = meta['forms'][0]
    menu_form_data = None
    for form in meta['forms']:
        if form.get('menus'):
            menu_form_data = form
            break

    # Read .frm for control positions (try both flat and forms/ layout)
    frm_path = REPO / 'decompiled' / zip_stem / exe_name / f'{main_form_data["name"]}.frm'
    if not frm_path.exists():
        frm_path = REPO / 'decompiled' / zip_stem / exe_name / 'forms' / f'{main_form_data["name"]}.frm'
    controls = read_frm_controls(frm_path) if frm_path.exists() else {}

    # Calculate non-client offset
    nc_x, nc_y = 3, 3
    if frm_path.exists():
        frm_text = frm_path.read_text(errors='replace')
        cw_m = re.search(r'ClientWidth\s*=\s*(\d+)', frm_text)
        ch_m = re.search(r'ClientHeight\s*=\s*(\d+)', frm_text)
        if cw_m and ch_m:
            frm_client_w = int(cw_m.group(1)) // TWIPS_PER_PX
            frm_client_h = int(ch_m.group(1)) // TWIPS_PER_PX
            nc_x = max((fw - frm_client_w) // 2, 0)
            nc_y = max(fh - frm_client_h - nc_x, 0)
            log.info(f'Non-client offset: x={nc_x}, y={nc_y} (client {frm_client_w}x{frm_client_h}, window {fw}x{fh})')

    # Park cursor off the main form before first capture
    QMP.move(0, 0)
    _free_process(100)
    fc.capture('main', delay_cs=200)
    _free_process(100)

    actions = find_menu_actions(zip_stem, exe_name)
    log.info(f'Actions: {actions}')

    def close_menu():
        QMP.key('escape')
        _free_process(100)

    def _try_click_for_popup(sx, sy):
        """Click at (sx,sy), poll for #32768 popup."""
        QMP.click(sx, sy)
        for _ in range(4):
            wins = get_window_rects()
            popups = [w for w in wins if w['class'] == '#32768' and w['w'] > 20]
            if popups:
                return popups[0]
        return None

    def _try_click_for_form(sx, sy):
        """Click at (sx,sy), poll for new VB form."""
        before = {w['title'] for w in get_window_rects() if w['class'] in vb6_classes}
        QMP.click(sx, sy)
        for _ in range(4):
            after = get_window_rects()
            nf = [w for w in after if w['class'] in vb6_classes and w['title'] not in before and w['w'] > 30]
            if nf:
                return nf[0]
        return None

    # Collect all clickable labels with their screen positions
    clickable_labels = []
    for name, ctrl in controls.items():
        if ctrl.get('type') not in ('Label', 'Image', 'PictureBox'):
            continue
        lx = fx + nc_x + ctrl.get('Left', 0) // TWIPS_PER_PX + ctrl.get('Width', 0) // TWIPS_PER_PX // 2
        ly = fy + nc_y + ctrl.get('Top', 0) // TWIPS_PER_PX + ctrl.get('Height', 0) // TWIPS_PER_PX // 2
        # Only include if inside the window bounds
        if fx < lx < fx + fw and fy < ly < fy + fh:
            clickable_labels.append({'name': name, 'x': lx, 'y': ly,
                                     'caption': ctrl.get('Caption', '')})

    log.info(f'Clickable labels: {len(clickable_labels)}')

    # Phase 1: Click each label, discover which ones produce popups or forms
    popup_rect = None
    popup_label = None
    popup_labels = []  # list of (label, popup_rect) for all labels that produce popups
    for lbl in clickable_labels:
        before_wins = {(w['class'], w['title']) for w in get_window_rects() if w['class'] in vb6_classes}
        QMP.click(lbl['x'], lbl['y'])
        # Poll for popup or new form (each get_window_rects ~1s, so 4 retries = ~4s max)
        found = None
        for _ in range(4):
            wins = get_window_rects()
            popups = [w for w in wins if w['class'] == '#32768' and w['w'] > 20]
            if popups:
                found = ('popup', popups[0])
                break
            nf = [w for w in wins if w['class'] in vb6_classes
                  and (w['class'], w['title']) not in before_wins and w['w'] > 30]
            if nf:
                found = ('form', nf[0])
                break
        if found and found[0] == 'popup':
            p = found[1]
            log.info(f'  {lbl["name"]} → popup at {p["x"]},{p["y"]} {p["w"]}x{p["h"]}')
            fc.capture(f'menu_{lbl["name"]}', delay_cs=200)
            popup_rect = p
            popup_label = lbl
            popup_labels.append((lbl, p))
            close_menu()
        elif found and found[0] == 'form':
            nf = found[1]
            log.info(f'  {lbl["name"]} → form "{nf["title"]}" at {nf["x"]},{nf["y"]}')
            fc.capture(f'dialog_{lbl["name"]}', delay_cs=300, win_rect=nf)
            QMP.key('escape')
        else:
            log.info(f'  {lbl["name"]} → no popup or form')

    # Phase 2: Click through menu items that show forms
    # Parse menu hierarchy from .frm (not flat metadata)
    menu_frm_path = None
    if menu_form_data:
        menu_frm_path = REPO / 'decompiled' / zip_stem / exe_name / f'{menu_form_data["name"]}.frm'
        if not menu_frm_path.exists():
            menu_frm_path = REPO / 'decompiled' / zip_stem / exe_name / 'forms' / f'{menu_form_data["name"]}.frm'
        if not menu_frm_path.exists():
            menu_frm_path = None

    log.info(f'Phase 2: {len(popup_labels)} popup labels, menu_frm_path={menu_frm_path is not None}')
    t_phase2 = time.time()
    log.info(f'Phase 1 took {t_phase2 - t_start:.1f}s')

    menu_map = []
    popup_labels_sorted = []

    if popup_labels and menu_form_data:
        # Deploy child form mover — after each menu click, move child form next to main
        deploy_move_child_script()
        # Child forms go to top-left corner (0,0) — away from main form at top-right
        child_tgt_x = 0
        child_tgt_y = 0

        menu_roots = parse_menu_tree_from_frm(menu_frm_path) if menu_frm_path else []
        if menu_roots:
            log.info(f'Menu tree: {[f"{r.caption} [{len(r.children)}]" for r in menu_roots]}')

        matched_roots = set()

        # Sort popup labels left-to-right to match menu category order
        popup_labels_sorted = sorted(popup_labels, key=lambda pl: pl[0]['x'])

        def wait_for(predicate, retries=4):
            """Poll predicate (each call ~1s due to get_window_rects)."""
            for _ in range(retries):
                result = predicate()
                if result:
                    return result
            return None

        def find_popup():
            wins = get_window_rects()
            popups = [w for w in wins if w['class'] == '#32768' and w['w'] > 20]
            return popups[0] if popups else None

        def open_popup_for(lbl, prect):
            """Click label to open popup. Trust it works — position known from Phase 1."""
            QMP.click(fx + fw // 2, fy + fh // 2)
            _free_process(50)
            QMP.click(lbl['x'], lbl['y'])
            _free_process(100)
            return prect

        def close_and_dismiss():
            """Dismiss MsgBoxes, then WM_CLOSE child forms."""
            dismiss_msgboxes()
            _free_process(100)
            deploy_close_form_script()
            keep = main_win.get('title', '')
            c2gui("shell", command=rf'python {CLOSE_FORM_GUEST} "{keep}"')
            _free_process(100)
            # Second pass — sometimes closing one form reveals another MsgBox
            dismiss_msgboxes()

        for plbl, prect in popup_labels_sorted:
            visible_count = prect['h'] // 20
            matched_items = None
            item_h = 20

            for ri, root in enumerate(menu_roots):
                if ri in matched_roots:
                    continue
                if abs(len(root.children) - visible_count) <= 3:
                    matched_items = root.children
                    matched_roots.add(ri)
                    item_h = prect['h'] // len(root.children)
                    log.info(f'{plbl["name"]} → {root.caption} ({len(root.children)} items, {item_h}px/item)')
                    break

            if not matched_items:
                log.info(f'{plbl["name"]} → no category match (~{visible_count} items)')
                continue

            cat = {'category': root.caption, 'items': []}

            for idx, item in enumerate(matched_items):
                act = actions.get(item.name, '')
                has_kids = hasattr(item, 'children') and len(item.children) > 0

                if has_kids:
                    for si, sub in enumerate(item.children):
                        if actions.get(sub.name, '') not in ('show_form', 'msgbox'):
                            continue
                        p = open_popup_for(plbl, prect)
                        tgt_x = p['x'] + p['w'] // 2
                        tgt_y = p['y'] + idx * item_h + item_h // 2
                        QMP.smooth_move(tgt_x, tgt_y)
                        _free_process(100)
                        stgt_x = p['x'] + p['w'] + 40
                        sub_ih = item_h
                        stgt_y = tgt_y + si * sub_ih
                        QMP.smooth_move(stgt_x, stgt_y)
                        fc.capture(f'hover_{sub.caption}', delay_cs=80)
                        QMP.click(stgt_x, stgt_y)
                        _free_process(100)
                        dismiss_msgboxes()
                        _free_process(100)
                        _ct = ''
                        if act in ('show_form', 'msgbox'):
                            _ct = move_child_form(main_win['title'], child_tgt_x, child_tgt_y)
                        fc.capture(f'form_{sub.caption}', delay_cs=250)
                        fc.spot_check(sub.caption)
                        log.info(f'  {sub.caption} → captured (child_title={_ct!r})')
                        cat['items'].append({'caption': sub.caption, 'type': act, 'child_title': _ct})
                        close_and_dismiss()
                    continue

                if act not in ('show_form', 'msgbox') or 'exit' in item.name.lower():
                    continue

                p = open_popup_for(plbl, prect)
                iy = p['y'] + idx * item_h + item_h // 2
                if iy > p['y'] + p['h']:
                    close_menu(); continue

                QMP.smooth_move(p['x'] + p['w'] // 2, iy)
                fc.capture(f'hover_{item.caption}', delay_cs=80)
                QMP.click(p['x'] + p['w'] // 2, iy)
                _free_process(100)
                dismiss_msgboxes()
                _free_process(100)
                _ct = move_child_form(main_win['title'], child_tgt_x, child_tgt_y)
                fc.capture(f'form_{item.caption}', delay_cs=250)
                fc.spot_check(item.caption)
                log.info(f'  {item.caption} → captured (child_title={_ct!r})')

                # Set disclaimer as reference for spot-checking
                if item.caption.lower() == 'disclaimer':
                    fc.set_reference(f'form_{item.caption}')

                # Greets: capture multiple frames for animated GIF of scrolling names
                if item.caption.lower() == 'greets':
                    greet_frames = []
                    for gi in range(60):  # ~12s at 200ms intervals
                        time.sleep(0.2)
                        gf = fc.capture(f'greets_{gi:02d}', delay_cs=20)
                        greet_frames.append(gf)
                    log.info(f'  Greets: captured {len(greet_frames)} animation frames')

                # If this form has a known secret/password, type it and capture the result
                secret = form_secrets.get(item.caption)
                if not secret:
                    # Fuzzy: menu caption is substring of a form caption with a secret
                    for cap, pw in form_secrets.items():
                        if item.caption.lower() in cap.lower() or cap.lower() in item.caption.lower():
                            secret = pw
                            break
                if secret:
                    log.info(f'  {item.caption} → typing secret ({len(secret)} chars)')
                    _free_process(100)
                    # WM_SETTEXT to TextBox + BM_CLICK on CommandButton via Win32 API
                    keep = main_win.get('title', '')
                    r = c2gui("shell", command=(
                        rf'python C:\work\type_secret.py '
                        rf'"{keep}" "{secret}"'
                    ))
                    log.info(f'  type_secret: {r.get("stdout", "").strip()}')
                    _free_process(100)
                    fc.capture(f'secret_{item.caption}', delay_cs=250)
                    log.info(f'  {item.caption} → secret result captured')
                    cat['items'].append({'caption': f'{item.caption} (unlocked)', 'type': 'secret',
                                         'image': f'screen_secret_{item.caption.lower().replace(" ", "_")}.png'})

                cat['items'].append({'caption': item.caption, 'type': act, 'child_title': _ct})
                close_and_dismiss()

            if cat['items']:
                menu_map.append(cat)

    # Build label position map (form-relative coords) for interactive HTML
    label_positions = {}
    for plbl, prect in popup_labels_sorted:
        for cat in menu_map:
            # Match by checking if this label produced this category
            # plbl was matched to root.caption which became cat['category']
            pass
    # Simpler: use controls dict directly — labels are Label2..Label6
    for name, ctrl in controls.items():
        if ctrl.get('type') != 'Label' or name == 'Label1':
            continue
        label_positions[name] = {
            'left': ctrl.get('Left', 0) // TWIPS_PER_PX,
            'top': ctrl.get('Top', 0) // TWIPS_PER_PX,
            'width': ctrl.get('Width', 0) // TWIPS_PER_PX,
            'height': ctrl.get('Height', 0) // TWIPS_PER_PX,
        }

    t_end = time.time()
    log.info(f'Phase 2 took {t_end - t_phase2:.1f}s, total {t_end - t_start:.1f}s, {len(fc.frames)} frames')
    return fc, (fx, fy, fw, fh), popup_rect, menu_map, label_positions, (nc_x, nc_y)


def save_outputs(fc, form_rect, popup_rect, zip_stem, exe_name=None, menu_map=None, label_positions=None, nc_offset=None):
    """Save GIF and static screenshots."""
    import sqlite3
    fx, fy, fw, fh = form_rect

    # Find AOL version from DB
    db = REPO / 'proggie_db.sqlite'
    aol_ver = 'unknown'
    if db.exists():
        conn = sqlite3.connect(str(db))
        row = conn.execute('SELECT aol_version FROM proggies WHERE zip_stem=?', (zip_stem,)).fetchone()
        if row: aol_ver = row[0] or 'unknown'
        conn.close()

    out_dir = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / aol_ver / zip_stem
    out_dir.mkdir(parents=True, exist_ok=True)

    # Bounding box: child forms at top-left (0,0), main form at top-right
    if popup_rect:
        px, py, pw, ph = popup_rect['x'], popup_rect['y'], popup_rect['w'], popup_rect['h']
    else:
        px, py, pw, ph = fx, fy + fh, 120, 150
    box_x0 = 0
    box_y0 = 0
    box_x1 = min(max(fx + fw, px + pw + pw) + 20, SCREEN_W)
    box_y1 = min(max(fy + fh + 400, py + ph) + 15, SCREEN_H)
    menu_crop = f'{box_x1 - box_x0}x{box_y1 - box_y0}+{box_x0}+{box_y0}'

    # Exclude dialog frames from GIF — they're static screenshots only
    gif_frames = [(p, l, d, wr) for p, l, d, wr in fc.frames if not l.startswith('dialog_')]
    orig_frames = fc.frames
    fc.frames = gif_frames
    main_rect = {'x': fx, 'y': fy, 'w': fw, 'h': fh}
    fc.build_gif(out_dir / 'animated.gif', menu_crop, main_rect=main_rect)
    fc.frames = orig_frames

    # Static screenshots
    form_crop = f'{fw + 5}x{fh + 5}+{fx}+{fy}'
    fc.save_crop(out_dir / 'screenshot.png', 'main', form_crop)
    fc.save_crop(out_dir / 'screen_menu.png', 'menu', menu_crop)

    # Save each form/dialog frame as individual PNG
    greets_pngs = []
    greets_crop = None
    for png, label, _, wr in fc.frames:
        if label.startswith('form_') or label.startswith('dialog_'):
            caption = label.replace('dialog_', '').replace('form_', '')
            name = caption.replace(' ', '_').lower()
            fname = f'screen_{name}.png'
            crop = FrameCapture._rect_to_crop(wr) if wr else menu_crop
            fc.save_crop(out_dir / fname, label, crop)
            if caption.lower() == 'greets':
                greets_crop = crop
        elif label.startswith('greets_'):
            greets_pngs.append(png)

    # Build greets animation GIF from captured frames
    if greets_pngs:
        from PIL import Image as _PILImage
        crop_str = greets_crop or menu_crop
        # Parse crop geometry "WxH+X+Y"
        import re as _re
        m = _re.match(r'(\d+)x(\d+)\+(\d+)\+(\d+)', crop_str)
        if m:
            cw, ch, cx, cy = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
        else:
            cx, cy, cw, ch = box_x0, box_y0, box_x1 - box_x0, box_y1 - box_y0
        imgs = []
        for gp in greets_pngs:
            full = _PILImage.open(gp)
            cropped = full.crop((cx, cy, cx + cw, cy + ch))
            imgs.append(cropped)
        if imgs:
            imgs_p = [im.convert('P', palette=_PILImage.ADAPTIVE) for im in imgs]
            imgs_p[0].save(out_dir / 'screen_greets.gif', save_all=True,
                         append_images=imgs_p[1:], duration=200, loop=0)
            log.info(f'Greets GIF: {len(imgs)} frames → screen_greets.gif')
        elif label.startswith('submenu_'):
            name = label.replace('submenu_', '').replace(' ', '_').lower()
            fc.save_crop(out_dir / f'screen_submenu_{name}.png', label, menu_crop)

    # Write walkthrough manifest for interactive HTML
    if menu_map:
        for cat in menu_map:
            for item in cat['items']:
                slug = item["caption"].replace(" ", "_").lower()
                # Use GIF for greets if available
                if item['caption'].lower() == 'greets' and greets_pngs:
                    item['image'] = f'screen_greets.gif'
                else:
                    item['image'] = f'screen_{slug}.png'
        # Save main form crop for interactive widget
        fc.save_crop(out_dir / 'main_form.png', 'main', f'{fw}x{fh}+{fx}+{fy}')
        nc_x, nc_y = nc_offset or (3, 3)

        # Auto-crop each child form screenshot to just the form content
        # Child forms are at screen (0,0), main form at (fx, fy)
        # In the cropped screenshot, child is at (0-box_x0, 0-box_y0) = (0,0)
        # Main form is at (fx-box_x0, fy-box_y0)
        # Find non-black bounds excluding the main form area and taskbar
        import numpy as _np
        from PIL import Image as _PILImage
        main_left_in_crop = fx - box_x0  # x where main form starts in crop coords
        taskbar_y = 440 - box_y0  # taskbar starts ~440px from screen top
        for cat in menu_map:
            for item in cat['items']:
                img_path = out_dir / item.get('image', '')
                if not img_path.exists():
                    continue
                img = _PILImage.open(img_path).convert('RGB')
                arr = _np.array(img)
                # Mask: only look at area left of main form and above taskbar
                clip_x = min(main_left_in_crop, arr.shape[1])
                clip_y = min(max(taskbar_y, 0), arr.shape[0])
                if clip_x <= 0 or clip_y <= 0:
                    continue
                region = arr[:clip_y, :clip_x, :]
                mask = region.max(axis=2) > 25
                rows = mask.any(axis=1)
                cols = mask.any(axis=0)
                if not rows.any():
                    # No content in child area — bad screenshot
                    item['child_h'] = img.height
                    continue
                y0 = int(_np.where(rows)[0][0])
                y1 = int(_np.where(rows)[0][-1])
                x0 = int(_np.where(cols)[0][0])
                x1 = int(_np.where(cols)[0][-1])
                # Crop to child form bounds with small padding
                pad = 2
                cx0 = max(x0 - pad, 0)
                cy0 = max(y0 - pad, 0)
                cx1 = min(x1 + pad + 1, img.width)
                cy1 = min(y1 + pad + 1, img.height)
                cropped = img.crop((cx0, cy0, cx1, cy1))
                cropped.save(img_path)
                item['child_h'] = cropped.height
                log.debug(f'  Auto-cropped {item["image"]}: {img.size} → {cropped.size}')

        manifest = {
            'form': {'width': fw, 'height': fh, 'image': 'main_form.png',
                     'nc_x': nc_x, 'nc_y': nc_y,
                     'crop_x0': box_x0, 'crop_y0': box_y0,
                     'screen_x': fx, 'screen_y': fy},
            'labels': label_positions or {},
            'categories': menu_map,
            'greets': extract_greet_names(zip_stem, exe_name) if exe_name else [],
        }
        with open(out_dir / 'walkthrough.json', 'w') as f:
            json.dump(manifest, f, indent=2)
        log.info(f'Walkthrough manifest: {len(menu_map)} categories, {sum(len(c["items"]) for c in menu_map)} items')

    log.info(f'Output: {out_dir}')
    return out_dir


# ── Main ─────────────────────────────────────────────────────────────

def screenshot_only(zip_stem, exe_name, meta):
    """Launch exe, screenshot the main form, save it, kill exe."""
    import sqlite3

    if not _launch_proggie(zip_stem, exe_name):
        return None

    db = sqlite3.connect(str(DB_PATH))
    row = db.execute('''SELECT p.aol_version FROM proggies p
                        JOIN exes e ON e.proggie_id=p.id
                        WHERE p.zip_stem=? AND e.exe_name=?''', (zip_stem, exe_name)).fetchone()
    db.close()
    ver = row[0] if row else '4.0'

    # Find window
    windows = get_window_rects()
    vb6_classes = {'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT5FormDC', 'ThunderRT5Form'}
    proggie_wins = [w for w in windows
                    if w['class'] in vb6_classes and 'VB Decompiler' not in w.get('title', '')
                    and w['x'] >= 0]
    if not proggie_wins:
        log.error('Could not find proggie window')
        c2gui("shell", command=f'taskkill /f /im "{exe_name}" 2>nul')
        return None

    win = proggie_wins[0]
    qmp = QMP()
    qmp.screenshot('/tmp/walkthrough_shot.ppm')
    _free_process(100)

    from PIL import Image
    img = Image.open('/tmp/walkthrough_shot.ppm')
    crop = img.crop((win['x'], win['y'], win['x'] + win['w'], win['y'] + win['h']))

    out_dir = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / ver / zip_stem
    out_dir.mkdir(parents=True, exist_ok=True)
    crop.save(out_dir / 'screenshot.png')
    log.info(f'Saved {out_dir}/screenshot.png ({win["w"]}x{win["h"]})')

    # Kill
    c2gui("shell", command=f'taskkill /f /im "{exe_name}" 2>nul')
    return True


def main():
    if len(sys.argv) < 2:
        print(f'Usage: {sys.argv[0]} <zip_stem> [<exe_name>] [--screenshot-only]')
        sys.exit(1)

    # Handle --screenshot-only flag (may be in any position)
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    screenshot_mode = '--screenshot-only' in sys.argv

    zip_stem = args[0]
    decomp_dir = REPO / 'decompiled' / zip_stem
    if not decomp_dir.exists():
        log.error(f'No decompiled data at {decomp_dir}')
        sys.exit(1)

    exe_dirs = [d for d in decomp_dir.iterdir() if d.is_dir()]
    exe_name = args[1] if len(args) > 1 else exe_dirs[0].name if len(exe_dirs) == 1 else None
    if not exe_name:
        # No subdirs — flat layout, exe_name from files
        frm_files = list(decomp_dir.glob('*.frm'))
        if frm_files:
            exe_name = decomp_dir.name
        else:
            log.error(f'Multiple exes, specify one: {[d.name for d in exe_dirs]}')
            sys.exit(1)

    meta_path = decomp_dir / exe_name / 'metadata.json'
    if not meta_path.exists():
        # Try flat layout
        meta_path = decomp_dir / 'metadata.json'
    if not meta_path.exists():
        log.error(f'No metadata.json at {meta_path}')
        sys.exit(1)

    meta = json.loads(meta_path.read_text())

    if screenshot_mode:
        result = screenshot_only(zip_stem, exe_name, meta)
        sys.exit(0 if result else 1)

    fc, form_rect, popup_rect, menu_map, label_positions, nc_offset = run_walkthrough(zip_stem, exe_name, meta)
    out_dir = save_outputs(fc, form_rect, popup_rect, zip_stem, exe_name, menu_map, label_positions, nc_offset)
    log.info('Done. Run: python3 tools/generate_analysis.py '
             f'programs/AOL/proggies-sorted-deduped/*/{zip_stem}.html')


if __name__ == '__main__':
    main()
