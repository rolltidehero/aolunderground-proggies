# Tools

Maintainer scripts for processing and organizing the archive. Not needed for browsing proggies.

## Scripts

| Script | Purpose |
|--------|---------|
| `analyze_archive.py` | Extract and analyze a single archive (exe hash, metadata, dependencies) |
| `detect_aol_version.py` | Detect AOL version compatibility from exe using API signatures |
| `detect_duplicates.py` | Group archives by exe SHA256 hash to find duplicates |
| `merge_archives.py` | Merge duplicate archive groups into single archives |
| `organize_by_version.py` | Copy merged archives into version-based directory structure |
| `build_api_database.py` | Extract AOL API signatures from BAS source files |
| `generate_index.py` | Generate proggie-index.html, .md, and .txt |
| `generate_needs_review.py` | Generate NEEDS_REVIEW.md for low-confidence detections |
| `generate_redirects.py` | Generate .github/REDIRECTS.md for moved files |

## Data Files

| File | Purpose |
|------|---------|
| `aol_api_signatures.json` | AOL window class/control signatures mapped to versions |
| `passwords.json` | Known archive passwords extracted from filenames |

## Dependencies

- Python 3.8+
- `unrar` binary (compile from `unrar-src.tar.gz` if needed for old RAR 2.0 formats)
