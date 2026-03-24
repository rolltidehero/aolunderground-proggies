# VB Decompiler Wine Setup (SUPERSEDED)

**Status:** Superseded by QEMU VM approach. See `docs/2026-03-07-pla.md`.

## What This Was

Plan to run DoDi's VBDIS3/VBOPT4 decompilers under Wine on Linux headlessly.
Abandoned because:
- Wine GUI automation was unreliable (cross-process WM_SETTEXT fails)
- Required DLL injection workaround (c2dll.dll)
- VB Decompiler Pro in a Windows VM is simpler and handles VB3-VB6

## What We Learned (still relevant)
- Cross-process WM_SETTEXT does NOT work under Wine (pointer not marshaled)
- DLL injection via CreateRemoteThread + LoadLibraryA works for in-process control
- Delphi TMainMenu doesn't use Win32 menu API — use WM_COMMAND with brute-forced IDs
- VB Decompiler Pro menu IDs: 2=Open, 10=Save Project, 25=About (stable, DFM-ordered)

These patterns are preserved in `.kiro/steering/win32-api-automation.md`.
