#!/usr/bin/env python3
"""Batch decompile all VB5/VB6 executables in the proggies archive.

Usage:
    sudo python3 batch_decompile.py [--stats] [--reset-errors] [--dry-run]
                                    [--report] [--reset-skipped]

Outputs decompiled .bas next to each .exe. Tracks progress in a JSON
checkpoint file so it can be stopped and resumed.

Requires: C2 DLL injected into running VB Decompiler.
"""
import sys, os, time, json, subprocess, argparse, logging, re
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
CHECKPOINT_FILE = os.path.join(REPO_ROOT, 'tools/c2/decompile_checkpoint.json')
LOG_FILE = os.path.join(REPO_ROOT, 'tools/c2/batch_decompile.log')

C_DRIVE = '/home/wineuser/.wine/drive_c'
CMD_FILE = os.path.join(C_DRIVE, 'c2_cmd.txt')
RES_FILE = os.path.join(C_DRIVE, 'c2_res.txt')
STAGING = os.path.join(C_DRIVE, 'vbdec_input.exe')
SAVE_TMP = os.path.join(C_DRIVE, 'vbdec_output.bas')

BREAKGLASS_SECS = 300

INSTALLER_NAME_RE = re.compile(
    r'(^setup\.exe$|^install\.exe$|setup\.exe$|install\.exe$'
    r'|installer\.exe$|[\b_ -]setup\.exe$)',
    re.IGNORECASE)

INSTALLER_SIGS = [
    b'Nullsoft', b'Inno Setup', b'InstallShield',
    b'WISE', b'Setup Factory', b'Installer.SetupType',
]

logger = logging.getLogger('batch_decompile')

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

# ── FreeProcess — the proggie yield pattern ──
# VB6 original: Do: DoEvents: Process=Process+1: If Process=50 Then Exit Do: Loop
# Python equivalent: yield timeslice 100 times with no minimum delay.
# time.sleep(0) yields the GIL + OS timeslice without any minimum wait.

def free_process():
    for _ in range(100):
        time.sleep(0)

# ── C2 comms — all use free_process polling, no arbitrary sleeps ──

def c2(cmd, timeout=10):
    """Send command to C2, poll for response with FreeProcess yield."""
    try: os.remove(RES_FILE)
    except: pass
    with open(CMD_FILE, 'w') as f:
        f.write(cmd + '\n')
    os.chown(CMD_FILE, 994, 1005)
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
    return r is not None and ('PONG' in r or 'INJECTED' in r)

def wait_window(cls, title, timeout=15):
    """Poll for a window to appear using FreeProcess yield."""
    deadline = time.time() + timeout
    while time.time() < deadline:
        free_process()
        r = c2(f'FINDWINDOW {cls} {title}', timeout=3)
        if r and r != '0':
            return r
    return None

def find_edit(dlg_hwnd):
    children = c2(f'ENUMCHILDREN {dlg_hwnd}')
    if not children: return None
    for line in children.split('\n'):
        parts = line.split('|')
        if len(parts) >= 2 and parts[1] == 'Edit':
            return parts[0]
    return None

def dismiss_dialogs():
    for _ in range(10):
        d = c2('FINDWINDOW TfrmMessageDialog *', timeout=3)
        if not d or d == '0': break
        c2(f'POSTMSG {d} 16 0 0')
        free_process()
    for _ in range(5):
        d = c2('FINDWINDOW #32770 *', timeout=3)
        if not d or d == '0': break
        title = c2(f'GETTEXT {d}', timeout=3)
        if title and title not in ('Open EXE File', 'Save All To One BAS File'):
            c2(f'POSTMSG {d} 16 0 0')
            free_process()
        else:
            break

# ── installer detection ──

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

# ── checkpoint ──

def load_checkpoint():
    if os.path.exists(CHECKPOINT_FILE):
        with open(CHECKPOINT_FILE) as f:
            return json.load(f)
    return {'files': {}, 'started': datetime.now().isoformat()}

def save_checkpoint(ckpt):
    ckpt['updated'] = datetime.now().isoformat()
    with open(CHECKPOINT_FILE, 'w') as f:
        json.dump(ckpt, f, indent=2)

# ── decompile one file ──

def decompile_one(exe_path, output_path, hmain):
    """Returns (success: bool, detail: str). All waits use FreeProcess polling."""
    start = time.time()
    dismiss_dialogs()

    subprocess.run(['sudo', 'cp', exe_path, STAGING], check=True,
                   capture_output=True)
    subprocess.run(['sudo', 'chown', 'wineuser:nonet', STAGING], check=True,
                   capture_output=True)

    # Open file dialog
    c2(f'WMCOMMAND {hmain} 2')
    dlg = wait_window('#32770', 'Open EXE File')
    if not dlg:
        return False, 'Open dialog never appeared'

    edit = find_edit(dlg)
    if not edit:
        c2(f'POSTMSG {dlg} 16 0 0')
        return False, 'Edit control not found in Open dialog'

    c2(f'SETTEXT {edit} C:\\vbdec_input.exe')
    free_process()  # yield, not sleep — let SETTEXT land
    c2(f'SENDMSG {dlg} 273 1 0')  # IDOK

    # Poll for info dialog OR tree population — no fixed sleep
    # VB Decompiler shows TfrmMessageDialog after opening, then populates tree
    deadline = time.time() + 30
    dismissed_info = False
    while time.time() < deadline:
        free_process()
        if not dismissed_info:
            d = c2('FINDWINDOW TfrmMessageDialog *', timeout=2)
            if d and d != '0':
                c2(f'POSTMSG {d} 16 0 0')
                dismissed_info = True
                continue
        # Check if tree is populated
        break_out = False
        children = c2(f'ENUMCHILDREN {hmain}', timeout=3)
        if children:
            for line in children.split('\n'):
                parts = line.split('|')
                if len(parts) >= 2 and parts[1] == 'TTreeView':
                    count = c2(f'SENDMSG {parts[0]} 4357 0 0', timeout=3)
                    if count and count != '0':
                        break_out = True
                    break
        if break_out:
            break
        # Also check for info dialog we might have missed
        if not dismissed_info:
            dismiss_dialogs()
            dismissed_info = True

    # Save
    try: os.remove(SAVE_TMP)
    except: pass

    c2(f'WMCOMMAND {hmain} 9')
    sdlg = wait_window('#32770', 'Save All To One BAS File')
    if not sdlg:
        return False, 'Save dialog never appeared'

    sedit = find_edit(sdlg)
    if not sedit:
        c2(f'POSTMSG {sdlg} 16 0 0')
        return False, 'Edit control not found in Save dialog'

    c2(f'SETTEXT {sedit} C:\\vbdec_output.bas')
    free_process()  # yield, let SETTEXT land
    c2(f'SENDMSG {sdlg} 273 1 0')  # IDOK

    # Poll for output file — no fixed sleep
    deadline = time.time() + 15
    while time.time() < deadline:
        free_process()
        if os.path.isfile(SAVE_TMP) and os.path.getsize(SAVE_TMP) > 0:
            break

    dismiss_dialogs()

    if not os.path.isfile(SAVE_TMP):
        return False, 'Output file not created'

    size = os.path.getsize(SAVE_TMP)
    if size == 0:
        os.remove(SAVE_TMP)
        return False, 'Output file is empty'

    os.makedirs(os.path.dirname(output_path) or '.', exist_ok=True)
    subprocess.run(['sudo', 'cp', SAVE_TMP, output_path], check=True,
                   capture_output=True)
    subprocess.run(['sudo', 'rm', '-f', STAGING, SAVE_TMP], check=False,
                   capture_output=True)

    elapsed = time.time() - start
    return True, f'{size} bytes, {elapsed:.1f}s'

# ── stats / report ──

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
    total_bytes = sum(v.get('output_size', 0) for v in files.values()
                      if v['status'] == 'ok')
    all_count = sum(1 for _ in _walk_exes())
    remaining = all_count - total

    print(f'\n{"="*60}')
    print(f'Checkpoint: {CHECKPOINT_FILE}')
    print(f'Started:    {ckpt.get("started", "?")}')
    print(f'Updated:    {ckpt.get("updated", "?")}')
    print(f'{"="*60}')
    print(f'Total exes: {all_count}')
    print(f'Processed:  {total}')
    print(f'  Success:  {ok}')
    print(f'  Errors:   {err}')
    print(f'  Skipped:  {skip}')
    print(f'Remaining:  {remaining}')
    print(f'Output:     {total_bytes:,} bytes ({total_bytes/1024/1024:.1f} MB)')
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

    if skip > 0:
        by_reason = {}
        for path, v in files.items():
            if v['status'] == 'skipped':
                by_reason.setdefault(v.get('detail', '?'), []).append(path)
        print('Skipped by reason:')
        for detail, paths in sorted(by_reason.items(), key=lambda x: -len(x[1])):
            print(f'  [{len(paths)}] {detail}')
        print()

def print_report(ckpt):
    files = ckpt['files']
    print('=== DECOMPILE REPORT ===\n')
    for status, label in [('ok', 'SUCCESS'), ('error', 'ERRORS'), ('skipped', 'SKIPPED')]:
        print(f'--- {label} ---')
        for p in sorted(files):
            v = files[p]
            if v['status'] == status:
                if status == 'ok':
                    print(f'  {p}  ({v.get("output_size",0)} bytes)')
                else:
                    print(f'  {p}: {v.get("detail","")}')
        print()
    print_stats(ckpt)

# ── main ──

def main():
    parser = argparse.ArgumentParser(description='Batch decompile VB executables')
    parser.add_argument('--stats', action='store_true')
    parser.add_argument('--report', action='store_true')
    parser.add_argument('--reset-errors', action='store_true')
    parser.add_argument('--reset-skipped', action='store_true')
    parser.add_argument('--dry-run', action='store_true')
    args = parser.parse_args()

    ckpt = load_checkpoint()

    if args.reset_errors:
        removed = sum(1 for v in ckpt['files'].values() if v['status'] == 'error')
        ckpt['files'] = {k: v for k, v in ckpt['files'].items()
                         if v['status'] != 'error'}
        save_checkpoint(ckpt)
        print(f'Cleared {removed} error entries')
        return

    if args.reset_skipped:
        removed = sum(1 for v in ckpt['files'].values() if v['status'] == 'skipped')
        ckpt['files'] = {k: v for k, v in ckpt['files'].items()
                         if v['status'] != 'skipped'}
        save_checkpoint(ckpt)
        print(f'Cleared {removed} skipped entries')
        return

    if args.report:
        print_report(ckpt)
        return

    if args.stats:
        print_stats(ckpt)
        return

    setup_logging()

    all_exes = list(_walk_exes())
    todo = [e for e in all_exes
            if os.path.relpath(e, REPO_ROOT) not in ckpt['files']]

    logger.info(f'Total .exe files: {len(all_exes)}')
    logger.info(f'Already processed: {len(all_exes) - len(todo)}')
    logger.info(f'Remaining: {len(todo)}')

    if args.dry_run:
        for p in todo[:20]:
            print(f'  {os.path.relpath(p, REPO_ROOT)}')
        if len(todo) > 20:
            print(f'  ... and {len(todo) - 20} more')
        return

    if not todo:
        logger.info('Nothing to do.')
        print_stats(ckpt)
        return

    r = c2('PING')
    if not r or ('PONG' not in r and 'INJECTED' not in r):
        logger.error(f'C2 not responding ({r}). Inject c2dll.dll first.')
        sys.exit(1)

    hmain = c2('FINDWINDOW TfrmMain *')
    if not hmain or hmain == '0':
        logger.error('VB Decompiler main window not found')
        sys.exit(1)

    logger.info(f'C2 OK, hMain={hmain}')

    last_success_time = time.time()

    for i, exe_path in enumerate(todo):
        rel = os.path.relpath(exe_path, REPO_ROOT)
        output_path = os.path.splitext(exe_path)[0] + '.decompiled.bas'

        logger.info(f'[{i+1}/{len(todo)}] {rel} ...')

        # Skip non-PE
        try:
            with open(exe_path, 'rb') as f:
                magic = f.read(2)
            if magic != b'MZ':
                ckpt['files'][rel] = {
                    'status': 'skipped', 'detail': 'Not a PE file',
                    'timestamp': datetime.now().isoformat()
                }
                save_checkpoint(ckpt)
                logger.info(f'  SKIP (not PE)')
                continue
        except PermissionError:
            ckpt['files'][rel] = {
                'status': 'skipped', 'detail': 'Permission denied',
                'timestamp': datetime.now().isoformat()
            }
            save_checkpoint(ckpt)
            logger.info(f'  SKIP (permission)')
            continue

        # Installer detection
        inst = is_installer(exe_path)
        if inst:
            ckpt['files'][rel] = {
                'status': 'skipped', 'detail': f'installer:{inst}',
                'timestamp': datetime.now().isoformat()
            }
            save_checkpoint(ckpt)
            logger.info(f'  SKIP (installer: {inst})')
            continue

        # Breakglass
        if time.time() - last_success_time > BREAKGLASS_SECS:
            logger.error(f'BREAKGLASS: No success in {BREAKGLASS_SECS}s. Exiting.')
            save_checkpoint(ckpt)
            print_stats(ckpt)
            sys.exit(2)

        try:
            success, detail = decompile_one(exe_path, output_path, hmain)
        except Exception as e:
            success = False
            detail = f'Exception: {e}'
            logger.debug(f'  Exception: {e}', exc_info=True)

        if success:
            out_size = os.path.getsize(output_path) if os.path.isfile(output_path) else 0
            ckpt['files'][rel] = {
                'status': 'ok',
                'output': os.path.relpath(output_path, REPO_ROOT),
                'output_size': out_size,
                'detail': detail,
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  OK ({detail})')
            last_success_time = time.time()
        else:
            ckpt['files'][rel] = {
                'status': 'error', 'detail': detail,
                'timestamp': datetime.now().isoformat()
            }
            logger.info(f'  ERROR: {detail}')
            dismiss_dialogs()
            free_process()
            dismiss_dialogs()

            if not c2_healthy():
                logger.error('FATAL: C2 died. Saving and exiting.')
                save_checkpoint(ckpt)
                print_stats(ckpt)
                sys.exit(1)

        save_checkpoint(ckpt)

    logger.info('Batch complete.')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
