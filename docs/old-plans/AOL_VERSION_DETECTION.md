# AOL Version Detection Research

## Overview

This document explains how to accurately detect which AOL version(s) a proggie was designed for by analyzing the actual API calls and window classes it uses, rather than relying on filename patterns.

## The Problem

Many AOL proggies have ambiguous or missing version information in their filenames. Traditional detection methods that only look for strings like "aol 4.0" in filenames or file descriptions are unreliable because:

1. Developers often didn't include version info
2. Filenames were changed during distribution
3. Multi-version proggies work across several AOL versions
4. Archives were renamed by collectors

## The Solution: API Signature Analysis

Each AOL version exposed different COM interfaces, window classes, and control types. By analyzing which specific API signatures a proggie uses, we can accurately determine compatibility.

### Key API Signatures by Version

#### Window Classes (Main AOL Window)

| Signature | Versions | Notes |
|-----------|----------|-------|
| `AOL Frame25` | 2.5, 3.0 | Primary identifier for early AOL |
| `AOL Frame` | 4.0+ | Used in AOL 4.0 and later |
| `_AOL_Modal` | 2.5-7.0 | Modal dialog windows |
| `_AOL_Palette` | 2.5-5.0 | Palette windows (early versions) |

#### Control Classes (UI Elements)

| Signature | Versions | Notes |
|-----------|----------|-------|
| `_AOL_Glyph` | 4.0-7.0 | Icon/glyph controls |
| `_AOL_Timer` | 6.0, 7.0 | Timer control (specific to 6.0/7.0) |
| `_AOL_Icone` | 6.0, 7.0 | Icon control (French spelling, 6.0/7.0 only) |
| `_AOL_RadioBox` | 6.0, 7.0 | Radio button control |
| `_AOL_FontCombo` | 4.0-7.0 | Font selection combo box |
| `_AOL_Edit` | 4.0-7.0 | Text edit control |
| `_AOL_Listbox` | 4.0-9.0 | List box control |
| `_AOL_Static` | 4.0-9.0 | Static text/label control |
| `_AOL_Button` | 4.0-7.0 | Button control |
| `_AOL_Checkbox` | 4.0-7.0 | Checkbox control |
| `_AOL_Combobox` | 4.0-9.0 | Combo box control |
| `_AOL_Icon` | 4.0-9.0 | Icon control |
| `_AOL_Spin` | 4.0-7.0 | Spin button control |
| `AOL Child` | 4.0-9.0 | Child window (MDI) |
| `AOL Toolbar` | 4.0-9.0 | Toolbar control |
| `RICHCNTL` | 2.5+ | Rich text control |

#### Installation Paths

| Signature | Versions | Notes |
|-----------|----------|-------|
| `C:\AOL25\` | 2.5 | Default install path |
| `C:\AOL30\` | 3.0 | Default install path |
| `C:\AOL40\` | 4.0 | Default install path |
| `C:\America Online 5\` | 5.0+ | Changed naming convention |
| `C:\America Online 6\` | 6.0+ | |
| `waol.exe` | 2.5-5.0 | Main AOL executable (early versions) |
| `aol.exe` | 6.0+ | Main AOL executable (later versions) |

## Detection Methodology

### 1. Extract Strings from EXE

Use `strings` command or binary analysis to extract all printable strings from the proggie executable:

```bash
strings -n 8 proggie.exe > strings.txt
```

### 2. Search for API Signatures

Look for the specific window class names and control classes in the extracted strings:

```bash
grep -i "_AOL_\|AOL Frame\|AOL Child" strings.txt
```

### 3. Score by Specificity

Different signatures have different specificity:

- **High specificity** (0.9 confidence): `_AOL_Timer`, `_AOL_Icone`, `_AOL_RadioBox` → Only 6.0/7.0
- **Medium specificity** (0.6 confidence): `_AOL_Glyph` → 4.0-7.0
- **Low specificity** (0.3 confidence): `AOL Frame25` → 2.5-9.0 (too broad)

### 4. Combine Evidence

A proggie is compatible with a version if:
- It uses API signatures specific to that version, OR
- It uses only API signatures available in that version

### 5. Handle Multi-Version Proggies

If a proggie uses:
- Only `_AOL_Edit` + `_AOL_Button` → Compatible with 4.0-7.0
- `_AOL_Timer` + `_AOL_Glyph` → Compatible with 6.0-7.0 (intersection)
- `AOL Frame25` + `_AOL_Glyph` → Compatible with 4.0-7.0 (most specific wins)

## Using the Detection Tool

### Basic Usage

```bash
# Detect version for a single proggie
python3 tools/detect_aol_version.py proggie.exe

# Batch process a directory
python3 tools/detect_aol_version.py programs/AOL/proggies/*.exe

# Output JSON for automation
python3 tools/detect_aol_version.py --json proggie.exe
```

### Output Format

```json
{
  "file": "aohell3.exe",
  "versions": ["3.0", "4.0"],
  "primary_version": "3.0",
  "confidence": {
    "3.0": 0.85,
    "4.0": 0.65
  },
  "evidence": {
    "window_classes": ["AOL Frame25"],
    "control_classes": ["_AOL_Edit", "_AOL_Button"],
    "install_paths": ["C:\\AOL30\\"]
  },
  "needs_review": false
}
```

### Confidence Levels

- **0.9-1.0**: High confidence - Multiple specific API signatures found
- **0.7-0.89**: Medium confidence - Some specific signatures found
- **0.5-0.69**: Low confidence - Only broad signatures found
- **< 0.5**: Needs review - Insufficient evidence

## Research Methodology

This API signature database was built by analyzing 328 Visual Basic source files (`.bas`) from the `programming/vb/aol/` directory. The source files are organized by AOL version (e.g., `40-50/`, `60-70/`) and contain the actual `FindWindow()` and `FindWindowEx()` API calls used by proggie developers.

### Source Analysis

```vb
' Example from a BAS file for AOL 3.0/4.0
Public Function FindAOLWindow() As Long
    AOL& = FindWindow("AOL Frame25", vbNullString)
    MDI& = FindWindowEx(AOL&, 0&, "MDIClient", vbNullString)
    child& = FindWindowEx(MDI&, 0&, "AOL Child", vbNullString)
End Function
```

By extracting these `FindWindow()` calls and correlating them with the directory structure (which indicates version compatibility), we built a comprehensive database of which API signatures correspond to which AOL versions.

## Limitations

1. **Obfuscated/Packed EXEs**: If the proggie is packed or obfuscated, strings may not be extractable
2. **Dynamic API Resolution**: Some proggies dynamically resolve APIs at runtime
3. **Version Ranges**: Many proggies work across multiple versions - we report all compatible versions
4. **Missing Evidence**: Some proggies may not use version-specific APIs

## Contributing

If you find proggies with incorrect version detection:

1. Run the detection tool with `--verbose` to see evidence
2. Check if the proggie uses undocumented API signatures
3. Submit an issue with the proggie name and correct version
4. If you have source code, add it to `programming/vb/aol/` with proper version directory

## References

- [AOL API Documentation Archive](https://web.archive.org/web/*/aol.com/developer)
- [Visual Basic AOL Programming Guide](programming/vb/tutorials/)
- [API Signature Database](../tools/aol_api_signatures.json)

## Credits

Research compiled from community-contributed Visual Basic source code spanning 1995-2006. Special thanks to all the proggie developers who documented their code.
