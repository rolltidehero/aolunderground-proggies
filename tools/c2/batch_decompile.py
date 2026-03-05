#!/usr/bin/env python3
"""Batch decompile all VB5/VB6 executables in the proggies archive.

Usage:
    sudo python3 batch_decompile.py [--stats] [--reset-errors] [--dry-run]

Outputs decompiled .bas next to each .exe. Tracks progress in a JSON
checkpoint file so it can be stopped and resumed.

Requires: C2 DLL injected into running VB Decompiler.
"""
import sys, os, time, json, shutil, subprocess, argparse, hashlib
from pathlib import Path
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
CHECKPOINT_FILE = os.path.join(REPO_ROOT, 'tools/c2/decompile_checkpoint.json')

C_DRIVE = '/home/wineuser/.wine/drive_c'
CMD_FILE = os.path.join(C_DRIVE, 'c2_cmd.txt')
RES_FILE = os.path.join(C_DRIVE, 'c2_res.txt')
STAGING = os.path.join(C_DRIVE, 'vbdec_input.exe')
SAVE_TMP = os.path.join(C_DRIVE, 'vbdec_output.bas')

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
    # Also dismiss any stray #32770 dialogs that aren't the main window
    for _ in range(5):
        d = c2('FINDWINDOW #32770 *')
        if not d or d == '0': break
        title = c2(f'GETTEXT {d}')
        if title and title not in ('Open EXE File', 'Save All To One BAS File'):
            c2(f'POSTMSG {d} 16 0 0')
            time.sleep(0.3)
        else:
            break

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

def file_hash(path):
    h = hashlib.md5()
    with open(path, 'rb') as f:
        for chunk in iter(lambda: f.read(65536), b''):
            h.update(chunk)
    return h.hexdigest()

# ── decompile one file ──

def decompile_one(exe_path, output_path, hmain):
    """Returns (success: bool, detail: str)."""
    start = time.time()

    # Clean up any leftover dialogs from previous run
    dismiss_dialogs()

    # Copy to staging
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

    # Click Open
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

    # Wait for output
    deadline = time.time() + 15
    while time.time() < deadline:
        if os.path.isfile(SAVE_TMP):
            time.sleep(0.5)  # let it finish writing
            break
        time.sleep(0.5)

    dismiss_dialogs()

    if not os.path.isfile(SAVE_TMP):
        return False, 'Output file not created'

    size = os.path.getsize(SAVE_TMP)
    if size == 0:
        os.remove(SAVE_TMP)
        return False, 'Output file is empty'

    # Copy to destination
    os.makedirs(os.path.dirname(output_path) or '.', exist_ok=True)
    subprocess.run(['sudo', 'cp', SAVE_TMP, output_path], check=True,
                   capture_output=True)
    subprocess.run(['sudo', 'rm', '-f', STAGING, SAVE_TMP], check=False,
                   capture_output=True)

    elapsed = time.time() - start
    return True, f'{size} bytes, {elapsed:.1f}s'

# ── stats ──

def print_stats(ckpt):
    files = ckpt['files']
    total = len(files)
    ok = sum(1 for v in files.values() if v['status'] == 'ok')
    err = sum(1 for v in files.values() if v['status'] == 'error')
    skip = sum(1 for v in files.values() if v['status'] == 'skipped')
    total_bytes = sum(v.get('output_size', 0) for v in files.values() if v['status'] == 'ok')

    print(f'\n{"="*60}')
    print(f'Checkpoint: {CHECKPOINT_FILE}')
    print(f'Started:    {ckpt.get("started", "?")}')
    print(f'Updated:    {ckpt.get("updated", "?")}')
    print(f'{"="*60}')
    print(f'Processed:  {total}')
    print(f'  Success:  {ok}')
    print(f'  Errors:   {err}')
    print(f'  Skipped:  {skip}')
    print(f'Output:     {total_bytes:,} bytes ({total_bytes/1024/1024:.1f} MB)')
    print()

    if err > 0:
        print('Errors:')
        for path, v in sorted(files.items()):
            if v['status'] == 'error':
                print(f'  {path}: {v.get("detail", "?")}')
        print()

# ── main ──

def main():
    parser = argparse.ArgumentParser(description='Batch decompile VB executables')
    parser.add_argument('--stats', action='store_true', help='Print stats and exit')
    parser.add_argument('--reset-errors', action='store_true',
                        help='Clear error entries so they get retried')
    parser.add_argument('--dry-run', action='store_true',
                        help='List files that would be processed')
    args = parser.parse_args()

    ckpt = load_checkpoint()

    if args.reset_errors:
        removed = 0
        for path in list(ckpt['files'].keys()):
            if ckpt['files'][path]['status'] == 'error':
                del ckpt['files'][path]
                removed += 1
        save_checkpoint(ckpt)
        print(f'Cleared {removed} error entries')
        return

    if args.stats:
        print_stats(ckpt)
        return

    # Find all .exe files
    all_exes = []
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if f.lower().endswith('.exe'):
                all_exes.append(os.path.join(root, f))

    # Filter to unprocessed
    todo = []
    for exe in all_exes:
        rel = os.path.relpath(exe, REPO_ROOT)
        if rel not in ckpt['files']:
            todo.append(exe)

    print(f'Total .exe files: {len(all_exes)}')
    print(f'Already processed: {len(all_exes) - len(todo)}')
    print(f'Remaining: {len(todo)}')

    if args.dry_run:
        for p in todo[:20]:
            print(f'  {os.path.relpath(p, REPO_ROOT)}')
        if len(todo) > 20:
            print(f'  ... and {len(todo) - 20} more')
        return

    if not todo:
        print('Nothing to do.')
        print_stats(ckpt)
        return

    # Verify C2
    r = c2('PING')
    if not r or 'INJECTED' not in r:
        print(f'ERROR: C2 not responding ({r}). Inject c2dll.dll first.')
        sys.exit(1)

    hmain = c2('FINDWINDOW TfrmMain *')
    if not hmain or hmain == '0':
        print('ERROR: VB Decompiler main window not found')
        sys.exit(1)

    print(f'C2 OK, hMain={hmain}')
    print()

    ok_count = 0
    err_count = 0
    skip_count = 0

    for i, exe_path in enumerate(todo):
        rel = os.path.relpath(exe_path, REPO_ROOT)
        basename = os.path.basename(exe_path)
        output_path = os.path.splitext(exe_path)[0] + '.decompiled.bas'

        print(f'[{i+1}/{len(todo)}] {rel}', end=' ... ', flush=True)

        # Skip non-PE files
        try:
            with open(exe_path, 'rb') as f:
                magic = f.read(2)
            if magic != b'MZ':
                ckpt['files'][rel] = {
                    'status': 'skipped',
                    'detail': 'Not a PE file',
                    'timestamp': datetime.now().isoformat()
                }
                save_checkpoint(ckpt)
                print('SKIP (not PE)')
                skip_count += 1
                continue
        except PermissionError:
            ckpt['files'][rel] = {
                'status': 'skipped',
                'detail': 'Permission denied',
                'timestamp': datetime.now().isoformat()
            }
            save_checkpoint(ckpt)
            print('SKIP (permission)')
            skip_count += 1
            continue

        try:
            success, detail = decompile_one(exe_path, output_path, hmain)
        except Exception as e:
            success = False
            detail = f'Exception: {e}'

        if success:
            out_size = os.path.getsize(output_path) if os.path.isfile(output_path) else 0
            ckpt['files'][rel] = {
                'status': 'ok',
                'output': os.path.relpath(output_path, REPO_ROOT),
                'output_size': out_size,
                'detail': detail,
                'timestamp': datetime.now().isoformat()
            }
            print(f'OK ({detail})')
            ok_count += 1
        else:
            ckpt['files'][rel] = {
                'status': 'error',
                'detail': detail,
                'timestamp': datetime.now().isoformat()
            }
            print(f'ERROR: {detail}')
            err_count += 1

            # Check if C2 is still alive after error
            check = c2('PING')
            if not check or 'INJECTED' not in check:
                print('\nFATAL: C2 died. Saving checkpoint and exiting.')
                save_checkpoint(ckpt)
                print_stats(ckpt)
                sys.exit(1)

        save_checkpoint(ckpt)

    print()
    print(f'Batch complete: {ok_count} ok, {err_count} errors, {skip_count} skipped')
    print_stats(ckpt)

if __name__ == '__main__':
    main()
