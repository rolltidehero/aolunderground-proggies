#!/usr/bin/env python3
"""Decompile a VB5/VB6 executable using VB Decompiler Pro via injected C2 DLL.

Usage: vbdecompile.py <input_exe> <output_bas>

Requires: C2 DLL already injected into running VB Decompiler.
"""
import sys, os, time, shutil, subprocess

C_DRIVE = '/home/wineuser/.wine/drive_c'
CMD_FILE = os.path.join(C_DRIVE, 'c2_cmd.txt')
RES_FILE = os.path.join(C_DRIVE, 'c2_res.txt')

def c2(cmd, timeout=10):
    """Send command to C2, return response string."""
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
    return 'TIMEOUT'

def wait_window(cls, title, timeout=15):
    """Poll for a window to appear, return hwnd."""
    deadline = time.time() + timeout
    while time.time() < deadline:
        r = c2(f'FINDWINDOW {cls} {title}')
        if r and r != '0' and r != 'TIMEOUT':
            return r
        time.sleep(0.3)
    return None

def find_edit(dlg_hwnd):
    """Find the Edit control (filename) inside a common dialog."""
    children = c2(f'ENUMCHILDREN {dlg_hwnd}')
    for line in children.split('\n'):
        parts = line.split('|')
        if len(parts) >= 2 and parts[1] == 'Edit':
            return parts[0]
    return None

def dismiss_dialogs():
    """Dismiss any TfrmMessageDialog popups."""
    for _ in range(5):
        d = c2('FINDWINDOW TfrmMessageDialog *')
        if not d or d == '0':
            break
        c2(f'POSTMSG {d} 16 0 0')
        time.sleep(0.5)

def main():
    if len(sys.argv) != 3:
        print(f'Usage: {sys.argv[0]} <input_exe> <output_bas>')
        sys.exit(1)

    input_exe = os.path.abspath(sys.argv[1])
    output_bas = os.path.abspath(sys.argv[2])

    if not os.path.isfile(input_exe):
        print(f'ERROR: {input_exe} not found')
        sys.exit(1)

    basename = os.path.basename(input_exe)
    staging = os.path.join(C_DRIVE, 'vbdec_input.exe')
    save_tmp = os.path.join(C_DRIVE, 'vbdec_output.bas')

    # Verify C2
    print('Checking C2...')
    r = c2('PING')
    if 'INJECTED' not in r:
        print(f'ERROR: C2 not responding ({r}). Inject c2dll.dll first.')
        sys.exit(1)
    print(f'C2 OK: {r}')

    # Find main window
    hmain = c2('FINDWINDOW TfrmMain *')
    if not hmain or hmain == '0':
        print('ERROR: VB Decompiler main window not found')
        sys.exit(1)
    print(f'hMain={hmain}')

    # Copy input to C: drive
    subprocess.run(['sudo', 'cp', input_exe, staging], check=True)
    subprocess.run(['sudo', 'chown', 'wineuser:nonet', staging], check=True)
    print(f'Staged {basename}')

    # Open file dialog (WM_COMMAND ID=2)
    print('Opening file...')
    c2(f'WMCOMMAND {hmain} 2')

    dlg = wait_window('#32770', 'Open EXE File')
    if not dlg:
        print('ERROR: Open dialog never appeared')
        sys.exit(1)

    # Set filename
    edit = find_edit(dlg)
    if not edit:
        print('ERROR: Edit control not found in Open dialog')
        sys.exit(1)

    c2(f'SETTEXT {edit} C:\\vbdec_input.exe')
    time.sleep(0.3)
    verify = c2(f'GETTEXT {edit}')
    print(f'Filename: {verify}')

    # Click Open (WM_COMMAND IDOK)
    c2(f'SENDMSG {dlg} 273 1 0')
    print('Waiting for decompilation...')

    # Wait + dismiss Info dialog
    time.sleep(3)
    dismiss_dialogs()

    # Poll tree view for items (decompilation complete when count > 0)
    children = c2(f'ENUMCHILDREN {hmain}')
    tree = None
    for line in children.split('\n'):
        parts = line.split('|')
        if len(parts) >= 2 and parts[1] == 'TTreeView':
            tree = parts[0]
            break

    if tree:
        deadline = time.time() + 60
        while time.time() < deadline:
            count = c2(f'SENDMSG {tree} 4357 0 0')  # TVM_GETCOUNT
            if count and count != '0' and count != 'TIMEOUT':
                print(f'Decompiled ({count} tree items)')
                break
            time.sleep(1)
    time.sleep(2)

    # Save all in one module (WM_COMMAND ID=9)
    print('Saving...')
    try: os.remove(save_tmp)
    except: pass

    c2(f'WMCOMMAND {hmain} 9')
    sdlg = wait_window('#32770', 'Save All To One BAS File')
    if not sdlg:
        print('ERROR: Save dialog never appeared')
        sys.exit(1)

    sedit = find_edit(sdlg)
    if not sedit:
        print('ERROR: Edit control not found in Save dialog')
        sys.exit(1)

    c2(f'SETTEXT {sedit} C:\\vbdec_output.bas')
    time.sleep(0.5)
    c2(f'SENDMSG {sdlg} 273 1 0')

    # Wait for output file
    deadline = time.time() + 15
    while time.time() < deadline:
        if os.path.isfile(save_tmp):
            break
        time.sleep(0.5)

    time.sleep(1)
    dismiss_dialogs()

    # Copy output
    if os.path.isfile(save_tmp):
        os.makedirs(os.path.dirname(output_bas) or '.', exist_ok=True)
        subprocess.run(['sudo', 'cp', save_tmp, output_bas], check=True)
        size = os.path.getsize(output_bas)
        print(f'SUCCESS: {output_bas} ({size} bytes)')
        # Cleanup
        subprocess.run(['sudo', 'rm', '-f', staging, save_tmp], check=False)
    else:
        print('ERROR: Output file was not created')
        sys.exit(1)

if __name__ == '__main__':
    main()
