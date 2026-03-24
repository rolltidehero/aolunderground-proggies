# AOL Underground Proggies Archive Reorganization - Status

**Last Updated:** 2026-03-08
**Current Branch:** `reorganize`

## Completed

### Task 1: Git Infrastructure ✅
- Branch structure (`reorganize` working, `archive-original` snapshot)
- `.github/REDIRECTS.md`, redirect template, README updated

### Task 2: Password Database ✅
- `tools/passwords.json` — 45 programs with known passwords
- `tools/extract_passwords.py` — extraction with fuzzy matching

### Task 3: Archive Analysis Engine ✅
- `tools/analyze_archive.py` — PE parser, string extractor, version detector
- `tools/detect_vb_version.py` — VB3-VB6 detection via PE/NE imports
- `tools/aol_api_signatures.json` — AOL API signatures for version detection

### Duplicate Detection & Merge ✅
- `tools/detect_duplicates.py` — grouped 6,061 archives by exe SHA256
- Result: 2,138 deduplicated zips in `programs/AOL/proggies-sorted-deduped/proggies-by-version/`
- Sorted by AOL version: 2.5/ 3.0/ 4.0/ 5.0/ 6.0/ 7.0/ 8.0/ 9.0/ unknown/

## Remaining (now handled by canonical DB spec)

Tasks 4-8 from the original plan are superseded by `.kiro/specs/canonical_proggie_db/`:
- **Task 4 (Search Interfaces)** → DB query tool: `tools/query_proggies.py`
- **Task 5 (Execute Reorganization)** → DB build: `tools/build_proggie_db.py`
- **Task 6 (Testing)** → DB validation built into build script
- **Task 7 (Password Enhancement)** → passwords imported into DB from passwords.json
- **Task 8 (Decompilation)** → VM pipeline: `docs/2026-03-07-pla.md`

## Data Produced

| File | What |
|------|------|
| `proggie-index.txt` | ⚠ BROKEN — FILE column points to nonexistent `data/merged/` paths |
| `proggie-index.md` | Browsable version (also broken paths) |
| `exe_strings.db` | 2.4GB, 11.6M strings from 2,452 exes |
| `tools/c2/metadata.json` | 5.7MB, 2,152 exe metadata (forms, features, deps) |
| `tools/c2/nav_graphs.json` | 2.3MB, navigation graphs for UI automation |
| `tools/passwords.json` | 45 known passwords |

All of this gets consolidated into `proggie_db.sqlite` once the canonical DB spec is implemented.
