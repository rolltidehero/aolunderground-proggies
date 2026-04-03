# America Online v2.6b15 — Mac Client

The unpatched AOL 2.6 Macintosh client, build 15 (May 1995). This is the version that AOL4Free v4 targets.

## Download

[Instll_AOl_v2.6b15.sit](Instll_AOl_v2.6b15.sit) — StuffIt 5 installer archive (1.5MB). Contains the full application folder with the main binary, Online Tools (Chat, File Transfer, Mail, etc.), modem configs, and art resources.

## Binary Details

| Property | Value |
|----------|-------|
| Version | 2.6b15 |
| Copyright | © 1987-1995 America Online, Inc. |
| File date | May 27, 1995 |
| Resource fork | 835,073 bytes |
| CODE segments | 54 (68k machine code) |
| FDO protocol | **FDO88** ([analysis](AOL26-FDO-Version-Analysis.md)) |

## Analysis

[AOL26-FDO-Version-Analysis.md](AOL26-FDO-Version-Analysis.md) — Binary proof that AOL 2.6 uses the FDO88 protocol, including:

- Reproducible extraction steps and full Python analysis script
- CODE segment map (P3, MOPs, TokenHandler, FormsCreation, etc.)
- Kg surcharge switch dispatch template found in unpatched client
- FDO88 terminology in error strings ("FDO code" vs FDO91's "atom")
- Free area billing strings matching FDO88 Manual p.2-44

## Extraction

```bash
# Extract the installer
unar -o /tmp/aol26 Instll_AOl_v2.6b15.sit

# Extract the nested application folder
unar -o /tmp/aol26/extracted "/tmp/aol26/Instll AOl v2.6b15"

# Main binary resource fork is at:
# /tmp/aol26/extracted/Instll AOl v2/America Online v2.6b15 Folder/America Online v2.6b15.rsrc
```

See [HOW-TO-DECOMPILE.md](../hells/aol4free/HOW-TO-DECOMPILE.md) for the full resource fork parsing method.
