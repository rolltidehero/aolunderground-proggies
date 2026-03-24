---
inclusion: always
description: AutoHotkey v1.1 syntax rules and mandatory patterns for Wine GUI automation. Prevents guessing at AHK commands.
---

# AutoHotkey v1.1 — Mandatory Syntax Reference

## VERSION

These rules apply to **AutoHotkey v1.1 (Unicode 32-bit)** running under Wine.
AHK v2 has completely different syntax — do NOT mix them.

## ABSOLUTE RULES

1. **NEVER guess at control names (ClassNN).** Use Window Spy or `WinGetText`
   to enumerate controls before writing automation. If you cannot run Window
   Spy, use `ControlGetFocus` and `WinGetText` in a diagnostic script first.
2. **NEVER use bare `Send` for menu access.** Use `WinMenuSelectItem` instead —
   it invokes menu items directly by name without focus/timing issues.
3. **NEVER use `Send` to type file paths.** Use `ControlSetText` to set text
   directly into an Edit control, or `Control, EditPaste` to insert at caret.
4. **ALWAYS quote paths with spaces** in `Run` commands using double quotes.
5. **ALWAYS use `SetTitleMatchMode, 2`** (contains match) unless you need exact.
6. **ALWAYS log to a file** so automation progress can be verified from Linux.
7. **ALWAYS check `ErrorLevel`** after `WinWait` with a timeout.

## COMMAND SYNTAX REFERENCE

### Run
```
Run, Target, WorkingDir, Options, OutputVarPID
```
- Target with spaces MUST be quoted: `Run, "C:\Program Files\App\app.exe"`
- To pass arguments: `Run, "C:\path\app.exe" "arg1" "arg2"`
- WorkingDir is optional, sets the CWD for the launched process
- Options: Max, Min, Hide, UseErrorLevel
- OutputVarPID: variable name to receive the PID

### WinWait
```
WinWait, WinTitle, WinText, Timeout
```
- WinTitle: window title (matching per SetTitleMatchMode)
- WinText: optional substring from window's text elements
- Timeout: seconds to wait (blank = wait forever)
- Sets ErrorLevel to 1 if timed out, 0 if found
- Sets the "Last Found Window" for subsequent commands

### WinMenuSelectItem
```
WinMenuSelectItem, WinTitle, WinText, Menu, SubMenu1, SubMenu2, ...
```
- Menu: top-level menu name (e.g., `File`, `Edit`, `View`)
- SubMenu1: item within that menu (e.g., `Open`, `Save As`)
- Can use position: `1&` = first menu, `2&` = second, etc.
- Case-insensitive matching
- **This is the CORRECT way to access menus — NOT Send, !f or Alt+F**

### ControlSetText
```
ControlSetText, ControlID, NewText, WinTitle, WinText
```
- ControlID: ClassNN (e.g., `Edit1`, `Edit2`) or control text
- NewText: the text to set (replaces entire content)
- WinTitle/WinText: identify the target window
- **Parameter order: Control, Text, Window** — do NOT mix up

### ControlClick
```
ControlClick, ControlID-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options
```
- ControlID: ClassNN (e.g., `Button1`, `Button2`) or position (`X55 Y33`)
- WinTitle/WinText: identify the target window
- WhichButton: Left (default), Right, Middle
- Options: `NA` = don't activate window (more reliable)
- For reliability: `SetControlDelay, -1` before ControlClick

### ControlSend
```
ControlSend, ControlID, Keys, WinTitle, WinText
```
- Sends keystrokes to a specific control WITHOUT requiring focus
- ControlID blank = sends to topmost control or window itself
- Use `{Enter}`, `{Tab}`, `^c` (Ctrl+C), etc. for special keys
- For literal text, prefer `ControlSetText` or `Control, EditPaste`

### ControlGetText
```
ControlGetText, OutputVar, ControlID, WinTitle, WinText
```
- Reads text from a control into a variable
- Use to VERIFY what's in a control after setting it

### ControlGetFocus
```
ControlGetFocus, OutputVar, WinTitle, WinText
```
- Gets the ClassNN of the currently focused control
- Use in diagnostic scripts to discover control names

### WinGetText
```
WinGetText, OutputVar, WinTitle, WinText
```
- Gets ALL text from a window (all controls concatenated)
- Use to discover what controls/text exist in a dialog

### FileAppend
```
FileAppend, Text, Filename
```
- Appends text to a file (creates if doesn't exist)
- Use backtick-n for newlines: `` `n ``
- Filename is relative to A_WorkingDir unless absolute path given

### Process
```
Process, Cmd, PIDorName
```
- `Process, Exist, name.exe` — sets ErrorLevel to PID if running, 0 if not
- `Process, WaitClose, name.exe, Timeout` — waits for process to exit

### Sleep
```
Sleep, Milliseconds
```
- Pauses execution. Use between UI interactions for Wine rendering.

## MANDATORY PATTERNS

### Launching an app and waiting for it
```ahk
Run, "C:\Program Files\My App\app.exe",, UseErrorLevel, AppPID
if (ErrorLevel = "ERROR") {
    FileAppend, ERROR: Failed to launch app`n, C:\ahk.log
    ExitApp, 1
}
WinWait, App Title,, 30
if ErrorLevel {
    FileAppend, ERROR: Window did not appear within 30s`n, C:\ahk.log
    ExitApp, 1
}
FileAppend, App launched successfully`n, C:\ahk.log
```

### Opening a file via File > Open menu
```ahk
; Use WinMenuSelectItem — NOT Send !f or Send ^o
WinMenuSelectItem, App Title,, File, Open
WinWait, Open,, 10
if ErrorLevel {
    FileAppend, ERROR: Open dialog did not appear`n, C:\ahk.log
    ExitApp, 1
}
Sleep, 500
; Set filename directly into the Edit control — NOT Send/type
ControlSetText, Edit1, C:\target.exe, Open
Sleep, 300
; Click Open button by control name
ControlClick, Button1, Open
```

### Dismissing a known dialog
```ahk
WinWait, Dialog Title, expected text, 10
if !ErrorLevel {
    ControlClick, Button1  ; uses Last Found Window from WinWait
    FileAppend, Dismissed dialog: Dialog Title`n, C:\ahk.log
}
```

### Saving via menu
```ahk
WinMenuSelectItem, App Title,, File, Save decompiled project
WinWait, Browse For Folder,, 10
if ErrorLevel {
    FileAppend, ERROR: Save dialog did not appear`n, C:\ahk.log
    ExitApp, 1
}
Sleep, 500
ControlClick, Button1  ; OK button in Browse For Folder
```

### Diagnostic script to discover controls
```ahk
; Run this FIRST to learn control names before writing automation
SetTitleMatchMode, 2
WinWait, Target Window Title,, 30
WinGetText, AllText
FileAppend, Window text:`n%AllText%`n, C:\controls.log
ControlGetFocus, Focused
FileAppend, Focused control: %Focused%`n, C:\controls.log
```

## WINE-SPECIFIC NOTES

- `WinMenuSelectItem` works reliably under Wine for standard menu bars
- `ControlClick` with `NA` option is more reliable than without under Wine
- `Send` is UNRELIABLE under Wine — always prefer Control* commands
- File dialogs under Wine use standard Windows common dialog controls:
  `Edit1` for filename, `Button1` for Open/Save (but VERIFY with Window Spy)
- Wine windows may take longer to render — use generous `Sleep` values
- Always log to a file on C:\ drive for easy retrieval from Linux side

## DELPHI APPLICATION NOTES (VB Decompiler Pro, etc.)

Delphi apps use VCL controls (TButton, TEdit, TMainMenu, etc.) which behave
differently from standard Win32 controls:

1. **`GetMenu()` returns 0** — Delphi's TMainMenu doesn't use the Windows menu
   API. `WinMenuSelectItem` WILL NOT WORK. Use keyboard accelerators instead:
   `Send, !f` (Alt+F for File menu) after `WinActivate`.
2. **`ControlClick` may not trigger Delphi buttons** — TButton doesn't always
   respond to `BM_CLICK`. Try these alternatives in order:
   a. `SendMessage, 0x00F5, 0, 0, TButton1, WinTitle` (BM_CLICK directly)
   b. `WinActivate` + `ControlFocus, TButton1` + `Send, {Enter}`
   c. `WinActivate` + `Send, {Enter}` (if button has default focus)
   d. `PostMessage, 0x201, 1, coords, TButton1` + `PostMessage, 0x202, 0, coords`
      (WM_LBUTTONDOWN/UP pair)
3. **`ControlSetText` works on TEdit** — verified under Wine.
4. **Delphi controls use T-prefixed ClassNN** — TButton1, TEdit1, TTreeView1,
   TPanel1, etc. These are discoverable via `WinGet, ControlList`.
5. **For menus: enumerate via keyboard** — since GetMenu fails, press Alt to
   activate the menu bar, then use arrow keys and read window text to discover
   menu items. Or use `Send, !f` (Alt+F) and screenshot/OCR to verify.

## MENU ENUMERATION VIA DllCall (MANDATORY before using WinMenuSelectItem)

`WinMenuSelectItem` requires EXACT menu item names. Never guess — enumerate first.

Windows API functions via DllCall:
- `GetMenu(hWnd)` → returns hMenu (menu bar handle)
- `GetSubMenu(hMenu, zeroBasedIndex)` → returns submenu handle
- `GetMenuItemCount(hMenu)` → returns number of items
- `GetMenuString(hMenu, index, buffer, bufSize, flags)` → gets item text
- `MF_BYPOSITION = 0x0400` — use this flag to enumerate by position
- `GetMenuItemID(hMenu, index)` → returns command ID for the item

### Full menu enumeration script
```ahk
; Enumerate ALL menu items from an external window's menu bar
; Requires: window already open, hWnd known
SetTitleMatchMode, 2

WinWait, Target Window,, 30
if ErrorLevel {
    FileAppend, ERROR: Window not found`n, C:\menu_enum.log
    ExitApp, 1
}
WinGet, hWnd, ID

hMenuBar := DllCall("GetMenu", "UInt", hWnd)
if (!hMenuBar) {
    FileAppend, ERROR: No menu bar found (hMenu=0)`n, C:\menu_enum.log
    ExitApp, 1
}

topCount := DllCall("GetMenuItemCount", "UInt", hMenuBar)
FileAppend, Menu bar has %topCount% top-level items`n, C:\menu_enum.log

Loop, %topCount%
{
    topIdx := A_Index - 1
    VarSetCapacity(topName, 256)
    DllCall("GetMenuString", "UInt", hMenuBar, "UInt", topIdx
        , "Str", topName, "Int", 255, "UInt", 0x0400)
    FileAppend, [%topIdx%] %topName%`n, C:\menu_enum.log

    hSub := DllCall("GetSubMenu", "UInt", hMenuBar, "Int", topIdx)
    if (!hSub)
        continue
    subCount := DllCall("GetMenuItemCount", "UInt", hSub)
    Loop, %subCount%
    {
        subIdx := A_Index - 1
        VarSetCapacity(subName, 256)
        DllCall("GetMenuString", "UInt", hSub, "UInt", subIdx
            , "Str", subName, "Int", 255, "UInt", 0x0400)
        menuID := DllCall("GetMenuItemID", "UInt", hSub, "Int", subIdx)
        FileAppend,   [%subIdx%] %subName% (ID=%menuID%)`n, C:\menu_enum.log
    }
}
FileAppend, Menu enumeration complete`n, C:\menu_enum.log
ExitApp, 0
```

### IMPORTANT: Menu item names may contain `&` (accelerator prefix)
- `&File` displays as `File` with F underlined
- `WinMenuSelectItem` matches WITHOUT the `&` — use `File` not `&File`
- But if the name contains a LITERAL `&` (displayed as `&`), you must use `&&`

## CONTROL ENUMERATION (MANDATORY before using ControlSetText/ControlClick)

### Full control enumeration script
```ahk
; Enumerate ALL controls in a window with their ClassNN and text
SetTitleMatchMode, 2

WinWait, Target Window,, 30
if ErrorLevel {
    FileAppend, ERROR: Window not found`n, C:\ctrl_enum.log
    ExitApp, 1
}

WinGetTitle, WinTitle
FileAppend, Window title: %WinTitle%`n, C:\ctrl_enum.log

WinGet, CtrlList, ControlList
FileAppend, `nControl list:`n, C:\ctrl_enum.log
Loop, Parse, CtrlList, `n
{
    classNN := A_LoopField
    ControlGetText, ctrlText, %classNN%
    FileAppend, %A_Index%. %classNN% = "%ctrlText%"`n, C:\ctrl_enum.log
}

ControlGetFocus, focused
FileAppend, `nFocused control: %focused%`n, C:\ctrl_enum.log

WinGetText, allText
FileAppend, `nWinGetText output:`n%allText%`n, C:\ctrl_enum.log

FileAppend, Control enumeration complete`n, C:\ctrl_enum.log
ExitApp, 0
```

## SYNTAX VALIDATION (MANDATORY before running any script)

AHK v1.1 supports `/iLib NUL /ErrorStdOut` to validate syntax without execution:

```bash
# Syntax check — wine takes >2s, MUST use nohup
nohup sudo -u wineuser DISPLAY=:99 wine "C:\AutoHotkey.exe" /iLib NUL /ErrorStdOut "C:\script.ahk" < /dev/null > /tmp/ahk_syntax.log 2>&1 &
# SEPARATE tool call to check result:
cat /tmp/ahk_syntax.log; echo "exit: $?"
```

- Exit code 0 = no syntax errors
- Exit code 2 = syntax error (message printed to stderr)
- **ALWAYS run this before executing any AHK script**
- **Wine commands ALWAYS need nohup** — even syntax checks take >2s due to Wine startup
- Common errors caught: unescaped commas in text, wrong parameter counts,
  missing quotes, invalid parameter types

### Common syntax pitfalls

1. **Commas in FileAppend text** — literal commas must be escaped: `` `, ``
   - WRONG: `FileAppend, Hello, world`n, C:\log.txt`
   - RIGHT: `FileAppend, Hello`, world`n, C:\log.txt`
2. **Backslashes in paths** — no escaping needed, backslash is NOT an escape char
3. **Percent signs in text** — use `%` for variable deref, `` `% `` for literal
4. **Backtick is the escape character** — not backslash

## PRE-SCRIPT CHECKLIST

Before writing ANY AHK automation script:

1. [ ] Run the MENU ENUMERATION script above — get exact menu item names
2. [ ] Run the CONTROL ENUMERATION script above — get exact ClassNN names
3. [ ] For each dialog the app shows: run control enumeration on THAT dialog
4. [ ] Record exact window titles, control ClassNNs, and button text
5. [ ] Write the automation script using ONLY verified names from enumeration
6. [ ] Include FileAppend logging at every step
7. [ ] Include ErrorLevel checks after every WinWait
8. [ ] NEVER use Send for menu access — use WinMenuSelectItem with verified names
9. [ ] NEVER use Send/type for file paths — use ControlSetText with verified ClassNN
10. [ ] After writing: re-read the script and verify every ClassNN and menu name
    against the enumeration log before running
