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
    # Response is just the hwnd number (no prefix)
    r = r.strip().split('\n')[0].strip()
    try:
        val = int(r)
        return val if val > 0 else 0
    except ValueError:
        return 0


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


def c2_screenshot(hwnd, path):
    """Screenshot a window, save as BMP. Returns True on success."""
    win_path = 'C:\\screenshots\\' + os.path.basename(path)
    r = c2('SCREENSHOT %d %s' % (hwnd, win_path), timeout=10)
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
    """Find all VB windows currently open."""
    found = []
    for cls in VB_CLASSES:
        hwnd = c2_find(cls)
        if hwnd and hwnd not in found:
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

    # Strategy: try nav graph menu matches first, then click ALL visible
    # CommandButtons that aren't in the danger set

    # Phase 1: Menu-based navigation (from nav graph)
    for nav in nav_graph['navigation']:
        ctrl = nav['from_control']
        target_form = nav['to_form']

        if ctrl.lower() in danger_names:
            log.info('SKIP dangerous: %s', ctrl)
            continue

        if not nav['is_menu']:
            continue

        log.info('--- Menu navigate: %s -> %s ---', ctrl, target_form)

        # Try Win32 menu API first (works for some apps)
        search_name = ctrl.lower()
        if search_name.startswith('mnu'):
            search_name = search_name[3:]

        clicked = False
        for menu_text, menu_id in menu_map.items():
            if search_name in menu_text or menu_text in search_name:
                log.info('  Menu match: "%s" -> id=%d', menu_text, menu_id)
                c2_wmcommand(hwnd, menu_id)
                clicked = True
                break

        if not clicked and menus:
            log.info('  No menu match for %s in Win32 menus', ctrl)
            continue

        if not clicked and not menus:
            # VB6 menus don't use Win32 menu API — try keyboard navigation
            # Press Alt to activate menu bar, then use xdotool to find
            # and click the menu item
            log.info('  No Win32 menus — trying Alt key activation')
            # Focus the main window first
            subprocess.run(
                ['xdotool', 'windowactivate', '--sync', str(hwnd)],
                env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True
            )
            time.sleep(0.3)
            subprocess.run(
                ['xdotool', 'key', 'alt+F10'],
                env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True
            )
            time.sleep(0.5)
            # Screenshot the menu state
            shot_path = os.path.join(out_dir, '%02d_menu_%s.bmp' % (step, search_name))
            if c2_screenshot(hwnd, shot_path):
                frames.append(shot_path)
                log.info('Frame %d: menu activated', step)
                step += 1
            # Press Escape to close menu
            subprocess.run(
                ['xdotool', 'key', 'Escape'],
                env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True
            )
            time.sleep(0.3)
            # Only do this once (screenshot the menu bar open)
            break

        if clicked:
            time.sleep(1.5)
            step = _screenshot_new_state(hwnd, step, target_form, out_dir, frames)

    # Phase 2: Click all visible CommandButtons (brute force)
    # We can't map VB control names to ENUMCHILDREN results because
    # ENUMCHILDREN gives us captions, not VB names. So just click them all.
    clickable_children = [c for c in children
                          if 'CommandButton' in c['class'] and c['text']]

    # Filter out buttons whose text matches dangerous control captions
    # (e.g. "Exit", "Quit", "Close")
    danger_captions = {'exit', 'quit', 'close', 'end', 'x', 'cancel'}
    safe_buttons = [c for c in clickable_children
                    if c['text'].lower().strip().replace('&', '') not in danger_captions]

    if safe_buttons:
        log.info('--- Phase 2: clicking %d safe CommandButtons ---',
                 len(safe_buttons))

    for child in safe_buttons[:8]:  # cap at 8 to avoid infinite loops
        log.info('  Clicking button: hwnd=%d text="%s"',
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
        frames.append(shot_path)
        new_title = get_window_title(shot_hwnd)
        log.info('Frame %d: %s (hwnd=%d title="%s")',
                 step, label, shot_hwnd, new_title)

    # Dismiss if it's a new window
    if shot_hwnd != main_hwnd:
        subprocess.run(
            ['xdotool', 'key', '--window', str(shot_hwnd), 'Escape'],
            env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True
        )
        time.sleep(0.5)
        still = find_all_vb_windows()
        if shot_hwnd in still:
            subprocess.run(
                ['xdotool', 'key', '--window', str(shot_hwnd), 'alt+F4'],
                env={'DISPLAY': DISPLAY}, timeout=5, capture_output=True
            )
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
