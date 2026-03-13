# VB5/6 P-Code Decompilation Research

> Deep research conducted March 2026 for the AOL Underground Proggies archive.
> Goal: batch decompile all ~1,035 VB5/6 p-code executables in the collection.

## Table of Contents

- [Executive Summary](#executive-summary)
- [Background](#background)
- [Tool Landscape](#tool-landscape)
- [Tool Details](#tool-details)
- [Reference Papers & Documentation](#reference-papers--documentation)
- [Key Technical Findings](#key-technical-findings)
- [Source Code Repositories](#source-code-repositories)
- [Resource Archives](#resource-archives)
- [Dead Ends](#dead-ends)
- [Pipeline Recommendation](#pipeline-recommendation)
- [Research Sources](#research-sources)

---

## Executive Summary

**No open-source tool produces full VB source from p-code.** All free tools produce opcode-level mnemonics. The only tool claiming ~85% source recovery is VB Decompiler Pro ($99, closed source, GUI only). No tool in the entire ecosystem has CLI/batch mode — the only CLI-capable option is SekoiaLab's pe-tools (Python), which produces opcode disassembly with resolved strings and function names.

## Background

VB5/6 programs can be compiled to either **native code** (x86 machine instructions) or **p-code** (pseudocode interpreted by `msvbvm50.dll`/`msvbvm60.dll`). P-code is a stack-based bytecode with ~822 unique opcode handlers across 6 dispatch tables (lead bytes `0xFB`–`0xFF` prefix into secondary tables). 18 opcodes have variable-length arguments.

Our collection: **1,811 total EXEs**, of which **1,045 have VB5 signatures**, **1,035 are p-code**, **10 are native code**, and **748 are non-VB**.

P-code is NOT related to .NET MSIL. They are completely different virtual machines. No .NET tools (Reflector, ILSpy, dnSpy, etc.) can process VB5/6 binaries.

## Tool Landscape

| Tool | Author | Type | CLI? | P-Code Quality | Cost | Status |
|------|--------|------|------|----------------|------|--------|
| **pe-tools** | SekoiaLab | Python | **Yes** | Opcode mnemonics (1,346 opcodes) | Free | Active |
| **python-vb** | williballenthin | Python | **Yes** | Header/structure parsing only | Free | Active |
| **VbDec** | dzzie/Sandsprite | VB6 | GUI only | Good disassembly + string resolution | Free | DMCA'd from GitHub, source available |
| **Semi-VB-Decompiler** | VBGAMER45 | VB6 | GUI only | Partial (~10% of opcodes for VB translation) | Free | Open source |
| **P32Dasm** | DARKER/Progress Tools | Native | GUI only | Decompiler + .map file export | Free | v2.8 (2016) |
| **VB Decompiler Pro** | DotFix (_aLfa_) | Native | **No CLI** | Best: ~85% source recovery, 1400+ opcodes | $99/$230 | Active, closed source |
| **VBReFormer** | Qiil | Native | GUI only | Native code focus | Free/$58 | Active |
| **DoDi VBDIS3 [Reloaded]** | Nadu (port of DoDi) | VB6 (port) | GUI | Near-original VB3 source recovery | Free | VB6 port with source |
| **RACEVB6** | Unknown | Native | Unknown | VB6 PCode analyzer | Free | racevb6.com |
| **ExDec** | Josephco | Native | Unknown | Older p-code tool | Free | Historical |
| **WKTVBDE** | Mr. Silver & Mr. Snow | DLL injection | Runtime debugger | P-code debugging via opcode handler hooks | Free | v4.3, old |
| **pcodedmp** | Bontchev | Python | Yes | **VBA only** (Office macros, NOT VB5/6 EXEs) | Free | Active |
| **Zaid Markabi "VB6 Decompiler"** | Zaid Markabi | VB6 | GUI only | **Not a decompiler** — PE resource editor only | Free | Planet Source Code |

## Tool Details

### SekoiaLab pe-tools (RECOMMENDED for batch processing)

- **Repo:** https://github.com/SekoiaLab/pe-tools
- **Language:** Python
- **What it does:** PE32/PE64 binary analysis, VB5/6 header parsing, p-code function disassembly
- **Opcode coverage:** 1,346 opcodes defined in `petools/pcodes.csv`
- **Output:** Opcode mnemonics with resolved operands (strings, function names, offsets)
- **CLI:** Full command-line support
- **Limitation:** Produces assembly-level output, not VB source reconstruction
- **Status:** We have this cloned to `tools/vb_decompile_ref/pe-tools/`

### VbDec (dzzie/Sandsprite)

- **Website:** http://sandsprite.com
- **Source:** Available via mega.nz source pack (extracted to `tools/vb_decompile_ref/vbdec_source/vbdec/`)
- **GitHub:** Was at `github.com/dzzie/VBDec` — DMCA'd, but Wayback Machine has full snapshot
- **Key source file:** `modPCode2.bas` (1,093 lines) — main p-code disassembly engine with `Decode2()` and `DecompileProc2()`
- **Output types:** `PcodeOut.txt` (raw disassembly), `PcodeToVB.txt` (mnemonics with resolved strings), `FileReport.txt` (PE/VB headers)
- **CLI:** Accepts file path on command line but only opens GUI — no headless/batch dump mode
- **Plugin system:** COM DLLs
- **93 VB6 source files** (.bas/.frm/.cls/.vbp)
- **Pre-compiled `vbdec.exe` included**
- **Installer:** `VBDEC_Setup.exe` (3.9MB PE32)

### Semi-VB-Decompiler (VBGAMER45)

- **Repo:** https://github.com/VBGAMER45/Semi-VB-Decompiler
- **What it does:** VB6 structure parsing, partial p-code→VB translation
- **P-code coverage:** ~10% of opcodes have VB translation (140 lines in `modPCodeToVB.bas`)
- **Canonical opcode table:** `modPCode.bas` has opcode size/format definitions
- **Status:** Open source, we have this cloned to `tools/vb_decompile_ref/Semi-VB-Decompiler/`

### P32Dasm

- **Website:** http://progress-tools.x10.mx/p32dasm.html
- **What it does:** VB5/6 PCode + Native code decompiler, string/number/object listing, .map file generation (importable to IDA/OllyDbg)
- **Current version:** 2.8 (March 2016)
- **Download:** 271 KB zip from website
- **Languages:** Arabic, Czech, English, German, Chinese, Korean, Russian, Slovak, Spanish, Turkish
- **CLI:** No evidence of command-line support — appears GUI only

### VB Decompiler Pro (DotFix)

- **Website:** https://www.vb-decompiler.org / https://www.dotfixsoft.com
- **What it does:** Best-in-class p-code decompilation with ~85% source recovery, 1400+ opcodes
- **Also supports:** VB native code (with emulator), .NET (C#/VB.NET MSIL)
- **Cost:** $99 (home) / $230 (business)
- **CLI/batch mode:** **Not available.** Documentation describes GUI-only workflow. No command-line flags, no scripting API, no batch automation.
- **Author:** Known as `_aLfa_` in the VB reversing community since ~2003

### DoDi's VBDIS3 — VB3 Decompiler [Reloaded]

- **Original author:** DoDi (~1997), written in VB3 itself (16-bit only)
- **Reloaded by:** Nadu (~2013) — cracked the original, made it decompile itself, then ported it to VB6 (32-bit, with source code)
- **What it does:** Decompiles VB3 executables to near-original source code. VB3/VB4 p-code is much simpler than VB5/6 and can be reliably decompiled.
- **Website:** http://vbdis4.angelfire.com
- **Wayback:** http://web.archive.org/web/20090301170633/http://vbdis4.angelfire.com
- **Archive filename:** `VBDIS3.67e_Reloaded_Rev3_DoDi_s_VB3Decompiler.7z`
- **Also on sandsprite:** `files/Vb3dec.zip` (original DoDi version)
- **Relevance to this collection:** AOHell (by Da Chronic, targeting AOL 2.5/3.0) is a VB3 program. The `INSTALL.EXE` in our archive is a Wise Setup 16-bit NE installer with the actual VB3 binary compressed inside. Any other VB3 proggies in the collection targeting AOL 2.5–3.0 era would also be candidates.
- **Igor Skochinsky (IDA Pro dev) confirmed:** VB3/VB4 programs "could be usually decompiled to almost original code" unlike later native-compiled versions.

### WKTVBDE (Mr. Silver & Mr. Snow)

- **What it does:** Runtime p-code debugger via DLL injection
- **How it works:** Loader injects debugger DLL into target process, hooks all VB runtime p-code handler dispatch tables. The entire debugging UI runs inside the target process.
- **Versions:** v1.4 and v4.3 available on sandsprite.com
- **Help file:** Contains listing of VB opcodes with argument counts
- **Not suitable for batch processing** — requires running each target

## Reference Papers & Documentation

### Alex Ionescu — "Visual Basic Image Internal Structure Format"

- **Author:** Alex Ionescu (co-author of "Windows Internals", ReactOS contributor)
- **Content:** Definitive documentation of VB5/6 PE internal structures and constants
- **Original URL:** `http://www.alex-ionescu.com/vb.pdf` (dead)
- **Wayback:** https://web.archive.org/web/20071020232030/http://www.alex-ionescu.com/vb.pdf
- **Local copy:** http://sandsprite.com/vb-reversing/files/Alex_Ionescu_vb_structures.pdf
- **Forum discussion:** Ionescu posted updates on the sandsprite VB Decompiler forum (2004), correcting earlier structure definitions

### Andrea Geddon — "Visual Basic Reversed: A Decompiling Approach"

- **Content:** Comprehensive approach to VB binary decompilation
- **Available at:** https://forum.tuts4you.com/files/file/1322-visual-basic-a-decompiling-approach/
- **Local copy:** http://sandsprite.com/vb-reversing/files/VISUAL%20BASIC%20REVERSED.pdf

### Sanchit Karve — "Disassembling Visual Basic Applications" (Parts I & II)

- **Content:** Practical guide to VB binary disassembly
- **Local copies on sandsprite:** `files/DISASSEMBLING VISUAL BASIC APPLICATIONS by Sanchit Karve.zip`

### Gen Digital/Avast (dzzie) — "VB6 P-Code Disassembly" (2024)

- **URL:** https://www.gendigital.com/blog/insights/research/vb6-p-code-disassembly
- **Content:** Most recent and comprehensive technical writeup on VB6 p-code internals
- **Key details:**
  - ~822 unique opcode handlers across 6 dispatch tables
  - Lead bytes 0xFB–0xFF prefix into secondary tables
  - 18 opcodes have variable-length arguments
  - Opcode naming conventions documented
  - 13 post-processors handle ~30 complex opcodes
  - dzzie mentions working on a new disassembly engine (not publicly released)

### Mr. Silver — "VB P-code Information"

- **Content:** Details on how the VB6 runtime processes p-code, how WKTVBDE implements its debugger
- **Local copy:** http://sandsprite.com/vb-reversing/files/VB%20P-code%20Information%20by%20Mr%20Silver.html

### John Chamberlain — "Microsoft's P-Code Implementation" (2001)

- **Content:** Microsoft's own p-code technology documentation
- **P-Code Extractor:** VBA add-in for extracting and disassembling compiled bytecodes
- **URL:** http://sandsprite.com/vb-reversing/johnChamberlain/

### Richard Marko (ESET) — "VB Wearing the Inside Out" (Virus Bulletin 2002)

- **Content:** VB malware analysis from an AV perspective
- **PDF:** https://www.virusbulletin.com/uploads/pdf/magazine/2002/200206.pdf

### Jurriaan Bremer & Marion Marschalek — VB6 Tracer Presentation

- **Content:** Runtime tracing of VB6 applications
- **Tool:** https://github.com/jbremer/vb6tracer

## Key Technical Findings

### VB5 vs VB6 P-Code Differences

From dzzie's research (sandsprite.com/vb-reversing/):

- VB6 adds **21 new p-code opcodes** compared to VB5 (table 5, indices 0x34–0x45)
- VB6 adds **33 new exports** to the runtime DLL
- VB5 table 5 has 0x33 entries, VB6 has 0x45
- Most opcode handlers are functionally identical between VB5/VB6 with some name changes
- New VB6 opcodes include: `StAryRecMove`, `StAryRecCopy`, `Bos`, `CDargRefUdt`, `CVarRefUdt`, `CVarUdt`, `StUdtVar`, `StAryVar`, `CopyBytesZero`, `FLdZeroAry`, `FStVarZero`, `CVarAryUdt`, `RedimVarUdt`, `RedimPreserveVarUdt`, `VarLateMemLdRfVar`, `VarLateMemCallLdRfVar`, `VarLateMemLdVar`, `VarLateMemCallLdVar`, `VarLateMemSt`, `VarLateMemCallSt`, `VarLateMemStAd`

### Debug Symbols Available

Microsoft released debug symbols for VB5/6 runtimes:
- `vb6.dbg` and `vba6.dbg` — available on sandsprite.com
- `msvbvm50.dll` with full symbols including `.Engine` opcode handlers
- VB5 SP3 debugging symbols: `VB5SP3DS.EXE` (Microsoft KB Q188588)
- VB5 SP2 debugging symbols: `VB5SP2DS.EXE` (Microsoft KB Q176547)

### Opcode Data Sources

| Source | Opcode Count | Format |
|--------|-------------|--------|
| pe-tools `pcodes.csv` | 1,346 | CSV with sizes |
| Semi-VB-Decompiler `modPCode.bas` | ~800 | VB6 arrays with sizes |
| VB Decompiler Pro | 1,400+ | Proprietary |
| MrUnleaded/Moogman/Napalm opcode DB | Unknown | HTML (on sandsprite) |
| WKTVBDE help file | ~800 | Opcode listing with arg counts |

### The vb-decompiler.theautomaters.com Archive

The retired VB Decompiler message board (hosted by TheAutomaters.com) was a key community resource. dzzie worked with admin MrUnleaded to preserve it:
- Available as flat HTML files, ZIP, and CHM format
- Hosted at: http://sandsprite.com/vb-reversing/vb-decompiler/
- Download: http://sandsprite.com/vb-reversing/vbdecompiler.zip
- CHM: http://sandsprite.com/vb-reversing/vbdecompiler.chm

## Source Code Repositories

### Cloned to `tools/vb_decompile_ref/`

| Directory | Repo | Description |
|-----------|------|-------------|
| `Semi-VB-Decompiler/` | VBGAMER45/Semi-VB-Decompiler | VB6 source, GUI, partial p-code→VB |
| `pe-tools/` | SekoiaLab/pe-tools | Python PE parser + VB header + p-code disassembler |
| `python-vb/` | williballenthin/python-vb | Python VB5/6 header/structure parsing |
| `vbdec_source/vbdec/` | dzzie/VBDec (DMCA'd) | VB6 source, 93 files, best open-source p-code disassembler |

### Other Relevant Repos

| Repo | Description |
|------|-------------|
| `commanderz/vb6_decompilers` | dzzie's resource page listing all VB6 reversing tools |
| `vb-decompiler/vb-decompiler-bb` | Archived message board (flat HTML + CHM) |
| `pmachapman/semi-vb-decompiler` | Fork of Semi-VB-Decompiler from Planet Source Code |
| `jbremer/vb6tracer` | Runtime VB6 tracer |
| `bontchev/pcodedmp` | VBA p-code disassembler (Office macros only, NOT VB5/6 EXEs) |
| Nadu/VBDIS3 Reloaded | DoDi's VB3 decompiler ported to VB6 (32-bit, with source) |

## Resource Archives

### sandsprite.com/vb-reversing/ (Master Resource Page)

dzzie's definitive collection of VB reversing resources. Key downloads:

- `files/Alex_Ionescu_vb_structures.pdf` — VB internal structures
- `files/VISUAL BASIC REVERSED.pdf` — Andrea Geddon's decompiling approach
- `files/VB P-code Information by Mr Silver.html` — P-code runtime internals
- `files/msvbvm60.zip` — VB6 runtime with debug symbols
- `files/msvbvm50_w_symbols.zip` — VB5 runtime with full symbols (including .Engine handlers)
- `opcode_db.zip` — P-code opcode database by MrUnleaded, Moogman, and Napalm
- `files/vb.idc` — VB6 IDA script by Reginald Wong
- `files/WKTVBDE1.4.zip` and `files/WKTVBDE4.3.rar` — P-code debugger
- `files/betaexdec.zip` and `files/ExDec.zip` — ExDec by Josephco
- `files/Vb3dec.zip` — DoDi's VB3 decompiler
- `files/Microsoft P-Code Technology_msdn_c7pcode2.pdf` — Microsoft's own p-code docs
- `vb_symbols.zip` — Dump of VB5/6 symbols/binaries/IDBs

### Exetools Forum Thread

- **URL:** https://forum.exetools.com/showthread.php?t=20340
- **Title:** "Sandsprite VB Decompiler Source Code"
- **Content:** Discussion of VbDec source release, DMCA backstory, mega.nz download links

## Dead Ends

| Lead | Result |
|------|--------|
| Planet-Source-Code Zaid Markabi "VB6 Decompiler" | **Not a decompiler.** PE resource editor (edit strings/images in EXEs). Misleading title. |
| .NET Reflector / ILSpy / dnSpy | **Wrong target.** These are for .NET MSIL bytecode, not VB5/6 p-code. Completely different VMs. |
| pcodedmp (Bontchev) | **Wrong target.** Disassembles VBA p-code in Office documents, not VB5/6 compiled EXEs. |
| Wayback Machine for dzzie/VBDec raw files | 404 — raw.githubusercontent.com URLs not cached. Repo page itself is cached but we already have the full source. |
| GitHub DMCA notices for VBDec | No specific DMCA notice found in github.com/github/dmca repo. The takedown happened but the notice isn't publicly indexed. |
| VB Decompiler Pro CLI mode | **Does not exist.** Documentation describes GUI-only product with no command-line, scripting, or batch capabilities. |
| Usenet archives | No significant additional findings beyond what's already documented in the RE Stack Exchange and sandsprite resources. |

## Pipeline Recommendation

### Option A: Python Pipeline with pe-tools (RECOMMENDED)

- Use SekoiaLab pe-tools for p-code disassembly (CLI, Python, 1,346 opcodes)
- Use python-vb for VB header/structure parsing (form definitions, control names, project info)
- **Output:** Opcode-level mnemonics with resolved strings, function names, form definitions
- **Pros:** Fully automated, CLI, we have everything needed, runs on macOS/Linux natively
- **Cons:** No source-level reconstruction (produces `LitStr "Hello"` not `MsgBox "Hello"`)

### Option B: VbDec under Wine with GUI automation

- Run `vbdec.exe` under Wine on Linux box
- Use xdotool/xvfb for headless GUI automation
- **Output:** Better quality disassembly with PcodeToVB translation
- **Pros:** Better output than pe-tools
- **Cons:** Fragile, slow, Wine compatibility issues, painful to debug

### Option C: Modify VbDec source for CLI output

- We have the full VB6 source (93 files)
- `frmMain.frm` already handles `Command()` for file path input
- Add code path: if command-line arg present, auto-load → dump all three outputs → exit
- Compile with VB6 IDE under Wine
- **Pros:** Best free output quality, true batch mode
- **Cons:** Requires VB6 compiler (available under Wine), development effort

### Option D: Buy VB Decompiler Pro ($99)

- Best quality output (~85% source recovery)
- **No CLI mode** — would still need GUI automation
- **Not recommended** unless DotFix adds batch support

### Verdict

**Start with Option A** (pe-tools Python pipeline). It's the only fully automatable path. The output — every string, API call, function name, and control flow for all 1,035 p-code executables — will be enormously valuable to the AOL Underground community even without full VB source reconstruction.

---

## Research Sources

1. SekoiaLab/pe-tools — https://github.com/SekoiaLab/pe-tools
2. VBGAMER45/Semi-VB-Decompiler — https://github.com/VBGAMER45/Semi-VB-Decompiler
3. williballenthin/python-vb — https://github.com/williballenthin/python-vb
4. commanderz/vb6_decompilers — https://github.com/commanderz/vb6_decompilers
5. dzzie/VBDec (Wayback) — https://web.archive.org/web/2022/https://github.com/dzzie/VBDec
6. Sandsprite VB Reversing — http://sandsprite.com/vb-reversing/
7. Gen Digital VB6 P-Code Disassembly — https://www.gendigital.com/blog/insights/research/vb6-p-code-disassembly
8. Exetools Forum Thread — https://forum.exetools.com/showthread.php?t=20340
9. VB Decompiler Pro — https://www.vb-decompiler.org/help/description.htm
10. P32Dasm — http://progress-tools.x10.mx/p32dasm.html
11. RE Stack Exchange — https://reverseengineering.stackexchange.com/q/1597
12. Sandsprite VB Decompiler Forum — http://sandsprite.com/vb-reversing/vb-decompiler/
13. Alex Ionescu VB Structures (Wayback) — https://web.archive.org/web/20071020232030/http://www.alex-ionescu.com/vb.pdf
14. tuts4you — https://forum.tuts4you.com/files/file/1322-visual-basic-a-decompiling-approach/
15. Planet-Source-Code Zaid Markabi — https://github.com/Planet-Source-Code/zaid-markabi-vb6-decompiler-updated-with-source__1-72111
16. bontchev/pcodedmp — https://github.com/bontchev/pcodedmp
17. jbremer/vb6tracer — https://github.com/jbremer/vb6tracer
18. VB Decompiler P-Code Table — https://www.vb-decompiler.org/vb_pcode_table.htm
19. John Chamberlain P-Code Extractor — http://sandsprite.com/vb-reversing/johnChamberlain/
20. Stack Overflow VB3 Decompiler thread — https://stackoverflow.com/questions/3983709/vb3-decompiler
21. DoDi VBDIS3 Reloaded (Nadu) — http://vbdis4.angelfire.com
