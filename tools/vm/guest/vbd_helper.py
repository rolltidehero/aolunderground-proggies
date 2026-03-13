r"""VBD helper — runs in interactive session (lab user) to automate VB Decompiler.
Launched by agent.py handle_decompile via schtasks.
Reads args from C:\Tools\vbd_args.json, writes result to C:\Tools\vbd_result.json.
"""
import ctypes, ctypes.wintypes, time, os, json, subprocess, shutil, sys

u32 = ctypes.windll.user32
WM_COMMAND = 0x0111
WM_SETTEXT = 0x000C
WM_CLOSE = 0x0010
BM_CLICK = 0x00F5
IDOK = 1

ARGS_FILE = r"C:\Tools\vbd_args.json"
RESULT_FILE = r"C:\Tools\vbd_result.json"
LOG_FILE = r"C:\Tools\vbd_helper.log"

def log(msg):
    with open(LOG_FILE, "a") as f:
        f.write(f"{time.time():.1f} {msg}\n")

@ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.wintypes.HWND, ctypes.c_long)
def _dismiss_blockers_cb(hwnd, lp):
    cls = ctypes.create_unicode_buffer(256)
    u32.GetClassNameW(hwnd, cls, 256)
    buf = ctypes.create_unicode_buffer(512)
    u32.GetWindowTextW(hwnd, buf, 512)
    if cls.value == "TfrmSplash":
        log(f"dismiss splash hwnd={hwnd}")
        u32.PostMessageW(hwnd, WM_CLOSE, 0, 0)
    elif cls.value == "#32770" and buf.value and \
         not any(x in buf.value for x in ["Open", "Save", "Browse"]):
        log(f"dismiss #32770 hwnd={hwnd} title={buf.value!r}")
        btn = u32.GetDlgItem(hwnd, IDOK)
        if btn:
            u32.SendMessageW(btn, BM_CLICK, 0, 0)
        else:
            u32.PostMessageW(hwnd, WM_CLOSE, 0, 0)
    elif cls.value == "TfrmMessageDialog":
        log(f"dismiss TfrmMessageDialog hwnd={hwnd}")
        btn = u32.FindWindowExW(hwnd, 0, "TButton", None)
        if btn:
            u32.SendMessageW(btn, BM_CLICK, 0, 0)
        else:
            u32.PostMessageW(hwnd, WM_CLOSE, 0, 0)
    return 1

def dismiss_all():
    """Dismiss all blocking dialogs (splash, #32770, TfrmMessageDialog)."""
    u32.EnumWindows(_dismiss_blockers_cb, 0)

def find_vbd(timeout=60):
    """Find VBD main form (TfrmMain class). Dismiss splash/info dialogs along the way."""
    result = [0]
    @ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.wintypes.HWND, ctypes.c_long)
    def find_main(hwnd, lp):
        cls = ctypes.create_unicode_buffer(256)
        u32.GetClassNameW(hwnd, cls, 256)
        if cls.value == "TfrmMain":
            result[0] = hwnd
            return 0
        return 1

    for i in range(timeout * 2):
        dismiss_all()
        result[0] = 0
        u32.EnumWindows(find_main, 0)
        if result[0]:
            u32.ShowWindow(result[0], 5)  # SW_SHOW
            return result[0]
        time.sleep(0.5)
    return 0

def dismiss_info(n=10):
    """Dismiss TfrmMessageDialog popups."""
    for _ in range(n):
        info = u32.FindWindowW("TfrmMessageDialog", None)
        if not info:
            break
        buf = ctypes.create_unicode_buffer(512)
        u32.GetWindowTextW(info, buf, 512)
        log(f"dismiss info {info} title={buf.value!r}")
        # Show it and bring to front
        u32.ShowWindow(info, 5)
        u32.SetForegroundWindow(info)
        time.sleep(0.2)
        # Try WM_COMMAND IDOK to the dialog (Delphi modal forms respond to this)
        u32.PostMessageW(info, WM_COMMAND, IDOK, 0)
        time.sleep(0.3)
        if not u32.IsWindow(info): continue
        # Try BM_CLICK on TButton
        btn = u32.FindWindowExW(info, 0, "TButton", None)
        if btn:
            u32.PostMessageW(btn, 0x0201, 1, 0)  # WM_LBUTTONDOWN
            time.sleep(0.05)
            u32.PostMessageW(btn, 0x0202, 0, 0)  # WM_LBUTTONUP
            time.sleep(0.3)
            if not u32.IsWindow(info): continue
        # Try WM_CLOSE
        u32.PostMessageW(info, WM_CLOSE, 0, 0)
        time.sleep(0.3)
        if not u32.IsWindow(info): continue
        # Try WM_KEYDOWN Enter (simulate pressing Enter)
        u32.PostMessageW(info, 0x0100, 0x0D, 0)  # WM_KEYDOWN VK_RETURN
        time.sleep(0.05)
        u32.PostMessageW(info, 0x0101, 0x0D, 0)  # WM_KEYUP VK_RETURN
        time.sleep(0.3)

def write_result(status, **kw):
    log(f"result: {status} {kw}")
    with open(RESULT_FILE, "w") as f:
        json.dump({"status": status, **kw}, f)

def kill_vbd():
    subprocess.run(["taskkill", "/f", "/im", "VB Decompiler.exe"],
                    capture_output=True, timeout=5)

def main():
    try: os.remove(LOG_FILE)
    except: pass

    with open(ARGS_FILE) as f:
        args = json.load(f)
    target = args["target"]
    output = args["output"]
    vbd = args["vbd"]
    use_plugin = args.get("use_plugin", True)

    log(f"start target={target} output={output} plugin={use_plugin}")
    os.makedirs(output, exist_ok=True)

    # PRE-FLIGHT: refuse to proceed without plugin DLL
    if use_plugin:
        plugin_dll = os.path.join(os.path.dirname(vbd), "Plugins", "vbd_plugin.dll")
        if not os.path.exists(plugin_dll):
            write_result("error", msg=f"FATAL: plugin DLL not found at {plugin_dll}. "
                         "Deploy vbd_plugin.dll before decompiling.")
            return

    # Clean plugin state
    for pf in [r"C:\plugin_cmd.txt", r"C:\plugin_done.txt", r"C:\plugin_err.txt"]:
        try: os.remove(pf)
        except: pass

    try:
        subprocess.Popen([vbd])
        time.sleep(5)
        hwnd = find_vbd(60)
        log(f"vbd hwnd={hwnd}")
        if not hwnd:
            write_result("error", msg="VBD window not found")
            return

        # Diagnostic: enumerate ALL top-level windows
        all_wins = []
        @ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.wintypes.HWND, ctypes.c_long)
        def enum_top(h, lp):
            buf = ctypes.create_unicode_buffer(512)
            u32.GetWindowTextW(h, buf, 512)
            cls = ctypes.create_unicode_buffer(256)
            u32.GetClassNameW(h, cls, 256)
            vis = u32.IsWindowVisible(h)
            if buf.value or vis:
                all_wins.append(f"  top hwnd={h} cls={cls.value} vis={vis} title={buf.value!r}")
            return 1
        u32.EnumWindows(enum_top, 0)
        log(f"top-level windows ({len(all_wins)}):")
        for w in all_wins:
            log(w)

        dismiss_info()

        # Wait for VBD to finish loading (title changes from "Decompiler is loading...")
        log("waiting for VBD to finish loading")
        for i in range(120):
            buf = ctypes.create_unicode_buffer(512)
            u32.GetWindowTextW(hwnd, buf, 512)
            title = buf.value
            if i < 5 or i % 15 == 0:
                log(f"  load_title[{i}]='{title}'")
            if "loading" not in title.lower() and title:
                log(f"  VBD loaded at i={i}: '{title}'")
                break
            dismiss_info()
            time.sleep(1)

        # File > Open (ID 2)
        log("sending File > Open (WM_COMMAND 2)")
        u32.PostMessageW(hwnd, WM_COMMAND, 2, 0)
        time.sleep(2)

        # Find Open dialog
        dlg = 0
        for _ in range(100):
            dlg = u32.FindWindowW(None, "Open EXE File")
            if not dlg:
                dlg = u32.FindWindowW("#32770", "Open EXE File")
            if dlg: break
            time.sleep(0.1)
        log(f"open dlg={dlg}")
        if not dlg:
            write_result("error", msg="open dialog not found")
            return

        # Set filename — try edt1 (0x480) first, then ComboBoxEx32 chain
        edit = u32.GetDlgItem(dlg, 0x480)
        if not edit:
            cbex = u32.FindWindowExW(dlg, 0, "ComboBoxEx32", None)
            if cbex:
                cb = u32.FindWindowExW(cbex, 0, "ComboBox", None)
                if cb:
                    edit = u32.FindWindowExW(cb, 0, "Edit", None)
        log(f"edit={edit}")
        if not edit:
            # Enumerate dialog children for debugging
            ch_list = []
            @ctypes.WINFUNCTYPE(ctypes.c_int, ctypes.wintypes.HWND, ctypes.c_long)
            def enum_dlg(ch, lp):
                cls = ctypes.create_unicode_buffer(256)
                u32.GetClassNameW(ch, cls, 256)
                cid = u32.GetDlgCtrlID(ch)
                ch_list.append(f"  dlg_child hwnd={ch} cls={cls.value} id={cid}")
                return 1
            u32.EnumChildWindows(dlg, enum_dlg, 0)
            for c in ch_list[:20]:
                log(c)
            write_result("error", msg="edit not found in open dialog")
            return

        target_buf = ctypes.create_unicode_buffer(target)
        # Method 1: CDM_SETCONTROLTEXT to the dialog (proper common dialog API)
        # CDM_SETCONTROLTEXT = WM_USER + 104 = 0x0468
        # wParam = control ID (edt1 = 0x480), lParam = text pointer
        CDM_SETCONTROLTEXT = 0x0468
        ret = u32.SendMessageW(dlg, CDM_SETCONTROLTEXT, 0x480, target_buf)
        log(f"CDM_SETCONTROLTEXT ret={ret}")
        # Also try direct WM_SETTEXT to edit as backup
        ret2 = u32.SendMessageW(edit, WM_SETTEXT, 0, target_buf)
        log(f"WM_SETTEXT ret={ret2}")
        time.sleep(0.5)

        # Verify text was set
        verify_buf = ctypes.create_unicode_buffer(1024)
        u32.SendMessageW(edit, 0x000D, 1024, verify_buf)  # WM_GETTEXT
        log(f"edit text after set: {verify_buf.value!r}")
        time.sleep(0.5)

        # Click OK (IDOK = 1)
        ok = u32.GetDlgItem(dlg, IDOK)
        log(f"ok={ok}")
        if ok:
            u32.SendMessageW(ok, BM_CLICK, 0, 0)
        else:
            u32.SendMessageW(dlg, WM_COMMAND, IDOK, 0)
        time.sleep(2)

        # Verify Open dialog closed
        still = u32.IsWindow(dlg)
        log(f"open dialog still alive after OK: {still}")
        if still:
            # Dialog didn't close — try WM_COMMAND IDOK to dialog
            log("retrying with WM_COMMAND IDOK to dialog")
            u32.SendMessageW(dlg, WM_COMMAND, IDOK, 0)
            time.sleep(2)
            still2 = u32.IsWindow(dlg)
            log(f"open dialog still alive after WM_COMMAND: {still2}")

        dismiss_info(3)

        # Wait for decompilation — check status bar for "Decompiled"
        log("waiting for decompile to finish")
        found = False
        for i in range(300):
            sb = u32.FindWindowExW(hwnd, 0, "TStatusBar", None)
            if sb:
                buf = ctypes.create_unicode_buffer(512)
                u32.SendMessageW(sb, 0x000D, 512, buf)  # WM_GETTEXT
                sbtxt = buf.value
                if i < 5 or i % 15 == 0:
                    log(f"  status[{i}]='{sbtxt}'")
                if "Decompiled" in sbtxt:
                    log(f"  decompile done at i={i}")
                    found = True
                    break
            else:
                if i < 5 or i % 30 == 0:
                    log(f"  no statusbar at i={i}")
            dismiss_all()
            time.sleep(1)
        if not found:
            write_result("error", msg="decompile timeout - status never showed Decompiled")
            return

        if use_plugin:
            # Activate plugin (ID 60) — must be done AFTER file is loaded
            # Use SendMessage (synchronous) to ensure it completes
            log("activating plugin (post-decompile)")
            ret = u32.SendMessageW(hwnd, WM_COMMAND, 60, 0)
            log(f"plugin activate ret={ret}")
            time.sleep(3)

            # Check if plugin_done.txt already appeared (plugin may auto-extract)
            if os.path.exists(r"C:\plugin_done.txt"):
                log("plugin already done (auto-triggered)")
            else:
                # Trigger extraction via plugin cmd file
                log("writing plugin cmd")
                with open(r"C:\plugin_cmd.txt", "w") as f:
                    f.write("GO")
                time.sleep(1)

            # Wait for done
            for i in range(120):
                if os.path.exists(r"C:\plugin_done.txt"):
                    log(f"plugin done at i={i}")
                    break
                if os.path.exists(r"C:\plugin_err.txt"):
                    with open(r"C:\plugin_err.txt") as f:
                        err = f.read()
                    write_result("error", msg=f"plugin: {err}")
                    return
                time.sleep(1)
            else:
                write_result("error", msg="plugin timeout")
                return

            # Copy plugin output
            with open(r"C:\plugin_done.txt", encoding="utf-8-sig") as f:
                exename = f.read().strip()
            plugin_out = os.path.join(r"C:\output", exename)
            log(f"plugin output: {plugin_out}")

            if os.path.isdir(plugin_out):
                for root, dirs, files in os.walk(plugin_out):
                    rel = os.path.relpath(root, plugin_out)
                    dest = os.path.join(output, rel) if rel != "." else output
                    os.makedirs(dest, exist_ok=True)
                    for fn in files:
                        shutil.copy2(os.path.join(root, fn), os.path.join(dest, fn))
                shutil.rmtree(plugin_out, ignore_errors=True)
        else:
            # Old flow: Save project (ID 10)
            u32.PostMessageW(hwnd, WM_COMMAND, 10, 0)
            time.sleep(2)
            browse = 0
            for _ in range(100):
                browse = u32.FindWindowW(None, "Browse For Folder")
                if browse: break
                browse = u32.FindWindowW("#32770", "Browse For Folder")
                if browse: break
                time.sleep(0.1)
            if browse:
                bedit = u32.FindWindowExW(browse, 0, "Edit", None)
                if bedit:
                    u32.SendMessageW(bedit, WM_SETTEXT, 0, ctypes.create_unicode_buffer(output))
                    time.sleep(0.5)
                bok = u32.GetDlgItem(browse, IDOK)
                if bok:
                    u32.SendMessageW(bok, BM_CLICK, 0, 0)
                time.sleep(3)
            dismiss_info(3)

        # Close VBD
        u32.PostMessageW(hwnd, WM_CLOSE, 0, 0)
        time.sleep(2)
        kill_vbd()

        # Count output files
        files_out = []
        for root, dirs, files in os.walk(output):
            for fn in files:
                files_out.append(os.path.relpath(os.path.join(root, fn), output))

        # POST-DECOMPILE VALIDATION: check VBP form count == .frm file count
        vbp_path = os.path.join(output, "Project.vbp")
        if os.path.exists(vbp_path):
            import re as _re
            vbp_text = open(vbp_path, errors='replace').read()
            vbp_forms = set(_re.findall(r'^Form=(\S+\.frm)', vbp_text, _re.MULTILINE))
            frm_files = set()
            for fn in files_out:
                if fn.endswith('.frm'):
                    frm_files.add(os.path.basename(fn))
            missing = sorted(vbp_forms - frm_files)
            if missing:
                log(f"VALIDATION FAIL: {len(missing)}/{len(vbp_forms)} forms missing: {missing[:10]}")
                write_result("error", msg=f"Incomplete: {len(missing)}/{len(vbp_forms)} forms missing",
                             files=files_out, count=len(files_out), missing_forms=missing)
                return

        write_result("ok", files=files_out, count=len(files_out))

    except Exception as e:
        log(f"exception: {e}")
        write_result("error", msg=str(e))
        kill_vbd()

if __name__ == "__main__":
    main()
