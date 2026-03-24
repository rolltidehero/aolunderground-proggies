---
inclusion: always
description: Windows API patterns for GUI automation under Wine. Covers DLL injection C2, Delphi-specific workarounds, and AOL proggie techniques. Cross-process WM_SETTEXT DOES NOT WORK under Wine — must use in-process DLL injection.
---

# Win32 API GUI Automation — Mandatory Patterns

## ORIGIN

These patterns are extracted from battle-tested AOL proggie modules (jaguar32.bas,
dos32.bas, Genozi~1.bas) that automated external Windows GUI apps using raw Win32
API calls. They work cross-process, don't require focus, and are proven under Wine.

Additional Delphi-specific patterns derived from:
- bcoder.com: external Delphi menu automation via GetMenu/WM_COMMAND
- delphidabbler.com: common dialog control IDs (edt1, cmb13, IDOK)
- stackoverflow.com: TMenuItem.Command property for WM_COMMAND dispatch
- patorjk.com API Spy tutorial: WindowFromPoint + GetClassName discovery

## ABSOLUTE RULE: DllCall ONLY

**NEVER use AHK high-level wrappers for Delphi apps under Wine.** The following
are BANNED — they are proven failures (diag3, diag4):

- `ControlClick` — FAILS on Delphi TButton under Wine
- `ControlSend` — FAILS
- `Send` — FAILS (unreliable under Wine, especially headless)
- `WinMenuSelectItem` — FAILS (Delphi TMainMenu is not a real Win32 menu)
- `ControlGet` — UNRELIABLE (ClassNN numbering may not match)
- `SendInput` / `SendKeys` — BANNED. Hardware-level input injection is
  non-deterministic, focus-dependent, and violates the core principle of
  targeting specific hWnds. Never use it to work around message delivery
  failures — find the real root cause instead.

**USE ONLY:**
- `DllCall("FindWindow", ...)` / `DllCall("FindWindowEx", ...)`
- `DllCall("SendMessage", ...)` / `DllCall("PostMessage", ...)`
- `DllCall("GetWindowText", ...)` / `DllCall("GetClassName", ...)`
- `DllCall("GetDlgItem", ...)` / `DllCall("SetDlgItemText", ...)`

The ONE exception: `ControlSetText` works on TEdit under Wine (verified diag6).
But prefer `WM_SETTEXT` via DllCall for consistency.

## VERIFIED RESULTS (VB Decompiler Pro v9.8 under Wine 9.0)

| Method | Target | Result |
|--------|--------|--------|
| WM_LBUTTONDOWN/UP to button hWnd | TButton2 (Browse) | **WORKS** |
| BM_CLICK (0x00F5) to button hWnd | TButton2 (Browse) | **WORKS** |
| WM_COMMAND with menu item ID to main hWnd | TMenuItem handlers | **WORKS** |
| WM_SETTEXT cross-process (SendMessageW) | TEdit, Edit | **FAILS** (Wine doesn't marshal) |
| WM_SETTEXT in-process (DLL injection) | TEdit, Edit | **WORKS** |
| WM_COMMAND IDOK to common dialog | #32770 Open/Save | **WORKS** (closes dialog, opens file) |
| PostMessage WM_KEYDOWN Ctrl+O to main hWnd | Main window | FAILS |
| WM_COMMAND BN_CLICKED to main hWnd | TButton2 via parent | FAILS |
| ControlClick (AHK) | TButton1 (Decompile) | FAILS |
| Send/ControlSend keyboard shortcuts | Main window | FAILS |

### VERIFIED RESULTS (VB6 apps under Wine 9.0 via c2host.exe)

| Method | Target | Result |
|--------|--------|--------|
| WM_COMMAND brute-force (PostMessage) | VB6 menu items | **WORKS** — discovered dialogs on Emoghoster 3 (3 dialogs), aimClone (7 dialogs) |
| GetMenu cross-process | VB6 ThunderRT6FormDC | **FAILS** — returns 0 (Wine doesn't expose VB6 menus cross-process) |
| F10/Alt keyboard via xdotool | VB6 menu bar | **FAILS** — no #32768 popup appears |
| FindWindowEx chain enumeration | Multiple VB6 windows | **WORKS** — correctly finds all instances of same class |
| WM_COMMAND IDCANCEL to #32770 | Common dialogs from menus | **WORKS** — dismisses modal dialogs |
| GETCLASS on dead hwnd | Closed VB6 window | **WORKS** — returns empty, reliable death detection |
| enumerate_controls.py (static) | Decompiled source + exe binary | **WORKS** — 1,369 apps, 39,240 controls, 100% match vs nav_graphs (1,225 apps) |
| ENUMCHILDREN + source combined | Windowed + lightweight controls | **WORKS** — runtime finds TextBoxes/Frames source misses; source finds menus runtime misses |

### CRITICAL: Cross-process WM_SETTEXT does NOT work under Wine

Wine does not marshal `WM_SETTEXT` string pointers across process boundaries.
`SendMessageW(hwnd, WM_SETTEXT, 0, (LPARAM)localPtr)` silently fails — the
target receives a null/invalid pointer. This affects ALL controls (TEdit, Edit,
ComboBoxEx32). Verified with both `SendMessageA` and `SendMessageW`, and with
`VirtualAllocEx` + `WriteProcessMemory` (also fails).

**Workaround: DLL injection.** Inject a C2 DLL into the target process via
`CreateRemoteThread` + `LoadLibraryA`. From inside the process, `WM_SETTEXT`
works because the string pointer is in the same address space.

## C2 DLL INJECTION — THE WORKING APPROACH

### Architecture

```
Linux bash                    Wine (wineuser)
  |                              |
  |  write C:\c2_cmd.txt         |
  |----------------------------->|
  |                         c2dll.dll (injected into VB Decompiler)
  |                           poll loop reads cmd, executes Win32 API,
  |  read C:\c2_res.txt          writes result
  |<-----------------------------|
```

### Build (mingw-w64 cross-compile on Linux)

```bash
# C2 DLL — gets injected, runs in-process
i686-w64-mingw32-gcc -shared -O2 -o c2dll.dll c2dll.c -luser32 -lgdi32

# Injector — finds target by process name, injects DLL
i686-w64-mingw32-gcc -O2 -o inject.exe inject.c -luser32
```

### Injection sequence

```bash
# 1. VB Decompiler must already be running
# 2. Deploy files to C:\ drive
sudo cp c2dll.dll inject.exe /home/wineuser/.wine/drive_c/
sudo chown wineuser:nonet /home/wineuser/.wine/drive_c/{c2dll.dll,inject.exe}

# 3. Run injector (same WINEPREFIX, same wineserver)
nohup sudo -u wineuser DISPLAY=:99 wine "C:\inject.exe" < /dev/null > /tmp/inject.log 2>&1 &

# 4. Wait for C2 ready signal
sleep 5; sudo cat /home/wineuser/.wine/drive_c/c2_res.txt
# Should show: C2 INJECTED pid=<same as VB Decompiler>
```

### Sending commands

```bash
# Write command file (use python to control escaping)
sudo python3 -c "
with open('/home/wineuser/.wine/drive_c/c2_cmd.txt','w') as f:
    f.write('SETTEXT 65742 C:\\\\BuddyMax.exe\n')
import os; os.chown('/home/wineuser/.wine/drive_c/c2_cmd.txt', 994, 1005)"
sleep 1; sudo cat /home/wineuser/.wine/drive_c/c2_res.txt
```

### C2 command reference

| Command | Args | Description |
|---------|------|-------------|
| PING | | Returns PONG with PID |
| FINDWINDOW | class title | FindWindowA (* = NULL) |
| FINDWINDOWEX | parent after class title | FindWindowExA (* = NULL) |
| GETTEXT | hwnd | GetWindowTextW (UTF-8 output) |
| GETCLASS | hwnd | GetClassNameW (UTF-8 output) |
| SETTEXT | hwnd text | SendMessageW WM_SETTEXT (in-process, works!) |
| SENDMSG | hwnd msg wp lp | SendMessageA |
| POSTMSG | hwnd msg wp lp | PostMessageA |
| GETDLGITEM | hwnd id | GetDlgItem |
| CLICK | hwnd | PostMessage BM_CLICK |
| LCLICK | hwnd | PostMessage WM_LBUTTONDOWN+UP |
| ENUMCHILDREN | hwnd | EnumChildWindows (hwnd\|class\|ctrlid\|text) |
| WMCOMMAND | hwnd id | PostMessage WM_COMMAND |
| SLEEP | ms | Sleep |
| EXIT | | Terminate C2 thread |

### Proven file-open sequence (BuddyMax.exe test)

```
WMCOMMAND 65696 2                    # File > Open dialog
FINDWINDOW #32770 Open EXE File     # Wait for dialog
ENUMCHILDREN <dlg_hwnd>             # Find Edit control
SETTEXT <edit_hwnd> C:\BuddyMax.exe # Set filename (in-process!)
SENDMSG <dlg_hwnd> 273 1 0          # WM_COMMAND IDOK → opens file
FINDWINDOW TfrmMessageDialog *       # Dismiss "Info" dialog
POSTMSG <info_hwnd> 16 0 0          # WM_CLOSE
```

## CORE PRINCIPLE

1. **Find** the window by class or title → get hWnd
2. **Walk** the child hierarchy with FindWindowEx → get control hWnd
3. **Send** messages directly to the control hWnd (not the parent)

## FreeProcess — The Proggie Yield Pattern (MANDATORY)

Every AOL proggie module (69+ files, 129 call sites) uses `FreeProcess()` instead
of `Sleep` for wait loops. The original VB6 implementation:

```vb
' Identical across jaguar32, dos32, genozide, livid32, kin2000, skybox, etc.
Function FreeProcess()
    Do: DoEvents
        Process = Process + 1
        If Process = 50 Then Exit Do
    Loop
End Function
```

It pumps `DoEvents` 50 times — yields CPU to process pending messages without any
arbitrary delay. No Sleep, no timer. The app stays responsive and reacts instantly
when the target window appears.

**AHK equivalent:**
```ahk
FreeProcess() {
    Loop, 50
        Sleep, -1  ; yield timeslice (like DoEvents), no minimum delay
}
```

`Sleep, -1` yields the current timeslice to other threads without the 10-15ms
minimum that `Sleep, 1` imposes. This is the direct equivalent of `DoEvents`.

## AHK DllCall EQUIVALENTS OF VB6 API CALLS

### Finding Windows

```ahk
; VB6: FindWindow("ClassName", "Title")
hWnd := DllCall("FindWindow", "Str", "ClassName", "Str", "Title", "UInt")

; VB6: FindWindow("ClassName", vbNullString)  — match class only
hWnd := DllCall("FindWindow", "Str", "ClassName", "UInt", 0, "UInt")

; VB6: FindWindowEx(hParent, hAfter, "ChildClass", vbNullString)
hChild := DllCall("FindWindowEx", "UInt", hParent, "UInt", 0, "Str", "ChildClass", "UInt", 0, "UInt")

; FindWindowEx with hAfter — to get the Nth child of same class:
h1 := DllCall("FindWindowEx", "UInt", hParent, "UInt", 0, "Str", "_AOL_Icon", "UInt", 0, "UInt")
h2 := DllCall("FindWindowEx", "UInt", hParent, "UInt", h1, "Str", "_AOL_Icon", "UInt", 0, "UInt")
```

### Clicking Buttons (TWO proven methods)

```ahk
; Method A: WM_LBUTTONDOWN + WM_LBUTTONUP (most reliable for owner-drawn)
DllCall("PostMessage", "UInt", hButton, "UInt", 0x201, "UInt", 0, "UInt", 0)
DllCall("PostMessage", "UInt", hButton, "UInt", 0x202, "UInt", 0, "UInt", 0)

; Method B: BM_CLICK (simpler, also proven on Delphi TButton)
SendMessage, 0x00F5, 0, 0,, ahk_id %hButton%
```

### Setting and Getting Text

```ahk
; WM_SETTEXT — works cross-process on Edit, RichEdit, window captions
DllCall("SendMessageA", "UInt", hEdit, "UInt", 0x0C, "UInt", 0, "Str", "text to set")

; WM_GETTEXTLENGTH then WM_GETTEXT
len := DllCall("SendMessage", "UInt", hWnd, "UInt", 0x0E, "UInt", 0, "UInt", 0)
VarSetCapacity(buf, len + 1)
DllCall("SendMessageA", "UInt", hWnd, "UInt", 0x0D, "UInt", len + 1, "Str", buf)
```

### Waiting for a Window to Appear (FreeProcess poll)

```ahk
; From LiviD32 IMSend — wait for window and all its controls to exist
safeCount := 0
Loop
{
    FreeProcess()
    hTarget := DllCall("FindWindow", "Str", "TargetClass", "Str", "Target Title", "UInt")
    if (hTarget)
        break
    safeCount++
    if (safeCount > 100) {
        FileAppend, ERROR: Target window never appeared`n, C:\log.txt
        ExitApp, 1
    }
}
```

**Key rules from the proggie source:**
1. **Call FreeProcess at the TOP of every wait loop** — yield first, then check
2. **Check ALL required controls exist** before breaking — not just the parent window
3. **Use a safety counter** (LiviD32 ChatFindRoom uses `l <> 100`) to prevent infinite loops
4. **NEVER use `Sleep, 500` or `Sleep, 1000`** — FreeProcess is the yield mechanism
5. **Re-walk the hierarchy each iteration** — handles race conditions where parent
   exists but children aren't created yet

## DELPHI TMainMenu — WM_COMMAND WITH MENU ITEM IDs

### The Problem

Delphi's TMainMenu does NOT use the standard Win32 menu API properly:
- `GetMenu(hWnd)` returns a non-zero value but it's NOT a usable HMENU
- `GetMenuItemCount()` returns -1 on it
- `GetMenuString()` returns garbage
- `WinMenuSelectItem` (AHK) fails completely
- The standard proggie pattern (GetMenu → GetSubMenu → GetMenuItemID → WM_COMMAND)
  does NOT work for Delphi apps

### The Solution

Delphi's TMenuItem has an internal `.Command` property — an integer ID assigned
sequentially at form creation time based on DFM order. When a user clicks a menu
item, Delphi internally dispatches `WM_COMMAND` with that ID to the form.

**From an external process, you can trigger any menu item by sending:**
```ahk
DllCall("PostMessage", "UInt", hMain, "UInt", 0x111, "UInt", menuItemID, "UInt", 0)
```

Source: stackoverflow.com/q/1259906 — "The command item identifier of a TMenuItem
is in the Command property. PostMessage(Handle, WM_COMMAND, MyMenuItem.Command, 0)"

### Discovering Menu Item IDs

Since the standard Win32 menu enumeration API doesn't work on Delphi TMainMenu,
discover IDs by brute force:

```ahk
; Send WM_COMMAND with IDs 1-100, check what happens after each
Loop, 100
{
    id := A_Index
    DllCall("PostMessage", "UInt", hMain, "UInt", 0x111, "UInt", id, "UInt", 0)
    Sleep, 300
    ; Check if a new window appeared
    ; Log the window title and class
    ; Close it and continue
}
```

**IDs are STABLE** — they're determined by DFM order at compile time and never
change between launches. Once discovered, hardcode them.

### VB Decompiler Pro v9.8 — Discovered Menu IDs

| ID | Action | Dialog Title | Dialog Class |
|----|--------|-------------|-------------|
| 2 | File > Open program | "Open EXE File" | #32770 |
| 6 | File > Open Decompiled DataBase | "Open VB Decompiler DataBase" | #32770 |
| 7 | File > Save Decompiled Data As DataBase | "Save VB Decompiler DataBase" | #32770 |
| 8 | File > Save procedures list | "VB Decompiler Procedures List" | #32770 |
| 9 | File > Save all in one module | "Save All To One BAS File" | #32770 |
| **10** | **File > Save decompiled project** | **"Browse for Folder"** | **#32770** |
| 19 | Tools > String references | "String references" | TfrmStrRef |
| 22 | Tools > Search string | "Search string (Decompiler)" | TfrmSearch |
| 25 | Help > About | "VB Decompiler" | #32770 |
| 28 | Help > Help | "VB Decompiler" | HH Parent |
| **60** | **Plugins > Full Data Extractor** | **(calls VBDecompilerPluginLoad)** | **none** |

IDs 3-5, 11 show "Info" dialogs (TfrmMessageDialog). IDs 12-18, 20-21, 23-24,
26-27, 29-30 produce no visible window (likely Options toggles, Exit, etc.).

## WINDOWS COMMON FILE DIALOGS (Open/Save)

### Control IDs (from Windows SDK dlgs.h, confirmed by delphidabbler.com)

Standard Open/Save dialogs (class `#32770`) use these well-known control IDs:

| Symbolic Name | Numeric ID | Description |
|--------------|-----------|-------------|
| edt1 | 0x480 (1152) | Edit control for filename |
| cmb13 | 0x47C (1148) | ComboBox for filename (used instead of edt1 on newer dialogs) |
| cmb1 | 0x470 (1136) | File type filter dropdown |
| cmb2 | 0x471 (1137) | Drive/folder dropdown |
| lst1 | 0x460 (1120) | File list |
| IDOK | 1 | Open/Save button |
| IDCANCEL | 2 | Cancel button |

### Setting the Filename in a Common Dialog

The filename control may be `edt1` (Edit) or `cmb13` (ComboBox with embedded Edit).
On Wine, the Explorer-style dialog nests controls deeper. Use `GetDlgItem` or
`FindWindowEx` recursively:

```ahk
; Method 1: GetDlgItem with known control ID (preferred)
; edt1 = 0x480 = 1152
hEdit := DllCall("GetDlgItem", "UInt", hDialog, "Int", 1152)
if (!hEdit) {
    ; Try cmb13 = 0x47C = 1148, then find Edit inside it
    hCombo := DllCall("GetDlgItem", "UInt", hDialog, "Int", 1148)
    hEdit := DllCall("FindWindowEx", "UInt", hCombo, "UInt", 0, "Str", "Edit", "UInt", 0, "UInt")
}
DllCall("SendMessageA", "UInt", hEdit, "UInt", 0x0C, "UInt", 0, "Str", "C:\file.exe")

; Method 2: Walk the hierarchy looking for Edit class
; Common dialog structure: #32770 > ComboBoxEx32 > ComboBox > Edit
hCBEx := DllCall("FindWindowEx", "UInt", hDialog, "UInt", 0, "Str", "ComboBoxEx32", "UInt", 0, "UInt")
hCB := DllCall("FindWindowEx", "UInt", hCBEx, "UInt", 0, "Str", "ComboBox", "UInt", 0, "UInt")
hEdit := DllCall("FindWindowEx", "UInt", hCB, "UInt", 0, "Str", "Edit", "UInt", 0, "UInt")
DllCall("SendMessageA", "UInt", hEdit, "UInt", 0x0C, "UInt", 0, "Str", "C:\file.exe")

; Click OK (IDOK = 1)
hOK := DllCall("GetDlgItem", "UInt", hDialog, "Int", 1)
DllCall("PostMessage", "UInt", hOK, "UInt", 0x201, "UInt", 0, "UInt", 0)
DllCall("PostMessage", "UInt", hOK, "UInt", 0x202, "UInt", 0, "UInt", 0)
```

### Browse For Folder Dialog

The "Save decompiled project" command opens a Browse For Folder dialog, not a
standard file dialog. This uses `SHBrowseForFolder` internally. The control
hierarchy is different:
- Class: `#32770` (same as file dialog)
- Title: "Browse For Folder" or similar
- Contains a `SysTreeView32` for folder navigation
- Contains an `Edit` control for the path (if `BIF_EDITBOX` flag is set)
- OK button: IDOK (control ID 1)

## WINDOW DISCOVERY (from API Spy / Rampage Toolz)

The API Spy pattern for discovering unknown windows:

```ahk
; GetCursorPos + WindowFromPoint — discover what's under the mouse
; (useful for interactive debugging, not batch automation)
VarSetCapacity(pt, 8, 0)
DllCall("GetCursorPos", "UInt", &pt)
x := NumGet(pt, 0, "Int")
y := NumGet(pt, 4, "Int")
hWnd := DllCall("WindowFromPoint", "Int", x, "Int", y, "UInt")
```

For batch automation, use `EnumChildWindows` with a callback:

```ahk
; RegisterCallback for EnumChildWindows
cb := RegisterCallback("MyEnumProc", "Fast")
DllCall("EnumChildWindows", "UInt", hParent, "UInt", cb, "UInt", 0)

MyEnumProc(hWnd, lParam) {
    VarSetCapacity(cls, 512, 0)
    DllCall("GetClassNameW", "UInt", hWnd, "Ptr", &cls, "Int", 255)
    className := StrGet(&cls, "UTF-16")
    ; ... log it
    return 1  ; continue enumeration
}
```

**IMPORTANT: Use W (Unicode) variants** — `GetClassNameW`, `GetWindowTextW` —
for Delphi apps under Wine. The A (ANSI) variants return garbled text because
Delphi VCL creates Unicode windows.

## DELPHI VCL CONTROL CLASSES

Delphi VCL controls register their own Win32 window classes with T-prefixed names:

| VCL Class | Win32 Window Class | Notes |
|-----------|-------------------|-------|
| TButton | "TButton" | NOT "Button" — use BM_CLICK or WM_LBUTTONDOWN/UP |
| TEdit | "TEdit" | Responds to WM_SETTEXT/WM_GETTEXT |
| TCheckBox | "TCheckBox" | Use BM_SETCHECK (0xF1) / BM_GETCHECK (0xF0) |
| TTreeView | "TTreeView" | Standard TreeView messages work (TVM_*) |
| TListBox | "TListBox" | Standard ListBox messages work (LB_*) |
| TPanel | "TPanel" | Container, no useful messages |
| TPageControl | "TPageControl" | Tab control, use TCM_* messages |
| TTabSheet | "TTabSheet" | Individual tab page |
| TSynEdit | "TSynEdit" | Scintilla-like code editor |
| TStatusBar | "TStatusBar" | Standard StatusBar messages (SB_*) |
| TMainMenu | (no window) | NOT a Win32 window — use WM_COMMAND with IDs |
| TfrmMain | "TfrmMain" | Main form class (app-specific) |

**Key difference from standard Win32:** Delphi buttons are class "TButton" not
"Button". FindWindowEx with "Button" will NOT find Delphi buttons.

## CONSTANTS REFERENCE

```ahk
; Window Messages
WM_CLOSE        := 0x0010
WM_SETTEXT      := 0x000C
WM_GETTEXT      := 0x000D
WM_GETTEXTLENGTH := 0x000E
WM_KEYDOWN      := 0x0100
WM_KEYUP        := 0x0101
WM_CHAR         := 0x0102
WM_COMMAND      := 0x0111
WM_SYSCOMMAND   := 0x0112
WM_LBUTTONDOWN  := 0x0201
WM_LBUTTONUP    := 0x0202

; Button Messages
BM_GETCHECK     := 0x00F0
BM_SETCHECK     := 0x00F1
BM_CLICK        := 0x00F5

; Listbox Messages
LB_SETCURSEL    := 0x0186
LB_GETCURSEL    := 0x0188
LB_GETTEXT      := 0x0189
LB_GETTEXTLEN   := 0x018A
LB_GETCOUNT     := 0x018B

; Common Dialog Control IDs
EDT1            := 1152  ; 0x480 — filename edit
CMB13           := 1148  ; 0x47C — filename combo (newer dialogs)
CMB1            := 1136  ; 0x470 — file type filter
IDOK            := 1
IDCANCEL        := 2

; Virtual Keys
VK_RETURN       := 0x0D
VK_SPACE        := 0x20
```

## MANDATORY RULES

1. **ALWAYS target the control's own hWnd** — never send messages to a parent
   hoping they reach the child.

2. **Use FindWindowEx chains** to walk the child hierarchy. The `hAfter` parameter
   (2nd arg) is how you get the 2nd, 3rd, Nth child of the same class.

3. **For Delphi TButton**: use BM_CLICK or WM_LBUTTONDOWN+WM_LBUTTONUP directly
   to the button hWnd. ControlClick FAILS.

4. **For Delphi TMainMenu**: use `PostMessage(hMain, WM_COMMAND, menuItemID, 0)`.
   GetMenu/GetSubMenu/GetMenuItemID do NOT work. Discover IDs by brute force.

5. **For common file dialogs**: use `GetDlgItem(hDialog, 1152)` for the filename
   edit, or walk `ComboBoxEx32 > ComboBox > Edit`. Use `GetDlgItem(hDialog, 1)`
   for the OK button.

6. **Use Unicode W variants** for Delphi apps: `GetClassNameW`, `GetWindowTextW`.
   ANSI A variants return garbled text.

7. **PostMessage vs SendMessage**: PostMessage for fire-and-forget (clicks, keys).
   SendMessage when you need the return value (GetText, GetCount).

8. **Always verify hWnd != 0** before sending messages.

9. **Poll for windows** with FreeProcess loops, not arbitrary Sleep values.
   Safety counter of ~100 iterations max.

10. **Menu item IDs are stable** — determined by DFM order at compile time.
    Discover once, hardcode forever.
