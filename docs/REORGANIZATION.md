# AOL Underground Proggies Archive Reorganization - Status

**Last Updated:** 2026-03-03  
**Current Branch:** `reorganize`  
**Status:** Tasks 1-3 Complete (37.5% done)

---

## 🎯 Project Goals

Reorganize 6,000+ proggie archives (3.1GB) with:
- ✅ Duplicate detection and merging
- ✅ AOL version identification (2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
- ✅ Metadata extraction (name, author, timestamp, dependencies, passwords)
- ✅ Searchable interfaces (text, markdown, HTML)
- ✅ Git history preservation with URL redirects

---

## ✅ Completed Tasks

### **Task 1: Git Infrastructure** ✅
**Status:** Complete  
**Branch:** `reorganize` (working), `archive-original` (snapshot)

**Files Created:**
- `.github/REDIRECTS.md` - Redirect mapping file
- `tools/redirect-template.txt` - Template for redirect files
- Updated `README.md` - Reorganization notice

**What Works:**
- Branch structure ready for reorganization
- Redirect system designed
- Users can view original structure on `archive-original` branch

---

### **Task 2: Password Database** ✅
**Status:** Complete  
**Passwords Found:** 45 programs

**Files Created:**
- `tools/passwords.json` - Password database (45 programs)
- `tools/extract_passwords.py` - Extraction script with fuzzy matching

**Sample Passwords:**
```json
{
  "blackrose chatpunter": ["rose"],
  "ditto punter": ["N64"],
  "aol 9.0 tools": ["wednesday"],
  "diablo v2.0": ["heartattack"]
}
```

**What Works:**
- Extracts passwords from filenames (e.g., "password=xxx")
- Fuzzy matching for program name variations
- Ready for integration with analysis engine

---

### **Task 3: Archive Analysis Engine** ✅
**Status:** Complete  
**Components:** 4 modules

**Files Created:**
- `tools/analyze_archive.py` - Main analysis engine
- `tools/pe_parser.py` - PE metadata parser
- `tools/string_extractor.py` - Binary string extractor
- `tools/version_detector.py` - AOL version detection

**What Works:**

#### PE Metadata Parser
- Extracts timestamp (compilation date)
- Extracts FileDescription, ProductVersion, CompanyName
- Extracts OriginalFilename, Comments
- Works on VB3-VB6 executables

#### String Extractor
- Extracts ASCII strings (min 4 chars)
- Extracts Unicode (UTF-16LE) strings
- Removes duplicates
- Fast binary scanning

#### Version Detector
**Detection Methods:**
1. **Filename Analysis** (30% confidence)
   - Patterns: "aol30", "aol 4.0", "[aol5.0]"
   
2. **String Analysis** (20% per match, max 60%)
   - Window classes: "AOL Frame25", "_AOL_Glyph"
   - Paths: "C:\\aol40\\", "America Online 6"
   - Executables: "waol.exe" (2.5-5.0), "aol.exe" (6.0+)
   - Menu text: "What's New in AOL 4.0"

3. **PE Metadata** (50% confidence)
   - FileDescription: "For AOL 3.0"
   - Comments field

4. **Source Files** (40% per match, max 120%)
   - .bas file comments: "'This is for AOL 4.0"

**Key Indicators:**
- `AOL Frame25` = AOL 2.5-5.0 (NOT version-specific!)
- `_AOL_Glyph` = AOL 4.0+ only
- `waol.exe` = AOL 2.5-5.0
- `aol.exe` = AOL 6.0+

**Confidence Scoring:**
- Combines all detection methods
- Normalizes to 0-1 range
- Filters versions with <50% confidence
- Flags for review if max confidence <90%

#### Main Analyzer
- Extracts archives (.zip, .rar support planned)
- Finds all .exe files (case-insensitive)
- Computes SHA256 hashes
- Detects dependencies (.dll, .ocx, .vbx, .wav)
- Matches passwords from database
- Generates complete JSON metadata

**Example Output:**
```json
{
  "archive_name": "aohell3.zip",
  "exe_name": "aohell.exe",
  "exe_hash": "sha256:abc123...",
  "program_name": "AOHell",
  "author": "Da Chronic",
  "timestamp": "1996-03-15T10:30:00",
  "versions": ["3.0", "4.0"],
  "version_confidence": {"3.0": 0.95, "4.0": 0.75},
  "primary_version": "3.0",
  "version_range": "3.0-4.0",
  "category": "all_in_one",
  "dependencies": {
    "dlls": ["vb40032.dll", "311.dll"],
    "ocx": [],
    "vbx": [],
    "other": ["acidrop.txt"]
  },
  "passwords": ["aohell", "chronic"],
  "has_password": true,
  "password_confidence": 0.95,
  "detection_evidence": {
    "filename": {"3.0": 0.3},
    "strings": {"3.0": 1.3, "4.0": 0.6},
    "pe_metadata": {"3.0": 2.0},
    "bas_files": {"3.0": 1.2}
  },
  "needs_review": false,
  "original_path": "programs/AOL/proggies/unsorted-zip/aohell3.zip",
  "new_path": "programs/AOL/proggies/all_in_one/aol3.0/aohell3.zip"
}
```

**Testing:**
```bash
# Test on single archive
python3 tools/analyze_archive.py "programs/AOL/proggies/unsorted-zip-[A-O]/aohell_9.zip" tools/passwords.json

# Test version detector
python3 tools/version_detector.py
```

---

## 📋 Remaining Tasks

### **Task 4: Duplicate Detection System** ⏳
**Status:** Not Started  
**Estimated Time:** 4 hours

**What Needs to Be Built:**
1. `tools/detect_duplicates.py`:
   - Group archives by .exe SHA256 hash
   - Identify duplicate groups (same .exe in multiple archives)
   - List unique supporting files across duplicates
   - Detect conflicting files (same name, different hash)
   - Generate `data/duplicates_report.json`

2. `tools/merge_archives.py`:
   - Select primary archive (most complete metadata)
   - Merge all unique files from duplicate archives
   - Create `_conflicts/` folder for duplicate non-.exe files
   - Generate `conflict.txt` explaining each conflict
   - Keep single copy of common files (acidrop.txt, readme.txt)
   - Combine passwords from all sources

**Merge Logic Example:**
```
Archive A: program.exe (hash:abc), readme.txt, 311.dll
Archive B: program.exe (hash:abc), readme.txt (different), vb40032.dll

Merged Result:
  program.exe (hash:abc)
  readme.txt (from A)
  311.dll
  vb40032.dll
  _conflicts/
    readme_from_B.txt
    conflict.txt ("readme.txt differs between archives")
```

**Success Criteria:**
- Identify all duplicate groups
- Show merge preview for 3-archive duplicate group
- Generate conflicts folder with explanations

---

### **Task 5: Search Interfaces** ⏳
**Status:** Not Started  
**Estimated Time:** 4 hours

**What Needs to Be Built:**
1. `tools/generate_indexes.py` - Main generator

2. **proggie-index.txt** (tab-delimited):
```
archive_name	exe_name	program_name	versions	category	dependencies	passwords	hash
aohell3.zip	aohell.exe	AOHell	3.0,4.0	all_in_one	vb40032.dll,311.dll	aohell,chronic	abc123...
```

3. **proggie-index.md** (markdown tables):
```markdown
## All-in-One Proggies

| Program | Version | Dependencies | Passwords | Download |
|---------|---------|--------------|-----------|----------|
| AOHell | 3.0-4.0 | vb40032.dll, 311.dll | aohell, chronic | [aohell3.zip](programs/AOL/proggies/all_in_one/aol3.0/aohell3.zip) |
```

4. **proggie-index.html** (searchable web interface):
   - Filter by: version, category, author
   - Search by: name, dependencies
   - Sort by: date, name, version
   - Show confidence levels
   - Static HTML/CSS/JS (no server)

5. **NEEDS_REVIEW.md**:
   - List proggies with confidence <90%
   - Show detection evidence
   - Template for community contributions

**Success Criteria:**
- All 3 formats generated
- Search for "punter AOL 4.0" works
- Filter by dependencies works
- HTML interface loads and functions

---

### **Task 6: Execute Reorganization** ⏳
**Status:** Not Started  
**Estimated Time:** 2 hours + processing time

**What Needs to Be Done:**
1. Run analysis on all 6,000 archives (parallel processing)
2. Generate complete `data/metadata.json`
3. Apply merge strategy for duplicates
4. Create new directory structure:
   - Keep categories (punters, idlers, etc.)
   - Add version subdirs when detectable (aol3.0, aol4.0, etc.)
5. Place redirect files at old locations
6. Update `REDIRECTS.md` with all moves
7. Generate all search interfaces
8. Update README with final instructions

**Redirect File Example:**
```
This file has been moved to:
programs/AOL/proggies/punters/aol4.0/fatex.zip

See REDIRECTS.md for complete mapping.
```

**Success Criteria:**
- All archives analyzed
- Duplicates merged
- New structure created
- Redirects in place
- Search interfaces generated
- No data loss

---

### **Task 7: Testing & Validation** ⏳
**Status:** Not Started  
**Estimated Time:** 2 hours

**What Needs to Be Done:**
1. Test 50 random old URLs → verify redirects work
2. Spot-check 100 random version detections
3. Verify no data loss (file count matches)
4. Test all search interfaces
5. Generate `QUALITY_REPORT.md`

**Success Criteria:**
- 95%+ version detection accuracy
- All redirects working
- No files lost
- Search interfaces functional

---

### **Task 8: Password Detection Enhancement** ⏳ [OPTIONAL]
**Status:** Not Started  
**Estimated Time:** 4 hours

**What Needs to Be Built:**
1. `tools/password_detector.py`:
   - Search strings for password indicators
   - Find candidates near "Wrong Password" messages
   - Cross-reference with password database
   - Analyze hex proximity to password checks

2. Generate `passwords.txt` for each protected program:
```
POSSIBLE PASSWORDS FOR AOPUSSY.EXE
===================================
High Confidence (95%): aopussy
Medium Confidence (60%): pussy
Low Confidence (30%): aol
```

3. Create `PASSWORDS_NEEDED.md` for community contributions

**Optional Enhancement:**
- Setup Wine/CrossOver on Mac M4
- Extract `programming/vb/vbdecompiler.zip`
- Create `tools/decompile_wrapper.py`
- Enhanced password detection with decompiled code

**Success Criteria:**
- Detect password-protected programs
- Show confidence levels
- Generate password hints

---

## 🚀 How to Continue

### **Option 1: Run Remaining Tasks Manually**

```bash
# Switch to reorganize branch
cd /Users/braker/git/aolunderground-proggies
git checkout reorganize

# Task 4: Detect duplicates
# TODO: Create detect_duplicates.py and merge_archives.py

# Task 5: Generate search interfaces
# TODO: Create generate_indexes.py

# Task 6: Execute reorganization
# TODO: Run analysis on all archives

# Task 7: Validate
# TODO: Create validate_reorganization.py
```

### **Option 2: Continue with AI Assistant**

Start a new conversation with this context:
- Reference this file: `REORGANIZATION_STATUS.md`
- Request: "Continue Task 4: Build Duplicate Detection System"
- The AI will have all context from completed tasks

### **Option 3: Hybrid Approach**

1. Use AI to build Task 4 tools
2. Run analysis manually on sample archives
3. Review results
4. Use AI to build Task 5 (search interfaces)
5. Execute Task 6 manually with monitoring
6. Use AI for Task 7 validation

---

## 📊 Progress Tracking

**Overall Progress:** 37.5% (3/8 tasks)

| Task | Status | Time Spent | Files Created |
|------|--------|------------|---------------|
| 1. Git Infrastructure | ✅ Complete | 30 min | 3 files |
| 2. Password Database | ✅ Complete | 1 hour | 2 files |
| 3. Analysis Engine | ✅ Complete | 3 hours | 4 files |
| 4. Duplicate Detection | ⏳ Pending | - | - |
| 5. Search Interfaces | ⏳ Pending | - | - |
| 6. Execute Reorganization | ⏳ Pending | - | - |
| 7. Testing & Validation | ⏳ Pending | - | - |
| 8. Password Enhancement | ⏳ Optional | - | - |

**Total Time Invested:** ~4.5 hours  
**Estimated Remaining:** ~12 hours (without Task 8)

---

## 🔧 Technical Stack

**Working:**
- Python 3.8+
- Libraries: `zipfile`, `hashlib`, `json`, `re`, `pathlib`
- Git branching and merging
- Native Mac M4 compatibility

**Planned:**
- `rarfile` library (for .rar support)
- Parallel processing (for 6,000 archives)
- Static HTML/CSS/JS (for web interface)

**Optional:**
- Wine/CrossOver (for VB decompiler)
- `pefile` library (enhanced PE parsing)

---

## 📝 Key Decisions Made

- ✅ 90% confidence threshold for version tagging
- ✅ Tag all supported versions (not just primary)
- ✅ Store full confidence data and evidence
- ✅ Manual override file: `version-overrides.json` (planned)
- ✅ Community contribution via `NEEDS_REVIEW.md`
- ✅ Works natively on Mac M4 (except Task 8 decompilation)

---

## 🐛 Known Issues

1. **RAR Support:** Currently only .zip files supported. Need to add `rarfile` library.
2. **Case Sensitivity:** Fixed in analyze_archive.py (now case-insensitive .exe detection)
3. **Empty Archives:** Some archives have no .exe files (installers, data files)
4. **Version Detection:** "aohell_9" doesn't have clear version indicators - needs review

---

## 📚 Documentation

**Created:**
- This file: `REORGANIZATION_STATUS.md`
- `.github/REDIRECTS.md` (structure)
- `tools/redirect-template.txt`
- Updated `README.md`

**Planned:**
- `NEEDS_REVIEW.md` (Task 5)
- `QUALITY_REPORT.md` (Task 7)
- `PASSWORDS_NEEDED.md` (Task 8)

---

## 🎯 Next Immediate Steps

1. **Install rarfile library:**
   ```bash
   pip3 install rarfile
   ```

2. **Add RAR support to analyze_archive.py:**
   ```python
   import rarfile
   # Add extraction logic
   ```

3. **Create detect_duplicates.py** (Task 4)

4. **Test on 10 sample archives:**
   ```bash
   for f in programs/AOL/proggies/punters/*.zip; do
       python3 tools/analyze_archive.py "$f" tools/passwords.json
   done
   ```

5. **Review results and adjust confidence thresholds**

---

## 💡 Tips for Continuation

- **Start Small:** Test on 10-20 archives before running on all 6,000
- **Monitor Performance:** Analysis may take hours for full repo
- **Check Disk Space:** Temp extraction needs ~5GB free space
- **Backup First:** Ensure `archive-original` branch is pushed to remote
- **Incremental Commits:** Commit after each task completion
- **Community Input:** Share `NEEDS_REVIEW.md` early for feedback

---

**Questions?** Check the implementation plan in git history or start a new conversation referencing this file.
