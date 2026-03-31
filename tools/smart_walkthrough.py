#!/usr/bin/env python3
"""Smart walkthrough: state-diff driven screenshot capture for VB proggies.

Uses decompiled source as navigation map, runtime window diffing for
verification and cropping, Bezier mouse movement for natural animation.

Usage:
    python3 tools/smart_walkthrough.py <zip_stem> [--screenshot-only]
"""
import argparse, json, logging, os, re, shutil, sqlite3, subprocess, sys, time
from pathlib import Path

# Hunter deep tracing — always on, timestamped per-run, file only
import hunter
from datetime import datetime, timezone
_hunter_log = (Path.home() / 'traces' / Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
_hunter_stream = open(_hunter_log, 'a')
hunter.trace(stdlib=False, action=hunter.CallPrinter(
    stream=_hunter_stream))
# _hunter_stream held at module level to prevent GC

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s.%(msecs)03d [%(levelname)-8s] %(name)s: %(message)s',
    datefmt='%H:%M:%S',
)
log = logging.getLogger(Path(__file__).stem)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'
DECOMPILED = REPO / 'decompiled'
SORTED = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped'
SCREEN_W, SCREEN_H = 1280, 800
TWIPS_PER_PX = 15

sys.path.insert(0, str(REPO / 'tools'))
from window_diff import (WindowDiff, QMP, capture_cropped, capture_context,
                          capture_full_screen, dismiss_msgboxes, close_child_forms,
                          move_child_form, _c2gui_shell, PYTHON_GUEST, VB6_CLASSES)
from bezier_mouse import bezier_move
from discover_targets import discover_targets
from extract_passwords import extract_passwords

# ── Guest scripts for Win32 interaction ──────────────────────────────

ENUM_CONTROLS_SCRIPT = r'''import ctypes, ctypes.wintypes, json, sys
u32 = ctypes.windll.user32
H = ctypes.wintypes.HWND
class RECT(ctypes.Structure):
    _fields_ = [("left",ctypes.c_long),("top",ctypes.c_long),
                ("right",ctypes.c_long),("bottom",ctypes.c_long)]
VB6 = {"ThunderRT6FormDC","ThunderRT6Form","ThunderRT6MDIForm",
       "ThunderRT5FormDC","ThunderRT5Form","ThunderFormDC","ThunderForm"}
# Find target form
target = None
title_arg = sys.argv[1] if len(sys.argv) > 1 else ""
def find_form(hwnd, _):
    global target
    if not u32.IsWindowVisible(hwnd): return 1
    buf = ctypes.create_unicode_buffer(256)
    u32.GetClassNameW(hwnd, buf, 256)
    if buf.value not in VB6: return 1
    u32.GetWindowTextW(hwnd, buf, 256)
    if title_arg and title_arg not in buf.value: return 1
    target = hwnd
    return 0
CB = ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.c_int, ctypes.c_int)
u32.EnumWindows(CB(find_form), 0)
if not target:
    json.dump({"error": "no form found"}, open(r"C:\work\controls.json","w"))
    sys.exit(0)
# Get form rect
frc = RECT()
u32.GetWindowRect(target, ctypes.byref(frc))
# Enum child controls
children = []
def enum_child(hwnd, _):
    buf = ctypes.create_unicode_buffer(256)
    u32.GetClassNameW(hwnd, buf, 256)
    cls = buf.value
    u32.GetWindowTextW(hwnd, buf, 256)
    txt = buf.value
    rc = RECT()
    u32.GetWindowRect(hwnd, ctypes.byref(rc))
    children.append({"hwnd": hwnd, "class": cls, "text": txt,
                     "x": rc.left, "y": rc.top,
                     "w": rc.right-rc.left, "h": rc.bottom-rc.top,
                     "id": u32.GetDlgCtrlID(hwnd)})
    return 1
u32.EnumChildWindows(target, CB(enum_child), 0)
# Enum menus
menus = []
hMenu = u32.GetMenu(target)
if hMenu:
    topN = u32.GetMenuItemCount(hMenu)
    for i in range(min(topN, 20)):
        buf = ctypes.create_string_buffer(256)
        u32.GetMenuStringA(hMenu, i, buf, 255, 0x400)  # MF_BYPOSITION
        hSub = u32.GetSubMenu(hMenu, i)
        top_name = buf.value.decode(errors="replace").replace("&","")
        if not hSub: continue
        subN = u32.GetMenuItemCount(hSub)
        for j in range(min(subN, 30)):
            u32.GetMenuStringA(hSub, j, buf, 255, 0x400)
            sub_name = buf.value.decode(errors="replace").replace("&","")
            mid = u32.GetMenuItemID(hSub, j)
            if mid > 0:
                menus.append({"top": top_name, "sub": sub_name, "id": mid})
result = {"form_hwnd": target,
          "form_rect": {"x":frc.left,"y":frc.top,"w":frc.right-frc.left,"h":frc.bottom-frc.top},
          "children": children, "menus": menus}
with open(r"C:\work\controls.json","w") as f:
    json.dump(result, f)
'''
ENUM_CONTROLS_GUEST = r'C:\work\enum_controls.py'
_enum_controls_deployed = False

def _deploy_enum_controls():
    global _enum_controls_deployed
    if _enum_controls_deployed:
        return
    from window_diff import _qga_write_file
    _qga_write_file(ENUM_CONTROLS_GUEST, ENUM_CONTROLS_SCRIPT.encode())
    _enum_controls_deployed = True

def enum_runtime_controls(title_hint=''):
    """Enumerate child controls and menus of a VB6 form on the guest. Returns dict."""
    _deploy_enum_controls()
    _c2gui_shell(rf'"{PYTHON_GUEST}" {ENUM_CONTROLS_GUEST} "{title_hint}"')
    from window_diff import _qga_read_file
    try:
        data = _qga_read_file(r'C:\work\controls.json')
        return json.loads(data)
    except Exception as exc:
        log.warning('enum_runtime_controls: failed: %s', exc)
        return None

TYPE_SECRET_SCRIPT = r'''import win32gui, win32con, sys
keep = sys.argv[1]
secret = sys.argv[2]
form_classes = {"ThunderRT6FormDC", "ThunderRT6Form", "ThunderRT5FormDC", "ThunderRT5Form"}

target = None
def find_form(h, _):
    global target
    if not win32gui.IsWindowVisible(h):
        return True
    cls = win32gui.GetClassName(h)
    t = win32gui.GetWindowText(h)
    if cls in form_classes and t != keep:
        target = h
        return False
    if cls == "#32770":
        target = h
        return False
    return True
win32gui.EnumWindows(find_form, None)
if not target:
    print("No child form found")
    sys.exit(1)

textbox = None
button = None
def find_controls(h, _):
    global textbox, button
    cls = win32gui.GetClassName(h)
    if "TextBox" in cls or "Edit" in cls:
        textbox = h
    if "CommandButton" in cls or "Button" in cls:
        button = h
    return True
win32gui.EnumChildWindows(target, find_controls, None)

if textbox:
    win32gui.SendMessage(textbox, win32con.WM_SETTEXT, 0, secret)
    print(f"Set text on {textbox}")
else:
    print("No TextBox found")
if button:
    win32gui.SendMessage(button, win32con.BM_CLICK, 0, 0)
    print(f"Clicked button {button}")
else:
    print("No CommandButton found")
'''
TYPE_SECRET_GUEST = r'C:\work\type_secret.py'
_type_secret_deployed = False


def _deploy_type_secret():
    global _type_secret_deployed
    if _type_secret_deployed:
        return
    from window_diff import _qga_write_file
    _qga_write_file(TYPE_SECRET_GUEST, TYPE_SECRET_SCRIPT.encode())
    _type_secret_deployed = True


def _type_secret_win32(main_title, secret):
    """Type a secret into a child form's TextBox via Win32 WM_SETTEXT + BM_CLICK."""
    _deploy_type_secret()
    result = _c2gui_shell(rf'"{PYTHON_GUEST}" {TYPE_SECRET_GUEST} "{main_title}" "{secret}"')
    log.info('type_secret_win32: %s', result.strip())
    return result


def extract_form_secrets(zip_stem, exe_name):
    """Extract passwords from decompiled source patterns like If Text1.Text = "pw"."""
    secrets = {}
    cleaned = DECOMPILED / zip_stem / exe_name / 'cleaned'
    if cleaned.exists():
        for frm in cleaned.glob('*.frm'):
            src = frm.read_text(errors='replace')
            for m in re.finditer(r'If\b.*Text\d*\.Text\s*=\s*"([^"]+)"', src):
                cap_m = re.search(r'Caption\s*=\s*"([^"]+)"', src)
                if cap_m:
                    secrets[cap_m.group(1)] = m.group(1)
    # Also scan raw .frm files
    for layout in [DECOMPILED / zip_stem / exe_name / 'forms', DECOMPILED / zip_stem / exe_name]:
        if not layout.exists():
            continue
        for frm in layout.glob('*.frm'):
            src = frm.read_text(errors='replace')
            for m in re.finditer(r'If\b.*Text\d*\.Text\s*=\s*"([^"]+)"', src):
                cap_m = re.search(r'Caption\s*=\s*"([^"]+)"', src)
                if cap_m and cap_m.group(1) not in secrets:
                    secrets[cap_m.group(1)] = m.group(1)
    if secrets:
        log.info('extract_form_secrets: found %d secrets', len(secrets))
    return secrets


def auto_crop_child(img_path, main_win_x_in_viewport):
    """Crop a child form screenshot to just the form content using numpy edge detection."""
    try:
        from PIL import Image
        import numpy as np
    except ImportError:
        return None
    try:
        img = Image.open(str(img_path)).convert('RGB')
        arr = np.array(img)
        clip_x = min(main_win_x_in_viewport, arr.shape[1])
        if clip_x <= 0:
            return img.height
        region = arr[:, :clip_x, :]
        mask = region.max(axis=2) > 25
        rows = mask.any(axis=1)
        cols = mask.any(axis=0)
        if not rows.any():
            return img.height
        y0, y1 = int(np.where(rows)[0][0]), int(np.where(rows)[0][-1])
        x0, x1 = int(np.where(cols)[0][0]), int(np.where(cols)[0][-1])
        pad = 2
        cropped = img.crop((max(x0 - pad, 0), max(y0 - pad, 0),
                            min(x1 + pad + 1, img.width), min(y1 + pad + 1, img.height)))
        cropped.save(str(img_path))
        return cropped.height
    except Exception as exc:
        log.warning('auto_crop_child: failed %s: %s', img_path, exc)
        return None


def detect_cutoff(gif_path):
    """Check if GIF frames have content cut off at edges (white edge > 40%)."""
    try:
        from PIL import Image
    except ImportError:
        return []
    results = []
    gif = Image.open(str(gif_path))
    idx = 0
    while True:
        try:
            gif.seek(idx)
        except EOFError:
            break
        frame = gif.convert('RGB')
        w, h = frame.size
        for name, coords, span in [
            ('TOP', [(x, 0) for x in range(w)], w),
            ('BOTTOM', [(x, h - 1) for x in range(w)], w),
            ('LEFT', [(0, y) for y in range(h)], h),
            ('RIGHT', [(w - 1, y) for y in range(h)], h),
        ]:
            white = sum(1 for c in coords if min(frame.getpixel(c)) > 200)
            if white > span * 0.4:
                results.append((idx, name))
        idx += 1
    if results:
        log.warning('detect_cutoff: %d frames have edge cutoff: %s', len(results), results[:5])
    return results


def _extract_greet_names(zip_stem, exe_name):
    """Extract greet names from Timer code in decompiled source."""
    names, seen = [], set()
    for search_dir in [DECOMPILED / zip_stem / exe_name / 'modules',
                       DECOMPILED / zip_stem / exe_name]:
        if not search_dir.exists():
            continue
        for vb_file in search_dir.rglob('*Timer*'):
            if not vb_file.is_file():
                continue
            code = vb_file.read_text(errors='replace')
            for m in re.finditer(r'var_\w+ = "([^"]+)"', code):
                n = m.group(1)
                if n not in seen and len(n) < 30:
                    seen.add(n)
                    names.append(n)
    return names


def _client_rect(win, nc_x, nc_y):
    """Compute client area rect from window rect + non-client offsets."""
    return {'x': win['x'] + nc_x, 'y': win['y'] + nc_y,
            'w': max(win['w'] - 2 * nc_x, 1), 'h': max(win['h'] - nc_y - nc_x, 1)}


def _free(n=100):
    for _ in range(n):
        time.sleep(0.01)


def find_exe_info(zip_stem):
    """Get exe name, path, and AOL version from DB."""
    if not DB_PATH.exists():
        return None, None, 'unknown'
    conn = sqlite3.connect(str(DB_PATH))
    row = conn.execute('''
        SELECT e.exe_name, p.aol_version FROM exes e
        JOIN proggies p ON e.proggie_id=p.id
        WHERE p.zip_stem=? AND e.vb_version IN ('VB5','VB6')
        ORDER BY e.is_primary DESC LIMIT 1
    ''', (zip_stem,)).fetchone()
    conn.close()
    if not row:
        return None, None, 'unknown'
    exe_name = row[0]
    ver = row[1] or 'unknown'
    extract_dir = SORTED / '_extracted' / zip_stem
    exe_path = extract_dir / exe_name
    if not exe_path.exists():
        for f in extract_dir.iterdir() if extract_dir.exists() else []:
            if f.name.lower() == exe_name.lower():
                exe_path = f; break
    return exe_name, exe_path if exe_path.exists() else None, ver


def launch_proggie(zip_stem, exe_name):
    """Push exe + deps to VM and launch. Returns True on success."""
    _t0 = time.monotonic()
    log.info('launch_proggie: ENTER %s/%s', zip_stem, exe_name)
    extract_dir = SORTED / '_extracted' / zip_stem
    local_exe = extract_dir / exe_name
    if not local_exe.exists():
        log.error('launch_proggie: exe not found %s', local_exe)
        return False

    guest_exe = rf'C:\work\{exe_name}'
    _c2gui_shell(r'if not exist C:\work mkdir C:\work')

    sys.path.insert(0, str(REPO / 'tools' / 'vm' / 'host'))
    from push_file import push_file
    try:
        push_file(str(local_exe), guest_exe)
    except Exception as e:
        log.warning('launch_proggie: push failed (%s), exe may already be on VM', e)

    for f in extract_dir.iterdir():
        if f.suffix.lower() in ('.dll', '.ocx', '.vbx') and f.name.lower() != exe_name.lower():
            try:
                push_file(str(f), rf'C:\work\{f.name}')
            except Exception as exc:
                log.warning('launch_proggie: failed to push dep %s: %s', f.name, exc)

    _c2gui_shell(rf'start "" "{guest_exe}"')
    log.info('launch_proggie: EXIT elapsed=%.1fs', time.monotonic() - _t0)
    return True


def wait_for_main_form(wd, timeout=30):
    """Poll for a VB6 form to appear. Also detects non-VB6 dialogs (password gates, splash screens).
    Returns (window_dict, is_vb6_form) or (None, False)."""
    _t0 = time.monotonic()
    log.debug('wait_for_main_form: ENTER timeout=%d', timeout)
    for attempt in range(timeout * 2):
        _free(50)
        windows = wd.snapshot()
        forms = wd.find_vb_forms(windows)
        if forms:
            # F8: prefer largest form by area to avoid splash/tool windows
            forms.sort(key=lambda w: w['w'] * w['h'], reverse=True)
            log.info('wait_for_main_form: VB6 form "%s" at %d,%d %dx%d (attempt %d, %.1fs)',
                     forms[0]['title'], forms[0]['x'], forms[0]['y'],
                     forms[0]['w'], forms[0]['h'], attempt, time.monotonic() - _t0)
            return forms[0], True
        # F4: Check for ANY non-VB6 visible window (not just #32770)
        non_vb = [w for w in windows
                  if w['class'] not in VB6_CLASSES
                  and w['class'] not in ('ConsoleWindowClass', 'Progman', 'Shell_TrayWnd',
                                         'tooltips_class32', 'TaskManagerWindow')
                  and w['w'] > 50 and w['h'] > 50]
        if non_vb and attempt > 6:  # give VB6 form a few seconds to appear first
            log.info('wait_for_main_form: non-VB6 window "%s" class=%s (attempt %d)',
                     non_vb[0].get('title', ''), non_vb[0]['class'], attempt)
            return non_vb[0], False
        if attempt % 10 == 0:
            log.debug('wait_for_main_form: waiting... attempt=%d', attempt)
    log.error('wait_for_main_form: TIMEOUT')
    return None, False


def run_walkthrough(zip_stem, exe_name, out_dir, passwords=None):
    """Main walkthrough loop. Returns walkthrough manifest dict."""
    _t0 = time.monotonic()
    log.info('run_walkthrough: ENTER zip_stem=%s exe_name=%s', zip_stem, exe_name)

    wd = WindowDiff()
    frames = []
    frame_dir = out_dir / 'frames'
    frame_dir.mkdir(parents=True, exist_ok=True)
    frame_idx = [0]
    passwords = passwords or []
    seen_forms = set()
    seen_msgboxes = set()
    used_fnames = set()  # track used screenshot filenames to prevent collisions
    IGNORE_CLASSES = frozenset({'ConsoleWindowClass', 'Progman', 'Shell_TrayWnd', 'tooltips_class32'})
    last_frame_path = [None]  # track last saved frame for dedup

    def unique_fname(caption, ctrl_name):
        """Generate a unique screenshot filename."""
        base = re.sub(r'[^a-z0-9]', '_', (caption or ctrl_name).lower()).strip('_')[:40]
        if not base:
            base = ctrl_name.lower()
        fname = f'screen_{base}.png'
        if fname in used_fnames:
            fname = f'screen_{base}_{ctrl_name.lower()}.png'
        i = 2
        while fname in used_fnames:
            fname = f'screen_{base}_{i}.png'
            i += 1
        used_fnames.add(fname)
        return fname

    viewport = [None]  # mutable container, set after main form found

    def crop_to_proggies(path):
        """Capture cropped to tight bounding box of all visible VB6 forms."""
        cur_windows = wd.snapshot()
        cur_forms = wd.find_vb_forms(cur_windows)
        if not cur_forms:
            return capture_cropped(main_win, str(path))
        x0 = min(w['x'] for w in cur_forms)
        y0 = min(w['y'] for w in cur_forms)
        x1 = max(w['x'] + w['w'] for w in cur_forms)
        y1 = max(w['y'] + w['h'] for w in cur_forms)
        pad = 4
        tight = {'x': max(x0 - pad, 0), 'y': max(y0 - pad, 0),
                 'w': min(x1 - x0 + 2 * pad, SCREEN_W), 'h': min(y1 - y0 + 2 * pad, SCREEN_H)}
        return capture_cropped(tight, str(path))

    def frames_are_identical(path_a, path_b):
        """Check if two images are visually identical (>97% similar)."""
        if not path_a or not path_b:
            return False
        try:
            from PIL import Image
            import numpy as np
        except ImportError as exc:
            log.warning('frames_are_identical: dedup disabled, missing dependency: %s', exc)
            return False
        try:
            a = np.array(Image.open(str(path_a)).convert('RGB'))
            b = np.array(Image.open(str(path_b)).convert('RGB'))
            if a.shape != b.shape:
                return False
            diff = np.abs(a.astype(int) - b.astype(int))
            pct_same = (diff.max(axis=2) < 10).mean()
            return pct_same > 0.97
        except Exception:
            return False

    def next_frame(label, ftype='result'):
        path = frame_dir / f'frame_{frame_idx[0]:03d}.png'
        QMP.park_cursor()
        _free(30)
        ok = crop_to_proggies(path)
        if not ok:
            frame_idx[0] += 1
            return False
        # Dedup: skip if identical to previous frame
        if frames_are_identical(last_frame_path[0], path):
            log.warning('frame %03d: DUPLICATE of previous, skipping: %s', frame_idx[0], label)
            path.unlink(missing_ok=True)
            frame_idx[0] += 1
            return False
        last_frame_path[0] = path
        frames.append({'file': f'frames/frame_{frame_idx[0]:03d}.png', 'label': label, 'type': ftype})
        log.debug('frame %03d: %s (%s)', frame_idx[0], label, ftype)
        frame_idx[0] += 1
        return True

    def wait_for_new_window(baseline_snap, max_retries=8):
        """Poll for a new VB6 form or MsgBox to appear. Returns diff or None."""
        for attempt in range(max_retries):
            _free(50 + attempt * 25)  # increasing wait: 0.5s, 0.75s, 1s...
            after = wd.snapshot()
            diff = wd.diff(baseline_snap, after)
            real_new = [w for w in diff['new'] if w['class'] not in IGNORE_CLASSES]
            if real_new:
                log.debug('wait_for_new_window: found %d new windows on attempt %d', len(real_new), attempt)
                return {'new': real_new, 'changed': diff['changed'], 'gone': diff['gone']}, after
        return None, wd.snapshot()

    # Launch
    if not launch_proggie(zip_stem, exe_name):
        return None

    # Wait for main form (or startup dialog)
    main_win, is_vb6 = wait_for_main_form(wd)
    if not main_win:
        return None

    # F1+F4: Handle non-VB6 startup dialogs (password gates)
    if not is_vb6:
        log.info('run_walkthrough: startup dialog detected, attempting password injection')
        pw_typed = False
        for pw in passwords:
            log.info('run_walkthrough: typing password (len=%d, gate=%s)',
                     len(pw['password']), pw.get('gate_type', 'unknown'))
            # Try Win32 WM_SETTEXT first (more reliable), fall back to QMP keyboard
            _deploy_type_secret()
            # Use empty keep_title since main form isn't visible yet
            result = _c2gui_shell(
                rf'"{PYTHON_GUEST}" {TYPE_SECRET_GUEST} "" "{pw["password"]}"')
            if 'Set text' in result:
                log.info('run_walkthrough: Win32 password injection succeeded')
            else:
                log.info('run_walkthrough: Win32 failed, trying QMP keyboard')
                QMP.send_text(pw['password'])
                time.sleep(0.2)
                QMP.send_key(['ret'])
            pw_typed = True
            break
        if not pw_typed:
            dismiss_msgboxes()
        # Wait for the real VB6 form
        _free(100)
        main_win, is_vb6 = wait_for_main_form(wd, timeout=15)
        if not main_win:
            log.error('run_walkthrough: no VB6 form appeared after startup dialog')
            return None

    # Dismiss startup MsgBoxes
    dismiss_msgboxes()
    _free(50)

    # Re-snapshot after dismissals
    windows = wd.snapshot()
    forms = wd.find_vb_forms(windows)
    if forms:
        forms.sort(key=lambda w: w['w'] * w['h'], reverse=True)
        main_win = forms[0]

    # Move main form to a known position with room for child forms to the right
    FORM_X, FORM_Y = 400, 300

    # Capture main form
    QMP.park_cursor()
    _free(30)
    if not capture_cropped(main_win, str(out_dir / 'screenshot.png')):
        log.error('run_walkthrough: failed to capture main form screenshot')
        return None
    if not capture_cropped(main_win, str(out_dir / 'main_form.png')):
        log.error('run_walkthrough: failed to capture main_form.png')
        return None
    next_frame('Main form', 'main')
    log.info('run_walkthrough: main form captured "%s" %dx%d', main_win['title'], main_win['w'], main_win['h'])

    # Compute fixed viewport — main form + space for child forms to the right
    # Child forms will be placed at main_win right edge + 10px
    child_x = main_win['x'] + main_win['w'] + 10
    child_y = main_win['y']
    max_child_w = max(main_win['w'], 400)  # assume child forms up to 400px wide
    max_child_h = max(main_win['h'], 400)
    vp_x = max(main_win['x'] - 2, 0)
    vp_y = max(main_win['y'] - 2, 0)
    vp_w = min(main_win['w'] + max_child_w + 20, SCREEN_W - vp_x)
    vp_h = min(max(main_win['h'], max_child_h) + 4, SCREEN_H - vp_y)
    viewport[0] = {'x': vp_x, 'y': vp_y, 'w': vp_w, 'h': vp_h}
    log.info('run_walkthrough: fixed viewport (%d,%d) %dx%d', vp_x, vp_y, vp_w, vp_h)

    # ── Resolve decompiled source tree ──────────────────────────────
    # F7: Match exe name precisely, fall back to best-match directory
    decomp_base = DECOMPILED / zip_stem / exe_name
    if not decomp_base.exists():
        exe_stem = Path(exe_name).stem.lower()
        best = None
        if (DECOMPILED / zip_stem).exists():
            for d in (DECOMPILED / zip_stem).iterdir():
                if not d.is_dir() or d.name.startswith('.') or d.name == 'cleaned':
                    continue
                if d.name.lower() == exe_stem:
                    best = d; break  # exact stem match
                if best is None:
                    best = d  # fallback to first valid dir
        if best:
            decomp_base = best
            log.info('run_walkthrough: decomp_base fallback %s (wanted %s)', best.name, exe_name)

    targets = discover_targets(decomp_base) if decomp_base.exists() else []
    safe_targets = [t for t in targets if not t['dangerous']]
    log.info('run_walkthrough: %d targets (%d safe)', len(targets), len(safe_targets))

    # Compute nc_offset from .frm ClientWidth/ClientHeight vs runtime GetWindowRect
    nc_x_off, nc_y_off = 3, 26  # defaults
    if decomp_base.exists():
        startup_frm = None
        for t in safe_targets:
            if t['is_startup_form']:
                startup_frm = t['form']; break
        if startup_frm:
            frm_candidates = list(decomp_base.glob(f'{startup_frm}.frm'))
            if (decomp_base / 'forms').exists():
                frm_candidates += list((decomp_base / 'forms').glob(f'{startup_frm}.frm'))
            for frm in frm_candidates:
                text = frm.read_text(errors='replace')
                cw_m = re.search(r'ClientWidth\s*=\s*(\d+)', text)
                ch_m = re.search(r'ClientHeight\s*=\s*(\d+)', text)
                if cw_m and ch_m:
                    client_w = int(cw_m.group(1)) // TWIPS_PER_PX
                    client_h = int(ch_m.group(1)) // TWIPS_PER_PX
                    nc_x_off = max((main_win['w'] - client_w) // 2, 0)
                    nc_y_off = max(main_win['h'] - client_h - nc_x_off, 0)
                    log.info('nc_offset: computed nc_x=%d nc_y=%d (client %dx%d, window %dx%d)',
                             nc_x_off, nc_y_off, client_w, client_h, main_win['w'], main_win['h'])
                break
    log.debug('nc_offset: using nc_x=%d nc_y=%d', nc_x_off, nc_y_off)

    # ── Identify the real main form ─────────────────────────────────────
    # Don't trust VBP Startup blindly — match runtime window to form metadata.
    # VB6 apps auto-navigate through splash/nag screens; we just need to wait
    # for the app to settle, dismiss junk, and find the form with real content.
    categories = {}
    main_form_name = None

    # Build a caption→form_name map from .frm files
    form_captions = {}  # caption → form_name
    form_target_counts = {}  # form_name → count of safe targets
    for t in safe_targets:
        form_target_counts[t['form']] = form_target_counts.get(t['form'], 0) + 1
    for frm_file in (list(decomp_base.glob('*.frm')) +
                     (list((decomp_base / 'forms').glob('*.frm')) if (decomp_base / 'forms').exists() else [])):
        first_lines = frm_file.read_text(errors='replace')[:500]
        m = re.search(r'Caption\s*=\s*"([^"]*)"', first_lines)
        if m:
            form_captions[m.group(1)] = frm_file.stem

    # Try to match runtime window title to a form name
    if main_win['title'] in form_captions:
        main_form_name = form_captions[main_win['title']]
        log.info('run_walkthrough: matched window title "%s" → %s', main_win['title'], main_form_name)

    # If the matched form is a splash (few targets, all show_form), dismiss and re-detect
    if main_form_name:
        mf_targets = [t for t in safe_targets if t['form'] == main_form_name]
        is_splash = (len(mf_targets) <= 5 and
                     all(t['action'] == 'show_form' or t['type'] in ('Form', 'unknown')
                         for t in mf_targets))
    else:
        is_splash = True  # unknown form, treat as splash

    if is_splash:
        log.info('run_walkthrough: current form looks like splash/nag, clicking to dismiss')
        # Click rapidly via QMP (fast) BEFORE entering the slow QGA poll loop
        for _ in range(5):
            QMP.click(main_win['x'] + main_win['w'] // 2, main_win['y'] + main_win['h'] // 2)
            time.sleep(0.3)
        # Dismiss any msgboxes that appeared from the clicks
        dismiss_msgboxes()
        _free(100)
        # Now poll (slow QGA) for a target-rich form to appear
        for _attempt in range(20):
            _free(50)
            windows = wd.snapshot()
            forms = wd.find_vb_forms(windows)
            if not forms:
                continue
            forms.sort(key=lambda w: w['w'] * w['h'], reverse=True)
            for f in forms:
                matched = form_captions.get(f['title'])
                if matched and form_target_counts.get(matched, 0) >= 5:
                    main_win = f
                    main_form_name = matched
                    log.info('run_walkthrough: found target-rich form "%s" → %s (%d targets)',
                             f['title'], matched, form_target_counts[matched])
                    break
            else:
                # Not found yet — click again and dismiss
                QMP.click(main_win['x'] + main_win['w'] // 2, main_win['y'] + main_win['h'] // 2)
                dismiss_msgboxes()
                continue
            break
        else:
            log.warning('run_walkthrough: no target-rich form appeared after splash dismiss')

        # Recapture main form
        QMP.park_cursor()
        _free(30)
        capture_cropped(main_win, str(out_dir / 'screenshot.png'))
        capture_cropped(main_win, str(out_dir / 'main_form.png'))
        next_frame('Main form', 'main')
        # Recompute viewport + nc_offset
        child_x = main_win['x'] + main_win['w'] + 10
        child_y = main_win['y']
        vp_x = max(main_win['x'] - 2, 0)
        vp_y = max(main_win['y'] - 2, 0)
        vp_w = min(main_win['w'] + max_child_w + 20, SCREEN_W - vp_x)
        vp_h = min(max(main_win['h'], max_child_h) + 4, SCREEN_H - vp_y)
        viewport[0] = {'x': vp_x, 'y': vp_y, 'w': vp_w, 'h': vp_h}
        log.info('run_walkthrough: settled on "%s" form=%s', main_win['title'], main_form_name)

    # Final fallback: pick the form with the most targets
    if not main_form_name:
        if form_target_counts:
            main_form_name = max(form_target_counts, key=form_target_counts.get)
            log.info('run_walkthrough: fallback to form with most targets: %s (%d)',
                     main_form_name, form_target_counts[main_form_name])

    # Move the REAL main form to a known position with room for child forms
    move_cmd = (f'import ctypes; u=ctypes.windll.user32; '
                f'u.MoveWindow({form_hwnd}, '
                f'{FORM_X}, {FORM_Y}, {main_win["w"]}, {main_win["h"]}, 1)')
    _c2gui_shell(rf'"{PYTHON_GUEST}" -c "{move_cmd}"')
    _free(50)
    main_win['x'] = FORM_X
    main_win['y'] = FORM_Y
    # Recapture after move — crop to client area only
    QMP.park_cursor(); _free(30)
    cr = _client_rect(main_win, nc_x_off, nc_y_off)
    capture_cropped(cr, str(out_dir / 'screenshot.png'))
    capture_cropped(cr, str(out_dir / 'main_form.png'))
    # Recompute viewport after move
    child_x = main_win['x'] + main_win['w'] + 10
    child_y = main_win['y']
    vp_x = max(main_win['x'] - 2, 0)
    vp_y = max(main_win['y'] - 2, 0)
    vp_w = min(main_win['w'] + max_child_w + 20, SCREEN_W - vp_x)
    vp_h = min(max(main_win['h'], max_child_h) + 4, SCREEN_H - vp_y)
    viewport[0] = {'x': vp_x, 'y': vp_y, 'w': vp_w, 'h': vp_h}

    # Recompute nc_offset for the actual main form
    if main_form_name:
        for frm_candidate in [decomp_base / f'{main_form_name}.frm',
                               decomp_base / 'forms' / f'{main_form_name}.frm']:
            if not frm_candidate.exists():
                continue
            text = frm_candidate.read_text(errors='replace')
            cw_m = re.search(r'ClientWidth\s*=\s*(\d+)', text)
            ch_m = re.search(r'ClientHeight\s*=\s*(\d+)', text)
            if cw_m and ch_m:
                client_w = int(cw_m.group(1)) // TWIPS_PER_PX
                client_h = int(ch_m.group(1)) // TWIPS_PER_PX
                nc_x_off = max((main_win['w'] - client_w) // 2, 0)
                nc_y_off = max(main_win['h'] - client_h - nc_x_off, 0)
                log.info('nc_offset: final nc_x=%d nc_y=%d for %s', nc_x_off, nc_y_off, main_form_name)
            break

    log.info('run_walkthrough: targeting form=%s window="%s" nc=(%d,%d)',
             main_form_name, main_win['title'], nc_x_off, nc_y_off)

    # ── Get runtime control positions + menus from Win32 API ─────────
    rt = enum_runtime_controls(main_win['title'])
    if rt and not rt.get('error'):
        rt_children = {c['text']: c for c in rt.get('children', []) if c['text']}
        rt_children_by_class = {}
        for c in rt.get('children', []):
            rt_children_by_class.setdefault(c['class'], []).append(c)
        rt_menus = rt.get('menus', [])
        form_hwnd = rt.get('form_hwnd', 0)
        log.info('run_walkthrough: runtime enum: %d children, %d menus, hwnd=%d',
                 len(rt.get('children', [])), len(rt_menus), form_hwnd)
    else:
        rt_children = {}
        rt_menus = []
        form_hwnd = 0
        log.warning('run_walkthrough: runtime enum failed, falling back to .frm coords')

    # ── Phase 1: Trigger menu items via WM_COMMAND ───────────────────
    WM_COMMAND = 0x0111
    for mi in rt_menus:
        caption = mi['sub']
        menu_id = mi['id']
        top_menu = mi['top']

        # Match to decompiled targets to check if safe
        matched_target = None
        for t in safe_targets:
            if t['form'] == main_form_name and t['type'] == 'Menu':
                if t['caption'] == caption or t['name'].lower() in caption.lower():
                    matched_target = t
                    break
        if not matched_target:
            # Try fuzzy match
            for t in safe_targets:
                if t['form'] == main_form_name and caption.lower() in (t['caption'] or '').lower():
                    matched_target = t
                    break

        if matched_target and matched_target.get('dangerous'):
            log.debug('run_walkthrough: skip dangerous menu %s/%s', top_menu, caption)
            continue
        if not matched_target:
            log.debug('run_walkthrough: skip unmatched menu %s/%s id=%d', top_menu, caption, menu_id)
            continue
        if matched_target['action'] in ('shell', 'file_dialog', 'hide_self'):
            continue
        if 'exit' in caption.lower() or 'quit' in caption.lower():
            continue

        log.info('run_walkthrough: menu WM_COMMAND %s/%s id=%d action=%s',
                 top_menu, caption, menu_id, matched_target['action'])

        baseline = wd.snapshot()
        # Send WM_COMMAND to trigger the menu item — no clicking needed
        _c2gui_shell(rf'"{PYTHON_GUEST}" -c "import ctypes; ctypes.windll.user32.PostMessageW({form_hwnd}, {WM_COMMAND}, {menu_id}, 0)"')
        _free(100)

        item = {'caption': caption, 'type': matched_target['action'],
                'image': '', 'hint': matched_target.get('hint_text', '')}

        diff_result, after = wait_for_new_window(baseline)
        if diff_result and diff_result['new']:
            real_new = diff_result['new']
            new_forms = [w for w in real_new if w['class'] in VB6_CLASSES]
            new_msgboxes = [w for w in real_new if w['class'] == '#32770']
            new_win = None

            if new_msgboxes:
                new_win = new_msgboxes[0]
                item['type'] = 'msgbox'
            elif new_forms:
                new_win = new_forms[0]

            if new_win:
                # Move child to top-left so it doesn't overlap main form
                if new_win['class'] in VB6_CLASSES:
                    move_child_form(main_win['title'], child_x, child_y)
                    _free(50)
                    # Re-detect child position after move
                    after2 = wd.snapshot()
                    all_vb = wd.find_vb_forms(after2)
                    moved = [w for w in all_vb if (w['x'], w['y']) != (main_win['x'], main_win['y'])]
                    if not moved:
                        moved = [w for w in all_vb if w['title'] != main_win['title'] or w['w'] != main_win['w']]
                    if moved:
                        new_win = moved[0]

                # Capture child window — client area only
                fname = unique_fname(caption, matched_target['name'])
                QMP.park_cursor(); _free(30)
                child_cr = _client_rect(new_win, nc_x_off, nc_y_off)
                capture_cropped(child_cr, str(out_dir / fname))
                label = f'MsgBox: {caption}' if item['type'] == 'msgbox' else f'Form: {caption}'
                next_frame(label, 'result')
                item['image'] = fname
                item['child_title'] = new_win.get('title', '')
                item['child_h'] = child_cr['h']

                # Cleanup
                if item['type'] == 'msgbox':
                    dismiss_msgboxes()
                else:
                    close_child_forms(main_win['title'])
                    _free(50)
                    dismiss_msgboxes()
        else:
            fname = unique_fname(caption, matched_target['name'])
            QMP.park_cursor(); _free(30)
            ok = capture_cropped(main_win, str(out_dir / fname))
            if ok and not frames_are_identical(out_dir / 'main_form.png', out_dir / fname):
                next_frame(f'{caption}', 'result')
                item['image'] = fname
            else:
                (out_dir / fname).unlink(missing_ok=True)

        cat_name = top_menu or main_form_name or 'Main'
        if cat_name not in categories:
            categories[cat_name] = []
        if item.get('image'):
            categories[cat_name].append(item)

    # ── Phase 2: Click buttons/controls using runtime positions ──────
    for target in safe_targets:
        if target['form'] != main_form_name:
            continue
        if target['type'] == 'Menu':
            continue  # already handled via WM_COMMAND
        if target['action'] in ('shell', 'file_dialog'):
            continue
        if target['type'] in ('Form', 'unknown') and target['name'] == 'Form':
            continue

        ctrl_name = target['name']
        caption = target['caption'] or ctrl_name

        # Find runtime position by matching caption or class
        rt_ctrl = rt_children.get(caption)
        if not rt_ctrl:
            # Try matching by control type class name
            vb_class_map = {'CommandButton': 'ThunderRT6CommandButton',
                            'TextBox': 'ThunderRT6TextBox',
                            'ListBox': 'ThunderRT6ListBox',
                            'ComboBox': 'ThunderRT6ComboBox',
                            'CheckBox': 'ThunderRT6CheckBox',
                            'OptionButton': 'ThunderRT6OptionButton'}
            rt_class = vb_class_map.get(target['type'], '')
            candidates = rt_children_by_class.get(rt_class, [])
            if len(candidates) == 1:
                rt_ctrl = candidates[0]

        if not rt_ctrl:
            log.debug('run_walkthrough: no runtime match for %s (%s)', ctrl_name, caption)
            continue

        sx = rt_ctrl['x'] + rt_ctrl['w'] // 2
        sy = rt_ctrl['y'] + rt_ctrl['h'] // 2
        log.info('run_walkthrough: clicking %s (%s) at runtime pos (%d,%d) %dx%d',
                 ctrl_name, caption, rt_ctrl['x'], rt_ctrl['y'], rt_ctrl['w'], rt_ctrl['h'])

        if sx < main_win['x'] or sx > main_win['x'] + main_win['w'] or \
           sy < main_win['y'] or sy > main_win['y'] + main_win['h']:
            log.debug('run_walkthrough: skip out-of-bounds %s screen=(%d,%d)', ctrl_name, sx, sy)
            continue

        # Hover phase — only capture if control has hint text
        bezier_move(QMP.move, QMP._last_x, QMP._last_y, sx, sy)
        _free(30)
        if target['hint_text']:
            next_frame(f'Hover: {caption} — {target["hint_text"]}', 'hover')

        # Take baseline IMMEDIATELY before click (minimizes stale state)
        baseline = wd.snapshot()

        # Click phase
        QMP.click(sx, sy)
        _free(100)

        # Diff phase — poll with retries for show_form targets
        max_retries = 8 if target['action'] == 'show_form' else 3
        diff_result, after = wait_for_new_window(baseline, max_retries)

        # Capture phase
        item = {'caption': caption, 'type': target['action'], 'image': '', 'hint': target.get('hint_text', '')}

        if diff_result and diff_result['new']:
            real_new = diff_result['new']

            new_forms = [w for w in real_new if w['class'] in VB6_CLASSES]
            new_msgboxes = [w for w in real_new if w['class'] == '#32770']
            other_new = [w for w in real_new if w['class'] not in VB6_CLASSES and w['class'] != '#32770']

            if new_msgboxes:
                mb = new_msgboxes[0]
                mb_key = mb.get('title', '')
                if mb_key not in seen_msgboxes:
                    seen_msgboxes.add(mb_key)
                    fname = unique_fname(caption, ctrl_name)
                    QMP.park_cursor()
                    _free(30)
                    capture_cropped(mb, str(out_dir / fname))
                    next_frame(f'MsgBox: {mb.get("title", caption)}', 'result')
                    item['image'] = fname
                    item['type'] = 'msgbox'
                dismiss_msgboxes()

            elif new_forms:
                nf = new_forms[0]
                nf_key = (nf['class'], nf['title'])
                if nf_key not in seen_forms:
                    seen_forms.add(nf_key)
                    move_child_form(main_win['title'], child_x, child_y)
                    _free(50)
                    after2 = wd.snapshot()
                    # F10: Find child form by excluding main form's position, not just title
                    # (handles same-title children and avoids picking stale windows)
                    all_vb = wd.find_vb_forms(after2)
                    moved = [w for w in all_vb
                             if (w['x'], w['y']) != (main_win['x'], main_win['y'])]
                    if not moved:
                        # fallback: any VB form that isn't the exact main window
                        moved = [w for w in all_vb
                                 if w['title'] != main_win['title'] or w['w'] != main_win['w']]
                    child_rect = moved[0] if moved else nf

                    fname = unique_fname(caption, ctrl_name)
                    QMP.park_cursor()
                    _free(30)
                    capture_cropped(_client_rect(child_rect, nc_x_off, nc_y_off), str(out_dir / fname))
                    next_frame(f'Form: {nf.get("title", caption)}', 'result')
                    item['image'] = fname
                    item['child_h'] = _client_rect(child_rect, nc_x_off, nc_y_off)['h']
                    item['child_title'] = nf.get('title', '')

                    # F5: Explore child form controls (buttons/tabs on the child)
                    child_form_name = nf.get('title', '')
                    child_targets = [t for t in safe_targets
                                     if t['form'] != main_form_name
                                     and t['action'] not in ('shell', 'file_dialog')
                                     and t['type'] not in ('Form', 'unknown')
                                     and t['left_px'] >= 0 and t['top_px'] >= 0]
                    for ct in child_targets[:6]:  # cap at 6 to avoid runaway
                        cx = child_rect['x'] + nc_x_off + ct['left_px'] + ct['width_px'] // 2
                        cy = child_rect['y'] + nc_y_off + ct['top_px'] + ct['height_px'] // 2
                        if cx < child_rect['x'] or cx > child_rect['x'] + child_rect['w']:
                            continue
                        if cy < child_rect['y'] or cy > child_rect['y'] + child_rect['h']:
                            continue
                        ct_caption = ct['caption'] or ct['name']
                        log.info('run_walkthrough: child click %s (%s)', ct['name'], ct_caption)
                        bezier_move(QMP.move, QMP._last_x, QMP._last_y, cx, cy)
                        _free(30)
                        QMP.click(cx, cy)
                        _free(80)
                        dismiss_msgboxes()
                        ct_fname = unique_fname(ct_caption, ct['name'])
                        QMP.park_cursor()
                        _free(30)
                        capture_cropped(child_rect, str(out_dir / ct_fname))
                        next_frame(f'Child: {ct_caption}', 'result')

                close_child_forms(main_win['title'])
                _free(50)
                dismiss_msgboxes()

            else:
                # New window but not VB6 form or MsgBox — capture it anyway
                nw = other_new[0]
                log.info('run_walkthrough: new non-VB window class=%s title="%s"', nw['class'], nw.get('title', ''))
                fname = unique_fname(caption, ctrl_name)
                QMP.park_cursor()
                _free(30)
                capture_cropped(nw, str(out_dir / fname))
                next_frame(f'Window: {nw.get("title", caption)}', 'result')
                item['image'] = fname
                dismiss_msgboxes()

        else:
            # No new window detected
            if target['action'] == 'show_form':
                log.warning('run_walkthrough: EXPECTED new form from %s but none appeared', ctrl_name)
            # Only capture if something visually changed (dedup will catch identical frames)
            fname = unique_fname(caption, ctrl_name)
            QMP.park_cursor()
            _free(30)
            ok = capture_cropped(main_win, str(out_dir / fname))
            if ok:
                # Check if this screenshot is different from main_form.png
                if not frames_are_identical(out_dir / 'main_form.png', out_dir / fname):
                    next_frame(f'{caption}', 'result')
                    item['image'] = fname
                else:
                    log.debug('run_walkthrough: %s produced no visual change, skipping', ctrl_name)
                    (out_dir / fname).unlink(missing_ok=True)

        # Add to categories
        cat_name = main_form_name or 'Main'
        if cat_name not in categories:
            categories[cat_name] = []
        if item.get('image'):
            categories[cat_name].append(item)

    # ── Phase 2: Label-based popup menu navigation ─────────────────────
    # Many proggies use clickable labels that open #32768 popup menus
    label_targets = [t for t in safe_targets
                     if t['form'] == main_form_name
                     and t['type'] in ('Label', 'Image', 'PictureBox')
                     and t['left_px'] >= 0 and t['top_px'] >= 0]
    popup_labels = []  # (target, popup_rect)
    if label_targets:
        log.info('run_walkthrough: Phase 2 — probing %d labels for popup menus', len(label_targets))
        for lt in label_targets:
            sx = main_win['x'] + nc_x_off + lt['left_px'] + lt['width_px'] // 2
            sy = main_win['y'] + nc_y_off + lt['top_px'] + lt['height_px'] // 2
            if sx < main_win['x'] or sx > main_win['x'] + main_win['w']:
                continue
            if sy < main_win['y'] or sy > main_win['y'] + main_win['h']:
                continue
            baseline = wd.snapshot()
            QMP.click(sx, sy)
            _free(80)
            after = wd.snapshot()
            diff = wd.diff(baseline, after)
            popups = [w for w in diff['new'] if w['class'] == '#32768' and w['w'] > 20]
            if popups:
                log.info('run_walkthrough: label %s → popup %dx%d', lt['name'], popups[0]['w'], popups[0]['h'])
                popup_labels.append((lt, popups[0]))
                next_frame(f'Menu: {lt["caption"] or lt["name"]}', 'menu')
                # Close popup
                QMP.send_key(['escape'])
                _free(50)
            else:
                # Close any accidental form/msgbox
                dismiss_msgboxes()

    # Click through popup menu items
    form_secrets = extract_form_secrets(zip_stem, exe_name)
    greet_names = _extract_greet_names(zip_stem, exe_name)
    # Compute main form position within viewport for auto-crop
    main_in_vp_x = main_win['x'] - vp_x

    if popup_labels:
        log.info('run_walkthrough: Phase 2b — clicking %d popup menus', len(popup_labels))
        # Parse menu tree from .frm for item count matching
        from capture_walkthrough import parse_menu_tree_from_frm
        menu_frm = None
        for frm_candidate in [decomp_base / f'{main_form_name}.frm',
                               decomp_base / 'forms' / f'{main_form_name}.frm'] if main_form_name else []:
            if frm_candidate.exists():
                menu_frm = frm_candidate; break
        menu_roots = parse_menu_tree_from_frm(menu_frm) if menu_frm else []
        matched_roots = set()

        # Sort labels left-to-right to match menu category order
        popup_labels.sort(key=lambda pl: pl[0]['left_px'])

        for lt, prect in popup_labels:
            # Re-open popup (may have been closed)
            sx = main_win['x'] + nc_x_off + lt['left_px'] + lt['width_px'] // 2
            sy = main_win['y'] + nc_y_off + lt['top_px'] + lt['height_px'] // 2
            QMP.click(sx, sy)
            _free(100)
            # Re-detect popup position
            after = wd.snapshot()
            cur_popups = [w for w in after if w['class'] == '#32768' and w['w'] > 20]
            p = cur_popups[0] if cur_popups else prect

            # Match to menu tree root by item count
            visible_count = p['h'] // 20
            matched_items = None
            root_caption = lt['caption'] or lt['name']
            for ri, root in enumerate(menu_roots):
                if ri in matched_roots:
                    continue
                if abs(len(root.children) - visible_count) <= 3:
                    matched_items = root.children
                    matched_roots.add(ri)
                    root_caption = root.caption
                    break

            if not matched_items:
                # No tree match — estimate items from popup height
                n_items = max(visible_count, 1)
                item_h = p['h'] // n_items
                log.info('run_walkthrough: popup %s — no tree match, ~%d items', lt['name'], n_items)
                QMP.send_key(['escape'])
                _free(50)
                continue

            item_h = p['h'] // len(matched_items)
            cat_name_popup = root_caption
            if cat_name_popup not in categories:
                categories[cat_name_popup] = []

            for idx, menu_item in enumerate(matched_items):
                if menu_item.is_separator:
                    continue
                cap = menu_item.caption
                if 'exit' in menu_item.name.lower() or 'quit' in cap.lower():
                    continue

                # Re-open popup for each item
                QMP.click(sx, sy)
                _free(100)
                after = wd.snapshot()
                cur_popups = [w for w in after if w['class'] == '#32768' and w['w'] > 20]
                p = cur_popups[0] if cur_popups else prect

                iy = p['y'] + idx * item_h + item_h // 2
                if iy > p['y'] + p['h']:
                    QMP.send_key(['escape']); _free(50); continue

                # Hover + capture
                bezier_move(QMP.move, QMP._last_x, QMP._last_y, p['x'] + p['w'] // 2, iy)
                _free(30)
                next_frame(f'Hover: {cap}', 'hover')

                # Click menu item
                QMP.click(p['x'] + p['w'] // 2, iy)
                _free(100)
                dismiss_msgboxes()
                _free(50)

                # Move child form next to main
                move_child_form(main_win['title'], child_x, child_y)
                _free(50)

                # Capture result
                QMP.park_cursor()
                _free(30)
                fname = unique_fname(cap, menu_item.name)
                item = {'caption': cap, 'type': 'menu_item', 'image': '', 'hint': ''}

                # Check for new child form
                after2 = wd.snapshot()
                all_vb = wd.find_vb_forms(after2)
                child_forms = [w for w in all_vb
                               if (w['x'], w['y']) != (main_win['x'], main_win['y'])]
                if not child_forms:
                    child_forms = [w for w in all_vb
                                   if w['title'] != main_win['title'] or w['w'] != main_win['w']]

                if child_forms:
                    cf = child_forms[0]
                    cf_cr = _client_rect(cf, nc_x_off, nc_y_off)
                    capture_cropped(cf_cr, str(out_dir / fname))
                    next_frame(f'Form: {cap}', 'result')
                    item['image'] = fname
                    item['child_title'] = cf.get('title', '')
                    item['child_h'] = cf_cr['h']

                    # Greets: capture animation frames
                    if cap.lower() == 'greets':
                        QMP.park_cursor()
                        greet_frames_list = []
                        for gi in range(60):
                            time.sleep(0.2)
                            gf_path = frame_dir / f'greets_{gi:02d}.png'
                            capture_cropped(cf, str(gf_path))
                            greet_frames_list.append(gf_path)
                        # Build greets GIF
                        try:
                            from PIL import Image
                            imgs = [Image.open(str(gf)) for gf in greet_frames_list if gf.exists()]
                            if len(imgs) > 1:
                                delays = [960] * len(imgs)
                                delays[-1] = 3000
                                imgs[0].save(str(out_dir / 'screen_greets.gif'), save_all=True,
                                             append_images=imgs[1:], duration=delays, loop=0)
                                item['image'] = 'screen_greets.gif'
                                log.info('run_walkthrough: greets GIF %d frames', len(imgs))
                        except Exception as exc:
                            log.warning('run_walkthrough: greets GIF failed: %s', exc)

                    # Form secrets: type password if known
                    secret = form_secrets.get(cap)
                    if not secret:
                        for fk, fv in form_secrets.items():
                            if cap.lower() in fk.lower() or fk.lower() in cap.lower():
                                secret = fv; break
                    if secret:
                        log.info('run_walkthrough: typing secret for %s (len=%d)', cap, len(secret))
                        _type_secret_win32(main_win['title'], secret)
                        _free(100)
                        QMP.park_cursor()
                        _free(30)
                        secret_fname = unique_fname(f'secret_{cap}', f'secret_{menu_item.name}')
                        capture_cropped(cf, str(out_dir / secret_fname))
                        next_frame(f'Secret: {cap}', 'result')
                        categories.setdefault(cat_name_popup, []).append(
                            {'caption': f'{cap} (unlocked)', 'type': 'secret',
                             'image': secret_fname, 'hint': ''})
                else:
                    # No child form — capture main form state change
                    ok = capture_cropped(main_win, str(out_dir / fname))
                    if ok and not frames_are_identical(out_dir / 'main_form.png', out_dir / fname):
                        next_frame(f'{cap}', 'result')
                        item['image'] = fname
                    else:
                        (out_dir / fname).unlink(missing_ok=True)

                if item.get('image'):
                    categories.setdefault(cat_name_popup, []).append(item)

                # Cleanup
                close_child_forms(main_win['title'])
                _free(50)
                dismiss_msgboxes()

    # ── Post-walkthrough validation ──────────────────────────────────
    expected_forms = sum(1 for t in safe_targets if t['form'] == main_form_name and t['action'] == 'show_form' and not t['dangerous'])
    captured_forms = sum(1 for f in frames if f['type'] == 'result' and 'Form:' in f['label'])
    total_items = sum(len(items) for items in categories.values())

    if expected_forms > 0 and captured_forms == 0:
        log.error('VALIDATION: expected %d child forms but captured 0 — walkthrough may have failed', expected_forms)
    if len(frames) <= 1:
        log.error('VALIDATION: only %d frame(s) captured — walkthrough produced no useful content', len(frames))
    if total_items == 0 and len(safe_targets) > 0:
        log.warning('VALIDATION: 0 items captured from %d safe targets', len(safe_targets))

    log.info('VALIDATION: frames=%d unique_items=%d expected_forms=%d captured_forms=%d',
             len(frames), total_items, expected_forms, captured_forms)

    # Build animated GIF from frames — only if we have >1 distinct frame
    gif_path = out_dir / 'animated.gif'
    if len(frames) > 1:
        try:
            from PIL import Image
            imgs = []
            durations = []
            for f in frames:
                fp = out_dir / f['file']
                if fp.exists():
                    imgs.append(Image.open(str(fp)))
                    # Hover frames get short duration, results get longer
                    durations.append(80 if f['type'] == 'hover' else 250 if f['type'] == 'result' else 200)
            if len(imgs) > 1:
                durations[-1] = 2000  # pause on last frame before loop
                imgs[0].save(str(gif_path), save_all=True, append_images=imgs[1:],
                             duration=durations, loop=0, optimize=True)
                log.info('run_walkthrough: GIF %s (%d frames)', gif_path, len(imgs))
                # Cutoff detection
                cutoffs = detect_cutoff(gif_path)
                if cutoffs:
                    log.warning('run_walkthrough: GIF has %d frames with edge cutoff', len(cutoffs))
            else:
                log.warning('run_walkthrough: only 1 frame, skipping GIF')
        except Exception as exc:
            log.warning('run_walkthrough: GIF failed exc=%s', exc)
    elif len(frames) == 1:
        log.warning('run_walkthrough: only 1 frame, no GIF created')

    # Kill proggie
    _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')

    # Build manifest
    cat_list = []
    for cat_name, items in categories.items():
        cat_list.append({'category': cat_name, 'items': items})

    # Build label positions from targets
    labels = {}
    for t in safe_targets:
        if t['form'] == main_form_name and t['type'] in ('Label', 'Image', 'PictureBox') and t['left_px'] >= 0 and t['top_px'] >= 0:
            labels[t['name']] = {
                'left': t['left_px'], 'top': t['top_px'],
                'width': t['width_px'], 'height': t['height_px'],
            }

    # Synthesize labels for menu-bar apps (no clickable Label controls on form)
    if not labels and rt_menus:
        seen_tops = []
        for mi in rt_menus:
            if mi['top'] not in seen_tops:
                seen_tops.append(mi['top'])
        cum_x = 0
        for top_name in seen_tops:
            w = len(top_name) * 8 + 16
            labels[top_name] = {
                'left': cum_x, 'top': 0,
                'width': w, 'height': 20,
            }
            cum_x += w
        if labels:
            log.info('run_walkthrough: synthesized %d menu-bar labels: %s',
                     len(labels), list(labels.keys()))

    # Collect files from extracted zip
    extract_dir = SORTED / '_extracted' / zip_stem
    files = sorted(f.name for f in extract_dir.iterdir()) if extract_dir.exists() else []

    client_w = main_win['w'] - 2 * nc_x_off
    client_h = main_win['h'] - nc_y_off - nc_x_off
    manifest = {
        'form': {
            'width': client_w, 'height': client_h,
            'image': 'main_form.png',
            'nc_x': 0, 'nc_y': 0,
            'screen_x': main_win['x'], 'screen_y': main_win['y'],
            'crop_x0': vp_x, 'crop_y0': vp_y,
        },
        'labels': labels,
        'categories': cat_list,
        'greets': greet_names,
        'passwords': passwords,
        'frames': frames,
        'files': files,
    }

    manifest_path = out_dir / 'walkthrough.json'
    manifest_path.write_text(json.dumps(manifest, indent=2))
    log.info('run_walkthrough: EXIT %d categories, %d items, %d frames, elapsed=%.1fs',
             len(cat_list), sum(len(c['items']) for c in cat_list), len(frames),
             time.monotonic() - _t0)
    return manifest


def screenshot_only(zip_stem, exe_name, out_dir):
    """Just launch, screenshot main form, kill."""
    _t0 = time.monotonic()
    log.info('screenshot_only: ENTER %s/%s', zip_stem, exe_name)
    wd = WindowDiff()

    if not launch_proggie(zip_stem, exe_name):
        return None

    main_win, is_vb6 = wait_for_main_form(wd)
    if not main_win:
        _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')
        return None
    if not is_vb6:
        dismiss_msgboxes()
        _free(100)
        main_win, is_vb6 = wait_for_main_form(wd, timeout=15)
        if not main_win:
            _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')
            return None

    dismiss_msgboxes()
    _free(50)

    # Re-snapshot
    windows = wd.snapshot()
    forms = wd.find_vb_forms(windows)
    if forms:
        main_win = forms[0]

    QMP.park_cursor()
    _free(30)
    out_dir.mkdir(parents=True, exist_ok=True)
    capture_cropped(main_win, str(out_dir / 'screenshot.png'))
    log.info('screenshot_only: saved %s (%dx%d)', out_dir / 'screenshot.png', main_win['w'], main_win['h'])

    _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')
    log.info('screenshot_only: EXIT elapsed=%.1fs', time.monotonic() - _t0)
    return main_win


def main():
    parser = argparse.ArgumentParser(description='Smart walkthrough for VB proggies')
    parser.add_argument('zip_stem', help='Proggie zip stem')
    parser.add_argument('--screenshot-only', action='store_true')
    parser.add_argument('-q', '--quiet', action='store_true')
    args = parser.parse_args()

    if args.quiet:
        logging.getLogger().setLevel(logging.WARNING)

    log.info('smart_walkthrough: pid=%d zip_stem=%s', os.getpid(), args.zip_stem)

    exe_name, exe_path, ver = find_exe_info(args.zip_stem)
    if not exe_name:
        log.error('No VB5/VB6 exe found for %s', args.zip_stem)
        sys.exit(1)

    out_dir = SORTED / ver / args.zip_stem
    out_dir.mkdir(parents=True, exist_ok=True)

    if args.screenshot_only:
        result = screenshot_only(args.zip_stem, exe_name, out_dir)
        sys.exit(0 if result else 1)

    # Extract passwords first
    passwords = extract_passwords(args.zip_stem)
    log.info('Passwords found: %d', len(passwords))

    result = run_walkthrough(args.zip_stem, exe_name, out_dir, passwords)
    if not result:
        log.error('Walkthrough failed')
        sys.exit(1)

    log.info('Done: %s', out_dir)


if __name__ == '__main__':
    main()
