#!/usr/bin/env python3
"""Capture AOHell 95 screenshots via QMP clicks + screendump.

AOHell is VB3 16-bit under NTVDM. Window classes: ThunderForm, ThunderRTMain.
VB3 child forms dismiss with Enter (hits default button).
Must bring main form to foreground before each button click.

Prerequisites: AOHell main menu form visible (run schtask 'aohell' first).
"""
import sys, time, subprocess, logging
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from capture_walkthrough import (
    QMP, _qga_write_file, _gui_launch, _free_process, _qga_read_file,
    REPO, SCREEN_W, SCREEN_H,
)

logging.basicConfig(level=logging.INFO, format='%(message)s')
log = logging.getLogger(__name__)

ZIP_STEM = 'aohell 95 for aol 2.5-3.0'
OUT_DIR = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / '2.5' / ZIP_STEM

# Buttons from AOHELL.FRM: (name, px_left, px_top, screen_name)
BUTTONS = [
    ('About',    0,   0, 'screen_about'),
    ('Fisher',  288,  0, 'screen_fisher'),
    ('Encrypt',  48, 16, 'screen_encrypt'),
    ('Options', 288, 16, 'screen_options'),
    ('ELiTE',    48, 32, 'screen_elite'),
    ('Annoy',   192, 32, 'screen_annoy'),
    ('Mass M.', 336, 32, 'screen_mass_mail'),
    ('Punt',    528, 32, 'screen_punt'),
    ('Mail B.', 192, 16, 'screen_mail_bomb'),
    ('IMs',     336,  0, 'screen_ims'),
    ('Bust In', 192,  0, 'screen_bust_in'),
    ('IRC',     480,  0, 'screen_irc'),
]

PPM = '/tmp/vm-screen.ppm'
MAIN_HWND = None  # Set dynamically


def take_screenshot(out_path):
    QMP.screenshot(PPM)
    time.sleep(0.2)
    subprocess.run(['convert', PPM, str(out_path)], capture_output=True, check=True)


def deploy_helper():
    """Deploy guest-side helper that finds AOHell and brings it to front."""
    script = (
        "import ctypes, sys\n"
        "u=ctypes.windll.user32\n"
        "CB=ctypes.WINFUNCTYPE(ctypes.c_int,ctypes.c_void_p,ctypes.c_void_p)\n"
        "SW_HIDE=0;SW_SHOW=5\n"
        "class POINT(ctypes.Structure):\n"
        "    _fields_=[('x',ctypes.c_long),('y',ctypes.c_long)]\n"
        "action=sys.argv[1]\n"
        "outfile=sys.argv[2]\n"
        "# Find main form\n"
        "main=[]\n"
        "def fp(h,l):\n"
        "    c=ctypes.create_unicode_buffer(256);u.GetClassNameW(h,c,256)\n"
        "    b=ctypes.create_unicode_buffer(256);u.GetWindowTextW(h,b,256)\n"
        "    if c.value=='ThunderForm' and 'Beta 5' in b.value: main.append(int(h))\n"
        "    return 1\n"
        "u.EnumWindows(CB(fp),0)\n"
        "if not main:\n"
        "    open(outfile,'w').write('ERROR');sys.exit(1)\n"
        "h=main[0]\n"
        "if action=='find':\n"
        "    p=POINT(0,0);u.ClientToScreen(h,ctypes.byref(p))\n"
        "    open(outfile,'w').write(f'{h},{p.x},{p.y}')\n"
        "elif action=='front':\n"
        "    u.ShowWindow(h,SW_SHOW);u.SetForegroundWindow(h);u.BringWindowToTop(h)\n"
        "    open(outfile,'w').write('OK')\n"
        "elif action=='hide_children':\n"
        "    others=[]\n"
        "    def fp2(h2,l):\n"
        "        c2=ctypes.create_unicode_buffer(256);u.GetClassNameW(h2,c2,256)\n"
        "        if c2.value=='ThunderForm' and int(h2)!=h and u.IsWindowVisible(h2):\n"
        "            u.ShowWindow(int(h2),SW_HIDE)\n"
        "            others.append(int(h2))\n"
        "        return 1\n"
        "    u.EnumWindows(CB(fp2),0)\n"
        "    # Re-show main form (AOHell hides it when opening child)\n"
        "    u.ShowWindow(h,SW_SHOW);u.SetForegroundWindow(h);u.BringWindowToTop(h)\n"
        "    open(outfile,'w').write(f'HID {len(others)}')\n"
    )
    _qga_write_file(r'C:\work\aoh_helper.py', script.encode())


_helper_seq = 0

def run_helper(action):
    """Run helper and return output. Uses unique filename per call."""
    global _helper_seq
    _helper_seq += 1
    outfile = rf'C:\work\aoh_out_{_helper_seq}.txt'
    # Patch the helper to write to this unique file
    _gui_launch(f'cmd.exe /c "C:\\Program Files\\Python313-32\\python.exe" C:\\work\\aoh_helper.py {action} {outfile}')
    for _ in range(80):
        _free_process(50)
        try:
            data = _qga_read_file(outfile)
            if data and data != 'ERROR':
                return data.strip()
        except Exception:
            pass
    return None


def bring_to_front():
    run_helper('front')
    time.sleep(0.5)


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    log.info('Deploying helper...')
    deploy_helper()

    log.info('Finding AOHell main form...')
    info = run_helper('find')
    if not info:
        log.error('AOHell not found!')
        sys.exit(1)
    parts = info.split(',')
    hwnd, cx, cy = int(parts[0]), int(parts[1]), int(parts[2])
    log.info(f'  hwnd={hwnd} client=({cx},{cy})')

    # Main form screenshot
    bring_to_front()
    log.info('Capturing main form...')
    take_screenshot(OUT_DIR / 'main_form.png')
    frames = [OUT_DIR / 'main_form.png']

    for name, bx, by, screen_name in BUTTONS:
        log.info(f'  {name} -> {screen_name}')

        # Bring to front before clicking
        bring_to_front()

        # Click button center (each button ~48x16)
        QMP.click(cx + bx + 24, cy + by + 8)
        time.sleep(2)

        # Screenshot
        path = OUT_DIR / f'{screen_name}.png'
        take_screenshot(path)
        frames.append(path)

        # Dismiss: hide child forms, bring main to front
        run_helper('hide_children')
        time.sleep(0.3)

    # Animated GIF
    gif_path = OUT_DIR / 'animated.gif'
    cmd = ['convert', '-delay', '200', '-loop', '0'] + [str(f) for f in frames] + [str(gif_path)]
    subprocess.run(cmd, capture_output=True, check=True)
    log.info(f'Built animated.gif ({len(frames)} frames)')
    log.info(f'Done! {OUT_DIR}')


if __name__ == '__main__':
    main()
