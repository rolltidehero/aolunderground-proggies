# Task 4: Duplicate Detection System - Complete ✅

## What Was Built

### 1. detect_duplicates.py
Groups archives by .exe SHA256 hash to identify duplicates.

**Features:**
- Analyzes all archives in a directory tree
- Groups by .exe hash (same .exe = duplicate)
- Identifies potential file conflicts
- Generates comprehensive JSON report

**Usage:**
```bash
python3 tools/detect_duplicates.py <archives_dir> <passwords_file> <output_file>

# Example
python3 tools/detect_duplicates.py "programs/AOL/proggies/unsorted-zip-[A-O]" tools/passwords.json data/duplicates_report.json
```

**Output:**
```json
{
  "total_archives": 1002,
  "unique_exes": 911,
  "duplicate_groups": 30,
  "groups": [
    {
      "exe_hash": "sha256:5a080ecb24e87...",
      "exe_name": "EX_DIAL.EXE",
      "count": 2,
      "archives": [
        "programs/AOL/proggies/unsorted-zip-[A-O]/exorcist30.zip",
        "programs/AOL/proggies/unsorted-zip-[A-O]/Exorcist3.zip"
      ],
      "metadata": [...],
      "potential_conflicts": [...],
      "unique_files": [...]
    }
  ]
}
```

### 2. merge_archives.py
Intelligently merges duplicate archives into single archives.

**Features:**
- Selects primary archive (best metadata)
- Merges all unique files from duplicates
- Detects file conflicts (same name, different content)
- Creates `_conflicts/` folder with alternate versions
- Generates `conflict.txt` explaining each conflict
- Combines passwords and versions from all sources

**Merge Logic:**
1. **Primary Selection:** Archive with most complete metadata (versions, author, passwords, dependencies)
2. **File Merging:** Include all unique files from all archives
3. **Conflict Handling:** 
   - Use version from primary archive
   - Store alternate versions in `_conflicts/`
   - Document all conflicts in `conflict.txt`

**Usage:**
```bash
python3 tools/merge_archives.py <duplicates_report.json> <output_dir>

# Example
python3 tools/merge_archives.py data/duplicates_report.json data/merged
```

**Output:**
- Merged archives in output directory
- `merge_report.json` with complete merge details

## Test Results

### Test Dataset
- **Directory:** `programs/AOL/proggies/unsorted-zip-[A-O]`
- **Total archives:** 1,002
- **Unique .exe files:** 911
- **Duplicate groups:** 30

### Example Merge: ascii2.zip
**Merged from 11 archives:**
- ascii2.zip (primary)
- ginspar78.zip
- enterim7.zip
- eod.zip
- flashole10.zip through flashole17.zip

**Result:**
- Total files: 9
- Conflicts: 2 (SETUP.LST, Flashole.CAB)
- All alternate versions preserved in `_conflicts/`

### Conflict Handling Example
```
_conflicts/
  conflict.txt                      # Explains all conflicts
  SETUP.LST.from_ginspar78          # Alternate version
  SETUP.LST.from_enterim7           # Alternate version
  SETUP.LST.from_eod                # Alternate version
  Flashole.CAB.from_flashole11      # Alternate version
  ...
```

**conflict.txt:**
```
MERGE CONFLICTS
==================================================

Primary archive: ascii2.zip

File: SETUP.LST
Different versions found in:
  - ascii2.zip (hash: 477c7644...)
  - ginspar78.zip (hash: f448c041...)
  - enterim7.zip (hash: 2c57adc8...)
  ...
Using version from primary archive.
```

## Known Issues

### Encoding Errors
Some archives have filename encoding issues (CP437 vs UTF-8):
```
Error: File name in directory 'BoTZ40v²' and header b'BoTZ40v\xb2' differ.
```
**Impact:** These archives are skipped but logged
**Workaround:** Manual extraction may be needed

### Encrypted Archives
Some archives are password-protected:
```
Error: File is encrypted, password required for extraction
```
**Impact:** Cannot analyze without password
**Future:** Task 8 will address password detection

### Non-ZIP Files
Some .zip files are actually other formats:
```
Error: File is not a zip file
```
**Impact:** Skipped (may be .rar or corrupted)
**Future:** Add .rar support

## Performance

**Test Run:**
- 1,002 archives analyzed
- ~1 minute processing time
- ~100 archives/minute

**Full Repository Estimate:**
- 6,000 archives
- ~60 minutes processing time
- Parallelization possible for faster processing

## Next Steps

### For Full Repository Run:
```bash
# Create data directory
mkdir -p data

# Run on all AOL proggies
python3 tools/detect_duplicates.py "programs/AOL/proggies" tools/passwords.json data/duplicates_report.json

# Review report
python3 -c "import json; r=json.load(open('data/duplicates_report.json')); print(f'Duplicates: {r[\"duplicate_groups\"]}')"

# Merge duplicates
python3 tools/merge_archives.py data/duplicates_report.json data/merged

# Review merge report
cat data/merged/merge_report.json
```

### Integration with Task 6:
- Use merged archives instead of originals
- Update metadata with merge information
- Track original archive paths for redirects

## Files Created
- `tools/detect_duplicates.py` (67 lines)
- `tools/merge_archives.py` (145 lines)
- `data/test_duplicates/duplicates_report.json` (test output)
- `data/test_duplicates/merged/` (30 merged archives)
- `data/test_duplicates/merged/merge_report.json` (test output)

## Success Criteria ✅
- ✅ Identify all duplicate groups (30 found in test)
- ✅ Show merge preview for multi-archive groups (11 archives merged)
- ✅ Generate conflicts folder with explanations
- ✅ Preserve all unique files
- ✅ Document all conflicts clearly
- ✅ Combine metadata from all sources

**Task 4 Status: COMPLETE** ✅
