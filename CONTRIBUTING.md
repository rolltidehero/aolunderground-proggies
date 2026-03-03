# Quick Start Guide - AOL Proggies Reorganization

## Current Status
✅ **Tasks 1-3 Complete** (37.5% done)  
📍 **Current Branch:** `reorganize`  
📄 **Full Details:** See `REORGANIZATION_STATUS.md`

---

## What's Working Now

### Analyze Any Archive
```bash
cd /Users/braker/git/aolunderground-proggies
python3 tools/analyze_archive.py "path/to/archive.zip" tools/passwords.json
```

### Extract Passwords from Filenames
```bash
python3 tools/extract_passwords.py
# Output: tools/passwords.json
```

### Test Version Detection
```bash
python3 tools/version_detector.py
```

---

## Next Steps

### 1. Install RAR Support
```bash
pip3 install rarfile
```

### 2. Test on Sample Archives
```bash
# Test on 10 punters
for f in programs/AOL/proggies/punters/*.{zip,rar}; do
    [ -f "$f" ] && python3 tools/analyze_archive.py "$f" tools/passwords.json > "data/test_$(basename "$f").json"
done
```

### 3. Continue with Task 4
Create `tools/detect_duplicates.py` to find duplicate .exe files across archives.

---

## File Structure

```
aolunderground-proggies/
├── .github/
│   └── REDIRECTS.md              # Redirect mappings (structure)
├── tools/
│   ├── analyze_archive.py        # ✅ Main analyzer
│   ├── pe_parser.py              # ✅ PE metadata extractor
│   ├── string_extractor.py       # ✅ Binary string extractor
│   ├── version_detector.py       # ✅ AOL version detector
│   ├── extract_passwords.py      # ✅ Password database builder
│   ├── passwords.json            # ✅ 45 programs with passwords
│   ├── redirect-template.txt     # ✅ Redirect file template
│   ├── detect_duplicates.py      # ⏳ TODO: Task 4
│   ├── merge_archives.py         # ⏳ TODO: Task 4
│   └── generate_indexes.py       # ⏳ TODO: Task 5
├── data/
│   ├── metadata.json             # ⏳ TODO: Task 6 (all archives)
│   └── duplicates_report.json    # ⏳ TODO: Task 4
├── REORGANIZATION_STATUS.md      # ✅ Full status document
├── QUICKSTART.md                 # ✅ This file
└── README.md                     # ✅ Updated with reorg notice
```

---

## Branches

- `main` - Original state (DO NOT MODIFY)
- `archive-original` - Snapshot of original structure
- `reorganize` - Working branch (CURRENT)

```bash
# View original structure
git checkout archive-original

# Continue working
git checkout reorganize
```

---

## Key Commands

```bash
# Check current branch
git branch

# View commit history
git log --oneline -10

# Test analyzer on specific archive
python3 tools/analyze_archive.py "programs/AOL/proggies/punters/fatex.zip" tools/passwords.json

# Count total archives
find programs -name "*.zip" -o -name "*.rar" | wc -l

# Find archives with passwords in filename
find programs -name "*password=*"
```

---

## Troubleshooting

### "No module named 'rarfile'"
```bash
pip3 install rarfile
```

### "Permission denied" on scripts
```bash
chmod +x tools/*.py
```

### Archive has no .exe
This is normal - some archives are installers or data files. The analyzer will return minimal metadata.

### Version detection shows empty
Check if archive filename or contents have version indicators. May need manual review.

---

## Getting Help

1. Read `REORGANIZATION_STATUS.md` for full details
2. Check git history: `git log --oneline`
3. Start new AI conversation with: "Continue AOL proggies reorganization, see REORGANIZATION_STATUS.md"

---

**Last Updated:** 2026-03-03
