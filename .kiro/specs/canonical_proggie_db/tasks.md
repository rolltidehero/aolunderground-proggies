# Canonical Proggie Database — Tasks

## Task 1: Build extraction + DB script ✅ DONE
- [x] Created `tools/build_proggie_db.py`
- [x] Extracts all 2,138 deduped zips (zero failures)
- [x] VB version detection, SHA256 hashes, dependency detection
- [x] PE import parsing + string scan for OCX/DLL/VBX refs
- [x] System DLL and VB runtime classification
- [x] Primary exe selection, file cataloging
- [x] DB: 2,138 proggies, 1,706 exes, 8,475 deps, 9,395 files

## Task 2: Import existing metadata ✅ DONE
- [x] Imported 2,169 entries from proggie-index.txt (name, author, category)
- [x] Matched 865 exes from metadata.json (author/name enrichment)
- [x] Imported 43 passwords from passwords.json
- [x] Result: 2,138 named, 1,198 with author, 36 with password
- [ ] TODO: Import nav_graphs.json and decompile_checkpoint.json (deferred)

## Task 3: Fix deduped zips ✅ DONE
- [x] Created `tools/repack_zips.py`
- [x] Built repo-wide DLL/OCX inventory (525 files from required_files/ + extracted dirs)
- [x] Repacked 1,402 zips with missing deps
- [x] Recovered 12 DLLs from old unsorted zips and AIM dirs
- [x] Reclassified 368 false-positive deps (system DLLs, prefixed VBX garbage)
- [x] Searched LensHell Wayback Machine archive — same DLL set, no bubble.dll
- [x] 274 string-scan deps still missing (zero PE import deps missing)
- [x] bubble.dll (86 refs) genuinely not in archive or anywhere online

## Task 4: Regenerate index files
- [ ] Implement `--index` in build_proggie_db.py
- [ ] Generate proggie-index.txt with real FILE paths
- [ ] Generate proggie-index.md

## Task 5: Query tool
- [x] Created `tools/query_proggies.py` (skeleton, needs testing with populated DB)
- [ ] Test all flags against populated DB

## Task 6: Gitignore + docs
- [x] _extracted/ already in .gitignore
- [x] Updated REORGANIZATION.md
- [ ] Commit proggie_db.sqlite
- [ ] Update README.md with query tool usage

## Task 7: Extract real names/authors from decompiled output (NEW — post-decompile)
After batch decompilation, parse the output to get authoritative metadata:
- [ ] Parse VBP files for `Title=`, `Description=` (App.Title, App.ProductName)
- [ ] Parse FRM files for About form labels/captions containing author names
- [ ] Parse .bas module headers for author comments (common pattern: `' Author: ...`)
- [ ] Scan string constants for author handles, crew names, greet lists
- [ ] Update proggies.name and proggies.author in DB with decompiled values
- [ ] Flag entries where decompiled name differs from proggie-index.txt name
- [ ] Current name/author data is suspect — scraped from filenames and old metadata
