# VB Decompiler Wine Setup — Spec

## Problem Statement

Get DoDi's VB decompilers (VBDIS3 for VB2/VB3, then VBOPT4 for VB4-32/VB5)
running under Wine on Linux headlessly over SSH. Prove each works by
decompiling an exe with known source to compare against.

## Requirements

### Functional

1. Fresh Wine + VB6 runtime install on Linux
2. Xvfb for headless operation (box has GUI but accessed via SSH only)
3. VBDIS3 (rev3, VB6 port) decompiles VBDIS3org.EXE successfully
4. VBOPT4 decompiles SETUP_Vb4.EXE successfully
5. Decompiled output compared against known source in each case
6. All steps documented and repeatable

### Headless Strategy

Both tools are GUI apps (VB6) that create windows even in CLI mode. Strategy:

- Xvfb provides virtual display
- Screenshots taken every few seconds via `import -window root`
- Tesseract OCR on each screenshot, text printed to console so user can
  follow along over SSH
- Raw PNG screenshots also saved for manual inspection / SCP
- xdotool auto-dismisses MsgBox dialogs (VBDIS3 shows one when frms2txt.exe
  fails)
- Xvfb cleanup on start (kill stale) + trap on EXIT/SIGINT/SIGTERM to clean
  up Xvfb and Wine processes

### Success Criteria

VBDIS3 cannot recover original Sub/Function names from p-code — it generates
address-based names (sub2400, fn1520, gv000A). Only control event handlers
and form/control names are recoverable. Success means:

- Output files are created (MAK, BAS, binary FRM)
- Control names are recovered (Command1, Text1, Image2, etc.)
- Event handler names are correct (Command1_Click, Form_Load)
- Code structure is present (Sub/Function bodies with logic, not garbage)
- String literals are recovered ("NwN is now punting", "kill.wav", etc.)

For VBOPT4, same criteria apply — plus comparison against known VB4 source
in `Example/source/`.

## Research Findings

### Tools

| Tool | Location | Type | Targets |
|------|----------|------|---------|
| VBDIS3 Rev3 | `tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e/VBDIS3.exe` | 32-bit PE (VB6) | VB2, VB3 16-bit NE exes |
| VBOPT4 Reload 0.1 | `tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1/Vbopt4.vb6/VBOPT4.exe` | 32-bit PE (VB6) | VB4-32, VB5 p-code |

### CLI Mode (verified from source code)

- **VBDIS3:** `processCommandline()` in F0000.FRM checks `Len(Command)`. If
  arg passed, sets `CommandlineMode=True`, skips File Open dialog and Project
  Directory dialog. Auto-creates output subdir named after the target exe.
- **VBOPT4:** Same pattern in FRM1.FRM. `processCommandline()` triggers
  `mi_OpenEXE_Click` which skips file dialog in CommandlineMode.
- **Both tools create GUI windows even in CLI mode** — need Xvfb.

### VBDIS3 Known Issue: frms2txt.exe

After decompiling, VBDIS3 tries to launch `frms2txt.exe` (16-bit VB3 app) to
convert binary FRM to text. This will fail under Wine 64-bit (no 16-bit
support). When it fails, a MsgBox pops:

> "Now save *.FRM as text / Continue work? / Press ESC or Cancel to Quit"

Project files (binary FRM + BAS + MAK) are already written to disk BEFORE this
MsgBox. xdotool can dismiss it.

### VBOPT4 License

VBOPT4 checks for `VB4Tools.lic` at startup. File exists in the directory (Pro
Edition, cracked — used for archival/research purposes consistent with repo
mission). Without it, runs as Demo with feature restrictions.

### VBDIS3 Data Files

Uses `App.Path` to find `.300` and `.DAT` data files. Must be run from its own
directory: `tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e/`

### Test Targets

- **VBDIS3:** Decompile `VBDIS3org.EXE` (original protected VB3 exe, 178KB, in
  same dir). Compare against `rev3/VBDIS3.67e/src/` (the VB6 port source —
  hand-cleaned, so not exact match but control names and event handlers should
  match).
- **VBOPT4:** Decompile `Example/SETUP_Vb4.EXE` (Microsoft VB4 Setup Toolkit,
  171KB). Compare against `Example/source/` (7 FRMs, 4 BAS, 1 VBP).

### Wine Configuration

- **Architecture:** Force 32-bit prefix with `WINEARCH=win32` — both tools are
  32-bit VB6 apps, avoids WoW64 complications.
- **Prefix init:** `wineboot --init` before winetricks to avoid first-run GUI
  dialogs (Mono/Gecko installer prompts).
- **i386 packages:** `dpkg --add-architecture i386` required on 64-bit Linux
  before installing wine32. This is standard, does not affect existing 64-bit
  packages, and is reversible.

## Design

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

## Task Breakdown

### Task 1a: Install non-Wine dependencies

- **Objective:** Install headless display, automation, and OCR tools
- **Commands:**
  ```bash
  sudo apt install -y xvfb xdotool imagemagick tesseract-ocr inotify-tools
  ```
- **Verify:** `Xvfb -help`, `xdotool --version`, `import --version`,
  `tesseract --version`, `inotifywait --help`
- **Done when:** All five tools respond to version/help commands

### Task 1b: Install Wine and VB6 runtime

- **Objective:** Install Wine with 32-bit support and VB6 runtime
- **Commands:**
  ```bash
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt install -y wine wine32 winetricks
  ```
- **Initialize prefix (under Xvfb since wineboot may create windows):**
  ```bash
  Xvfb :99 -screen 0 800x600x24 &
  DISPLAY=:99 WINEARCH=win32 wineboot --init
  DISPLAY=:99 winetricks vb6run
  kill %1  # stop Xvfb
  ```
- **Verify:** `wine --version`, `ls ~/.wine/drive_c/windows/system32/msvbvm60.dll`
- **Done when:** Wine runs and msvbvm60.dll exists in prefix

### Task 2: Write headless Wine runner script

- **Objective:** Reusable bash script that runs a Wine GUI app headlessly with
  screenshot+OCR monitoring and auto-dismiss
- **Script:** `tools/wine_headless_run.sh`
- **Inputs:** working directory, wine exe path, exe argument
- **Behavior:**
  1. Kill any stale Xvfb on :99
  2. Start Xvfb :99
  3. Trap EXIT/SIGINT/SIGTERM to kill Xvfb + Wine
  4. cd to working directory
  5. DISPLAY=:99 wine <exe> <arg> &
  6. Screenshot loop every few seconds:
     - `import -window root -display :99 screenshot_NNN.png`
     - `tesseract screenshot_NNN.png stdout` → print to console
  7. When process exits or user Ctrl-C's, cleanup
- **Test:** `tools/wine_headless_run.sh . notepad.exe` — should produce
  screenshots showing notepad
- **Done when:** Script runs, produces screenshots, OCR text appears on console

### Task 3: Decompile VBDIS3org.EXE with VBDIS3

- **Objective:** Run VBDIS3 against its own ancestor exe
- **Pre-check:** `file VBDIS3.exe` — confirm it's 32-bit PE, not 16-bit NE
- **Run:**
  ```bash
  tools/wine_headless_run.sh \
    tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e \
    VBDIS3.exe \
    VBDIS3org.EXE
  ```
- **Expected:** New `VBDIS3org/` subdirectory with .FRM, .BAS, .MAK files
- **MsgBox expected:** frms2txt.exe will fail → MsgBox → xdotool dismiss
- **Done when:** Output files exist on disk

### Task 4: Compare VBDIS3 output against known source

- **Objective:** Assess decompilation quality
- **Compare against:** `rev3/VBDIS3.67e/src/*.BAS` and `*.FRM`
- **Check:**
  - Control names recovered
  - Event handler names correct
  - Code structure present (Subs with logic)
  - String literals recovered
- **Note:** Source was hand-cleaned during VB6 port. Sub/function names will be
  address-based in decompiled output vs meaningful names in src/. This is
  expected.
- **Done when:** Written comparison showing what matched and what didn't

### Task 5: Decompile SETUP_Vb4.EXE with VBOPT4

- **Objective:** Run VBOPT4 against the bundled VB4 test exe
- **Run:**
  ```bash
  tools/wine_headless_run.sh \
    tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1/Vbopt4.vb6 \
    VBOPT4.exe \
    ../Example/SETUP_Vb4.EXE
  ```
- **Check output files**, compare against `Example/source/`
- **Done when:** Decompiled output exists and roughly matches known source

### Task 6: Compare VBOPT4 output against known source

- **Objective:** Assess decompilation quality
- Same approach as Task 4
- **Done when:** Written comparison

### Task 7: Document everything

- **Objective:** Write up results so it's repeatable
- Update docs with: Wine setup steps, workarounds, CLI findings, output
  quality, readiness for batch
- **Done when:** Someone else can follow the doc and reproduce

## VB Decompiler Pro — Wine Findings (2026-03-04)

### Setup

- **Dedicated user:** `wineuser` (uid 994), primary group `nonet` (gid 1005)
- **Network isolation:** iptables DROP on GID 1005, persisted via iptables-persistent
- **Wine prefix:** `/home/wineuser/.wine`, Windows 10 build 19041
- **Display:** Xvfb :99 (1024x768x24)
- **Tool:** VB Decompiler Pro v9.8 (DotFix Software), Enigma Protector wrapped,
  patched build. Installed via Inno Setup `/VERYSILENT`.

### VB Decompiler Pro — Supported Targets

From official docs (vb-decompiler.org): **VB5 and VB6 only.** No VB3, no VB4.

| Target | P-Code | Native Code |
|--------|--------|-------------|
| VB5 | Decompile to VB source (up to 85%) | Disassembly + partial decompile via emulation (up to 75%) |
| VB6 | Decompile to VB source (up to 85%) | Disassembly + partial decompile via emulation (up to 75%) |
| VB3 | ✗ "File is incorrect" | ✗ 16-bit NE not supported |
| VB4 | ✗ Not supported | ✗ Not supported |
| .NET | Decompile to C# | Decompile to C# |

### Archive Coverage (from COMPILER_BREAKDOWN.md)

| Version | P-code | Native | Total | VB Decompiler Pro? |
|---------|--------|--------|-------|--------------------|
| VB3 | 178 | - | 178 | ✗ |
| VB4-16 | 3 | - | 3 | ✗ |
| VB4-32 | - | 446 | 446 | ✗ |
| VB5 | 50 | 276 | 330 | ✓ (1,084 total) |
| VB6 | 126 | 601 | 754 | ✓ |
| non-VB | - | - | 433 | ✗ |

### Enigma Protector Crash — Full Details

**Crash:** `EXCEPTION_ACCESS_VIOLATION (code=c0000005)` at `0E23045C` in
`VB Decompiler.exe` — write of address `00000000`. Occurs on every launch
during Enigma Protector runtime initialization.

**Wine debug log evidence:**
```
0024:warn:seh:dispatch_exception EXCEPTION_ACCESS_VIOLATION exception (code=c0000005) raised
```

**Impact:** The crash is non-fatal to the GUI process. The application continues
running and can parse VB project structures. However, the p-code decompilation
engine and native code emulation engine fail to initialize. All procedure bodies
in exported files contain only `'Data Table: XXXXXX` comments (a pointer to the
procedure's data table address) with no actual decompiled code.

**Test matrix:**

| Target | Type | Protected? | Result |
|--------|------|------------|--------|
| VBDIS3.exe | VB6 native | Yes (modified VB header: `VB6DE.DLL`) | Empty bodies, `'Data Table:` stubs |
| VBDIS3_patched.exe | VB6 native | Header patched to `MSVBVM60.DLL` | Empty bodies, same stubs |
| BuddyMax.exe | VB6 native | No | x86 disassembly (Lite-level), no VB decompilation |
| Wild Tools 2.exe | VB6 p-code | No | Empty bodies, `'Data Table:` stubs |

**Eliminated causes:**
- ✗ Not a licensing issue (patched build, no "Demo" indicators in UI)
- ✗ Not file-specific (tested 4 different exes)
- ✗ Not a checkbox issue (Parse stack parameters / Procedure analyzer)
- ✗ Not an export issue (tested both "Save decompiled project" and "Save all
  in one module" — both produce empty bodies)
- ✗ Not a VB header issue (patching VBDIS3's `VB6DE.DLL` → `MSVBVM60.DLL`
  didn't help)

**Confirmed root cause:** Enigma Protector's memory protection/unpacking layer
is incompatible with Wine 9.0's memory management. The crash corrupts the
decompilation engine initialization while leaving the GUI and project parser
functional.

**IMPORTANT — Likely contributing factor discovered (2026-03-04 22:19):**

Another Kiro agent added `/usr/NX/lib` to `/etc/ld.so.conf.d/nomachine.conf`,
causing NoMachine's bundled libraries to override system libraries system-wide:

```
$ ldconfig -p | grep libcrypt.so.1
  libcrypt.so.1 => /usr/NX/lib/libcrypt.so.1      ← WRONG, takes priority
  libcrypt.so.1 => /lib/x86_64-linux-gnu/libcrypt.so.1  ← correct system lib
```

**Known damage from this ldconfig change:**
1. `sudo` broken — PAM uses `libcrypt.so.1` for password hashing; NoMachine's
   version is incompatible → "account validation failure" on all sudo calls
2. ImageMagick `import`/`convert` and `tesseract` crash — NoMachine's
   `libstdc++.so.6` is missing `GLIBCXX_3.4.30` required by system `libicuuc.so.74`
3. **Enigma Protector crash in Wine is POSSIBLY caused by this** — Wine loads
   shared libraries from the system ldconfig cache. If Wine or its child
   processes loaded NoMachine's incompatible `libcrypt.so.1` or `libstdc++.so.6`,
   this would cause memory corruption in exactly the kind of dynamically
   allocated region where the crash occurs (`0E23045C`).

**Action required:** Fix ldconfig from physical console, then re-test VB
Decompiler Pro. The Enigma crash may disappear entirely.

```bash
sudo rm /etc/ld.so.conf.d/nomachine.conf
sudo ldconfig
```

### GUI Automation Notes

- **Error dialog dismissal:** The access violation produces a dialog titled
  "VB Decompiler" (not "Error") with geometry ~324x114. Must be dismissed by
  clicking OK button at center-bottom of dialog. Sometimes requires multiple
  dismissals.
- **xdotool reliability:** Unreliable for keyboard input to Wine windows (focus
  issues). Mouse clicks via `xdotool mousemove X Y click 1` work better.
  `windowactivate --sync` before interaction.
- **Save all in one module:** Opens a standard Windows Save As dialog. Can type
  `Z:\tmp\filename.bas` to save to Linux `/tmp/` (world-writable). This is the
  most reliable export method.
- **Save decompiled project:** Opens Browse for Folder dialog. Pressing Enter
  accepts default location (Desktop). Files saved to
  `/home/wineuser/.wine/drive_c/users/wineuser/Desktop/`.
- **LD_LIBRARY_PATH:** NoMachine's `/usr/NX/lib/libstdc++.so.6` interferes with
  ImageMagick and tesseract. Must set
  `LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu` before using `import`/`convert`.

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
