# VB Decompiler Wine Setup — Requirements

## Problem Statement

Get DoDi's VB decompilers (VBDIS3 for VB2/VB3, then VBOPT4 for VB4-32/VB5)
running under Wine on Linux headlessly over SSH. Prove each works by
decompiling an exe with known source to compare against.

## Scope

- VBDIS3 first, then VBOPT4
- Single exe decompilation only — no batch processing yet

## Functional Requirements

1. Fresh Wine + VB6 runtime install on Linux
2. Xvfb for headless operation (box has GUI but accessed via SSH only)
3. VBDIS3 (rev3, VB6 port) decompiles VBDIS3org.EXE successfully
4. VBOPT4 decompiles SETUP_Vb4.EXE successfully
5. Decompiled output compared against known source in each case
6. All steps documented and repeatable

## Headless Requirements

Both tools are GUI apps (VB6) that create windows even in CLI mode:

- Xvfb provides virtual display
- Screenshots taken every few seconds via `import -window root`
- Tesseract OCR on each screenshot, text printed to console so user can
  follow along over SSH
- Raw PNG screenshots also saved for manual inspection / SCP
- xdotool auto-dismisses MsgBox dialogs
- Xvfb cleanup on start (kill stale) + trap on EXIT/SIGINT/SIGTERM

## Success Criteria

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

## User Answers

**Q: VBDIS3 only or both tools?**
A: Both — VBDIS3 first, then VBOPT4.

**Q: Test target for VBDIS3?**
A: Use VBDIS3org.EXE — the tool decompiling its own ancestor. Known source
path for comparison.

**Q: Which VBDIS3 build?**
A: Research it, pick whatever gives best chance of success. Result: rev3
(pre-compiled VB6 port, 180KB, protection bypass built in). Rev5 is
developer-only, needs VB6 IDE.

**Q: Wine already installed?**
A: No, fresh install needed.

**Q: Headless or GUI?**
A: Headless — accessed over SSH only. Box has a GUI but user can't access
it remotely (NoMachine didn't work).

**Q: How to detect completion?**
A: Take screenshots every few seconds from the start, OCR them, print text
to console. User observes what's happening. No fragile file-watching
heuristics.

**Q: Worried about Wine install impact?**
A: Yes. Split Wine install from other deps. Document rollback. i386
architecture enable is acceptable since it's standard and reversible.
