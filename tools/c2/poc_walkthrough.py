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
import sys, os, re, json, time, struct, subprocess, shutil, logging
from pathlib import Path

logging.basicConfig(level=logging.INFO, format='%(message)s')
log = logging.getLogger('poc')

DISPLAY = ':98'
WINE_USER = 'wineshot'
WINE_PREFIX = '/home/wineshot/.wine'
C2_CMD = '/home/wineshot/.wine/drive_c/c2s_cmd.txt'
C2_RES = '/home/wineshot/.wine/drive_c/c2s_res.txt'
REPO_ROOT = '/home/braker/git/aolunderground-proggies'
NAV_FILE = os.path.join(REPO_ROOT, 'tools/c2/nav_graphs.json')
STAGE_DIR = '/home/wineshot/.wine/drive_c/progstage'

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
    """Send command to c2host.exe, return response string."""
    try:
        os.remove(C2_RES)
    except FileNotFoundError:
        pass
    with open(C2_CMD, 'w') as f:
        f.write(cmd + '\n')
    os.chown(C2_CMD, 993, 993)
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            with open(C2_RES, 'r') as f:
                r = f.read().strip()
            if r:
                os.remove(C2_RES)
                return r
        except FileNotFoundError:
            pass
        time.sleep(0.05)
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
    """Find ALL top-level windows of a given class using FindWindowEx chain."""
    found = []
    after = 0
    for _ in range(50):  # safety limit
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


def c2_screenshot(hwnd, path, client=True):
    """Screenshot a window, save as BMP. client=True crops title bar."""
    win_path = 'C:\\screenshots\\' + os.path.basename(path)
    cmd = 'SCREENSHOT %d %s%s' % (hwnd, win_path, ' client' if client else '')
    r = c2(cmd, timeout=10)
    if r and r.startswith('OK'):
        src = os.path.join(WINE_PREFIX, 'drive_c', 'screenshots',
                           os.path.basename(path))
        if os.path.exists(src):
            shutil.move(src, path)
            return True
    return False


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
    """Copy exe + co-located files to stage dir, launch under Wine."""
    os.makedirs(STAGE_DIR, exist_ok=True)
    # Clean stage
    for f in os.listdir(STAGE_DIR):
        os.remove(os.path.join(STAGE_DIR, f))

    exe_dir = os.path.dirname(exe_path)
    exe_name = os.path.basename(exe_path)

    # Copy exe and supporting files
    shutil.copy2(exe_path, os.path.join(STAGE_DIR, exe_name))
    for f in os.listdir(exe_dir):
        if f == exe_name:
            continue
        src = os.path.join(exe_dir, f)
        if os.path.isfile(src) and os.path.getsize(src) < 5_000_000:
            shutil.copy2(src, os.path.join(STAGE_DIR, f))

    # Fix ownership
    subprocess.run(['sudo', 'chown', '-R', 'wineshot:nonet', STAGE_DIR],
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
    exe_path = os.path.abspath(exe_path)
    exe_name = Path(exe_path).stem
    log.info('=== POC Walkthrough: %s ===', exe_name)

    # Load nav graph
    nav_graph = None
    if os.path.exists(NAV_FILE):
        with open(NAV_FILE) as f:
            all_graphs = json.load(f)
        # Find matching graph by exe name
        for key, g in all_graphs.items():
            if exe_name.lower() in key.lower():
                nav_graph = g
                log.info('Nav graph found: %d nav, %d dangerous, %d menus',
                         len(g['navigation']), len(g['dangerous']),
                         len(g['menus']))
                break
    if not nav_graph:
        log.info('No nav graph found, will do blind screenshot only')

    # Setup output
    out_dir = os.path.join(REPO_ROOT, 'tools/c2/poc_output', exe_name)
    os.makedirs(out_dir, exist_ok=True)
    os.makedirs(os.path.join(WINE_PREFIX, 'drive_c', 'screenshots'),
                exist_ok=True)

    # Kill any running proggies
    log.info('Cleaning up...')
    kill_all_proggies()

    # Ensure c2host is running
    if not ensure_c2host():
        log.error('c2host.exe failed to start')
        return

    # Launch
    log.info('Launching %s...', exe_name)
    proc = stage_and_launch(exe_path)

    # Wait for VB window
    hwnd = find_vb_window()
    if not hwnd:
        log.error('No VB window appeared')
        proc.kill()
        return
    time.sleep(1.5)  # let it render

    title = get_window_title(hwnd)
    log.info('Found window: hwnd=%d title="%s"', hwnd, title)

    frames = []

    # Screenshot 1: main window
    shot1 = os.path.join(out_dir, '01_main.bmp')
    if c2_screenshot(hwnd, shot1):
        frames.append(shot1)
        log.info('Frame 1: main window')
    else:
        log.error('Failed to screenshot main window')

    # Discover controls and menus
    children = c2_enum_children(hwnd)
    menus = c2_enum_menus(hwnd)
    log.info('ENUMCHILDREN: %d controls', len(children))
    for c in children:
        log.info('  hwnd=%d class=%s text="%s"', c['hwnd'], c['class'],
                 c['text'][:40])
    log.info('ENUMMENUS: %d items', len(menus))
    for m in menus:
        log.info('  id=%d %s > %s', m['id'], m['top'], m['sub'])

    if not nav_graph:
        log.info('No nav graph — done with blind screenshot')
        proc.kill()
        _assemble_gif(exe_name, frames, out_dir)
        return

    # Build danger set
    danger_names = {d['control'].lower() for d in nav_graph['dangerous']}
    log.info('Dangerous controls to avoid: %s', danger_names)

    # Build menu name -> id mapping
    menu_map = {}
    for m in menus:
        if m['id'] > 0:
            # Key by submenu text, lowercased
            clean = m['sub'].strip().lower()
            menu_map[clean] = m['id']

    step = 2

    # Phase 1: Brute-force WM_COMMAND menu scan
    # VB6 menus are internal (ENUMMENUS returns 0 for most apps under Wine).
    # Keyboard walk (F10) is unreliable. WM_COMMAND brute-force works.
    nav_menu_count = len(nav_graph.get('menus', []))
    if nav_menu_count > 0 or menus:
        log.info('--- Phase 1: WM_COMMAND brute-force (%d nav graph menus, '
                 '%d Win32 menus) ---', nav_menu_count, len(menus))
        step = _bruteforce_wmcommand(
            hwnd, step, out_dir, frames, nav_graph,
            max_id=max(nav_menu_count * 3, 50))

    # Check main window still alive before continuing
    if hwnd not in find_all_vb_windows():
        log.warning('Main window died during Phase 1, skipping remaining phases')
        _assemble_gif(exe_name, frames, out_dir)
        kill_all_proggies()
        return

    # Phase 2: Tab cycling — SSTabControl, SysTabControl32, etc.
    tab_classes = {'sstabctlwndclass', 'systabcontrol32', 'thunderrt6tabstrip'}
    tab_controls = [c for c in children
                    if c['class'].lower() in tab_classes]
    if tab_controls:
        log.info('--- Phase 2: tab cycling (%d tab controls) ---',
                 len(tab_controls))
        step = _cycle_tabs(hwnd, step, out_dir, frames, max_tabs=6)

    # Phase 3: Click ONLY buttons that the nav graph says open another form.
    # Match by: caption text == nav control name (case-insensitive),
    # or nav control name starts with "Command" and we try all CommandButtons
    # that aren't dangerous.
    nav_names = set()  # lowercase control names that navigate to forms
    nav_command_targets = {}  # "Command2" -> target_form (can't match by caption)
    for nav in nav_graph.get('navigation', []):
        ctrl = nav['from_control']
        if nav['is_menu']:
            continue  # menus handled in Phase 1
        if ctrl.lower() in danger_names:
            continue
        nav_names.add(ctrl.lower())
        if ctrl.lower().startswith('command'):
            nav_command_targets[ctrl.lower()] = nav['to_form']

    clickable_children = [c for c in children
                          if 'CommandButton' in c['class'] and c['text']]
    danger_captions = {'exit', 'quit', 'close', 'end', 'x', 'cancel',
                       'start', 'stop', 'connect', 'send', 'crack',
                       'punt', 'flood', 'attack', 'run', 'go', 'begin'}

    # Match children to nav graph entries by caption
    nav_buttons = []
    for child in clickable_children:
        caption = child['text'].lower().strip().replace('&', '')
        if caption in danger_captions:
            continue
        if caption in nav_names:
            nav_buttons.append(child)
            log.info('  Nav match by caption: "%s"', child['text'])

    # If nav graph has generic "Command*" entries and we have unmatched buttons,
    # try them if they're not dangerous
    if nav_command_targets and not nav_buttons:
        for child in clickable_children:
            caption = child['text'].lower().strip().replace('&', '')
            if caption not in danger_captions:
                nav_buttons.append(child)

    if nav_buttons:
        log.info('--- Phase 3: clicking %d nav-graph buttons ---',
                 len(nav_buttons))

    for child in nav_buttons[:6]:
        log.info('  Clicking nav button: hwnd=%d text="%s"',
                 child['hwnd'], child['text'])
        _xdotool_click_window(child['hwnd'])
        time.sleep(1.5)
        step = _screenshot_new_state(hwnd, step, child['text'], out_dir, frames)

    # Clean up
    log.info('Killing app...')
    proc.kill()
    try:
        proc.wait(timeout=5)
    except subprocess.TimeoutExpired:
        pass
    kill_all_proggies()

    # Assemble GIF
    _assemble_gif(exe_name, frames, out_dir)


def _xdotool_click_window(hwnd):
    """Click the center of a Win32 child control via xdotool.

    Uses GETRECT to get the control's screen coordinates (Wine virtual screen),
    then xdotool to click at those coordinates on the X11 display.
    Wine maps its virtual screen 1:1 to the X11 display.
    """
    r = c2('GETRECT %d' % hwnd)
    if not r:
        log.warning('GETRECT failed for hwnd=%d', hwnd)
        return
    try:
        parts = r.strip().split()
        x, y, w, h = int(parts[0]), int(parts[1]), int(parts[2]), int(parts[3])
        cx = x + w // 2
        cy = y + h // 2
        log.info('  GETRECT: %d,%d %dx%d -> click at %d,%d', x, y, w, h, cx, cy)
        subprocess.run(
            ['xdotool', 'mousemove', '--sync', str(cx), str(cy),
             'click', '1'],
            env={'DISPLAY': DISPLAY}, timeout=5
        )
    except Exception as e:
        log.warning('click failed: %s', e)


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
    """Send a key via xdotool. Finds X11 window by title, falls back to focus."""
    xid = _find_x11_window(hwnd)
    if xid:
        subprocess.run(
            ['xdotool', 'windowactivate', str(xid)],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)
        time.sleep(0.1)
        subprocess.run(
            ['xdotool', 'key', '--window', str(xid), key],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)
    else:
        subprocess.run(
            ['xdotool', 'key', key],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)


def _bruteforce_wmcommand(main_hwnd, step, out_dir, frames, nav_graph,
                          max_id=200):
    """Brute-force WM_COMMAND IDs 1..max_id. Screenshot any new windows.

    VB6 menu item IDs are assigned sequentially by MSVBVM60 at runtime.
    GetMenu() returns 0 cross-process under Wine, but WM_COMMAND still works
    because the VB6 runtime dispatches it internally.

    Returns next step number.
    """
    # Build danger words from nav graph
    danger_words = {'exit', 'quit', 'close', 'end', 'unload', 'terminate',
                    'shutdown', 'kill'}
    if nav_graph:
        for d in nav_graph.get('dangerous', []):
            ctrl = d['control'].lower()
            if ctrl.startswith('mnu'):
                danger_words.add(ctrl[3:].lower())
            danger_words.add(ctrl.lower())

    # Snapshot existing windows before we start
    baseline_vb = set(find_all_vb_windows())
    baseline_dlg = set(c2_find_all('#32770'))

    # Determine main window's class for faster per-iteration checks
    main_cls_r = c2('GETCLASS %d' % main_hwnd)
    main_cls = main_cls_r.strip() if main_cls_r else VB_CLASSES[0]

    discovered = []  # list of (id, title, class)
    consecutive_noop = 0
    seen_hwnds = set(baseline_vb | baseline_dlg)  # track all known windows

    for cmd_id in range(1, max_id + 1):
        # Send WM_COMMAND (0x111 = 273)
        c2_wmcommand(main_hwnd, cmd_id)
        time.sleep(0.8)

        # Check main window alive (fast: single GETCLASS on known hwnd)
        alive_r = c2('GETCLASS %d' % main_hwnd, timeout=3)
        if not alive_r or not alive_r.strip() or alive_r.strip() == '0':
            log.warning('Main window died at WM_COMMAND id=%d (likely exit)',
                        cmd_id)
            return step

        # Check for new windows: main class + #32770 (covers most cases)
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
            if consecutive_noop > 50:
                log.info('50 consecutive no-ops after id=%d, stopping', cmd_id)
                break
            continue

        consecutive_noop = 0
        seen_hwnds.add(new_hwnd)
        title = get_window_title(new_hwnd)
        cls_r = c2('GETCLASS %d' % new_hwnd)
        cls = cls_r.strip() if cls_r else '?'
        log.info('  id=%d -> new window: "%s" (%s)', cmd_id, title, cls)

        # Check if this looks dangerous by title
        title_lower = title.lower() if title else ''
        if any(w in title_lower for w in danger_words):
            log.info('  id=%d title matches danger word, dismissing', cmd_id)
        else:
            # Screenshot it
            safe = re.sub(r'[^\w\-]', '_', title or 'cmd_%d' % cmd_id)[:30]
            shot_path = os.path.join(out_dir, '%02d_menu_%s.bmp' % (step, safe))
            if c2_screenshot(new_hwnd, shot_path):
                if not frames or not _frames_identical(frames[-1], shot_path):
                    frames.append(shot_path)
                    log.info('Frame %d: WM_COMMAND id=%d -> "%s"', step, cmd_id, title)
                    step += 1
                else:
                    os.remove(shot_path)

        discovered.append((cmd_id, title, cls))

        # Dismiss: blast all methods without checking (fast, no c2 round-trips).
        # Sending to a dead/closed window is harmless.
        if cls == '#32770':
            c2('POSTMSG %d 273 2 0' % new_hwnd, timeout=3)  # WM_COMMAND IDCANCEL
            time.sleep(0.3)
        c2('POSTMSG %d 16 0 0' % new_hwnd, timeout=3)  # WM_CLOSE
        time.sleep(0.3)
        _xkey(new_hwnd, 'Escape')
        time.sleep(0.3)

    if discovered:
        log.info('WM_COMMAND scan found %d windows:', len(discovered))
        for cid, t, c in discovered:
            log.info('  id=%d "%s" (%s)', cid, t, c)

    return step


def _walk_menus_keyboard(main_hwnd, step, out_dir, frames, danger_words,
                         max_top=6, max_sub=10):
    """Walk VB6 menus via keyboard: F10, arrows, Enter. Screenshot new forms.

    NOTE: This is unreliable under Wine for VB6 apps. Prefer
    _bruteforce_wmcommand() instead. Kept as fallback.

    Returns next step number.
    """
    # Activate and focus main window via X11
    xid = _find_x11_window(main_hwnd)
    if xid:
        subprocess.run(
            ['xdotool', 'windowactivate', str(xid)],
            env={'DISPLAY': DISPLAY}, timeout=3, capture_output=True)
    time.sleep(0.3)

    # F10 activates the menu bar in VB6 apps
    _xkey(main_hwnd, 'F10')
    time.sleep(0.5)

    # Screenshot with menu bar active (full window, not client, to show menu)
    shot_path = os.path.join(out_dir, '%02d_menubar.bmp' % step)
    if c2_screenshot(main_hwnd, shot_path, client=False):
        if not frames or not _frames_identical(frames[-1], shot_path):
            frames.append(shot_path)
            log.info('Frame %d: menu bar activated', step)
            step += 1
        else:
            os.remove(shot_path)

    # Escape back, then walk each top-level menu
    _xkey(main_hwnd, 'Escape')
    time.sleep(0.2)

    for top_idx in range(max_top):
        # Activate menu bar
        _xkey(main_hwnd, 'F10')
        time.sleep(0.3)

        # Navigate to the Nth top-level menu
        for _ in range(top_idx):
            _xkey(main_hwnd, 'Right')
            time.sleep(0.15)

        # Open this top-level menu (Down arrow)
        _xkey(main_hwnd, 'Down')
        time.sleep(0.3)

        # Check if a popup appeared (VB6 menus create popup windows)
        # If no popup, we've gone past the last menu
        popup = c2_find('#32768')  # Win32 popup menu class
        if not popup:
            # Also check for VB6 internal popup (sometimes no #32768)
            # Try screenshotting — if identical to previous, no menu opened
            _xkey(main_hwnd, 'Escape')
            time.sleep(0.2)
            _xkey(main_hwnd, 'Escape')
            time.sleep(0.2)
            log.info('  Top menu %d: no popup, stopping', top_idx)
            break

        log.info('  Top menu %d: popup found', top_idx)

        # Walk submenu items
        for sub_idx in range(max_sub):
            # Get the menu item text via GETTEXT on the popup
            # (won't work for VB6 internal menus, but try)

            # Press Enter to click the current item
            _xkey(main_hwnd, 'Return')
            time.sleep(1.0)

            # Check if a new window appeared
            new_wins = find_all_vb_windows()
            dlg = c2_find('#32770')
            new_hwnd = None
            for h in new_wins:
                if h != main_hwnd:
                    new_hwnd = h
                    break
            if not new_hwnd and dlg:
                new_hwnd = dlg

            if new_hwnd:
                # Screenshot the new form
                new_title = get_window_title(new_hwnd)
                safe = re.sub(r'[^\w\-]', '_', new_title or 'menu_%d_%d' % (top_idx, sub_idx))[:30]
                shot_path = os.path.join(out_dir, '%02d_%s.bmp' % (step, safe))
                if c2_screenshot(new_hwnd, shot_path):
                    if not frames or not _frames_identical(frames[-1], shot_path):
                        frames.append(shot_path)
                        log.info('Frame %d: menu %d.%d -> "%s"',
                                 step, top_idx, sub_idx, new_title)
                        step += 1
                    else:
                        os.remove(shot_path)

                # Dismiss the new window
                _xkey(new_hwnd, 'Escape')
                time.sleep(0.3)
                still = find_all_vb_windows()
                if new_hwnd in still:
                    _xkey(new_hwnd, 'alt+F4')
                    time.sleep(0.3)

                # Check main window still alive
                main_alive = find_all_vb_windows()
                if main_hwnd not in main_alive:
                    log.warning('Main window died after menu %d.%d', top_idx, sub_idx)
                    return step

                # Re-open the menu to continue walking
                _xkey(main_hwnd, 'F10')
                time.sleep(0.3)
                for _ in range(top_idx):
                    _xkey(main_hwnd, 'Right')
                    time.sleep(0.15)
                _xkey(main_hwnd, 'Down')
                time.sleep(0.3)
                # Navigate back to where we were + 1
                for _ in range(sub_idx + 1):
                    _xkey(main_hwnd, 'Down')
                    time.sleep(0.15)
            else:
                # No new window — might be a toggle, separator, or submenu
                # Check if we're still in a menu
                popup2 = c2_find('#32768')
                if not popup2:
                    # Menu closed — item was a leaf action (no dialog)
                    # Re-open to continue
                    _xkey(main_hwnd, 'F10')
                    time.sleep(0.3)
                    for _ in range(top_idx):
                        _xkey(main_hwnd, 'Right')
                        time.sleep(0.15)
                    _xkey(main_hwnd, 'Down')
                    time.sleep(0.3)
                    for _ in range(sub_idx + 1):
                        _xkey(main_hwnd, 'Down')
                        time.sleep(0.15)
                    popup3 = c2_find('#32768')
                    if not popup3:
                        log.info('  Menu %d: exhausted at item %d', top_idx, sub_idx)
                        break
                else:
                    # Still in menu — move down to next item
                    _xkey(main_hwnd, 'Down')
                    time.sleep(0.15)

        # Close any remaining menu
        _xkey(main_hwnd, 'Escape')
        time.sleep(0.2)
        _xkey(main_hwnd, 'Escape')
        time.sleep(0.2)

    return step


def _cycle_tabs(main_hwnd, step, out_dir, frames, max_tabs=6):
    """Cycle through tab pages via Ctrl+PageDown, screenshot each."""
    for i in range(max_tabs):
        _xkey(main_hwnd, 'ctrl+Next')  # Ctrl+PageDown
        time.sleep(0.8)
        safe = 'tab_%d' % (i + 1)
        shot_path = os.path.join(out_dir, '%02d_%s.bmp' % (step, safe))
        if c2_screenshot(main_hwnd, shot_path):
            if not frames or not _frames_identical(frames[-1], shot_path):
                frames.append(shot_path)
                log.info('Frame %d: tab %d', step, i + 1)
                step += 1
            else:
                os.remove(shot_path)
                log.info('Tab %d: duplicate, stopping tab cycle', i + 1)
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
    """Assemble BMP frames into animated GIF."""
    if len(frames) < 1:
        log.info('No frames to assemble')
        return

    try:
        from PIL import Image
    except ImportError:
        log.error('Pillow not installed, skipping GIF assembly')
        return

    gif_path = os.path.join(out_dir, exe_name + '.gif')
    pil_frames = []
    for f in frames:
        try:
            img = Image.open(f).convert('RGB')
            # Upscale small images
            if img.width < 400:
                scale = max(2, 400 // img.width)
                img = img.resize((img.width * scale, img.height * scale),
                                 Image.NEAREST)
            pil_frames.append(img)
        except Exception as e:
            log.warning('Cannot load %s: %s', f, e)

    if not pil_frames:
        return

    # Normalize all frames to same size as first
    w, h = pil_frames[0].size
    normalized = []
    for img in pil_frames:
        if img.size != (w, h):
            # Center on gray background
            bg = Image.new('RGB', (w, h), (192, 192, 192))
            ox = (w - img.width) // 2
            oy = (h - img.height) // 2
            bg.paste(img, (max(0, ox), max(0, oy)))
            normalized.append(bg)
        else:
            normalized.append(img)

    normalized[0].save(
        gif_path, save_all=True, append_images=normalized[1:],
        duration=2000, loop=0, optimize=True
    )
    log.info('GIF: %s (%d frames, %d KB)',
             gif_path, len(normalized),
             os.path.getsize(gif_path) // 1024)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: poc_walkthrough.py <exe_path>')
        sys.exit(1)
    run_poc(sys.argv[1])
