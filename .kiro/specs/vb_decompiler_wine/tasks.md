# VB Decompiler Wine Setup — Tasks

## Task 1a: Install non-Wine dependencies ✅

- **Done:** xvfb, xdotool, imagemagick, tesseract-ocr, inotify-tools all installed

## Task 1b: Install Wine and VB6 runtime ✅

- **Done:** Wine 9.0, win32 prefix, msvbvm60.dll installed via winetricks vb6run

## Task 1c: Fix VBDIS3 runtime dependencies ✅

- **Done:** Created dummy `vb.exe` in VBDIS3.67e/ dir to satisfy `Dir$()` check
  in MODULE5.BAS:InitPaths(). Traced VB3Path usage — only used for non-critical
  `autoload.mak` read (On Error Resume Next) and commented-out Shell call.

## Task 1d: Set up network-isolated Wine instance ✅

- **Done:** Dedicated `wineuser` (uid 994, primary group `nonet` gid 1005)
- **Network block:** `iptables -I OUTPUT 1 -m owner --gid-owner 1005 -j DROP`
- **Persistence:** Saved via `iptables-persistent` to `/etc/iptables/rules.v4`
- **Display:** Xvfb on `:99` (1024x768x24), X access granted via `xhost +SI:localuser:wineuser`
- **Wine prefix:** `/home/wineuser/.wine`, Windows 10 build 19041
- **Run commands as:** `sudo -u wineuser DISPLAY=:99 wine ...`
- **Verified:** wineuser traffic blocked, braker traffic unaffected

## Task 1e: Install VB Decompiler Pro under Wine ✅ (partial — see blocker)

- **Done:** Installed via `/VERYSILENT` Inno Setup to `C:\Program Files\VB Decompiler Pro\`
- **Replaced exe:** Swapped installed `VB Decompiler.exe` with patched build from
  `~/Documents/files/decompiler/the_exe/VB Decompiler.exe` (7.1MB, SHA256:
  `3c03767a6db89c58b7667766dd2e759d0ffa78a0e51f0f9cb41518bff34acc9f`)
- **Version:** VB Decompiler Pro v9.8 build 5389.64863 (DotFix Software)
- **Protection:** Enigma Protector (patched/cracked build)

### BLOCKER: Enigma Protector crashes under Wine 9.0

- **Symptom:** `EXCEPTION_ACCESS_VIOLATION (code=c0000005)` at address `0E23045C`
  during Enigma Protector runtime initialization on every launch
- **Effect:** GUI loads, project structure is recovered (forms, modules, control
  names, API declares), status shows "Decompiled OK" — but the p-code/native
  code decompilation engine never initializes. All procedure bodies are empty
  `'Data Table: XXXXXX` stubs.
- **Tested on:**
  - `VBDIS3.exe` (VB6 native code, protected header) — empty bodies
  - `BuddyMax.exe` (VB6 native code, unprotected) — got x86 disassembly but
    NOT decompiled VB code (disassembly is Lite-level output)
  - `Wild Tools 2.exe` (VB6 p-code, unprotected) — empty bodies
- **Root cause:** Enigma Protector's unpacking/decryption layer uses memory
  operations incompatible with Wine 9.0. The crash is non-fatal to the GUI
  but corrupts the decompilation engine initialization.
- **Confirmed NOT the issue:** Licensing (patched build), file format (tested
  multiple VB versions), checkboxes (Parse stack parameters / Procedure
  analyzer), export method (tested Save decompiled project AND Save all in
  one module — both produce empty bodies)
- **No CLI workaround:** VB Decompiler has no headless/batch mode. "Command
  line support" only means accepting a filename argument to auto-open in GUI.
  No `/save`, `/export`, or `/batch` flags exist.

### What VB Decompiler Pro CAN do under Wine (Lite-level features only)

- Parse VB5/VB6 PE headers and project structure
- Recover form layouts, control names, menu structures
- List module names and procedure addresses
- Recover API Declare statements (without parameters)
- Generate VBP project files with correct module/form references
- Save to single .bas file via "Save all in one module" (to Z:\tmp\ path)
- Save decompiled project via "Save decompiled project" (Browse for Folder)

### What it CANNOT do under Wine (broken by Enigma crash)

- P-code decompilation (recovery to VB source — the main feature)
- Native code decompilation (via code emulation engine)
- String reference recovery
- Stack parameter parsing

### Possible resolutions

1. **FIX LDCONFIG FIRST (likely root cause)** — Another Kiro agent added
   `/usr/NX/lib` to `/etc/ld.so.conf.d/nomachine.conf`, causing NoMachine's
   bundled `libcrypt.so.1` and `libstdc++.so.6` to override system libraries.
   This broke PAM authentication (sudo), ImageMagick/tesseract, and very
   likely caused the Enigma Protector crash in Wine (corrupted library loads
   in dynamically allocated memory). **Must fix from physical console:**
   ```bash
   sudo rm /etc/ld.so.conf.d/nomachine.conf
   sudo ldconfig
   ```
   Then re-test VB Decompiler Pro — the crash may disappear entirely.
   Evidence: `ldconfig -p | grep libcrypt.so.1` shows `/usr/NX/lib/libcrypt.so.1`
   listed FIRST, before the system library.
2. **Run on real Windows** — Enigma Protector works correctly on native Windows.
   Need a Windows VM or bare metal machine.
3. **Find unprotected build** — A build without Enigma wrapping would bypass
   the crash entirely.
4. **Newer Wine version** — Wine 9.0 is current Ubuntu package. WineHQ staging
   or newer releases may have better Enigma compatibility.
5. **Use alternative decompilers** — Semi-VB-Decompiler (open source, GitHub),
   VBReFormer, or p32dasm for VB5/VB6 targets.

## Task 2: Install VB6 compiler under Wine

- **Objective:** Get `vb6.exe /make` working under Wine so we can compile the
  patched VBDIS3 source into a true CLI binary
- **VBP found:** `tools/vb_decompile_ref/vbdis3_reloaded/rev3/VBDIS3.67e/!VBDIS3.vbp`
  - Clean project: no OCX refs, just .BAS/.FRM/.CLS modules
  - Compile command: `wine vb6.exe /make "!VBDIS3.vbp" /outdir .`
- **Repo has no VB6 compiler** — VBGUARD/vb6 and VBDIFF/vb6 are just VB6
  project source dirs, not the compiler itself
- **Approach (try in order):**
  1. **NanoVB6 (portable, ~5MB)** — vbforums.com/showthread.php?884241
     - Fully portable VB6 compiler, no install needed, xcopy-deploy
     - Should work under Wine since it's just the core VB6 files
     - Try this first — simplest path
  2. **VS6/VB6 from archive.org** — search for "visual studio 6" or
     "visual basic 6 enterprise" ISO
     - Full installer needs Xvfb + AHK to automate setup dialogs
     - Heavier but guaranteed to have everything
  3. **Manual VB6 portable assembly** — extract just the needed files from
     a VS6 ISO without running the installer:
     - `VB98/VB6.EXE` (IDE/compiler)
     - `VB98/C2.EXE` (backend code generator)
     - `VB98/LINK.EXE` (linker)
     - `VB98/MSVBVM60.DLL` (already have via winetricks)
     - `VB98/VB6.OLB`, `VB98/VB6EXT.OLB` (type libraries)
- **Wine prefix:** `~/.wine`, win32, Windows 2000
- **Steps:**
  1. Download NanoVB6 or VS6 ISO
  2. Extract/install VB6 compiler files into Wine prefix
  3. Verify: `wine vb6.exe /make "!VBDIS3.vbp"` produces VBDIS3.exe
- **Done when:** `wine vb6.exe /make` compiles the patched VBDIS3 source
  into a working exe without errors

## Task 3: Decompile VBDIS3org.EXE with VBDIS3

- **Objective:** Run VBDIS3 against its own ancestor exe
- **Pre-check:** `file VBDIS3.exe` — confirm 32-bit PE ✅
- **Known dialogs (from source):**
  - "Visual Basic not found" (MODULE5.BAS:100) — **eliminated by dummy vb.exe**
  - frms2txt.exe failure MsgBox: "Now save *.FRM as text / Continue work? /
    Press ESC or Cancel to Quit" — AHK dismisses with Enter
  - frm_ProvideCtrlNames form — AHK closes it
- **Expected output:** `VBDIS3org/` subdir with .FRM, .BAS, .MAK files
- **Done when:** Output files exist on disk

## Task 4: Compare VBDIS3 output against known source

- **Objective:** Assess decompilation quality
- **Compare against:** `rev3/VBDIS3.67e/src/*.BAS` and `*.FRM`
- **Check:** Control names, event handlers, code structure, string literals
- **Done when:** Written comparison showing what matched and what didn't

## Task 5: Decompile SETUP_Vb4.EXE with VBOPT4

- **Objective:** Run VBOPT4 against the bundled VB4 test exe
- **Pre-work:** Read VBOPT4 source to enumerate all dialogs, write AHK script
- **Done when:** Decompiled output exists and roughly matches known source

## Task 6: Compare VBOPT4 output against known source

- **Objective:** Assess decompilation quality, same approach as Task 4
- **Done when:** Written comparison

## Task 7: Document everything

- **Objective:** Write up results so it's repeatable
- Wine setup, AHK automation approach, workarounds, output quality, batch readiness
- **Done when:** Someone else can follow the doc and reproduce
