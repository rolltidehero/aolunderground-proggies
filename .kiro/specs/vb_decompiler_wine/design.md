# VB Decompiler Wine Setup — Design

## Architecture

```
Install non-Wine deps (xvfb, xdotool, imagemagick, tesseract, inotify-tools)
         │
         ▼
Enable i386 arch → Install Wine + wine32 + winetricks
         │
         ▼
Start Xvfb :99 → WINEARCH=win32 wineboot --init → winetricks vb6run
         │
         ▼
┌─── VBDIS3 Phase ───────────────────────────────┐
│ Verify VBDIS3.exe is 32-bit PE (file command)   │
│ cd into VBDIS3.67e/ (App.Path requirement)      │
│ DISPLAY=:99 wine VBDIS3.exe VBDIS3org.EXE &    │
│ Screenshot loop: every few seconds              │
│   → OCR text to console + save PNG              │
│ When MsgBox detected: xdotool key Return        │
│ Collect output files from VBDIS3org/ subdir     │
│ Compare against src/                            │
└─────────────────────────────────────────────────┘
         │
         ▼
┌─── VBOPT4 Phase ───────────────────────────────┐
│ cd into Vbopt4.vb6/                             │
│ DISPLAY=:99 wine VBOPT4.exe ../Example/SETUP_Vb4.EXE & │
│ Screenshot loop: same as above                  │
│ Collect output files                            │
│ Compare against Example/source/                 │
└─────────────────────────────────────────────────┘
         │
         ▼
    Document results
```

## Tools

| Tool | Location | Type | Targets |
|------|----------|------|---------|
| VBDIS3 Rev3 | `tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e/VBDIS3.exe` | 32-bit PE (VB6) | VB2, VB3 16-bit NE exes |
| VBOPT4 Reload 0.1 | `tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1/Vbopt4.vb6/VBOPT4.exe` | 32-bit PE (VB6) | VB4-32, VB5 p-code |

## CLI Mode (verified from source code)

- **VBDIS3:** `processCommandline()` in F0000.FRM checks `Len(Command)`. If
  arg passed, sets `CommandlineMode=True`, skips File Open dialog and Project
  Directory dialog. Auto-creates output subdir named after the target exe.
- **VBOPT4:** Same pattern in FRM1.FRM. `processCommandline()` triggers
  `mi_OpenEXE_Click` which skips file dialog in CommandlineMode.
- **Both tools create GUI windows even in CLI mode** — need Xvfb.

## Known Issues

### VBDIS3: frms2txt.exe failure

After decompiling, VBDIS3 tries to launch `frms2txt.exe` (16-bit VB3 app) to
convert binary FRM to text. This will fail under Wine 64-bit (no 16-bit
support). When it fails, a MsgBox pops:

> "Now save *.FRM as text / Continue work? / Press ESC or Cancel to Quit"

Project files (binary FRM + BAS + MAK) are already written to disk BEFORE this
MsgBox. xdotool can dismiss it.

### VBOPT4: License file

VBOPT4 checks for `VB4Tools.lic` at startup. File exists in the directory (Pro
Edition, cracked — used for archival/research purposes consistent with repo
mission). Without it, runs as Demo with feature restrictions.

### VBDIS3: App.Path data files

Uses `App.Path` to find `.300` and `.DAT` data files. Must be run from its own
directory: `tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e/`

## Test Targets

- **VBDIS3:** Decompile `VBDIS3org.EXE` (original protected VB3 exe, 178KB, in
  same dir). Compare against `rev3/VBDIS3.67e/src/` (the VB6 port source —
  hand-cleaned, so not exact match but control names and event handlers should
  match).
- **VBOPT4:** Decompile `Example/SETUP_Vb4.EXE` (Microsoft VB4 Setup Toolkit,
  171KB). Compare against `Example/source/` (7 FRMs, 4 BAS, 1 VBP).

## Wine Configuration

- **Architecture:** Force 32-bit prefix with `WINEARCH=win32` — both tools are
  32-bit VB6 apps, avoids WoW64 complications.
- **Prefix init:** `wineboot --init` before winetricks to avoid first-run GUI
  dialogs (Mono/Gecko installer prompts).
- **i386 packages:** `dpkg --add-architecture i386` required on 64-bit Linux
  before installing wine32. Standard practice, does not affect existing 64-bit
  packages, reversible.
- **No OCX dependencies:** Neither VBP references any OCX controls. MSVBVM60.DLL
  (via winetricks vb6run) is the only runtime dependency.

## Headless Runner Script Design

`tools/wine_headless_run.sh` — reusable for both tools and future batch use.

**Inputs:** working directory, wine exe path, exe argument

**Behavior:**
1. Kill any stale Xvfb on :99
2. Start Xvfb :99
3. Trap EXIT/SIGINT/SIGTERM to kill Xvfb + Wine
4. cd to working directory
5. `DISPLAY=:99 wine <exe> <arg> &`
6. Screenshot loop every few seconds:
   - `import -window root -display :99 screenshot_NNN.png`
   - `tesseract screenshot_NNN.png stdout` → print to console
7. When process exits or user Ctrl-C's, cleanup

## Rollback

To completely undo all Wine-related changes:

```bash
# Remove Wine and all i386 packages
sudo apt remove --purge wine wine32 winetricks
sudo apt autoremove

# Remove Wine prefix (all Windows stuff)
rm -rf ~/.wine

# Remove i386 architecture
sudo dpkg --remove-architecture i386
sudo apt update
```

Non-Wine tools (xvfb, xdotool, imagemagick, tesseract, inotify-tools) are
standard Linux packages and can be removed individually with `sudo apt remove`.
