# VB4/VB5 Batch Decompilation with VBDIS4 Reloaded

## Overview

VBDIS4 Reloaded (aka VBOPT4) can decompile VB4-32 and VB5 p-code executables.
It's a VB6 Windows GUI app with command line support, so it runs under Wine.

## Targets

| Version | Count | Notes |
|---------|------:|-------|
| VB4-32 | 446 | All p-code (VB4-32 had no native compilation) |
| VB5 p-code | 50 | Confirmed p-code via ProjectInfo.aNativeCode == 0 |
| **Total** | **496** | |

## Prerequisites (Linux box)

```bash
# 1. Install Wine
sudo apt install wine wine32

# 2. Get VB6 runtime (VBOPT4 itself is a VB6 app)
# winetricks is the easiest way
sudo apt install winetricks
winetricks vb6run

# 3. Clone the repo
git clone <repo-url> && cd aolunderground-proggies
git checkout reorganize
```

## Tool Location

```
tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1/Vbopt4.vb6/VBOPT4.exe
```

Note: This path is gitignored. You'll need to re-extract it:
```bash
# The source archive should be at:
tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1.rar
# Or re-download from Wayback:
# https://web.archive.org/web/20090301170633/http://vbdis4.angelfire.com
```

## Quick Test

```bash
# Extract a known VB4-32 exe from the archive and test
cd /path/to/aolunderground-proggies

python3 -c "
import zipfile, sys
with zipfile.ZipFile('data/merged/platinum_from_rar.zip') as z:
    for n in z.namelist():
        if n.lower().endswith('.exe'):
            z.extract(n, '/tmp/vbtest')
            print(f'Extracted: /tmp/vbtest/{n}')
"

# Run VBDIS4 under Wine
wine tools/vb_decompile_ref/vbdis3_reloaded/vb4/VBDIS4_Reload_0.1/Vbopt4.vb6/VBOPT4.exe "/tmp/vbtest/platin~1.exe"
```

## Command Line Usage

From the VBDIS4 info file:
```
VBOPT4.exe C:\path\to\target.EXE
```

Under Wine, use unix paths — Wine translates them:
```bash
wine VBOPT4.exe /tmp/vbtest/target.exe
```

## Batch Script

A batch decompile script will be written once we confirm Wine + VBOPT4 works.
The script will:

1. Extract each exe from its zip in `data/merged/`
2. Run `wine VBOPT4.exe <exe>` on it
3. Capture decompiled output to `data/decompiled/<archive-name>/`
4. Log success/failure

## Also Needed for Full Coverage

| Version | Count | Tool |
|---------|------:|------|
| VB3 | 178 | VBDIS3 Reloaded (16-bit — needs DOSBox or OTVDM) |
| VB5 p-code | 50 | VBDIS4 (covered above) |
| VB6 p-code | 126 | VBDIS4 + VB6 opcode patch, or VbDec/Semi-VBDecompiler |

### VB6 Support Gap in VBDIS4

In `MODULE19.BAS` line 237-238, VBDIS4 detects VB version by DLL import:
```vb
Case "VB40032.":   gVBversion = &H432:  gIsVB_Ver = 4
Case "MSVBVM50":   gVBversion = 5:      gIsVB_Ver = 5
' MISSING: Case "MSVBVM60":   gVBversion = 6:  gIsVB_Ver = 6
```

Adding VB6 detection is one line. The harder part is 21 new VB6 opcodes
not present in VB5. But many VB6 p-code exes may only use VB4/5 opcodes
and could decompile as-is with just the detection fix.
