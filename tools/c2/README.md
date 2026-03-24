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
- **`c2vb.c`** — **(PLANNED)** DLL injected into VB6 proggies. Walks COM `Forms`/`Controls` collections via IDispatch to enumerate all controls (including lightweight ones with no HWND) with full coordinates. Enables clicking buttons by name for form navigation.
- **`inject.c`** — Injector using `CreateRemoteThread` + `LoadLibraryA`.

### Automation Scripts

- **`batch_decompile.py`** — Batch decompile all VB5/VB6 exes. Auto-recovers Xvfb/:99/VB Decompiler/C2 on failure.
- **`screenshot_proggies.py`** — Launch each proggie under Wine, capture window screenshots. Auto-recovers Xvfb/:98/c2host.exe.
- **`extract_frx.py`** — Extract embedded images (BMP/PNG/JPEG/GIF/ICO) from VB exe FRX resources. Pure Python, no Wine needed.
- **`extract_metadata.py`** — Extract app name, author, version, forms, features, UI elements from decompiled .bas files. 52 tests passing.
- **`parse_nav_graph.py`** — Parse decompiled .bas files to extract navigation graphs: which controls navigate to which forms, which are dangerous (exit/unload), which are menu items. Zero-cost static analysis for screenshot navigation planning.
- **`enumerate_controls.py`** — Full control inventory from decompiled source + exe binary scanning. Extracts every control name, type, and caption including lightweight controls (Labels, Images) and menus invisible to Win32 API. Batch mode: 1,369 apps, 39,240 controls.
- **`poc_walkthrough.py`** — End-to-end screenshot walkthrough POC. Launches app, discovers controls, navigates forms via nav graph, assembles animated GIF. See POC section below.

## Build

```bash
# C2 DLL (injected into VB Decompiler)
i686-w64-mingw32-gcc -shared -O2 -o c2dll.dll c2dll.c -luser32 -lgdi32

# Injector
i686-w64-mingw32-gcc -O2 -o inject.exe inject.c -luser32

# Standalone C2 host (for screenshots)
i686-w64-mingw32-gcc -O2 -o c2host.exe c2host.c -luser32 -lgdi32

# VB6 in-process C2 (for control enumeration — PLANNED)
i686-w64-mingw32-gcc -shared -O2 -o c2vb.dll c2vb.c -luser32 -lgdi32 -loleaut32 -lole32 -luuid -lcomctl32
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
| GETRECT | hwnd | GetWindowRect → `x y w h` screen coordinates |
| POSTMSG | hwnd msg wp lp | PostMessageA |
| GETDLGITEM | hwnd id | GetDlgItem |
| CLICK | hwnd | BM_CLICK |
| LCLICK | hwnd | WM_LBUTTONDOWN+UP |
| ENUMCHILDREN | hwnd | EnumChildWindows (hwnd\|class\|ctrlid\|text) |
| WMCOMMAND | hwnd id | WM_COMMAND |
| SCREENSHOT | hwnd path [client] | BitBlt capture to BMP. `client` flag = client area only (no WM title bar) |
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
- Build `c2vb.dll` — in-process VB6 COM control enumeration for lightweight controls (see detailed section below)
- Update `screenshot_proggies.py` to use nav graph data + ENUMCHILDREN for windowed controls + c2vb.dll fallback for lightweight controls
- Animated GIFs: splash → main → navigate forms → About → FRX art
- VirtualBox VM setup for 16-bit NE executables (VB3/VB4-16)
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

## Screenshot Pipeline Strategy

### CRITICAL FINDING: .decompiled.bas does NOT contain control coordinates

VB Decompiler's "Save All To One BAS" output contains only:
- `'Object: formname` headers
- `Sub controlname_Click()` event handlers with code
- Navigation calls like `formname.Show`

It does NOT contain control properties (Left, Top, Width, Height, Caption).
Those exist only in VB6 `.frm` source files (only 6 apps shipped with source)
or in the binary form resource inside the exe.

### What we CAN extract statically (Tier 1 — `parse_nav_graph.py`)

From 2152 decompiled .bas files:
- **82 apps** have explicit `.Show` navigation (control → form mappings)
- **237 apps** have menu items (`mnu*_Click` handlers)
- **152 apps** have dangerous controls (Unload Me, End, App.End) — AVOID these
- **1634 apps** are multi-form (excluding Module objects)

This gives us a navigation graph: which controls to click and which forms
they open. But NOT where those controls are on screen.

### Runtime control discovery (Tier 2 — at screenshot time)

For 32-bit PE apps running under Wine:

1. **ENUMCHILDREN** via c2host.exe — finds windowed controls (TextBox,
   PictureBox, CommandButton sometimes) with their HWNDs and text.
   Match control text against nav graph control names to find click targets.

2. **xdotool click** at control coordinates — the ONLY reliable click method.
   PostMessage WM_LBUTTONDOWN does NOT trigger VB6 lightweight controls.
   xdotool generates real X11 input → Wine → VB6 hit-testing.

3. **c2vb.dll injection** (fallback) — for apps where ENUMCHILDREN can't find
   the navigation controls (lightweight Labels/Images used as buttons).
   Walks COM Forms→Controls via IDispatch to get ALL controls with coordinates.

### 16-bit NE executables (Tier 3 — VirtualBox)

VB3/VB4-16 apps crash Wine. Solution: headless VirtualBox VM running
Windows XP 32-bit (has NTVDM for 16-bit support) with AutoIt3 C2 agent.

Key insight: VB3 VBX controls ARE windowed (have HWNDs), unlike VB6
lightweight controls. EnumChildWindows WORKS for VB3 apps.

See `docs/vb-screenshot-pipeline.md` for full tier architecture.

## c2vb.dll — In-Process VB6 Control Enumeration (PLANNED)

### Problem

VB6 lightweight controls (Label, Image, CommandButton, Shape, Line, Frame) have
**no HWND**. They are drawn by the VB6 runtime and invisible to `EnumChildWindows`.
Our external C2 (`c2host.exe`) can only see windowed controls like TextBox and
PictureBox. This means we can't find buttons to click for navigating between forms.

Tested and confirmed:
- `ENUMCHILDREN` on a VB6 form with 53 CommandButtons returned only 7 PictureBoxDC children
- `PostMessage WM_LBUTTONDOWN/UP` to the form does NOT trigger lightweight control clicks
- `WM_COMMAND` brute force does NOT work on VB6 (unlike Delphi — VB6 uses internal dispatch)
- `xdotool` clicks DO work (real X11 input → Wine → VB6 hit-testing) but we don't know coordinates
- `Tab+Space` keyboard navigation is dangerous — can hit Exit buttons and kill the app

### Solution: In-Process COM Enumeration

All VB6 objects are COM objects supporting `IDispatch`. From inside the process,
we can walk the `Forms` collection and each form's `Controls` collection to get
**every** control including lightweight ones, with full properties:

```
Forms(i).Controls → IEnumVARIANT → for each control:
  .Name     (via GetIDsOfNames)
  .Caption  (DISPID -518)
  .Left     (via GetIDsOfNames, in twips)
  .Top      (via GetIDsOfNames, in twips)
  .Width    (via GetIDsOfNames, in twips)
  .Height   (via GetIDsOfNames, in twips)
  .Visible  (via GetIDsOfNames)
  .Enabled  (DISPID -514)
  .HWND     (DISPID -515, 0 for lightweight)
  TypeName  (from IDispatch::GetTypeInfo)
```

With coordinates known, we send `WM_LBUTTONDOWN`/`WM_LBUTTONUP` to the form
at the control's center point — the VB6 runtime does hit-testing and fires `_Click`.

### Research Sources

- **GenDigital/Avast "Scripting Arbitrary VB6 Applications" (2023)** — David Zimmer (dzzie/sandsprite).
  Proved that injecting a DLL at process startup, hooking `CVBApplication::Init`,
  patching `ObjectType` bit 0x800 to make classes public, and registering `Forms`
  in the Running Object Table (ROT) gives full scripting access to any VB6 exe.
  Forms, controls, public members — all accessible via IDispatch from Python/JS.
  Source: https://www.gendigital.com/blog/insights/research/scripting-arbitrary-vb6-applications

- **Karl E. Peterson "Subclassing the XP Way" (2009)** — `SetWindowSubclass` from
  comctl32.dll (ordinal 410, named export from XP SP1). Safe multi-hook subclassing
  with `RemoveWindowSubclass` (412) and `DefSubclassProc` (413). No teardown-order
  issues. Available since Win98/IE4 by ordinal, confirmed working in Wine.
  Source: https://visualstudiomagazine.com/articles/2009/07/16/subclassing-the-xp-way.aspx

- **Geoff Chappell comctl32 history** — Documents ordinals 410-413 as existing since
  IE 4.0 / Win98, exported by name from XP SP1.
  Source: https://www.geoffchappell.com/studies/windows/shell/comctl32/history/ords472.htm

- **Wine API** — `SetWindowSubclass` implemented in Wine's comctl32.
  Source: https://source.winehq.org/WineAPI/SetWindowSubclass.html

- **Microsoft OLE Standard DISPIDs** (olectl.h, confirmed in mingw-w64 headers):
  ```
  DISPID_BACKCOLOR  = -501    DISPID_FONT       = -512
  DISPID_FORECOLOR  = -513    DISPID_ENABLED    = -514
  DISPID_HWND       = -515    DISPID_TABSTOP    = -516
  DISPID_TEXT        = -517    DISPID_CAPTION    = -518
  DISPID_NEWENUM    = -4      DISPID_VALUE      = 0
  ```

### Architecture

```
inject.exe → CreateRemoteThread + LoadLibraryA → c2vb.dll loaded in proggie

c2vb.dll DllMain:
  1. Start polling thread (reads C:\c2v_cmd.txt, writes C:\c2v_res.txt)
  2. PostMessage(WM_USER+99) to main form → executes on VB6 STA thread

On WM_USER+99 (main thread, safe for COM):
  3. AccessibleObjectFromWindow(hwnd, OBJID_NATIVEOM) → form IDispatch
     OR walk VBHeader → ObjectTable → Forms (GenDigital technique)
  4. form->Invoke("Controls", DISPATCH_PROPERTYGET) → controls IDispatch
  5. controls->Invoke(DISPID_NEWENUM) → IEnumVARIANT
  6. IEnumVARIANT::Next() → each control's IDispatch
  7. GetIDsOfNames("Name","Left","Top","Width","Height","Visible","Caption")
  8. Invoke each → report name|type|caption|left|top|width|height|visible
```

### Planned Commands

| Command | Description |
|---------|-------------|
| ENUMCONTROLS | Walk all forms/controls, report name/type/caption/coordinates |
| CLICKCONTROL name | Find control by name, click at its center coordinates |
| SHOWFORM name | Call formname.Show via IDispatch |
| GETPROPERTY ctrl.prop | Read any property via GetIDsOfNames + Invoke |

### Build (planned)

```bash
i686-w64-mingw32-gcc -shared -O2 -o c2vb.dll c2vb.c -luser32 -lgdi32 -loleaut32 -lole32 -luuid
```

### STA Threading Constraint

VB6 uses single-threaded apartment (STA). All COM/runtime calls MUST happen on
the main VB6 thread. The injected DLL's polling thread cannot call IDispatch
directly. Instead:
- Use `SetWindowSubclass` (comctl32 ordinal 410) to hook the form's wndproc
- Or `PostMessage` a custom `WM_USER+N` to the form, handle it in the subclass proc
- The subclass proc runs on the main thread → safe to call IDispatch

### VB6 Control Visibility Summary

| Control Type | Has HWND | Visible to EnumChildWindows | Visible to COM Controls collection |
|---|---|---|---|
| TextBox | Yes | Yes (ThunderRT6TextBox) | Yes |
| CommandButton | Sometimes | Sometimes (ThunderRT6CommandButton) | **Yes** |
| Label | No | No | **Yes** |
| Image | No | No | **Yes** |
| PictureBox | Yes | Yes (ThunderRT6PictureBoxDC) | Yes |
| Frame | No | No | **Yes** |
| Shape/Line | No | No | **Yes** |
| SSTab | Yes | Yes | Yes |
| ListBox/ComboBox | Yes | Yes | Yes |

### Coordinate System

VB6 uses **twips** (1 twip = 1/1440 inch, 15 twips = 1 pixel at 96 DPI).
Convert: `pixels = twips / 15` (at standard 96 DPI).
The control's Left/Top are relative to its container (form client area).

### App Navigation Stats (from metadata analysis)

- 2152 apps with metadata extracted
- 77 apps have explicit `_Click` → `.Show` form navigation in decompiled source
- 144 apps have detected About/Credits/Splash forms
- 1632 apps are multi-form (but most extra "forms" are shared modules like dos32, monkefade)
- 491 apps are single-form
- 20 apps use SSTab tabbed controls
- Control types used as buttons: CommandButton, Label (54 instances), Image (4), Menu (25), custom-named (124)

## enumerate_controls.py

Full control inventory extracted statically from decompiled source and exe binaries.
No Wine/runtime needed.

```bash
python3 enumerate_controls.py path/to/app.decompiled.bas   # single app
python3 enumerate_controls.py --batch                       # all 1,369 apps
```

### Data Sources

1. **Decompiled source** — event handler names (`cmdPunt_Click`, `mnuExit_Click`) reveal control names and types. Works for native code and p-code decompiled output.
2. **Exe binary** — raw string scanning finds menu names (`mnu*` prefixed null-terminated strings) and their captions. Catches parent menu containers and items without click handlers.

### Batch Results (1,369 apps, 39,240 controls)

| Type | Count | Notes |
|---|---|---|
| Menu | 13,507 | Includes parent containers + leaf items |
| CommandButton | 11,937 | Most common interactive control |
| Unknown | 4,856 | Non-standard naming (no recognized prefix) |
| Label | 2,674 | Lightweight — invisible to Win32 API |
| Timer | 1,935 | No UI, but has event handlers |
| Form | 1,128 | Form_Load, Form_Unload handlers |
| TextBox | 941 | |
| ListBox | 478 | |
| Image | 468 | Lightweight — invisible to Win32 API |
| CheckBox | 421 | |
| PictureBox | 267 | |
| OptionButton | 263 | |
| ComboBox | 105 | |

### Verified Against Source

| App | Decompiled handlers | Binary menus | Total | Source match |
|---|---|---|---|---|
| Emoghoster 3 | 14 (9 menu + 5 other) | +2 parent menus | 25 | ✓ all 9 mnuXxx_Click found |
| aimClone | 18 (11 menu + 7 other) | +8 parent menus | 29 | ✓ all 11 mnuXxx_Click found |
| ScrollMoreShit | 9 (4 menu + 5 other) | +17 binary menus | 30 | ✓ all 4 mnuXxx_Click found |

## poc_walkthrough.py

Proof-of-concept screenshot walkthrough. Launches a single app, navigates its
forms, and assembles an animated GIF showing different views.

```bash
sudo python3 poc_walkthrough.py /path/to/app.exe
```

### Walkthrough Phases

1. **Main window screenshot** — client area only (no WM title bar)
2. **WM_COMMAND brute-force** — sends `PostMessage(hwnd, WM_COMMAND, id, 0)` for IDs 1..N, screenshots any new windows that appear, dismisses them, stops if main window dies. Replaces the unreliable keyboard menu walk.
3. **Tab cycling** — Ctrl+PageDown to cycle SSTabControl/SysTabControl32 tabs
4. **Nav-graph button clicks** — ONLY clicks CommandButtons that the nav graph says open another form. Avoids API-calling buttons (Start, Crack, Punt, etc.) that would crash/hang.

### Features

- **WM_COMMAND brute-force** — discovers VB6 menu actions by sending sequential command IDs. Works even though `GetMenu()` returns 0 cross-process under Wine.
- **Danger word filter** — skips menu windows whose titles contain exit/quit/close/end/send/kill/unload/terminate. Also skips nav graph dangerous controls.
- **Frame dedup** — identical consecutive screenshots discarded
- **c2host auto-recovery** — starts c2host.exe if not running
- **X11 window mapping** — resolves Wine hwnds to X11 window IDs for xdotool
- **Client-area capture** — SCREENSHOT `client` flag crops WM title bar ("as wineshot")
- **Nearest-neighbor upscale** — images < 400px wide get 2x+ upscaled
- **Early exit detection** — stops brute-force and skips remaining phases if main window dies

### Tested Results

| App | Frames | What happened |
|---|---|---|
| Emoghoster 3 | 4 | Main → WM_COMMAND found Load dialog (id=3), EG3/About (id=6), Screenname input (id=7). Exit at id=10. |
| aimClone | 6 | Main → WM_COMMAND found Enter Room (id=7), Leave All (id=9), Format (id=14), Encryption (id=16), About (id=17). Danger-filtered: Send IM (id=4), How Many To Send (id=5). Exit at id=18. |
| cools cracker helper | 3 | Main → clicked "Sns" CommandButton → "Cool Collect" form → clicked "Passwords" |
| gta's nauti tools | 2 | Main → Alt key menu activation (VB6 menus invisible to Win32 API) |
| ScrollMoreShit | 1 | 4 menus but all toggles (no visible windows opened). 0 ENUMCHILDREN (all lightweight). |
| Viking Toolz | 1 | All controls lightweight (0 ENUMCHILDREN), no navigation possible |

### Output

`tools/c2/poc_output/<app_name>/` — contains `01_main.bmp`, `02_*.bmp`, ..., `<app_name>.gif`

## VB6 Menu Problem — CRITICAL FINDING

### The Problem

VB6 menus don't respond to keyboard input (F10/Alt) via xdotool under Wine,
and `GetMenu()` returns NULL from c2host.exe (cross-process).

### Root Cause Analysis

1. **GetMenu returns 0 cross-process under Wine.** VB6's MSVBVM60.DLL creates
   real Win32 menus internally (`GetMenu(Me.hwnd)` works from INSIDE the process
   per vbforums.com). But Wine doesn't properly expose them via cross-process
   GetMenu for VB6 windows. Our c2host ENUMMENUS calls `GetMenu(hw)` → returns 0.

2. **F10/keyboard doesn't activate VB6 menus under Wine.** xdotool sends X11 key
   events, but Wine's VB6 runtime doesn't process F10/Alt for menu activation
   correctly. Tested on Emoghoster 3 (ThunderRT6FormDC) — F10 + Down produced
   identical screenshots, no `#32768` popup menu window appeared.

3. **VB6 menus ARE real Win32 menus.** The VB Decompiler article on form binary
   format (vb-decompiler.org/forms_editing.htm) confirms menus are stored as
   `Begin VB.Menu` objects with Caption, Enabled, Name properties, using `FF 05`
   (vbFormMenu) markers in the binary form data. MSVBVM60 creates them via
   CreateMenu/SetMenu at form load time.

### Solution: Brute-Force WM_COMMAND (IMPLEMENTED)

Implemented in `_bruteforce_wmcommand()` in poc_walkthrough.py. The approach:

1. Send `PostMessage(hwnd, WM_COMMAND, id, 0)` for IDs 1 through `max(menu_count * 3, 50)`
2. After each, check if a new VB window or `#32770` dialog appeared (using `FindWindowEx` chain to enumerate all instances)
3. Screenshot new windows, skip if title matches danger words
4. Dismiss via WM_COMMAND IDCANCEL → WM_CLOSE → Escape
5. Stop if main window dies (hit exit) or 50 consecutive no-ops

Key findings from testing:
- VB6 assigns WM_COMMAND IDs non-contiguously — gaps between menu IDs are normal (toolbar buttons, form controls also get IDs)
- Most menu items are toggles/actions that don't open windows — only ~30-50% produce visible dialogs
- `#32770` (common dialog) is the most common class for menu-triggered windows
- Danger word filter on titles ("send", "exit", "quit", "kill", etc.) effectively avoids harmful actions
- IDs are stable across launches but may shift slightly between runs

### Impact

- **237 apps** have real VB Menu objects (3,570 total menu items, avg 15.1 per app)
- **159 apps** have 5+ menu items
- Distribution: 55 apps with 1-3 menus, 84 with 4-10, 62 with 11-30, 36 with 31+
- All menu entries in nav graph start with `mnu` prefix (confirmed 237/237)
- Top menu actions: exit (76 apps), about (57), show (32), clear (27), save (21), load (15)
- **344 dangerous-sounding menu names** across all apps (exit, quit, close, kill, send, stop, unload variants)
- 13 apps have menus that navigate to other forms (nav graph `is_menu` entries)
- Only ~30-50% of menu IDs produce visible windows — rest are toggles, state changes, or AOL API calls

### Alternative: Extract Menu IDs from EXE Binary

VB6 form binary data (inside the exe) contains the full menu structure with
names and captions. The VB Decompiler can parse this. We could extract menu
item order statically, predict WM_COMMAND IDs (sequential), and only send
IDs for safe menu items. This avoids blind brute-force.

## Known Issues

- **16-bit NE executables** (VB3, .VBX) crash Wine and can take down Xvfb. Both scripts detect and skip them.
- **Non-VB exes** produce empty decompile output (34 "Output file is empty" errors). These are Delphi/C++ apps that VB Decompiler can't handle.
- **PrintWindow** doesn't work under Wine — windows return black. Using BitBlt from desktop DC with SetForegroundWindow instead.
- **Cross-process WM_SETTEXT** doesn't work under Wine — must use DLL injection.
- **VB6 lightweight controls invisible to Win32 API** — Labels, Images, CommandButtons (sometimes) have no HWND. Must use in-process COM enumeration via c2vb.dll.
- **VB6 menus invisible to cross-process GetMenu** — `GetMenu()` returns 0 for VB6 apps under Wine. Solved with WM_COMMAND brute-force (see above).
