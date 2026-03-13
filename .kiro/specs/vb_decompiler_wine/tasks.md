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

### RESOLVED: Enigma Protector crash under Wine 9.0

- **Symptom:** `EXCEPTION_ACCESS_VIOLATION (code=c0000005)` at `0E23045C`
  when a file is passed as a command-line argument.
- **Root cause:** Enigma Protector's unpacking layer crashes specifically on
  the command-line file loading code path. The GUI startup path is unaffected.
- **Fix (2026-03-04):** Nuked Wine prefix, reinstalled fresh (wineboot +
  winetricks vb6run + Inno Setup /VERYSILENT + patched exe copy). Launch
  VB Decompiler with NO arguments, then open files via File > Open in the GUI.
- **Confirmed working:** BuddyMax.exe opened via File > Open — full
  decompilation with procedure bodies, VBP structure, OCX refs, compiler
  settings all recovered.
- **Automation approach:** Use xdotool to drive File > Open dialog instead
  of passing filename on command line. Copy target exes to C:\ drive since
  Z:\ not visible in file dialog.
- **Snapshot:** `~/wineuser_prefix_snapshot_20260304.tar.gz` (202MB) —
  clean working state, restore with:
  ```bash
  sudo rm -rf /home/wineuser/.wine
  sudo tar xzf ~/wineuser_prefix_snapshot_20260304.tar.gz -C /home/wineuser
  sudo chown -R wineuser:nonet /home/wineuser/.wine
  ```

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
