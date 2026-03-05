#!/usr/bin/env python3
"""Screenshot every proggie in the archive by launching under Wine.

Usage:
    sudo python3 screenshot_proggies.py [--stats] [--dry-run] [--reset-errors]
                                        [--one <exe_path>]

Launches each exe under Wine, finds its VB runtime window via C2,
captures via BitBlt SCREENSHOT command, kills the process.

Saves <name>.screenshot.png next to each exe.
Separate checkpoint from decompile — screenshot_checkpoint.json.

Requires: C2 DLL injected into running VB Decompiler (for SCREENSHOT/FINDWINDOW).
"""
import sys, os, time, json, subprocess, shutil, argparse, logging, re
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
CHECKPOINT_FILE = os.path.join(REPO_ROOT, 'tools/c2/screenshot_checkpoint.json')
LOG_FILE = os.path.join(REPO_ROOT, 'tools/c2/screenshot_proggies.log')

# Separate user/prefix/display from decompile pipeline (wineuser/:99)
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

# VB runtime window classes (VB6, VB5, VB3/4)
VB_CLASSES = [
    'ThunderRT6FormDC', 'ThunderRT6Form', 'ThunderRT6MDIForm',
    'ThunderRT5FormDC', 'ThunderRT5Form',
    'ThunderFormDC', 'ThunderForm',
]

# Skip these — same patterns as batch_decompile
INSTALLER_NAME_RE = re.compile(
    r'(^setup\.exe$|^install\.exe$|setup\.exe$|install\.exe$'
    r'|installer\.exe$|[\b_ -]setup\.exe$)',
    re.IGNORECASE)

INSTALLER_SIGS = [
    b'Nullsoft', b'Inno Setup', b'InstallShield',
    b'WISE', b'Setup Factory',
]

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

# ── FreeProcess ──

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

# ── Window discovery ──

def find_proggie_windows():
    """Find all VB runtime top-level windows that aren't VB Decompiler."""
    found = []
    for cls in VB_CLASSES:
        hwnd = c2(f'FINDWINDOW {cls} *', timeout=3)
        while hwnd and hwnd != '0':
            title = c2(f'GETTEXT {hwnd}', timeout=3) or ''
            if 'VB Decompiler' not in title:
                found.append((hwnd, cls, title))
            hwnd = c2(f'FINDWINDOWEX 0 {hwnd} {cls} *', timeout=3)
    return found

def find_dialog_windows():
    """Find #32770 dialogs that might be InputBox/MsgBox from the proggie."""
    found = []
    for _ in range(5):
        hwnd = c2('FINDWINDOW #32770 *', timeout=3)
        if not hwnd or hwnd == '0':
            break
        title = c2(f'GETTEXT {hwnd}', timeout=3) or ''
        # Skip VB Decompiler's own dialogs
        if any(x in title for x in ['Open EXE', 'Save All', 'VB Decompiler']):
            break
        found.append((hwnd, '#32770', title))
        break  # just get the first one
    return found

# ── Installer detection ──

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
    except:
        pass
    return None

# ── Stage and launch ──

def stage_and_launch(exe_path):
    """Copy exe + sibling files to C:\\progstage, launch, return basename."""
    exe_dir = os.path.dirname(exe_path)
    basename = os.path.basename(exe_path)

    if os.path.exists(STAGE):
        shutil.rmtree(STAGE)
    os.makedirs(STAGE)
    for f in os.listdir(exe_dir):
        src = os.path.join(exe_dir, f)
        if os.path.isfile(src):
            try:
                shutil.copy2(src, os.path.join(STAGE, f))
            except:
                pass
    subprocess.run(['sudo', 'chown', '-R', f'{WINE_USER}:{WINE_USER}', STAGE],
                   capture_output=True)

    proc = subprocess.Popen(
        ['sudo', '-u', WINE_USER, 'env', f'DISPLAY={WINE_DISPLAY}',
         f'WINEPREFIX={WINE_PREFIX}',
         'wine', f'C:\\progstage\\{basename}'],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    return proc, basename

def kill_proggie(basename):
    """Kill the proggie process by name. Only exact PID, never blanket kill."""
    # Truncate to avoid shell issues with unicode filenames
    search = basename[:20] if len(basename) > 20 else basename
    result = subprocess.run(['pgrep', '-u', WINE_USER, '-f', search],
                           capture_output=True, text=True)
    for pid in result.stdout.strip().split('\n'):
        pid = pid.strip()
        if not pid:
            continue
        # Don't kill VB Decompiler or wine infrastructure
        check = subprocess.run(['ps', '-p', pid, '-o', 'args='],
                              capture_output=True, text=True)
        cmdline = check.stdout.strip()
        if any(x in cmdline for x in ['VB Decompiler', 'wineserver', 'services.exe',
                                       'winedevice', 'explorer.exe', 'plugplay',
                                       'svchost', 'inject.exe']):
            continue
        subprocess.run(['sudo', 'kill', pid], capture_output=True)

# ── Screenshot one proggie ──

def screenshot_one(exe_path, output_path):
    """Launch exe, find window, screenshot, kill. Returns (success, detail, extra_shots)."""
    proc, basename = stage_and_launch(exe_path)

    # Poll for VB window to appear
    deadline = time.time() + 12
    windows = []
    dialogs = []
    while time.time() < deadline:
        free_process()
        windows = find_proggie_windows()
        if windows:
            break
        # Check for dialog (InputBox, MsgBox, error)
        dialogs = find_dialog_windows()
        if dialogs:
            # Give it a moment more — main window might appear behind it
            time.sleep(1)
            windows = find_proggie_windows()
            break

    screenshots = []

    # Screenshot any dialog first (splash, inputbox, error — all interesting)
    if dialogs:
        dhwnd, dcls, dtitle = dialogs[0]
        logger.debug(f'  Dialog: hwnd={dhwnd} title="{dtitle}"')
        try: os.remove(BMP_TMP)
        except: pass
        r = c2(f'SCREENSHOT 0 {BMP_TMP}')  # desktop shot to capture dialog in context
        if r and r.startswith('OK'):
            dialog_png = output_path.replace('.screenshot.png', '.dialog.png')
            subprocess.run(['sudo', 'convert', BMP_TMP, dialog_png], capture_output=True)
            if os.path.isfile(dialog_png) and os.path.getsize(dialog_png) > 0:
                screenshots.append(('dialog', dialog_png, dtitle))

    if windows:
        # Screenshot each VB window (some proggies have multiple forms)
        for i, (hwnd, cls, title) in enumerate(windows):
            logger.debug(f'  Window: hwnd={hwnd} class={cls} title="{title}"')
            try: os.remove(BMP_TMP)
            except: pass
            r = c2(f'SCREENSHOT {hwnd} {BMP_TMP}')
            if not r or not r.startswith('OK'):
                continue
            if i == 0:
                png_path = output_path
            else:
                png_path = output_path.replace('.screenshot.png', f'.screenshot_{i}.png')
            subprocess.run(['sudo', 'convert', BMP_TMP, png_path], capture_output=True)
            if os.path.isfile(png_path) and os.path.getsize(png_path) > 0:
                screenshots.append(('window', png_path, title))
    elif not dialogs:
        # No VB window, no dialog — take desktop as fallback
        try: os.remove(BMP_TMP)
        except: pass
        r = c2(f'SCREENSHOT 0 {BMP_TMP}')
        if r and r.startswith('OK'):
            subprocess.run(['sudo', 'convert', BMP_TMP, output_path], capture_output=True)
            if os.path.isfile(output_path) and os.path.getsize(output_path) > 0:
                screenshots.append(('desktop', output_path, 'no window found'))

    kill_proggie(basename)
    time.sleep(0.5)

    if not screenshots:
        return False, 'No screenshot captured', []

    types = [s[0] for s in screenshots]
    titles = [s[2] for s in screenshots]
    detail = f'{len(screenshots)} shots: {",".join(types)}'
    if titles[0]:
        detail += f' title="{titles[0]}"'
    return True, detail, screenshots

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

# ── Stats ──

def _walk_exes():
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if f.lower().endswith('.exe'):
                yield os.path.join(root, f)

def print_stats(ckpt):
    files = ckpt['files']
    total = len(files)
    ok = sum(1 for v in files.values() if v['status'] == 'ok')
    err = sum(1 for v in files.values() if v['status'] == 'error')
    skip = sum(1 for v in files.values() if v['status'] == 'skipped')
    all_count = sum(1 for _ in _walk_exes())

    print(f'\n{"="*60}')
    print(f'Screenshot Checkpoint: {CHECKPOINT_FILE}')
    print(f'{"="*60}')
    print(f'Total exes: {all_count}')
    print(f'Processed:  {total}')
    print(f'  Success:  {ok}')
    print(f'  Errors:   {err}')
    print(f'  Skipped:  {skip}')
    print(f'Remaining:  {all_count - total}')
    print()

    if err > 0:
        by_type = {}
        for path, v in files.items():
            if v['status'] == 'error':
                by_type.setdefault(v['detail'], []).append(path)
        print('Errors by type:')
        for detail, paths in sorted(by_type.items(), key=lambda x: -len(x[1])):
            print(f'  [{len(paths)}] {detail}')
        print()

# ── Main ──

def main():
    parser = argparse.ArgumentParser(description='Screenshot proggies')
    parser.add_argument('--stats', action='store_true')
    parser.add_argument('--reset-errors', action='store_true')
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--one', type=str, help='Screenshot one exe and exit')
    args = parser.parse_args()

    ckpt = load_checkpoint()

    if args.reset_errors:
        removed = sum(1 for v in ckpt['files'].values() if v['status'] == 'error')
        ckpt['files'] = {k: v for k, v in ckpt['files'].items()
                         if v['status'] != 'error'}
        save_checkpoint(ckpt)
        print(f'Cleared {removed} error entries')
        return

    if args.stats:
        print_stats(ckpt)
        return

    setup_logging()

    # Single file mode for testing
    if args.one:
        exe = args.one
        if not os.path.isfile(exe):
            print(f'Not found: {exe}')
            sys.exit(1)
        out = os.path.splitext(exe)[0] + '.screenshot.png'
        print(f'Screenshotting: {exe}')
        ok, detail, shots = screenshot_one(exe, out)
        print(f'  {"OK" if ok else "ERROR"}: {detail}')
        for stype, spath, stitle in shots:
            print(f'  {stype}: {spath}')
        return

    all_exes = list(_walk_exes())
    todo = [e for e in all_exes
            if os.path.relpath(e, REPO_ROOT) not in ckpt['files']]

    logger.info(f'Total: {len(all_exes)}, Already: {len(all_exes)-len(todo)}, Remaining: {len(todo)}')

    if args.dry_run:
        for p in todo[:20]:
            print(f'  {os.path.relpath(p, REPO_ROOT)}')
        if len(todo) > 20:
            print(f'  ... and {len(todo) - 20} more')
        return

    if not todo:
        logger.info('Nothing to do.')
        return

    # Verify C2
    if not c2_healthy():
        logger.error('C2 not responding. Inject c2dll.dll first.')
        sys.exit(1)
    logger.info('C2 OK')

    for i, exe_path in enumerate(todo):
        rel = os.path.relpath(exe_path, REPO_ROOT)
        output_path = os.path.splitext(exe_path)[0] + '.screenshot.png'

        logger.info(f'[{i+1}/{len(todo)}] {rel}')

        # Skip non-PE
        try:
            with open(exe_path, 'rb') as f:
                magic = f.read(2)
            if magic != b'MZ':
                ckpt['files'][rel] = {'status': 'skipped', 'detail': 'Not PE',
                                      'timestamp': datetime.now().isoformat()}
                save_checkpoint(ckpt)
                logger.info('  SKIP (not PE)')
                continue
        except:
            ckpt['files'][rel] = {'status': 'skipped', 'detail': 'Read error',
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt)
            continue

        # Skip installers
        inst = is_installer(exe_path)
        if inst:
            ckpt['files'][rel] = {'status': 'skipped', 'detail': f'installer:{inst}',
                                  'timestamp': datetime.now().isoformat()}
            save_checkpoint(ckpt)
            logger.info(f'  SKIP (installer)')
            continue

        try:
            ok, detail, shots = screenshot_one(exe_path, output_path)
        except Exception as e:
            ok, detail, shots = False, f'Exception: {e}', []
            logger.debug(f'  Exception: {e}', exc_info=True)

        if ok:
            ckpt['files'][rel] = {
                'status': 'ok',
                'detail': detail,
                'screenshots': [os.path.relpath(s[1], REPO_ROOT) for s in shots],
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  OK ({detail})')
        else:
            ckpt['files'][rel] = {
                'status': 'error', 'detail': detail,
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  ERROR: {detail}')

        save_checkpoint(ckpt)

        # Verify C2 still alive every 10 files
        if (i + 1) % 10 == 0 and not c2_healthy():
            logger.error('C2 died. Saving and exiting.')
            save_checkpoint(ckpt)
            sys.exit(1)

    logger.info('Done.')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
