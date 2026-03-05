# C2 — In-Process Command & Control for Wine GUI Automation

DLL injection-based C2 for automating VB Decompiler Pro v9.8 and standalone C2 host for screenshot capture, both running under Wine 9.0 on headless Xvfb.

## Architecture

Two isolated Wine environments run in parallel:

| | Decompile Pipeline | Screenshot Pipeline |
|---|---|---|
| User | `wineuser` (uid 994) | `wineshot` (uid 993) |
| Display | `:99` | `:98` |
| Prefix | `/home/wineuser/.wine` | `/home/wineshot/.wine` |
| C2 binary | `c2dll.dll` (injected into VB Decompiler) | `c2host.exe` (standalone) |
| Cmd/Res files | `C:\c2_cmd.txt` / `C:\c2_res.txt` | `C:\c2s_cmd.txt` / `C:\c2s_res.txt` |
| Checkpoint | `decompile_checkpoint.json` | `screenshot_checkpoint.json` |

## Components

### C2 Binaries

- **`c2dll.c`** — DLL injected into VB Decompiler. Polls `C:\c2_cmd.txt`, executes Win32 API calls in-process, writes results to `C:\c2_res.txt`. Required because Wine doesn't marshal WM_SETTEXT across processes.
- **`c2host.c`** — Standalone C2 exe for screenshot pipeline. Same command set, different file paths (`c2s_cmd.txt`/`c2s_res.txt`). No injection needed.
- **`inject.c`** — Injector using `CreateRemoteThread` + `LoadLibraryA`.

### Automation Scripts

- **`batch_decompile.py`** — Batch decompile all VB5/VB6 exes. Auto-recovers Xvfb/:99/VB Decompiler/C2 on failure.
- **`screenshot_proggies.py`** — Launch each proggie under Wine, capture window screenshots. Auto-recovers Xvfb/:98/c2host.exe.
- **`extract_frx.py`** — Extract embedded images (BMP/PNG/JPEG/GIF/ICO) from VB exe FRX resources. Pure Python, no Wine needed.

## Build

```bash
# C2 DLL (injected into VB Decompiler)
i686-w64-mingw32-gcc -shared -O2 -o c2dll.dll c2dll.c -luser32 -lgdi32

# Injector
i686-w64-mingw32-gcc -O2 -o inject.exe inject.c -luser32

# Standalone C2 host (for screenshots)
i686-w64-mingw32-gcc -O2 -o c2host.exe c2host.c -luser32 -lgdi32
```

## C2 Commands

| Command | Args | Description |
|---------|------|-------------|
| PING | | Returns PONG with PID |
| FINDWINDOW | class title | FindWindowA (* = NULL) |
| FINDWINDOWEX | parent after class title | FindWindowExA (* = NULL) |
| GETTEXT | hwnd | GetWindowTextW (UTF-8) |
| GETCLASS | hwnd | GetClassNameW (UTF-8) |
| SETTEXT | hwnd text | WM_SETTEXT in-process (works under Wine!) |
| SENDMSG | hwnd msg wp lp | SendMessageA |
| POSTMSG | hwnd msg wp lp | PostMessageA |
| GETDLGITEM | hwnd id | GetDlgItem |
| CLICK | hwnd | BM_CLICK |
| LCLICK | hwnd | WM_LBUTTONDOWN+UP |
| ENUMCHILDREN | hwnd | EnumChildWindows (hwnd\|class\|ctrlid\|text) |
| WMCOMMAND | hwnd id | WM_COMMAND |
| SCREENSHOT | hwnd path | BitBlt window capture to BMP (SetForegroundWindow first) |
| SLEEP | ms | Sleep |
| EXIT | | Terminate C2 thread |

## batch_decompile.py

Decompiles every `.exe` in `programs/`, saves `.decompiled.bas` next to each.

```bash
sudo python3 batch_decompile.py            # Run batch (auto-starts environment)
sudo python3 batch_decompile.py --stats    # Progress summary
sudo python3 batch_decompile.py --report   # Full success/error/skip lists
sudo python3 batch_decompile.py --reset-errors   # Clear errors for retry
sudo python3 batch_decompile.py --reset-skipped  # Clear skipped for retry
sudo python3 batch_decompile.py --dry-run  # Preview remaining work
```

Features:
- **Auto-recovery** — detects when Xvfb/:99, VB Decompiler, or C2 die and spins them back up (up to 3 attempts)
- **JSON checkpoint** — resumable, saves after every file
- **Installer detection** — skips setup.exe, NSIS, InnoSetup, InstallShield, WISE
- **FreeProcess polling** — no arbitrary sleeps, ~5-6s per file
- **Breakglass** — if no success in 5 minutes, attempts recovery before exiting

### Decompile Sequence

```
WMCOMMAND <hmain> 2 → wait "Open EXE File" dialog → SETTEXT <edit> → SENDMSG IDOK
→ dismiss TfrmMessageDialog → poll TTreeView TVM_GETCOUNT until >0
→ WMCOMMAND <hmain> 9 → wait "Save All To One BAS File" → SETTEXT <edit> → SENDMSG IDOK
→ poll for output file
```

### VB Decompiler Menu IDs

| ID | Action |
|----|--------|
| 2 | File > Open |
| 9 | File > Save all in one module |

## screenshot_proggies.py

Launches each proggie under Wine on `:98`, finds VB runtime windows, captures via C2 SCREENSHOT, kills process.

```bash
sudo python3 screenshot_proggies.py                    # Run batch
sudo python3 screenshot_proggies.py --one /path/to.exe # Test one
sudo python3 screenshot_proggies.py --stats            # Progress
sudo python3 screenshot_proggies.py --reset-errors     # Retry errors
```

Features:
- **Auto-recovery** — starts Xvfb/:98 and c2host.exe automatically
- **16-bit NE detection** — skips NE executables that crash Wine/Xvfb
- **Window-only capture** — SetForegroundWindow + BitBlt cropped to window rect, no background bleed
- **Upscaling** — small windows (<400px wide) upscaled with nearest-neighbor
- **Multi-window** — captures all VB forms (main + splash + dialogs)

### VB Runtime Window Classes

`ThunderRT6FormDC`, `ThunderRT6Form`, `ThunderRT6MDIForm`, `ThunderRT5FormDC`, `ThunderRT5Form`, `ThunderFormDC`, `ThunderForm`

## extract_frx.py

Extracts embedded images from VB exe FRX resources. Pure Python — no Wine, no VB Decompiler needed. Runs at disk speed.

```bash
python3 extract_frx.py                    # Batch extract all
python3 extract_frx.py --one /path/to.exe # Extract from one exe
python3 extract_frx.py --stats            # Progress
python3 extract_frx.py --dry-run          # Preview
```

Features:
- Scans for BMP, PNG, JPEG, GIF, ICO magic bytes with header validation
- Converts all output to PNG
- Upscales small images to 400px+ width
- ~83% of VB exes have extractable images
- Outputs: `<name>.frx_0.png`, `<name>.frx_1.png`, ... next to each exe

## extract_metadata.py

Parses `.decompiled.bas` files to extract structured metadata. No Wine needed.

```bash
python3 extract_metadata.py                    # Batch all → metadata.json
python3 extract_metadata.py --one /path/to.bas # Single file (prints JSON)
python3 extract_metadata.py --one /path/to.exe # Finds matching .bas automatically
```

Extracts per app:
- **name**: from `App.Title`, form captions, version strings
- **author**: from "by <name>", "coded by", "created by" patterns in string literals
- **version**: from "v1.0", "Version 2.5" patterns
- **forms**: all `'Object:` entries (form and module names)
- **about_form**: detected About/Credits/Splash/Greetz forms
- **dependencies**: OCX/DLL references found in source
- **features**: inferred from keywords (punt, crack, flood, fade, chat, IM, idle, etc.)
- **ui_elements**: buttons (from `_Click` handlers), captions, text controls

Tests: `python3 test_metadata.py` (52 tests)

## Pipeline Status

### Completed
- **Decompile**: 2258/2328 exes processed (1549 success, 70 errors, 35 skipped, 674 remaining)
- **FRX extraction**: 2328/2328 done — **14,852 images** extracted from 1978 exes
- **Metadata**: 2152 apps parsed — 362 authors, 144 About forms, 1467 with features

### In Progress
- **Screenshots**: 81/2328 processed, running on `:98`

### TODO
- Smart screenshot script using metadata (About form targeting, menu/button text from source)
- Animated GIFs from FRX images + window screenshot per app
- GitHub Pages site generation

## Environment Setup

### Decompile environment (`:99` / `wineuser`)

```bash
nohup sudo Xvfb :99 -screen 0 1024x768x24 -ac < /dev/null > /dev/null 2>&1 &
sleep 2; nohup metacity --display=:99 --replace < /dev/null > /dev/null 2>&1 &
sleep 2; nohup sudo -u wineuser DISPLAY=:99 wine \
  "C:\Program Files\VB Decompiler Pro\VB Decompiler.exe" < /dev/null > /dev/null 2>&1 &
sleep 12; nohup sudo -u wineuser DISPLAY=:99 wine "C:\inject.exe" < /dev/null > /dev/null 2>&1 &
```

Or just run `batch_decompile.py` — it auto-starts everything.

### Screenshot environment (`:98` / `wineshot`)

```bash
nohup sudo Xvfb :98 -screen 0 1024x768x24 -ac < /dev/null > /dev/null 2>&1 &
sleep 2; nohup sudo -u wineshot DISPLAY=:98 WINEPREFIX=/home/wineshot/.wine \
  wine "C:\c2host.exe" < /dev/null > /dev/null 2>&1 &
```

Or just run `screenshot_proggies.py` — it auto-starts everything.

### OCX/Runtime Registration

Both prefixes have registered: mscomctl.ocx, comctl32.ocx, mswinsck.ocx, Comdlg32.ocx, richtx32.ocx, Tabctl32.ocx, Msinet.ocx, ssa3d30.ocx, threed32.ocx, msvbvm50.dll, msvbvm60.dll.

## Known Issues

- **16-bit NE executables** (VB3, .VBX) crash Wine and can take down Xvfb. Both scripts detect and skip them.
- **Non-VB exes** produce empty decompile output (34 "Output file is empty" errors). These are Delphi/C++ apps that VB Decompiler can't handle.
- **PrintWindow** doesn't work under Wine — windows return black. Using BitBlt from desktop DC with SetForegroundWindow instead.
- **Cross-process WM_SETTEXT** doesn't work under Wine — must use DLL injection.
