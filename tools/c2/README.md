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

## Known Issues

- **16-bit NE executables** (VB3, .VBX) crash Wine and can take down Xvfb. Both scripts detect and skip them.
- **Non-VB exes** produce empty decompile output (34 "Output file is empty" errors). These are Delphi/C++ apps that VB Decompiler can't handle.
- **PrintWindow** doesn't work under Wine — windows return black. Using BitBlt from desktop DC with SetForegroundWindow instead.
- **Cross-process WM_SETTEXT** doesn't work under Wine — must use DLL injection.
- **VB6 lightweight controls invisible to Win32 API** — Labels, Images, CommandButtons (sometimes) have no HWND. Must use in-process COM enumeration via c2vb.dll.
- **Animated GIFs currently broken** — TCM_SETCURSEL doesn't repaint VB6 SSTab under Wine. WM_COMMAND brute force doesn't work on VB6. Needs c2vb.dll for source-aware navigation.
