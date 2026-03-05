#!/usr/bin/env python3
"""Batch decompile all VB5/VB6 executables in the proggies archive.

Usage:
    sudo python3 batch_decompile.py [--stats] [--reset-errors] [--dry-run]
                                    [--report] [--reset-skipped]

Outputs decompiled .bas next to each .exe. Tracks progress in a JSON
checkpoint file so it can be stopped and resumed.

Requires: C2 DLL injected into running VB Decompiler.
"""
import sys, os, time, json, subprocess, argparse, hashlib, logging, re
from pathlib import Path
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

BREAKGLASS_SECS = 300  # 5 min with no success = bail

# Installer filename patterns (case-insensitive)
INSTALLER_NAME_RE = re.compile(
    r'(^setup\.exe$|^install\.exe$|setup\.exe$|install\.exe$'
    r'|installer\.exe$|[\b_ -]setup\.exe$)',
    re.IGNORECASE)

# Binary signatures found in installer executables
INSTALLER_SIGS = [
    b'Nullsoft',        # NSIS
    b'Inno Setup',      # InnoSetup
    b'InstallShield',   # InstallShield
    b'WISE',            # Wise Installer
    b'Setup Factory',   # Setup Factory
    b'Installer.SetupType',  # Delphi installer
]

# ── logging ──

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

# ── C2 comms ──

def c2(cmd, timeout=10):
    try: os.remove(RES_FILE)
    except: pass
    with open(CMD_FILE, 'w') as f:
        f.write(cmd + '\n')
    os.chown(CMD_FILE, 994, 1005)
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            with open(RES_FILE) as f:
                return f.read().strip().replace('\r', '')
        except:
            time.sleep(0.15)
    return None

def c2_healthy():
    r = c2('PING', timeout=5)
    return r is not None and ('PONG' in r or 'INJECTED' in r)

def wait_window(cls, title, timeout=15):
    deadline = time.time() + timeout
    while time.time() < deadline:
        r = c2(f'FINDWINDOW {cls} {title}')
        if r and r != '0':
            return r
        time.sleep(0.3)
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
        d = c2('FINDWINDOW TfrmMessageDialog *')
        if not d or d == '0': break
        c2(f'POSTMSG {d} 16 0 0')
        time.sleep(0.3)
    for _ in range(5):
        d = c2('FINDWINDOW #32770 *')
        if not d or d == '0': break
        title = c2(f'GETTEXT {d}')
        if title and title not in ('Open EXE File', 'Save All To One BAS File'):
            c2(f'POSTMSG {d} 16 0 0')
            time.sleep(0.3)
        else:
            break

# ── installer detection ──

def is_installer(exe_path):
    """Check filename patterns and binary signatures."""
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
    """Returns (success: bool, detail: str)."""
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
    time.sleep(0.3)
    c2(f'SENDMSG {dlg} 273 1 0')
    time.sleep(3)
    dismiss_dialogs()

    # Wait for decompilation — poll tree view
    children = c2(f'ENUMCHILDREN {hmain}')
    tree = None
    if children:
        for line in children.split('\n'):
            parts = line.split('|')
            if len(parts) >= 2 and parts[1] == 'TTreeView':
                tree = parts[0]
                break

    if tree:
        deadline = time.time() + 60
        while time.time() < deadline:
            count = c2(f'SENDMSG {tree} 4357 0 0')
            if count and count != '0':
                break
            time.sleep(1)
    else:
        time.sleep(5)

    time.sleep(1)

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
    time.sleep(0.5)
    c2(f'SENDMSG {sdlg} 273 1 0')

    deadline = time.time() + 15
    while time.time() < deadline:
        if os.path.isfile(SAVE_TMP):
            time.sleep(0.5)
            break
        time.sleep(0.5)

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

def print_stats(ckpt):
    files = ckpt['files']
    total = len(files)
    ok = sum(1 for v in files.values() if v['status'] == 'ok')
    err = sum(1 for v in files.values() if v['status'] == 'error')
    skip = sum(1 for v in files.values() if v['status'] == 'skipped')
    total_bytes = sum(v.get('output_size', 0) for v in files.values()
                      if v['status'] == 'ok')

    # Count all exes
    all_count = sum(1 for _ in _walk_exes())

    msg = f"""
{"="*60}
Checkpoint: {CHECKPOINT_FILE}
Started:    {ckpt.get("started", "?")}
Updated:    {ckpt.get("updated", "?")}
{"="*60}
Total exes: {all_count}
Processed:  {total}
  Success:  {ok}
  Errors:   {err}
  Skipped:  {skip}
Remaining:  {all_count - total}
Output:     {total_bytes:,} bytes ({total_bytes/1024/1024:.1f} MB)
Est. time remaining: ~{(all_count - total) * 27 / 3600:.1f} hours
"""
    print(msg)

    if err > 0:
        # Group errors by type
        by_type = {}
        for path, v in files.items():
            if v['status'] == 'error':
                d = v['detail']
                by_type.setdefault(d, []).append(path)
        print('Errors by type:')
        for detail, paths in sorted(by_type.items(), key=lambda x: -len(x[1])):
            print(f'  [{len(paths)}] {detail}')
        print()

    if skip > 0:
        by_reason = {}
        for path, v in files.items():
            if v['status'] == 'skipped':
                d = v.get('detail', '?')
                by_reason.setdefault(d, []).append(path)
        print('Skipped by reason:')
        for detail, paths in sorted(by_reason.items(), key=lambda x: -len(x[1])):
            print(f'  [{len(paths)}] {detail}')
        print()

def print_report(ckpt):
    """Full report to stdout."""
    files = ckpt['files']
    print('=== DECOMPILE REPORT ===\n')

    print('--- SUCCESS ---')
    for p in sorted(files):
        v = files[p]
        if v['status'] == 'ok':
            print(f'  {p}  →  {v.get("output","")}  ({v.get("output_size",0)} bytes)')
    print()

    print('--- ERRORS ---')
    for p in sorted(files):
        v = files[p]
        if v['status'] == 'error':
            print(f'  {p}: {v.get("detail","")}')
    print()

    print('--- SKIPPED ---')
    for p in sorted(files):
        v = files[p]
        if v['status'] == 'skipped':
            print(f'  {p}: {v.get("detail","")}')
    print()

    print_stats(ckpt)

# ── helpers ──

def _walk_exes():
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if f.lower().endswith('.exe'):
                yield os.path.join(root, f)

# ── main ──

def main():
    parser = argparse.ArgumentParser(description='Batch decompile VB executables')
    parser.add_argument('--stats', action='store_true', help='Print stats and exit')
    parser.add_argument('--report', action='store_true', help='Full report')
    parser.add_argument('--reset-errors', action='store_true',
                        help='Clear error entries so they get retried')
    parser.add_argument('--reset-skipped', action='store_true',
                        help='Clear skipped entries so they get retried')
    parser.add_argument('--dry-run', action='store_true',
                        help='List files that would be processed')
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

    # Find all .exe files
    all_exes = list(_walk_exes())

    # Filter to unprocessed
    todo = []
    for exe in all_exes:
        rel = os.path.relpath(exe, REPO_ROOT)
        if rel not in ckpt['files']:
            todo.append(exe)

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

    # Verify C2
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

        # Skip non-PE files
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

        # Breakglass: no success in 5 minutes
        if time.time() - last_success_time > BREAKGLASS_SECS:
            logger.error(f'BREAKGLASS: No successful decompile in {BREAKGLASS_SECS}s. '
                         f'Saving checkpoint and exiting.')
            save_checkpoint(ckpt)
            print_stats(ckpt)
            sys.exit(2)

        try:
            success, detail = decompile_one(exe_path, output_path, hmain)
        except Exception as e:
            success = False
            detail = f'Exception: {e}'
            logger.debug(f'  Exception in decompile_one: {e}', exc_info=True)

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

            # Dismiss any stuck dialogs after error
            dismiss_dialogs()
            time.sleep(1)
            dismiss_dialogs()

            if not c2_healthy():
                logger.error('FATAL: C2 died after error. Saving and exiting.')
                save_checkpoint(ckpt)
                print_stats(ckpt)
                sys.exit(1)

        save_checkpoint(ckpt)

    logger.info('Batch complete.')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
