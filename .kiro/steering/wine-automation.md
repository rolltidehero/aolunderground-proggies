---
inclusion: always
description: Rules for automating Windows GUI apps under Wine headlessly. Prevents blind guessing.
---

# Wine GUI Automation — Mandatory Rules

## CORE PRINCIPLE

**Know every dialog before you run.** Read the source code (or run once manually) to enumerate every window, dialog, and MsgBox the app will produce. Write a deterministic automation script that handles each one by name. Never rely on OCR for control flow.

## TOOL HIERARCHY (use in this order)

1. **AutoHotkey (AHK) inside Wine** — preferred for all dialog interaction. Uses Windows API directly (`WinWait`, `ControlClick`, `Send`). This is what winetricks uses. Install via `winetricks autohotkey` or extract from the AHK setup exe.
2. **xdotool** — fallback only. Known to be unreliable with Wine windows (focus issues, keyboard input problems). Acceptable for simple cases like sending Enter to a known-focused window.
3. **xwd + ImageMagick convert** — for pixel-level verification (e.g., confirming a checkbox state by color). Convert screenshot to text pixel map, grep for specific colors at specific coordinates.
4. **Tesseract OCR on screenshots** — for human-readable logging ONLY. Print what's on screen so the user can follow along over SSH. **NEVER use OCR output to make automation decisions.** OCR is too unreliable on small dialogs and Wine-rendered text.

## BEFORE RUNNING ANY WINE GUI APP

1. **Read the source code** (if available) to find every `MsgBox`, `Show`, `Shell`, dialog, and error path.
2. **List every expected dialog** with: window title, message text, which button to click, and whether it's fatal or informational.
3. **Identify blocking vs non-blocking dialogs** — a MsgBox with `vbInformation` (&H40) is non-fatal; a MsgBox with `vbCritical` (&H10) means something broke.
4. **Check for missing dependencies** — use `objdump -p` or `strings` on the exe to find DLL imports. Verify each exists in the Wine prefix or the app's directory. Fix missing DLLs BEFORE running, not after.
5. **Check for runtime file dependencies** — read the source for `App.Path`, `GetPrivateProfileString`, registry reads, `Dir$()` checks. Ensure all referenced files exist where the app expects them.

## WRITING THE AUTOMATION SCRIPT

### If using AHK (preferred):

```ahk
SetTitleMatchMode, 2
Run, myapp.exe argument

; Handle known dialog #1
WinWait, Dialog Title, expected text
ControlClick, Button1  ; OK / Yes / specific button

; Handle known dialog #2
WinWait, Another Dialog, some text
Send {Enter}

; Wait for app to finish
Process, WaitClose, myapp.exe
```

Key AHK patterns (from winetricks source):
- `WinWait, title, text` — wait for window with matching title and text
- `ControlClick, Button1` — click a specific button by control name
- `Send {Enter}` — send keypress to focused window
- `WinClose, title` — close a window
- `Process, exist, name.exe` — check if process is running
- `Loop { sleep 1000 ; ... }` — poll loop for dynamic dialogs

### If using xdotool (fallback):

```bash
# Wait for window by exact name, then send key
wid=$(xdotool search --sync --name "Exact Window Title")
xdotool windowfocus "$wid" key Return
```

- Always use `--sync` with search to wait for the window
- Always `windowfocus` before sending keys
- Target windows by exact name, not by guessing

## SCREENSHOT + OCR LOGGING (for human observation only)

```bash
# Take screenshot, OCR it, print to console
import -window root -display :99 screenshot.png
tesseract screenshot.png stdout  # print for human to read
```

- Save PNGs for manual inspection / SCP
- Print OCR text to console so user can follow progress over SSH
- **Do NOT parse OCR text to decide what button to press**
- For better OCR on small dialogs: `convert screenshot.png -resize 400% big.png && tesseract big.png stdout`

## HANDLING UNKNOWN DIALOGS

If an unexpected dialog appears:
1. **Screenshot it** and OCR for the log
2. **Get the window title** with `xdotool getwindowname`
3. **Log it clearly** — "UNEXPECTED DIALOG: [title] — manual intervention may be needed"
4. **Do NOT blindly dismiss it** — you might be hiding a real error
5. If the app is stuck, let it time out and report failure

## COMMON WINE + VB6 ISSUES

- **Missing DLLs:** VB6 apps need MSVBVM60.DLL (via `winetricks vb6run`). Check for additional DLLs with `objdump -p` and `strings | grep -i dll`.
- **App.Path dependencies:** VB6 apps using `App.Path` must be run from their own directory. `cd` there before launching Wine.
- **16-bit apps won't run:** Wine on 64-bit Linux has no 16-bit support. If the app shells out to a 16-bit exe, that call will fail. Read the source to know if this happens and whether it's fatal.
- **vb.ini / registry lookups:** Some VB3-era tools read `vb.ini` or registry keys for VB installation paths. If the path isn't critical (trace the code to verify), a dummy file or empty path may suffice. If it IS critical, you need the actual dependency.
- **License dialogs during winetricks:** Some runtime installers (e.g., VB6 SP6) pop license acceptance dialogs even under Xvfb. Use `xdotool` or AHK to accept them.

## MANDATORY VERIFICATION

After any Wine GUI automation run:
1. **Check that expected output files exist** — don't assume success from exit code alone (Wine exit codes are unreliable).
2. **Check the final screenshot** — verify the app reached the expected end state.
3. **Read any log files** the app produced.
4. **If output is missing, check screenshots chronologically** to find where it went wrong.

## References

- [winetricks source (w_ahk_do function)](https://github.com/Winetricks/winetricks/blob/master/src/winetricks) — canonical example of AHK-based Wine automation
- [Endpoint Dev: Automating GUI programs on X11](https://www.endpointdev.com/blog/2022/03/automate-read-screen-interact-gui-x11/) — xwd + convert + xdotool pixel-based approach
- [WineHQ forum: automating dialog boxes](https://forum.winehq.org/viewtopic.php?t=28021) — confirms xdotool unreliability, recommends AHK/AutoIt
- [SuperUser: Run wine totally headless](https://superuser.com/questions/902175/run-wine-totally-headless) — Xvfb setup pattern
