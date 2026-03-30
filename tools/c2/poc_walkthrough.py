#!/usr/bin/env python3
"""POC: Screenshot walkthrough using nav graph + ENUMCHILDREN + ENUMMENUS.

Demonstrates the full Tier 1+2 pipeline on a single app:
1. Parse nav graph to know what to click and what to avoid
2. Launch app under Wine on :98
3. ENUMCHILDREN to find windowed controls
4. ENUMMENUS to find menu item IDs
5. Match nav graph targets to discovered controls/menus
6. Click/invoke each safe target, screenshot the result
7. Assemble animated GIF

Usage:
    python3 poc_walkthrough.py <exe_path>
"""
import sys, os, re, json, time, struct, subprocess, shutil, logging, glob, pwd
from pathlib import Path

# Hunter deep tracing — always on, timestamped per-run, file only
import hunter
from pathlib import Path as _Path
from datetime import datetime, timezone
_hunter_log = (_Path.home() / 'traces' / _Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
hunter.trace(stdlib=False, action=hunter.CallPrinter(
    stream=open(_hunter_log, 'a')))

logging.basicConfig(level=logging.INFO, format='%(message)s')
log = logging.getLogger('poc')

# F21: All paths overridable via environment variables
DISPLAY = os.environ.get('POC_DISPLAY', ':98')
WINE_USER = os.environ.get('POC_WINE_USER', 'wineshot')
WINE_PREFIX = os.environ.get('POC_WINE_PREFIX', '/home/wineshot/.wine')
C2_CMD = os.environ.get('POC_C2_CMD', WINE_PREFIX + '/drive_c/c2s_cmd.txt')
C2_RES = os.environ.get('POC_C2_RES', WINE_PREFIX + '/drive_c/c2s_res.txt')
REPO_ROOT = os.environ.get('POC_REPO_ROOT',
                           '/home/braker/git/aolunderground-proggies')
NAV_FILE = os.environ.get('POC_NAV_FILE',
                          os.path.join(REPO_ROOT, 'tools/c2/nav_graphs.json'))
STAGE_DIR = os.environ.get('POC_STAGE_DIR',
                           WINE_PREFIX + '/drive_c/progstage')

# F20: Configurable timing (seconds)
TIMING = {
    'wmcommand_delay': float(os.environ.get('POC_WMCMD_DELAY', '0.6')),
    'tab_delay':       float(os.environ.get('POC_TAB_DELAY', '0.8')),
    'click_delay':     float(os.environ.get('POC_CLICK_DELAY', '1.5')),
    'render_delay':    float(os.environ.get('POC_RENDER_DELAY', '1.5')),
}

# F8: Single unified danger word set for ALL phases
DANGER_WORDS = frozenset({
    'exit', 'quit', 'close', 'send', 'punt', 'boot', 'kill', 'bomb',
    'flood', 'nuke', 'disconnect', 'terminate', 'shutdown', 'unload',
    'destroy', 'attack', 'scroll', 'mass', 'spam', 'kick',
    'end', 'x', 'cancel', 'start', 'stop', 'connect', 'crack',
    'run', 'go', 'begin',
})

VB_CLASSES = [
    'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT6MDIForm',
    'ThunderRT5FormDC', 'ThunderRT5Form',
    'ThunderFormDC', 'ThunderForm',
]


# ── C2 helpers ──

def ensure_c2host():
    """Start c2host.exe if not running."""
    r = c2('PING', timeout=5)
    if r and 'PONG' in r:
        return True
    log.info('Starting c2host.exe...')
    subprocess.Popen(
        ['sudo', '-u', WINE_USER, 'env', 'DISPLAY=' + DISPLAY,
         'WINEPREFIX=' + WINE_PREFIX, 'wine', 'C:\\c2host.exe'],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        stdin=subprocess.DEVNULL)
    for _ in range(8):
        time.sleep(2)
        r = c2('PING', timeout=5)
        if r and 'PONG' in r:
            return True
    return False


def c2(cmd, timeout=8):
    """Send command to c2host.exe, return response or None on failure."""
    # F16: Clear stale response
    try:
        os.remove(C2_RES)
    except FileNotFoundError:
        pass
    except PermissionError:
        log.error('c2: permission denied removing %s', C2_RES)
        return None
    # F16: Atomic write via tmp + rename
    tmp_path = C2_CMD + '.tmp'
    try:
        with open(tmp_path, 'w') as f:
            f.write(cmd + '\n')
        os.rename(tmp_path, C2_CMD)
    except OSError as e:
        log.error('c2: failed to write command: %s', e)
        try:
            os.unlink(tmp_path)
        except OSError:
            pass
        return None
    # F10: Dynamic UID via pwd instead of hardcoded 993
    try:
        pw = pwd.getpwnam(WINE_USER)
        os.chown(C2_CMD, pw.pw_uid, pw.pw_gid)
    except KeyError:
        log.error('c2: user "%s" not found', WINE_USER)
        return None
    except PermissionError as e:
        log.warning('c2: chown failed: %s', e)
    # F12: Distinct failure returns with specific logging
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            with open(C2_RES, 'r') as f:
                r = f.read().strip()
            if r:
                try:
                    os.remove(C2_RES)
                except OSError:
                    pass
                return r
        except FileNotFoundError:
            pass
        except PermissionError:
            log.error('c2: permission denied reading %s', C2_RES)
            return None
        time.sleep(0.05)
    log.warning('c2: timeout after %ds for: %s', timeout, cmd[:80])
    return None


def c2_find(cls, title='*'):
    r = c2('FINDWINDOW %s %s' % (cls, title))
    if not r:
        return 0
    r = r.strip().split('\n')[0].strip()
    try:
        val = int(r)
        return val if val > 0 else 0
    except ValueError:
        return 0


def c2_find_all(cls):
    """Find ALL top-level windows of a given class via FindWindowEx chain.
    F19: Dedup protection via seen set."""
    found = []
    seen = set()
    after = 0
    for _ in range(50):
        r = c2('FINDWINDOWEX 0 %d %s *' % (after, cls), timeout=3)
        if not r:
            break
        r = r.strip().split('\n')[0].strip()
        try:
            hwnd = int(r)
        except ValueError:
            break
        if hwnd <= 0:
            break
        if hwnd in seen:
            break
        seen.add(hwnd)
        found.append(hwnd)
        after = hwnd
    return found


def c2_enum_children(hwnd):
    """Returns list of (hwnd, class, ctrlid, text)."""
    r = c2('ENUMCHILDREN %d' % hwnd, timeout=5)
    if not r:
        return []
    children = []
    for line in r.split('\n'):
        line = line.strip().strip('\r')
        if not line or line.startswith('OK'):
            continue
        parts = line.split('|')
        if len(parts) >= 4:
            children.append({
                'hwnd': int(parts[0]),
                'class': parts[1],
                'ctrlid': int(parts[2]) if parts[2].isdigit() else 0,
                'text': parts[3],
            })
    return children


def c2_enum_menus(hwnd):
    """Returns list of {top, sub, id}."""
    r = c2('ENUMMENUS %d' % hwnd, timeout=5)
    if not r:
        return []
    menus = []
    for line in r.split('\n'):
        line = line.strip().strip('\r')
        if not line or line.startswith('OK') or line.startswith('ERR') or line == 'EMPTY':
            continue
        # Format from c2host: topMenu|subMenu|id
        parts = line.split('|')
        if len(parts) >= 3:
            menus.append({
                'top': parts[0].replace('&', ''),
                'sub': parts[1].replace('&', ''),
                'id': int(parts[2]) if parts[2].strip().isdigit() else 0,
            })
    return menus


def _get_window_geometry(hwnd):
    """Get window geometry (x, y, w, h) via xdotool. Returns tuple or None.
    Helper for F3/F4 fixes."""
    title = get_window_title(hwnd)
    if not title:
        return None
    try:
        r = subprocess.run(
            ['xdotool', 'search', '--name', title],
            env={'DISPLAY': DISPLAY}, timeout=5,
            capture_output=True, text=True)
        for line in r.stdout.strip().split('\n'):
            xid = line.strip()
            if not xid:
                continue
            geo = subprocess.run(
                ['xdotool', 'getwindowgeometry', '--shell', xid],
                env={'DISPLAY': DISPLAY}, timeout=5,
                capture_output=True, text=True)
            if geo.returncode == 0:
                vals = {}
                for gl in geo.stdout.strip().split('\n'):
                    if '=' in gl:
                        k, v = gl.split('=', 1)
                        vals[k.strip()] = int(v.strip())
                if all(k in vals for k in ('X', 'Y', 'WIDTH', 'HEIGHT')):
                    return (vals['X'], vals['Y'],
                            vals['WIDTH'], vals['HEIGHT'])
    except Exception:
        pass
    return None


def c2_screenshot(hwnd, path, client=True):
    """Screenshot a specific window via xwd + targeted crop.
    F3: Uses xdotool geometry for the target hwnd when available.
    Falls back to non-black content detection."""
    from PIL import Image
    try:
        proc = subprocess.run(
            ['sudo', '-u', WINE_USER, 'env', 'DISPLAY=' + DISPLAY,
             'xwd', '-root', '-silent'],
            capture_output=True, timeout=10)
        if proc.returncode != 0:
            log.error('xwd failed: %s', proc.stderr[:200])
            return False
        tmp_png = path + '.tmp.png'
        proc2 = subprocess.run(
            ['convert', 'xwd:-', tmp_png],
            input=proc.stdout, capture_output=True, timeout=10)
        if proc2.returncode != 0:
            log.error('convert failed: %s', proc2.stderr[:200])
            return False
        img = Image.open(tmp_png).convert('RGB')
        os.remove(tmp_png)
    except Exception as e:
        log.error('Screenshot capture failed: %s', e)
        return False
    w_img, h_img = img.size
    # F3: Try targeted crop via xdotool window geometry
    win_geom = _get_window_geometry(hwnd)
    if win_geom:
        gx, gy, gw, gh = win_geom
        cl = max(0, gx)
        ct = max(0, gy)
        cr = min(w_img, gx + gw)
        cb = min(h_img, gy + gh)
        if cr > cl + 10 and cb > ct + 10:
            cropped = img.crop((cl, ct, cr, cb))
            cropped.save(path)
            return True
        log.warning('xdotool geometry for hwnd=%d out of range, fallback',
                    hwnd)
    # Fallback: crop to non-black content region
    w, h = img.size
    pixels = img.load()
    top, bottom, left, right = h, 0, w, 0
    for y in range(0, h, 2):
        for x in range(0, w, 2):
            r, g, b = pixels[x, y]
            if r > 10 or g > 10 or b > 10:
                top = min(top, y)
                bottom = max(bottom, y)
                left = min(left, x)
                right = max(right, x)
    if right <= left or bottom <= top:
        return False
    if top < 5:
        gap_rows = range(21, 26)
        gap_is_black = True
        for y in gap_rows:
            for x in range(left, right + 1, 4):
                r, g, b = pixels[x, y]
                if r > 10 or g > 10 or b > 10:
                    gap_is_black = False
                    break
            if not gap_is_black:
                break
        if gap_is_black:
            top, left, right = h, w, 0
            for y in range(26, h, 2):
                for x in range(0, w, 2):
                    r, g, b = pixels[x, y]
                    if r > 10 or g > 10 or b > 10:
                        top = min(top, y)
                        bottom = max(bottom, y)
                        left = min(left, x)
                        right = max(right, x)
            if top >= h:
                return False
    if right <= left or bottom <= top:
        return False
    cropped = img.crop((max(0, left - 1), max(0, top - 1),
                        min(w, right + 2), min(h, bottom + 2)))
    cropped.save(path)
    return True


def c2_wmcommand(hwnd, cmd_id):
    """Send WM_COMMAND to a window via PostMessage."""
    # WM_COMMAND = 0x111 = 273
    r = c2('POSTMSG %d 273 %d 0' % (hwnd, cmd_id))
    return r


# ── Process management ──

def kill_all_proggies():
    """Kill all non-infrastructure wineshot processes."""
    infra = {'services.exe', 'winedevice.exe', 'explorer.exe',
             'plugplay.exe', 'svchost.exe', 'c2host.exe',
             'dbus-launch', 'dbus-daemon', 'wineserver',
             'rpcss.exe'}
    try:
        out = subprocess.check_output(
            ['pgrep', '-u', WINE_USER, '-a'], timeout=5
        ).decode()
    except subprocess.CalledProcessError:
        return
    for line in out.strip().split('\n'):
        parts = line.split(None, 1)
        if len(parts) < 2:
            continue
        pid = int(parts[0])
        cmdline = parts[1]
        is_infra = any(i in cmdline.lower() for i in infra)
        if not is_infra and 'defunct' not in cmdline:
            log.info('  killing pid %d: %s', pid, cmdline[:60])
            subprocess.run(['sudo', 'kill', str(pid)], timeout=5)
    time.sleep(1)


def stage_and_launch(exe_path):
    """Copy exe + co-located files to stage dir, launch under Wine.
    F11: Handles subdirectories and Wine file locks gracefully."""
    os.makedirs(STAGE_DIR, exist_ok=True)
    for fn in os.listdir(STAGE_DIR):
        fp = os.path.join(STAGE_DIR, fn)
        try:
            if os.path.isdir(fp):
                shutil.rmtree(fp, ignore_errors=True)
            else:
                os.remove(fp)
        except OSError as e:
            log.warning('stage cleanup: cannot remove %s: %s', fp, e)
    exe_dir = os.path.dirname(exe_path)
    exe_name = os.path.basename(exe_path)
    shutil.copy2(exe_path, os.path.join(STAGE_DIR, exe_name))
    for fn in os.listdir(exe_dir):
        if fn == exe_name:
            continue
        src = os.path.join(exe_dir, fn)
        if os.path.isfile(src) and os.path.getsize(src) < 5_000_000:
            try:
                shutil.copy2(src, os.path.join(STAGE_DIR, fn))
            except OSError as e:
                log.warning('stage copy failed for %s: %s', fn, e)
    # F11: Use WINE_USER variable instead of hardcoded string
    subprocess.run(['sudo', 'chown', '-R', WINE_USER + ':nonet', STAGE_DIR],
                   timeout=5)
    win_path = 'C:\\progstage\\' + exe_name
    proc = subprocess.Popen(
        ['sudo', '-u', WINE_USER, 'env',
         'DISPLAY=' + DISPLAY, 'WINEPREFIX=' + WINE_PREFIX,
         'wine', win_path],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )
    return proc


def find_vb_window(timeout=12):
    """Poll for a VB runtime window. Returns hwnd or 0."""
    deadline = time.time() + timeout
    while time.time() < deadline:
        for cls in VB_CLASSES:
            hwnd = c2_find(cls)
            if hwnd:
                return hwnd
        time.sleep(0.5)
    return 0


def find_all_vb_windows():
    """Find all VB windows currently open (all instances per class)."""
    found = []
    for cls in VB_CLASSES:
        for hwnd in c2_find_all(cls):
            if hwnd not in found:
                found.append(hwnd)
    return found


def get_window_title(hwnd):
    r = c2('GETTEXT %d' % hwnd)
    if r:
        # Response is just the text, no prefix
        return r.strip().split('\n')[0].strip()
    return ''


# ── Main POC ──


def run_poc(exe_path):
    """Main POC walkthrough entry point."""
    exe_path = os.path.abspath(exe_path)
    exe_name = os.path.splitext(os.path.basename(exe_path))[0]
    log.info('=== POC Walkthrough: %s ===', exe_name)

    # F5: Load nav graph with exact-match priority
    nav_graph = None
    has_nav_graph = False
    if os.path.exists(NAV_FILE):
        with open(NAV_FILE) as f:
            all_graphs = json.load(f)
        exe_lower = exe_name.lower()
        match_key = None
        for key in all_graphs:
            if exe_lower == key.lower():
                match_key = key
                break
        if not match_key:
            for key in all_graphs:
                ks = os.path.splitext(key)[0].lower() if '.' in key else key.lower()
                if exe_lower == ks:
                    match_key = key
                    break
        if not match_key:
            candidates = [k for k in all_graphs if exe_lower in k.lower()]
            if len(candidates) == 1:
                match_key = candidates[0]
                log.info('Nav graph substring match: "%s"', match_key)
            elif len(candidates) > 1:
                log.warning('Ambiguous nav graph for "%s": %s',
                            exe_name, candidates)
        if match_key:
            nav_graph = all_graphs[match_key]
            has_nav_graph = True
            log.info('Nav graph (%s): %d nav, %d dangerous, %d menus',
                     match_key, len(nav_graph['navigation']),
                     len(nav_graph['dangerous']),
                     len(nav_graph['menus']))
    if not nav_graph:
        log.info('No nav graph found, blind screenshot only')
        nav_graph = {'navigation': [], 'dangerous': [], 'menus': [],
                     'clickable': [], 'forms': []}

    # F13: Load and validate enumerate_controls data
    dangerous_captions = set()
    ec_menu_count = 0
    bas_path = os.path.join(os.path.dirname(exe_path),
                            exe_name + '.decompiled.bas')
    if os.path.exists(bas_path):
        try:
            bas_mt = os.path.getmtime(bas_path)
            exe_mt = os.path.getmtime(exe_path)
            if bas_mt < exe_mt - 86400:
                log.warning('.bas file is >1 day older than exe')
            with open(bas_path, 'r', errors='replace') as bf:
                hdr = bf.read(4096)
            if exe_name.lower() not in hdr.lower():
                log.warning('.bas file may not match "%s"', exe_name)
        except OSError as e:
            log.warning('.bas validation failed: %s', e)
    if os.path.exists(bas_path):
        try:
            sys.path.insert(0, os.path.join(REPO_ROOT, 'tools/c2'))
            from enumerate_controls import enumerate_app
            ec = enumerate_app(bas_path, exe_path)
            for name, ctrl in ec.get('controls', {}).items():
                if ctrl['type'] != 'Menu':
                    continue
                ec_menu_count += 1
                cap = (ctrl.get('caption') or '').lower().strip()
                if cap and cap != '?' and cap != '-':
                    if any(w in cap for w in DANGER_WORDS):
                        dangerous_captions.add(cap)
            log.info('enumerate_controls: %d menus, %d dangerous',
                     ec_menu_count, len(dangerous_captions))
        except Exception as e:
            log.warning('enumerate_controls failed: %s', e)

    # Setup output
    out_dir = os.path.join(REPO_ROOT, 'tools/c2/poc_output', exe_name)
    os.makedirs(out_dir, exist_ok=True)
    os.makedirs(os.path.join(WINE_PREFIX, 'drive_c', 'screenshots'),
                exist_ok=True)

    log.info('Cleaning up...')
    kill_all_proggies()
    if not ensure_c2host():
        log.error('c2host.exe failed to start')
        return

    log.info('Launching %s...', exe_name)
    proc = stage_and_launch(exe_path)
    hwnd = find_vb_window()
    if not hwnd:
        log.error('No VB window appeared')
        proc.kill()
        return
    time.sleep(TIMING['render_delay'])

    title = get_window_title(hwnd)
    log.info('Found window: hwnd=%d title="%s"', hwnd, title)
    frames = []

    shot1 = os.path.join(out_dir, '01_main.bmp')
    if c2_screenshot(hwnd, shot1):
        frames.append(shot1)
        log.info('Frame 1: main window')
    else:
        log.error('Failed to screenshot main window')

    children = c2_enum_children(hwnd)
    menus = c2_enum_menus(hwnd)
    log.info('ENUMCHILDREN: %d controls', len(children))
    for ch in children:
        log.info('  hwnd=%d class=%s text="%s"',
                 ch['hwnd'], ch['class'], ch['text'][:40])
    log.info('ENUMMENUS: %d items', len(menus))
    for m in menus:
        log.info('  id=%d %s > %s', m['id'], m['top'], m['sub'])

    danger_names = {d['control'].lower() for d in nav_graph['dangerous']}
    log.info('Dangerous controls: %s', danger_names)

    # F15: Build menu_map AND use it for safe ID computation
    menu_map = {}
    for m in menus:
        if m['id'] > 0:
            clean = m['sub'].strip().lower()
            menu_map[clean] = m['id']

    # F1: Compute safe menu IDs from nav graph + menu_map
    safe_menu_ids = set()
    if menu_map and has_nav_graph:
        nav_menu_names = set()
        for me in nav_graph.get('menus', []):
            mn = me.get('name', '').lower().strip().replace('&', '')
            if mn:
                nav_menu_names.add(mn)
        for name, mid in menu_map.items():
            if name in danger_names:
                continue
            if any(w in name for w in DANGER_WORDS):
                continue
            if nav_menu_names:
                if name in nav_menu_names:
                    safe_menu_ids.add(mid)
            else:
                safe_menu_ids.add(mid)
        if safe_menu_ids:
            log.info('Safe menu IDs: %s', sorted(safe_menu_ids))

    step = 2

    # Phase 1: WM_COMMAND scan
    # F7: Only run when nav graph exists for safety filtering
    nav_menu_count = len(nav_graph.get('menus', []))
    has_menus = nav_menu_count > 0 or menus or ec_menu_count > 0
    if has_menus and has_nav_graph:
        max_id = max(nav_menu_count * 3, ec_menu_count * 2, 50)
        log.info('--- Phase 1: WM_COMMAND scan (max_id=%d) ---', max_id)
        step, hwnd, relaunched_proc = _bruteforce_wmcommand(
            hwnd, step, out_dir, frames, nav_graph,
            max_id=max_id, exe_path=exe_path,
            dangerous_captions=dangerous_captions,
            safe_menu_ids=safe_menu_ids if safe_menu_ids else None)
        if relaunched_proc is not None:
            proc = relaunched_proc
    elif has_menus:
        log.info('Skipping Phase 1: no nav graph for safety filtering')

    if not hwnd or hwnd not in find_all_vb_windows():
        log.warning('Main window lost during Phase 1')
        _assemble_gif(exe_name, frames, out_dir)
        kill_all_proggies()
        return

    children = c2_enum_children(hwnd)

    # Phase 2: Tab cycling
    tab_classes = {'sstabctlwndclass', 'systabcontrol32',
                   'thunderrt6tabstrip'}
    tab_controls = [ch for ch in children
                    if ch['class'].lower() in tab_classes]
    if tab_controls:
        log.info('--- Phase 2: tab cycling (%d tabs) ---', len(tab_controls))
        step = _cycle_tabs(hwnd, step, out_dir, frames, max_tabs=6)

    # Phase 3: F2 - click ONLY positively matched nav buttons
    nav_names = set()
    for nav in nav_graph.get('navigation', []):
        ctrl = nav['from_control']
        if nav['is_menu']:
            continue
        if ctrl.lower() in danger_names:
            continue
        nav_names.add(ctrl.lower())

    clickable_children = [ch for ch in children
                          if ('CommandButton' in ch['class'] or
                              'PictureBox' in ch['class']) and
                          ch['hwnd'] != hwnd]

    nav_buttons = []
    for child in clickable_children:
        caption = child['text'].lower().strip().replace('&', '')
        if any(w in caption for w in DANGER_WORDS):
            continue
        if caption in nav_names:
            nav_buttons.append(child)
            log.info('  Nav match: "%s"', child['text'])

    # F2: No fallback -- do not click unmatched controls
    if nav_names and not nav_buttons:
        log.info('  No caption matches for %s, skipping Phase 3', nav_names)

    if nav_buttons:
        log.info('--- Phase 3: clicking %d nav buttons ---', len(nav_buttons))

    for child in nav_buttons[:6]:
        log.info('  Click: hwnd=%d text="%s"', child['hwnd'], child['text'])
        _xdotool_click_window(child['hwnd'])
        time.sleep(TIMING['click_delay'])
        step = _screenshot_new_state(hwnd, step, child['text'],
                                     out_dir, frames)

    log.info('Killing app...')
    proc.kill()
    try:
        proc.wait(timeout=5)
    except subprocess.TimeoutExpired:
        pass
    kill_all_proggies()
    _assemble_gif(exe_name, frames, out_dir)


def _xdotool_click_window(hwnd):
    """Click center of a Win32 child control via coordinate-based click.
    F4: Uses GETRECT as primary, xdotool geometry as fallback."""
    r = c2('GETRECT %d' % hwnd)
    if r:
        try:
            parts = r.strip().split()
            if len(parts) >= 4:
                x, y, w, h = (int(parts[0]), int(parts[1]),
                              int(parts[2]), int(parts[3]))
                if w > 0 and h > 0:
                    cx = x + w // 2
                    cy = y + h // 2
                    log.info('  GETRECT: %d,%d %dx%d -> click %d,%d',
                             x, y, w, h, cx, cy)
                    subprocess.run(
                        ['xdotool', 'mousemove', '--sync',
                         str(cx), str(cy), 'click', '1'],
                        env={'DISPLAY': DISPLAY}, timeout=5)
                    return
        except (ValueError, IndexError) as e:
            log.warning('GETRECT parse error for hwnd=%d: %s', hwnd, e)
    geom = _get_window_geometry(hwnd)
    if geom:
        x, y, w, h = geom
        cx = x + w // 2
        cy = y + h // 2
        log.info('  xdotool geom fallback: click %d,%d', cx, cy)
        subprocess.run(
            ['xdotool', 'mousemove', '--sync', str(cx), str(cy),
             'click', '1'],
            env={'DISPLAY': DISPLAY}, timeout=5)
    else:
        log.warning('No geometry for hwnd=%d, cannot click', hwnd)


def _find_x11_window(hwnd):
    """Find the X11 window ID corresponding to a Wine hwnd by matching title."""
    title = get_window_title(hwnd)
    if not title:
        return None
    try:
        r = subprocess.run(
            ['xdotool', 'search', '--name', title],
            env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True, text=True)
        for line in r.stdout.strip().split('\n'):
            if line.strip():
                return int(line.strip())
    except Exception:
        pass
    return None


def _xkey(hwnd, key):
    """Send a key to a specific window via xdotool.
    F6: Does NOT fall back to global keystrokes -- drops instead."""
    title = get_window_title(hwnd)
    if not title:
        log.warning('_xkey: no title for hwnd=%d, dropping key "%s"',
                    hwnd, key)
        return
    try:
        r = subprocess.run(
            ['xdotool', 'search', '--name', title],
            env={'DISPLAY': DISPLAY}, timeout=5,
            capture_output=True, text=True)
        xids = [x.strip() for x in r.stdout.strip().split('\n')
                if x.strip()]
    except Exception as e:
        log.warning('_xkey: xdotool search failed: %s', e)
        return
    if not xids:
        log.warning('_xkey: no X11 window for "%s" (hwnd=%d), '
                    'dropping key "%s"', title, hwnd, key)
        return
    xid = xids[0]
    try:
        subprocess.run(
            ['xdotool', 'windowactivate', xid],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)
        time.sleep(0.1)
        subprocess.run(
            ['xdotool', 'key', '--window', xid, key],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)
    except Exception as e:
        log.warning('_xkey: send failed for hwnd=%d: %s', hwnd, e)


def _bruteforce_wmcommand(main_hwnd, step, out_dir, frames, nav_graph,
                          max_id=200, exe_path=None, dangerous_captions=None,
                          safe_menu_ids=None):
    """Invoke WM_COMMAND IDs to discover menu-triggered windows.
    F1: When safe_menu_ids is provided, only those IDs are invoked.
    Returns (next_step, main_hwnd, relaunched_proc)."""
    danger_words = set(DANGER_WORDS)
    if nav_graph:
        for d in nav_graph.get('dangerous', []):
            ctrl = d['control'].lower()
            if ctrl.startswith('mnu'):
                danger_words.add(ctrl[3:].lower())
            danger_words.add(ctrl.lower())
    baseline_vb = set(find_all_vb_windows())
    baseline_dlg = set(c2_find_all('#32770'))
    main_cls_r = c2('GETCLASS %d' % main_hwnd)
    main_cls = main_cls_r.strip() if main_cls_r else VB_CLASSES[0]
    discovered = []
    consecutive_noop = 0
    seen_hwnds = set(baseline_vb | baseline_dlg)
    skip_ids = set()
    max_deaths = 3
    relaunched_proc = None
    # F1: Positive-match mode when safe IDs available
    if safe_menu_ids:
        ids_to_try = sorted(safe_menu_ids)
        log.info('Positive-match mode: %d safe IDs: %s',
                 len(ids_to_try), ids_to_try)
    else:
        ids_to_try = list(range(1, max_id + 1))
        log.warning('No safe menu IDs - danger-filtered scan (1..%d)', max_id)
    for cmd_id in ids_to_try:
        if cmd_id in skip_ids:
            continue
        c2_wmcommand(main_hwnd, cmd_id)
        time.sleep(TIMING['wmcommand_delay'])
        # F9: Check if main window survived
        alive_r = c2('GETCLASS %d' % main_hwnd, timeout=3)
        if not alive_r or not alive_r.strip() or alive_r.strip() == '0':
            skip_ids.add(cmd_id)
            log.warning('Main window died at WM_COMMAND id=%d', cmd_id)
            if not exe_path or len(skip_ids) > max_deaths:
                return step, 0, relaunched_proc
            relaunched_proc = stage_and_launch(exe_path)
            main_hwnd = find_vb_window(timeout=10)
            if not main_hwnd:
                log.error('Failed to relaunch after id=%d', cmd_id)
                return step, 0, relaunched_proc
            time.sleep(TIMING['render_delay'])
            baseline_vb = set(find_all_vb_windows())
            baseline_dlg = set(c2_find_all('#32770'))
            seen_hwnds = set(baseline_vb | baseline_dlg)
            main_cls_r = c2('GETCLASS %d' % main_hwnd)
            main_cls = main_cls_r.strip() if main_cls_r else VB_CLASSES[0]
            consecutive_noop = 0
            continue
        new_hwnd = None
        for h in c2_find_all(main_cls):
            if h not in seen_hwnds:
                new_hwnd = h
                break
        if not new_hwnd:
            for h in c2_find_all('#32770'):
                if h not in seen_hwnds:
                    new_hwnd = h
                    break
        if not new_hwnd:
            consecutive_noop += 1
            if consecutive_noop > 30:
                log.info('30 consecutive no-ops after id=%d, stopping', cmd_id)
                break
            continue
        consecutive_noop = 0
        seen_hwnds.add(new_hwnd)
        title = get_window_title(new_hwnd)
        cls_r = c2('GETCLASS %d' % new_hwnd)
        cls = cls_r.strip() if cls_r else '?'
        body_text = ''
        if cls == '#32770':
            ch_list = c2_enum_children(new_hwnd)
            body_text = ' '.join(
                ch['text'] for ch in ch_list
                if ch['class'] == 'Static' and ch['text'].strip()
            ).lower()
        log.info('  id=%d -> new window: "%s" (%s) body="%s"',
                 cmd_id, title, cls, body_text[:60])
        title_lower = title.lower() if title else ''
        is_dangerous = any(w in title_lower for w in danger_words)
        if not is_dangerous and dangerous_captions and body_text:
            is_dangerous = any(cap in body_text for cap in dangerous_captions)
        if is_dangerous:
            log.info('  id=%d matches danger filter, dismissing', cmd_id)
        else:
            safe = re.sub(r'[^\w\-]', '_', title or 'cmd_%d' % cmd_id)[:30]
            shot_path = os.path.join(out_dir,
                                     '%02d_menu_%s.bmp' % (step, safe))
            if c2_screenshot(new_hwnd, shot_path):
                if not frames or not _frames_identical(frames[-1], shot_path):
                    frames.append(shot_path)
                    log.info('Frame %d: WM_COMMAND id=%d -> "%s"',
                             step, cmd_id, title)
                    step += 1
                else:
                    os.remove(shot_path)
        discovered.append((cmd_id, title, cls))
        if cls == '#32770':
            c2('POSTMSG %d 273 2 0' % new_hwnd, timeout=3)
            time.sleep(0.3)
        c2('POSTMSG %d 16 0 0' % new_hwnd, timeout=3)
        time.sleep(0.3)
        _xkey(new_hwnd, 'Escape')
        time.sleep(0.3)
    if discovered:
        log.info('WM_COMMAND scan found %d windows:', len(discovered))
        for cid, ttl, clz in discovered:
            log.info('  id=%d "%s" (%s)', cid, ttl, clz)
        meta = {str(cid): {'title': ttl, 'class': clz}
                for cid, ttl, clz in discovered}
        if skip_ids:
            for sid in skip_ids:
                meta[str(sid)] = {'title': '(killed app)', 'class': 'DEAD'}
        meta_path = os.path.join(out_dir, 'wmcommand_map.json')
        with open(meta_path, 'w') as mf:
            json.dump(meta, mf, indent=2)
        log.info('Saved %s', meta_path)
    return step, main_hwnd, relaunched_proc


def _walk_menus_keyboard(main_hwnd, step, out_dir, frames, danger_words,
                         max_top=6, max_sub=10):
    """DEPRECATED: Unreliable under Wine for VB6 apps.
    F17: Use _bruteforce_wmcommand() instead."""
    raise NotImplementedError(
        '_walk_menus_keyboard is deprecated - use _bruteforce_wmcommand')


def _cycle_tabs(main_hwnd, step, out_dir, frames, max_tabs=6):
    """Cycle through tab pages via Ctrl+PageDown, screenshot each.
    F20: Uses TIMING config instead of hardcoded delays."""
    for i in range(max_tabs):
        _xkey(main_hwnd, 'ctrl+Next')
        time.sleep(TIMING['tab_delay'])
        safe = 'tab_%d' % (i + 1)
        shot_path = os.path.join(out_dir, '%02d_%s.bmp' % (step, safe))
        if c2_screenshot(main_hwnd, shot_path):
            if not frames or not _frames_identical(frames[-1], shot_path):
                frames.append(shot_path)
                log.info('Frame %d: tab %d', step, i + 1)
                step += 1
            else:
                os.remove(shot_path)
                log.info('Tab %d: duplicate, stopping', i + 1)
                break
    return step


def _frames_identical(path_a, path_b):
    """Return True if two BMP files have identical pixel data."""
    try:
        return open(path_a, 'rb').read() == open(path_b, 'rb').read()
    except OSError:
        return False


def _screenshot_new_state(main_hwnd, step, label, out_dir, frames):
    """Screenshot whatever new window appeared, dismiss it, return next step."""
    new_hwnds = find_all_vb_windows()
    dlg = c2_find('#32770')
    if dlg:
        new_hwnds.append(dlg)

    shot_hwnd = None
    for h in new_hwnds:
        if h != main_hwnd:
            shot_hwnd = h
            break
    if not shot_hwnd:
        shot_hwnd = main_hwnd

    safe_label = re.sub(r'[^\w\-]', '_', str(label))[:30]
    shot_path = os.path.join(out_dir, '%02d_%s.bmp' % (step, safe_label))
    if c2_screenshot(shot_hwnd, shot_path):
        # Dedup: discard if identical to previous frame
        if frames and _frames_identical(frames[-1], shot_path):
            os.remove(shot_path)
            log.info('Frame %d: %s — duplicate, discarded', step, label)
        else:
            frames.append(shot_path)
            new_title = get_window_title(shot_hwnd)
            log.info('Frame %d: %s (hwnd=%d title="%s")',
                     step, label, shot_hwnd, new_title)

    # Dismiss if it's a new window
    if shot_hwnd != main_hwnd:
        _xkey(shot_hwnd, 'Escape')
        time.sleep(0.5)
        still = find_all_vb_windows()
        if shot_hwnd in still:
            _xkey(shot_hwnd, 'alt+F4')
            time.sleep(0.5)

    return step + 1


def _assemble_gif(exe_name, frames, out_dir):
    """Assemble BMP frames into animated GIF.
    F18: Scale to fit instead of silent crop for size normalization."""
    if len(frames) < 1:
        log.info('No frames to assemble')
        return
    try:
        from PIL import Image
    except ImportError:
        log.error('Pillow not installed, skipping GIF')
        return
    gif_path = os.path.join(out_dir, exe_name + '.gif')
    pil_frames = []
    for f in frames:
        try:
            img = Image.open(f).convert('RGB')
            if img.width < 400:
                scale = max(2, 400 // img.width)
                img = img.resize((img.width * scale, img.height * scale),
                                 Image.NEAREST)
            pil_frames.append(img)
        except Exception as e:
            log.warning('Cannot load %s: %s', f, e)
    if not pil_frames:
        return
    # F18: Normalize to first frame size via scale-to-fit
    w, h = pil_frames[0].size
    normalized = []
    for img in pil_frames:
        if img.size != (w, h):
            sf = min(w / img.width, h / img.height)
            nw = int(img.width * sf)
            nh = int(img.height * sf)
            resample = Image.LANCZOS if hasattr(Image, 'LANCZOS') else Image.BICUBIC
            img = img.resize((nw, nh), resample)
            bg = Image.new('RGB', (w, h), (192, 192, 192))
            ox = (w - img.width) // 2
            oy = (h - img.height) // 2
            bg.paste(img, (ox, oy))
            normalized.append(bg)
        else:
            normalized.append(img)
    palettized = [img.quantize(colors=256, method=2) for img in normalized]
    palettized[0].save(
        gif_path, save_all=True, append_images=palettized[1:],
        duration=2000, loop=0)
    log.info('GIF: %s (%d frames, %d KB)',
             gif_path, len(normalized),
             os.path.getsize(gif_path) // 1024)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: poc_walkthrough.py <exe_path>')
        sys.exit(1)
    run_poc(sys.argv[1])
