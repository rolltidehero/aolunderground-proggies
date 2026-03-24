# Screenshot & GIF Walkthrough Pipeline (SUPERSEDED)

**Status:** Partially superseded. The Wine-based approach was abandoned.
Screenshot automation will use the QEMU VM with QMP screendump instead.
See `docs/2026-03-07-pla.md` Phase 7 for video recording approach.

## What This Was

2,981-line strategy doc for running VB3-VB6 proggies under Wine, taking
screenshots, and generating GIF walkthroughs. Key components:
- Xvfb headless display
- AHK/xdotool for GUI automation
- c2host.exe DLL injection for WM_COMMAND brute-forcing
- enumerate_controls.py for static control analysis

## What We Learned (still relevant)
- WM_COMMAND brute-force discovers Delphi/VB menu items reliably
- VB6 apps: GetMenu returns 0 cross-process (Wine limitation)
- enumerate_controls.py found 39,240 controls across 1,369 apps
- nav_graphs.json (2,152 entries) has clickable controls per app
- metadata.json (2,152 entries) has forms, features, deps per app

## Data Produced (still in use)
- `tools/c2/metadata.json` — 5.7MB, 2,152 exe metadata
- `tools/c2/nav_graphs.json` — 2.3MB, navigation graphs
- `tools/c2/screenshot_checkpoint.json` — progress tracking
- `tools/c2/decompile_checkpoint.json` — decompile progress
- `tools/c2/frx_checkpoint.json` — FRX extraction progress
- `tools/c2/poc_output/*/wmcommand_map.json` — discovered menu IDs
