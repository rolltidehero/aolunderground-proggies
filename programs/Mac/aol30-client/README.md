# America Online v3.0 — Mac Client

Two AOL 3.0 Mac installers: 68K (v3.0.1) and PPC (v3.0B). AOL 3.0 is significant because
it represents a major architectural shift — the FDO91 Manual (AOL internal, February 1998)
states in its introduction that FDO91 was designed for "Windows and Macintosh platforms" while
FDO88 was "the original online service forms display language developed for the Apple II
platform."

## Downloads

| Installer | File | Size | Architecture |
|-----------|------|------|-------------|
| [AOL 3.0.1 (68K)](InstallaOL3-0.1.sit) | `InstallaOL3-0.1.sit` | 3.7MB | Motorola 68K |
| [AOL 3.0B (PPC)](InstallaOL3.0bppc.sit) | `InstallaOL3.0bppc.sit` | 3.6MB | PowerPC |

## Status: Binary Analysis Not Yet Possible

Both installers use **MindVision Installer VISE** format (`SVCT` header in data fork). The
application code is compressed inside the VISE payload and cannot be extracted with `unar`.

```bash
# Extraction produces the installer, but the data fork is SVCT:
unar InstallaOL3.0bppc.sit
# → Install AOL 3.0B (PPC)  (217295 B rsrc, 3530316 B data)

unar "Install AOL 3.0B (PPC)"
# → "Couldn't recognize the archive format."
```

### To extract, one of these is needed:
- **[vise-rs](https://codeberg.org/cyco/vise-rs)** — Rust tool for extracting VISE installers
- **Basilisk II / SheepShaver** — Mac emulator to run the installer
- **A pre-extracted copy** of the AOL 3.0 Mac application

## What the VISE File Catalog Reveals

The VISE installer's uncompressed file catalog (`FVCT` entries) shows the application
structure. Comparing AOL 2.6 (68K, monolithic) vs AOL 3.0 (PPC, shared libraries):

### AOL 2.6b15 (68K) — Monolithic Architecture
```
America Online v2.6b15          ← single binary, 54 CODE segments in resource fork
Online Tools/
  Chat                          ← 68K CODE resources in resource fork
  File Transfer                 ← 68K CODE resources in resource fork
  Mail                          ← 68K CODE resources in resource fork
  [etc.]
```

### AOL 3.0B (PPC) — Shared Library Architecture
```
America Online PPC              ← main binary
Online Tools/
  Chat PPC                      ← PPC shared library
  Browser PPC                   ← NEW: web browser (not in 2.6)
  Charting PPC                  ← PPC shared library
  Compression PPC               ← PPC shared library
  Spelling PPC                  ← NEW: spell checker (not in 2.6)
  RichText PPC                  ← NEW: rich text rendering (not in 2.6)
  RuntimeLibPPC                 ← PPC runtime library
  PPLib PPC                     ← PPC protocol library
  UtilLib PPC                   ← PPC utility library
  TCPConfigLib PPC              ← TCP configuration library
  jgdw.ppc                      ← charting/graphing engine
  ObjectSupportLib              ← Apple Events support
  TCPack for AOL                ← TCP/IP stack
  AOL Scheduler                 ← FlashSession scheduler
  AOL Diagnostic                ← diagnostic tool
```

The shift from monolithic 68K CODE segments to PPC shared libraries is consistent with a
major rewrite — the kind of rewrite where a protocol transition (FDO88 → FDO91) would occur.

New components in 3.0 (Browser, Spelling, RichText) reflect AOL's expansion beyond the
original text-based service into web browsing and formatted content.

## What We Expect to Find When Extracted

If AOL 3.0 uses FDO91 as the FDO91 Manual's introduction implies:
- Error strings using "atom" terminology instead of "FDO code"
- No `MOPs` CODE segment (FDO91 uses atoms, not MOPs)
- Different dispatch data format (FDO91 atom streams vs FDO88 `fdo$dispch`)
- Possibly `atom$hfs_attr_plus_group_type` references for billing
- No Kg dispatch template in the format found in AOL 2.6's MOPs segment

This would confirm the FDO88→FDO91 transition at AOL Mac 3.0 and validate the
[AOL 2.6 FDO88 analysis](../aol26-client/AOL26-FDO-Version-Analysis.md) by contrast.
