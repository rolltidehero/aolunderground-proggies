#!/usr/bin/env python3
"""Screenshot every proggie: main window, menu views, About dialog, animated GIF.

Usage:
    sudo python3 screenshot_proggies.py [--stats] [--dry-run] [--reset-errors]
                                        [--one <exe_path>]

For each exe:
  1. Launch under Wine on wineshot/:98
  2. Screenshot main window
  3. Click through top-level menu items, screenshot each view
  4. Look for About/Help menu, screenshot it
  5. Combine all frames into animated GIF

Outputs next to each exe:
  <name>.screenshot.png       — main window
  <name>.screenshot_N.png     — additional views
  <name>.about.png            — About dialog (if found)
  <name>.animated.gif         — all frames animated

Auto-recovers Xvfb/:98 and c2host.exe on failure.
Skips 16-bit NE executables.
"""
import sys, os, time, json, subprocess, shutil, argparse, logging, re, struct
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
CHECKPOINT_FILE = os.path.join(REPO_ROOT, 'tools/c2/screenshot_checkpoint.json')
LOG_FILE = os.path.join(REPO_ROOT, 'tools/c2/screenshot_proggies.log')

WINE_USER = 'wineshot'
WINE_UID = 993
WINE_GID = 1005
WINE_DISPLAY = ':98'
WINE_PREFIX = '/home/wineshot/.wine'
C_DRIVE = os.path.join(WINE_PREFIX, 'drive_c')
CMD_FILE = os.path.join(C_DRIVE, 'c2s_cmd.txt')
RES_FILE = os.path.join(C_DRIVE, 'c2s_res.txt')
STAGE = os.path.join(C_DRIVE, 'progstage')
BMP_TMP = os.path.join(C_DRIVE, 'screenshot_tmp.bmp')

MIN_WIDTH = 400
GIF_DELAY = 100  # centiseconds between frames (1 second)
MAX_RECOVERY = 3

VB_CLASSES = [
    'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT6MDIForm',
    'ThunderRT5FormDC', 'ThunderRT5Form',
    'ThunderFormDC', 'ThunderForm',
]

INSTALLER_NAME_RE = re.compile(
    r'(^setup\.exe$|^install\.exe$|setup\.exe$|install\.exe$'
    r'|installer\.exe$|[\b_ -]setup\.exe$)',
    re.IGNORECASE)
INSTALLER_SIGS = [b'Nullsoft', b'Inno Setup', b'InstallShield',
                  b'WISE', b'Setup Factory']

logger = logging.getLogger('screenshot')

def setup_logging():
    logger.setLevel(logging.DEBUG)
    fh = logging.FileHandler(LOG_FILE)
    fh.setLevel(logging.DEBUG)
    fh.setFormatter(logging.Formatter('%(asctime)s %(levelname)s %(message)s'))
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    ch.setFormatter(logging.Formatter('%(message)s'))
    logger.addHandler(fh)
    logger.addHandler(ch)

def free_process():
    for _ in range(100):
        time.sleep(0)

# ── C2 ──

def c2(cmd, timeout=10):
    try: os.remove(RES_FILE)
    except: pass
    with open(CMD_FILE, 'w') as f:
        f.write(cmd + '\n')
    os.chown(CMD_FILE, WINE_UID, WINE_GID)
    deadline = time.time() + timeout
    while time.time() < deadline:
        free_process()
        try:
            with open(RES_FILE) as f:
                return f.read().strip().replace('\r', '')
        except FileNotFoundError:
            pass
    return None

def c2_healthy():
    r = c2('PING', timeout=5)
    return r is not None and ('PONG' in r or 'C2HOST' in r)

# ── Auto-recovery ──

def _pgrep(pattern):
    r = subprocess.run(['pgrep', '-f', pattern], capture_output=True, text=True)
    return [p for p in r.stdout.strip().split('\n') if p.strip()] if r.stdout.strip() else []

def ensure_xvfb():
    if _pgrep('Xvfb.*:98'):
        return True
    logger.info('RECOVERY: Starting Xvfb :98')
    subprocess.Popen(['sudo', 'Xvfb', ':98', '-screen', '0', '1024x768x24', '-ac'],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                     stdin=subprocess.DEVNULL)
    time.sleep(2)
    return bool(_pgrep('Xvfb.*:98'))

def ensure_c2host():
    if c2_healthy():
        return True
    logger.info('RECOVERY: Launching c2host.exe')
    subprocess.Popen(
        ['sudo', '-u', WINE_USER, 'env', f'DISPLAY={WINE_DISPLAY}',
         f'WINEPREFIX={WINE_PREFIX}', 'wine', 'C:\\c2host.exe'],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        stdin=subprocess.DEVNULL)
    deadline = time.time() + 15
    while time.time() < deadline:
        time.sleep(2)
        if c2_healthy():
            return True
    return False

def ensure_environment():
    for attempt in range(MAX_RECOVERY):
        logger.info(f'RECOVERY: Attempt {attempt+1}/{MAX_RECOVERY}')
        if not ensure_xvfb():
            time.sleep(5); continue
        if not ensure_c2host():
            time.sleep(5); continue
        logger.info('RECOVERY: Environment ready')
        return True
    return False

# ── Detection ──

def is_16bit_ne(exe_path):
    try:
        with open(exe_path, 'rb') as f:
            if f.read(2) != b'MZ': return False
            f.seek(0x3C)
            pe_off = struct.unpack('<I', f.read(4))[0]
            f.seek(pe_off)
            return f.read(2) == b'NE'
    except:
        return False

def is_installer(exe_path):
    basename = os.path.basename(exe_path)
    if INSTALLER_NAME_RE.search(basename):
        return f'filename:{basename}'
    try:
        with open(exe_path, 'rb') as f:
            data = f.read(min(os.path.getsize(exe_path), 512 * 1024))
        for sig in INSTALLER_SIGS:
            if sig in data:
                return f'signature:{sig.decode()}'
    except: pass
    return None

# ── Window discovery ──

def find_proggie_windows():
    found = []
    for cls in VB_CLASSES:
        hwnd = c2(f'FINDWINDOW {cls} *', timeout=3)
        while hwnd and hwnd != '0':
            title = c2(f'GETTEXT {hwnd}', timeout=3) or ''
            found.append((hwnd, cls, title))
            hwnd = c2(f'FINDWINDOWEX 0 {hwnd} {cls} *', timeout=3)
    return found

def find_dialog_windows():
    hwnd = c2('FINDWINDOW #32770 *', timeout=3)
    if not hwnd or hwnd == '0': return []
    title = c2(f'GETTEXT {hwnd}', timeout=3) or ''
    if any(x in title for x in ['Open EXE', 'Save All', 'VB Decompiler']):
        return []
    return [(hwnd, '#32770', title)]

def find_any_new_window(known_hwnds):
    """Find any new VB window or dialog not in known set."""
    for cls in VB_CLASSES + ['#32770']:
        hwnd = c2(f'FINDWINDOW {cls} *', timeout=3)
        while hwnd and hwnd != '0':
            if hwnd not in known_hwnds:
                title = c2(f'GETTEXT {hwnd}', timeout=3) or ''
                return hwnd, cls, title
            hwnd = c2(f'FINDWINDOWEX 0 {hwnd} {cls} *', timeout=3)
    return None, None, None

# ── Launch / kill ──

def stage_and_launch(exe_path):
    exe_dir = os.path.dirname(exe_path)
    basename = os.path.basename(exe_path)
    if os.path.exists(STAGE):
        shutil.rmtree(STAGE)
    os.makedirs(STAGE)
    for f in os.listdir(exe_dir):
        src = os.path.join(exe_dir, f)
        if os.path.isfile(src):
            try: shutil.copy2(src, os.path.join(STAGE, f))
            except: pass
    subprocess.run(['sudo', 'chown', '-R', f'{WINE_USER}:{WINE_USER}', STAGE],
                   capture_output=True)
    proc = subprocess.Popen(
        ['sudo', '-u', WINE_USER, 'env', f'DISPLAY={WINE_DISPLAY}',
         f'WINEPREFIX={WINE_PREFIX}', 'wine', f'C:\\progstage\\{basename}'],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return proc, basename

def kill_proggie(basename):
    search = basename[:20] if len(basename) > 20 else basename
    result = subprocess.run(['pgrep', '-u', WINE_USER, '-f', search],
                           capture_output=True, text=True)
    safe = {'wineserver', 'services.exe', 'winedevice', 'explorer.exe',
            'plugplay', 'svchost', 'c2host.exe'}
    for pid in result.stdout.strip().split('\n'):
        pid = pid.strip()
        if not pid: continue
        check = subprocess.run(['ps', '-p', pid, '-o', 'args='],
                              capture_output=True, text=True)
        if any(x in check.stdout for x in safe): continue
        subprocess.run(['sudo', 'kill', pid], capture_output=True)

# ── BMP→PNG ──

def capture_window(hwnd, png_path):
    """Screenshot one window, convert to PNG with upscale. Returns True on success."""
    try: os.remove(BMP_TMP)
    except: pass
    r = c2(f'SCREENSHOT {hwnd} {BMP_TMP}')
    if not r or not r.startswith('OK'):
        return False
    try:
        with open(BMP_TMP, 'rb') as f:
            f.seek(18)
            w = struct.unpack('<i', f.read(4))[0]
    except:
        w = MIN_WIDTH
    if w < MIN_WIDTH and w > 0:
        scale = max(2, (MIN_WIDTH + w - 1) // w) * 100
        subprocess.run(['sudo', 'convert', BMP_TMP, '-filter', 'Point',
                       '-resize', f'{scale}%', png_path], capture_output=True)
    else:
        subprocess.run(['sudo', 'convert', BMP_TMP, png_path], capture_output=True)
    return os.path.isfile(png_path) and os.path.getsize(png_path) > 0

def dismiss_window(hwnd):
    """Close a window via WM_CLOSE."""
    c2(f'POSTMSG {hwnd} 16 0 0', timeout=3)
    free_process()

# ── Menu exploration ──

def get_menu_info(hwnd):
    """Get menu bar handle and item count. Returns (hmenu, count) or (None, 0)."""
    r = c2(f'SENDMSG {hwnd} 0x01E1 0 0', timeout=3)  # MN_GETHMENU — won't work
    # Use GetMenu via a SENDMSG trick — actually we need the C2 to call GetMenu.
    # Our C2 doesn't have a GETMENU command. Use WM_COMMAND brute force instead.
    return None, 0

def explore_menus(main_hwnd, base_path, frame_idx):
    """Discover menu items via ENUMMENUS, click About/Help items, try tab cycling.
    Returns (extra_screenshots, about_shot, next_frame_idx)."""
    screenshots = []
    about_shot = None
    known = {main_hwnd}
    for w in find_proggie_windows():
        known.add(w[0])

    # 1. Try ENUMMENUS for real Win32 menus
    menus = c2(f'ENUMMENUS {main_hwnd}', timeout=5)
    if menus and menus not in ('EMPTY', 'ERR: no menu'):
        for line in menus.split('\n'):
            parts = line.split('|')
            if len(parts) != 3: continue
            top_name, sub_name, cmd_id = parts[0], parts[1], parts[2]
            if not cmd_id.isdigit(): continue
            sub_lower = sub_name.lower().replace('&', '')
            # Screenshot About/Help/Credits
            if any(x in sub_lower for x in ['about', 'credit', 'help', 'info']):
                c2(f'WMCOMMAND {main_hwnd} {cmd_id}', timeout=3)
                time.sleep(0.5)
                new_h, new_c, new_t = find_any_new_window(known)
                if new_h:
                    about_path = base_path.replace('.screenshot.png', '.about.png')
                    if capture_window(new_h, about_path):
                        about_shot = (about_path, f'About: {new_t}')
                    png = base_path.replace('.screenshot.png', f'.screenshot_{frame_idx}.png')
                    if capture_window(new_h, png):
                        screenshots.append((png, f'{sub_name}'))
                        frame_idx += 1
                    dismiss_window(new_h)
                    time.sleep(0.3)
            if frame_idx > 9: break

    # 2. Look for About/Credits buttons in main window children
    children = c2(f'ENUMCHILDREN {main_hwnd}', timeout=5)
    if not about_shot and children:
            for line in children.split('\n'):
                parts = line.split('|')
                if len(parts) < 4: continue
                child_hwnd, child_cls, child_id, child_text = parts[0], parts[1], parts[2], parts[3]
                text_lower = child_text.lower()
                if any(x in text_lower for x in ['about', 'credit', 'help']):
                    if 'Button' in child_cls or 'Command' in child_cls or 'Thunder' in child_cls:
                        c2(f'CLICK {child_hwnd}', timeout=3)
                        time.sleep(0.8)
                        new_h, new_c, new_t = find_any_new_window(known)
                        if new_h:
                            about_path = base_path.replace('.screenshot.png', '.about.png')
                            if capture_window(new_h, about_path):
                                about_shot = (about_path, f'About: {new_t}')
                            png = base_path.replace('.screenshot.png', f'.screenshot_{frame_idx}.png')
                            if capture_window(new_h, png):
                                screenshots.append((png, child_text))
                                frame_idx += 1
                            dismiss_window(new_h)
                            time.sleep(0.3)
                        break

    # 3. Try cycling tabs (SSTab uses TCM_SETCURSEL = 0x130C)
    if children:
        for line in children.split('\n'):
            parts = line.split('|')
            if len(parts) < 2: continue
            child_hwnd, child_cls = parts[0], parts[1]
            if 'Tab' in child_cls or 'SSTab' in child_cls:
                # Try tabs 1-4 (tab 0 is already visible)
                for tab_idx in range(1, 5):
                    c2(f'SENDMSG {child_hwnd} 4876 {tab_idx} 0', timeout=3)  # TCM_SETCURSEL
                    c2(f'SENDMSG {child_hwnd} 4906 {tab_idx} 0', timeout=3)  # TCM_SETCURFOCUS
                    time.sleep(0.5)
                    png = base_path.replace('.screenshot.png', f'.screenshot_{frame_idx}.png')
                    if capture_window(main_hwnd, png):
                        screenshots.append((png, f'tab_{tab_idx}'))
                        frame_idx += 1
                    if frame_idx > 9: break
                # Reset to tab 0
                c2(f'SENDMSG {child_hwnd} 4876 0 0', timeout=3)
                break

    return screenshots, about_shot, frame_idx

# ── Animated GIF ──

def make_animated_gif(png_paths, gif_path):
    """Combine PNGs into an animated GIF with 2s delay per frame."""
    if len(png_paths) < 2:
        return False
    cmd = ['convert', '-delay', str(GIF_DELAY), '-loop', '0']
    cmd.extend(png_paths)
    cmd.append(gif_path)
    r = subprocess.run(cmd, capture_output=True)
    return os.path.isfile(gif_path) and os.path.getsize(gif_path) > 0

# ── Screenshot one proggie ──

def kill_all_proggies():
    """Kill ALL non-infrastructure wineshot processes to clear the desktop."""
    result = subprocess.run(['pgrep', '-u', WINE_USER, '-a'],
                           capture_output=True, text=True)
    safe = {'wineserver', 'services.exe', 'winedevice', 'explorer.exe',
            'plugplay', 'svchost', 'c2host.exe', 'dbus'}
    for line in result.stdout.strip().split('\n'):
        if not line.strip(): continue
        pid = line.split()[0]
        if any(x in line for x in safe): continue
        subprocess.run(['sudo', 'kill', pid], capture_output=True)

def screenshot_one(exe_path, output_path):
    """Full screenshot pipeline. Returns (success, detail, file_list)."""
    # Clean slate — kill any leftover proggies from previous run
    kill_all_proggies()
    time.sleep(0.5)

    proc, basename = stage_and_launch(exe_path)

    # Wait for VB window
    deadline = time.time() + 12
    windows = []
    dialogs = []
    while time.time() < deadline:
        free_process()
        windows = find_proggie_windows()
        if windows: break
        dialogs = find_dialog_windows()
        if dialogs:
            time.sleep(1)
            windows = find_proggie_windows()
            break

    all_pngs = []
    all_files = []
    frame_idx = 0

    # 1. Screenshot dialogs (splash, inputbox)
    if dialogs:
        dhwnd = dialogs[0][0]
        dtitle = dialogs[0][2]
        dialog_png = output_path.replace('.screenshot.png', '.dialog.png')
        if capture_window(dhwnd, dialog_png):
            all_pngs.append(dialog_png)
            all_files.append(('dialog', dialog_png, dtitle))
        dismiss_window(dhwnd)
        time.sleep(0.5)
        # Re-check for main window
        if not windows:
            windows = find_proggie_windows()

    if not windows:
        kill_proggie(basename)
        time.sleep(0.5)
        if all_files:
            return True, f'{len(all_files)} shots (dialog only)', all_files
        return False, 'No window appeared', []

    main_hwnd = windows[0][0]
    main_title = windows[0][2]

    # 2. Screenshot main window
    if capture_window(main_hwnd, output_path):
        all_pngs.append(output_path)
        all_files.append(('main', output_path, main_title))
        frame_idx = 1

    # 3. Screenshot additional VB windows (multi-form apps)
    for i, (hwnd, cls, title) in enumerate(windows[1:], 1):
        png = output_path.replace('.screenshot.png', f'.screenshot_{frame_idx}.png')
        if capture_window(hwnd, png):
            all_pngs.append(png)
            all_files.append(('window', png, title))
            frame_idx += 1
        if frame_idx > 9: break

    # 4. Explore menus — try WM_COMMAND IDs to find views and About
    menu_shots, about_shot, frame_idx = explore_menus(
        main_hwnd, output_path, frame_idx)
    for png, desc in menu_shots:
        all_pngs.append(png)
        all_files.append(('menu', png, desc))
    if about_shot:
        all_files.append(('about', about_shot[0], about_shot[1]))

    # 5. Animated GIF from all frames (need 3+ for it to be worthwhile)
    if len(all_pngs) >= 3:
        gif_path = output_path.replace('.screenshot.png', '.animated.gif')
        if make_animated_gif(all_pngs, gif_path):
            all_files.append(('gif', gif_path, f'{len(all_pngs)} frames'))

    kill_proggie(basename)
    time.sleep(0.5)

    if not all_files:
        return False, 'No screenshots captured', []

    detail = f'{len(all_pngs)} views'
    if about_shot:
        detail += ' +about'
    if any(f[0] == 'gif' for f in all_files):
        detail += ' +gif'
    return True, detail, all_files

# ── Checkpoint ──

def load_checkpoint():
    if os.path.exists(CHECKPOINT_FILE):
        with open(CHECKPOINT_FILE) as f:
            return json.load(f)
    return {'files': {}, 'started': datetime.now().isoformat()}

def save_checkpoint(ckpt):
    ckpt['updated'] = datetime.now().isoformat()
    with open(CHECKPOINT_FILE, 'w') as f:
        json.dump(ckpt, f, indent=2)

def _walk_exes():
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if f.lower().endswith('.exe'):
                yield os.path.join(root, f)

def print_stats(ckpt):
    files = ckpt['files']
    ok = sum(1 for v in files.values() if v['status'] == 'ok')
    err = sum(1 for v in files.values() if v['status'] == 'error')
    skip = sum(1 for v in files.values() if v['status'] == 'skipped')
    all_count = sum(1 for _ in _walk_exes())
    print(f'\n{"="*60}')
    print(f'Total: {all_count}  Processed: {len(files)}  OK: {ok}  Err: {err}  Skip: {skip}  Remaining: {all_count - len(files)}')
    print(f'{"="*60}')
    if err:
        by_type = {}
        for p, v in files.items():
            if v['status'] == 'error':
                by_type.setdefault(v['detail'], []).append(p)
        for detail, paths in sorted(by_type.items(), key=lambda x: -len(x[1])):
            print(f'  [{len(paths)}] {detail}')

# ── Main ──

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--stats', action='store_true')
    parser.add_argument('--reset-errors', action='store_true')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--one', type=str)
    args = parser.parse_args()

    ckpt = load_checkpoint()

    if args.reset_errors:
        removed = sum(1 for v in ckpt['files'].values() if v['status'] == 'error')
        ckpt['files'] = {k: v for k, v in ckpt['files'].items() if v['status'] != 'error'}
        save_checkpoint(ckpt)
        print(f'Cleared {removed} error entries')
        return

    if args.stats:
        print_stats(ckpt)
        return

    setup_logging()

    if args.one:
        if not os.path.isfile(args.one):
            print(f'Not found: {args.one}'); sys.exit(1)
        if not ensure_environment():
            print('Cannot start environment'); sys.exit(1)
        out = os.path.splitext(args.one)[0] + '.screenshot.png'
        ok, detail, files = screenshot_one(args.one, out)
        print(f'{"OK" if ok else "ERROR"}: {detail}')
        for ftype, fpath, fdesc in files:
            print(f'  {ftype}: {fpath}')
        return

    all_exes = list(_walk_exes())
    todo = [e for e in all_exes if os.path.relpath(e, REPO_ROOT) not in ckpt['files']]
    logger.info(f'Total: {len(all_exes)}, Remaining: {len(todo)}')

    if args.dry_run:
        for p in todo[:20]:
            print(f'  {os.path.relpath(p, REPO_ROOT)}')
        if len(todo) > 20: print(f'  ... and {len(todo)-20} more')
        return

    if not todo:
        logger.info('Nothing to do.'); return

    if not ensure_environment():
        logger.error('Cannot start environment'); sys.exit(1)

    for i, exe_path in enumerate(todo):
        rel = os.path.relpath(exe_path, REPO_ROOT)
        output_path = os.path.splitext(exe_path)[0] + '.screenshot.png'
        logger.info(f'[{i+1}/{len(todo)}] {rel}')

        try:
            with open(exe_path, 'rb') as f:
                if f.read(2) != b'MZ':
                    ckpt['files'][rel] = {'status': 'skipped', 'detail': 'Not PE',
                                          'timestamp': datetime.now().isoformat()}
                    save_checkpoint(ckpt); continue
        except:
            ckpt['files'][rel] = {'status': 'skipped', 'detail': 'Read error',
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt); continue

        if is_16bit_ne(exe_path):
            ckpt['files'][rel] = {'status': 'skipped', 'detail': '16-bit NE',
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt); logger.info('  SKIP (16-bit NE)'); continue

        inst = is_installer(exe_path)
        if inst:
            ckpt['files'][rel] = {'status': 'skipped', 'detail': f'installer:{inst}',
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt); continue

        try:
            ok, detail, files = screenshot_one(exe_path, output_path)
        except Exception as e:
            ok, detail, files = False, f'Exception: {e}', []

        if ok:
            ckpt['files'][rel] = {
                'status': 'ok', 'detail': detail,
                'files': [{'type': f[0], 'path': os.path.relpath(f[1], REPO_ROOT),
                           'desc': f[2]} for f in files],
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  OK ({detail})')
        else:
            ckpt['files'][rel] = {'status': 'error', 'detail': detail,
                                  'timestamp': datetime.now().isoformat()}
            logger.info(f'  ERROR: {detail}')

        save_checkpoint(ckpt)

        if (i + 1) % 10 == 0 and not c2_healthy():
            logger.warning('C2 died, recovering...')
            if not ensure_environment():
                logger.error('Recovery failed'); sys.exit(1)

    logger.info('Done.')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
