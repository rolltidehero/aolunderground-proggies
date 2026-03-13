# AOL Proggies — Compiler & Language Breakdown

Generated: 2026-03-03
Total archives analyzed: **2,144**

## Summary

The overwhelming majority of AOL proggies were written in Microsoft Visual Basic.
This document breaks down every executable in the archive by compiler, VB version,
compilation type (p-code vs native), and PEiD signature match.

## VB Version Distribution

| Version | Count | % |
|---------|------:|--:|
| VB3 | 178 | 8.3% |
| VB4-16 | 3 | 0.1% |
| VB4-32 | 446 | 20.8% |
| VB5 | 330 | 15.4% |
| VB6 | 754 | 35.2% |
| non-VB | 433 | 20.2% |
| **Total** | **2,144** | **100%** |

## Compilation Type

| Version | P-code | Native | Unknown | Total |
|---------|-------:|-------:|--------:|------:|
| VB3 | 178 | - | - | 178 |
| VB4-16 | 3 | - | - | 3 |
| VB4-32 | - | - | 446 | 446 |
| VB5 | 50 | 276 | 4 | 330 |
| VB6 | 126 | 601 | 27 | 754 |
| non-VB | - | - | 433 | 433 |
| **Total** | **357** | **877** | **910** | **2,144** |

Notes:
- VB3 and VB4-16 are always p-code (16-bit interpreters)
- VB4-32 shows 'unknown' because its PE structure differs from VB5/6
- VB5/6 'unknown' entries have corrupted or non-standard headers
- 'non-VB' includes C++, Delphi, installers, and packed executables

## PEiD Compiler/Packer Identification

| PEiD Signature | Count |
|----------------|------:|
| Microsoft Visual Basic v5.0 | 799 |
| Microsoft Visual Basic 4.0 | 485 |
| (unknown) | 239 |
| Installer VISE Custom | 28 |
| Microsoft Visual C++ v4.2 | 22 |
| Microsoft Visual Basic v5.0 - v6.0 | 13 |
| TLink v%v5.%v6 | 9 |
| Inno Setup Module Heuristic Mode | 8 |
| Borland Delphi 4.0 | 7 |
| Microsoft Visual C++ v5.0 | 6 |
| ASPack v2.1 | 5 |
| Netopsystems FEAD Optimizer 1 | 4 |
| Microsoft Visual C++ v6.0 | 3 |
| Setup Factory v6.0.0.3 Setup Launcher | 2 |
| Symantec Visual Cafe v3.0 | 2 |
| tElock 0.98 -> tE! | 2 |
| Inno Setup Module v5 | 2 |
| Neolite v2.0 | 1 |
| Nullsoft Install System v1.98 | 1 |
| InstallShield 3.x Custom | 1 |
| FSG v1.10 -> bart/xt | 1 |
| Microsoft Visual C++ | 1 |
| Exe Guarder v1.8 -> Exeicon.com (h) | 1 |
| Microsoft Visual C++ DLL | 1 |
| tElock 0.96 -> tE! | 1 |
| ASProtect 1.1 BRS -> Solodovnikov Alexey | 1 |
| Armadillo v2.52 - v2.8x >> $ignBy AT4RE | 1 |
| Borland Delphi v3.0 | 1 |
| FSG v1.0 | 1 |
| Rar SFX Archive | 1 |

Notes:
- 'Microsoft Visual Basic v5.0' matches both VB5 and VB6 (PEiD uses the same VB5! header signature)
- Our VB version detector is more precise — it checks the actual runtime DLL import (MSVBVM50 vs MSVBVM60)
- The 13 'v5.0 - v6.0' entries are correctly resolved: 12 VB6, 1 VB5

## Non-VB Executables

| Type | Count | Examples |
|------|------:|---------|
| MSVC++ | 35 | C/C++ compiled (v4.2, v5.0, v6.0) |
| Borland Delphi | 8 | Object Pascal (Delphi 3.0/4.0) |
| Installer VISE | 28 | Setup stubs with compressed payloads |
| Inno Setup | 10 | Pascal-based installer framework |
| Packers/Protectors | 12 | ASPack, tElock, Neolite |
| Unknown | 239 | No PEiD signature match (may be NE/16-bit or custom) |
| Other | 20 | Setup Factory, Nullsoft, Symantec Visual Cafe, TLink |

## Proggie Categories

| Category | Count | % |
|----------|------:|--:|
| unsorted [A-O] | 503 | 23.5% |
| idlers | 304 | 14.2% |
| unsorted [P-Z] | 303 | 14.1% |
| ccoms | 234 | 10.9% |
| unsorted [A-O] | 177 | 8.3% |
| punters | 108 | 5.0% |
| faders | 88 | 4.1% |
| busters | 82 | 3.8% |
| mmservers | 57 | 2.7% |
| crackers | 57 | 2.7% |
| aolxers | 45 | 2.1% |
| unsorted [P-Z] | 45 | 2.1% |
| termers | 43 | 2.0% |
| orgd | 30 | 1.4% |
| scrollers | 27 | 1.3% |
| mmers | 23 | 1.1% |
| filters | 10 | 0.5% |
| nzscf | 3 | 0.1% |
| antis | 2 | 0.1% |
| aol2.5 | 1 | 0.0% |
| pwls | 1 | 0.0% |
| aol4.0 | 1 | 0.0% |

## P-code Decompilation Targets

**357 executables** are compiled to p-code and can potentially be decompiled
back to near-original Visual Basic source code.

| Version | P-code Count | Decompiler |
|---------|-------------:|------------|
| VB3 | 178 | DoDi VBDIS3 Reloaded |
| VB4-16 | 3 | DoDi VBDIS4 Reloaded |
| VB5 | 50 | DoDi VBDIS4 Reloaded / VbDec |
| VB6 | 126 | VbDec / Semi-VBDecompiler |
| **Total** | **357** | |

## Detection Methodology

### VB Version Detection
- **NE (16-bit) executables**: Check imported module names for VBRUN100/200/300 (VB1-3) or VB40016 (VB4-16)
- **PE (32-bit) executables**: Locate `VB5!` signature in the binary, then check runtime DLL import:
  - `VB40032.DLL` → VB4-32
  - `MSVBVM50.DLL` → VB5
  - `MSVBVM60.DLL` → VB6

### P-code vs Native Detection
- VB5/6: Read `ProjectInfo.aNativeCode` field (offset +0x20 from ProjectInfo structure)
  - Value = 0 → p-code
  - Value ≠ 0 → native code
- VB3/VB4-16: Always p-code (16-bit VB had no native compilation)
- VB4-32: Detection method TBD (different internal structure)

### PEiD Identification
- Python `peid` package (v2.2.1) with 5,500+ signatures
- Identifies compiler, packer, and installer frameworks
- Supplements VB detection for non-VB executables
