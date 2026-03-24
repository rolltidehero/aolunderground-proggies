---
inclusion: always
description: VB3/VB4/VB5/VB6 language differences and gotchas when compiling decompiler-recovered source.
---

# Visual Basic Version Compatibility — Mandatory Reference

## VERSION TIMELINE

| Version | Year | Runtime | Key change |
|---------|------|---------|------------|
| VB1/VB2 | 1991-92 | VBRUN100/200.DLL | 16-bit only |
| VB3 | 1993 | VBRUN300.DLL | Jet 1.1, VBX controls |
| VB4 | 1995 | VB40016/32.DLL | First 32-bit, OLE controls, `Public`/`Private` replace `Global` |
| VB5 | 1997 | MSVBVM50.DLL | 32-bit only, native code compile option |
| VB6 | 1998 | MSVBVM60.DLL | Final classic VB, ADO, enhanced forms |

## CRITICAL LANGUAGE DIFFERENCES BY VERSION

### VB3 → VB4/VB5/VB6 Breaking Changes

**Variable scope keywords:**
- VB3: `Global varName As Type` (module-level public)
- VB4+: `Public varName As Type` (preferred), `Global` still accepted as synonym in standard modules
- VB6 compiles `Global` fine in `.BAS` modules — NOT a compile error

**Numeric line labels (BASIC heritage):**
- VB3 source often has bare numeric labels: `7000`, `7010` on their own line
- These are GoTo targets, NOT variables
- VB6 supports numeric line labels — they do NOT cause "Variable not defined" errors
- Example valid VB6: `7010` on its own line, then `GoTo 7010` elsewhere

**16-bit Declare statements:**
- VB3: `Declare Function Foo Lib "Kernel" (...)` — 16-bit Windows API
- VB6: Must use `Lib "kernel32"` with `Alias "FooA"` for ANSI versions
- VB3 source often has both versions, with the 16-bit one commented out
- VB6 will fail if an uncommented 16-bit `Declare` is present

**Type suffixes:**
- All versions: `%` = Integer, `&` = Long, `!` = Single, `#` = Double, `$` = String, `@` = Currency
- VB3 used these heavily; VB6 prefers `As Type` but accepts suffixes

**String functions:**
- VB3: `Left$`, `Right$`, `Mid$` return String (faster)
- VB6: `Left`, `Right`, `Mid` return Variant; `Left$` etc. still work

### VB6 Compile Requirements

**Option Explicit + Global scope:**
- `Global` in a `.BAS` module IS visible project-wide in VB6 — same as `Public`
- "Variable not defined" for a `Global` var means the `.BAS` module declaring it isn't in the project, OR the type library providing the constant isn't loaded

**Built-in constants (vbNormal, vbModal, etc.):**
- These come from VB6.OLB (Visual Basic Objects and Procedures type library)
- GUID: `{EA544A21-C82D-11D1-A3E4-00A0C90AEA82}` version 6.0
- If VB6.OLB is not registered with its file path, ALL `vb*` constants are undefined
- NanoVB6's VB6.reg does NOT register type library paths — only license keys
- Must manually register: `VB6.OLB`, `VBA6.DLL`, `DAO350.DLL` paths in registry

**VBP Reference lines:**
- Without `Reference=` lines, VB6 uses its default references (VB6.OLB, VBA6.DLL, stdole2.tlb)
- But "default" means VB6 looks them up by GUID in the registry — if not registered, they fail silently and constants are undefined
- Always verify type library registrations before blaming source code

## NANOVB6 SPECIFIC ISSUES

NanoVB6 is a portable VB6 compiler (~5MB). It includes the binaries but its `VB6.reg` only adds license keys. After extracting NanoVB6, you MUST also register the type library paths:

```reg
[HKEY_CLASSES_ROOT\TypeLib\{EA544A21-C82D-11D1-A3E4-00A0C90AEA82}\6.0\0\win32]
@="C:\\Program Files\\Microsoft Visual Studio\\VB98\\VB6.OLB"

[HKEY_CLASSES_ROOT\TypeLib\{000204EF-0000-0000-C000-000000000046}\6.0\0\win32]
@="C:\\Program Files\\Microsoft Visual Studio\\VB98\\VBA6.DLL"

[HKEY_CLASSES_ROOT\TypeLib\{00025E01-0000-0000-C000-000000000046}\4.0\0\win32]
@="C:\\Program Files\\Microsoft Visual Studio\\VB98\\DAO350.DLL"
```

## DIAGNOSING "VARIABLE NOT DEFINED" IN RECOVERED VB3 SOURCE

When VB6 reports "Variable not defined" for a known VB constant (vbNormal, vbModal, vbInformation, etc.):
1. **Check type library registration first** — not a source code problem
2. Run: `wine reg query "HKEY_CLASSES_ROOT\TypeLib\{EA544A21-C82D-11D1-A3E4-00A0C90AEA82}\6.0\0\win32"`
3. If that key is missing or has no path, register VB6.OLB

When VB6 reports "Variable not defined" for a project variable:
1. Check it's declared `Global` or `Public` in a `.BAS` module (not a Form)
2. Verify that `.BAS` module is listed in the `.VBP` file
3. Check for typos — VB6 is case-insensitive but `Option Explicit` catches undeclared names

## DECOMPILER-RECOVERED SOURCE PATTERNS

Source recovered by VBDIS3/VBOPT4 from VB3 executables will have:
- Numeric line labels (`7000`, `7010`) — valid, leave them
- `Global` declarations in MAIN.bas — valid in VB6 standard modules
- Mixed 16-bit/32-bit Declare statements — 16-bit ones must be commented out
- `mc0048 = 48` style constants (hex literals as integers) — valid
- Missing `Option Explicit` in some modules — add if needed for compile
- Form references like `FrmMain.Show` — require the form to be in the VBP
