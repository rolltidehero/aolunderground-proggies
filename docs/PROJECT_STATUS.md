# AOL Underground Proggies - Project Status

**Last Updated:** 2026-03-24

## What Is This?

We're preserving and reverse-engineering about 2,800 AOL/AIM "proggies," the underground tools from the late 1990s and early 2000s that automated AOL. Punters, phishers, chat tools, mail bombers, scrollers, faders, the whole scene. Most were written in Visual Basic 3-6 and distributed on AOL itself or via web pages.

This repo is the largest known collection. We're building tooling to catalog every program, decompile the source code, and make it all browsable and searchable.

**Podcast:** [AOL Underground](https://aolunderground.com)
**Live Site:** https://ssstonebraker.github.io/aolunderground-proggies/

## What We've Done

### Archive Organization (Complete)
- 2,138 deduplicated AOL proggies cataloged from 6,061 original archives
- 649 AIM proggies identified (separate pass coming)
- Organized by AOL version: 2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0
- Duplicate detection via SHA256
- 1,198 programs with author attribution recovered
- 36 password-protected archives cracked and documented

### Metadata and Search
- SQLite database with names, authors, VB versions, dependencies, compile dates
- 1,821 HTML analysis pages, one per proggie, with:
  - VB version and compile type badges
  - Dependency listings (VB runtime, system DLLs, bundled files)
  - AOL API references (which window classes and APIs each proggie uses)
  - String analysis from the binary
  - SVG form layouts from decompiled .frm control positions
  - Collapsible function listings with decompiled code
- Interactive search via [proggie-index.html](../proggie-index.html)
- Greppable index via [proggie-index.txt](../proggie-index.txt)
- GitHub Pages auto-deployed on every push to main

### VB Version Breakdown

| Version | Count | Notes |
|---------|-------|-------|
| VB6 | 805 | Most common, fully decompilable |
| VB5 | 349 | Fully decompilable |
| VB4-32 | 458 | Partially decompilable |
| VB4-16 | 6 | Partially decompilable |
| VB3 | 211 | Partially decompilable |
| Non-VB | 112 | Delphi, C++, etc. |
| **Decompilable (all VB)** | **1,829** | |

### Decompilation Pipeline (In Progress)
- Network-isolated Windows 10 VM with automated VB Decompiler Pro
- End-to-end pipeline proven: push exe, decompile, pull source, generate HTML
- 3 of 1,829 VB exes decompiled so far (pipeline works, batch processing next)
- Output includes .frm forms, .bas modules, .vbp project files
- Source code browsable in the analysis pages with syntax highlighting

### Strings Database
- 11.6 million strings extracted from 2,452 executables
- Searchable across all exes
- Distributed as `exe_strings.db.zip` (301MB compressed, 2.4GB uncompressed) via Git LFS

### Infrastructure
- GitHub Pages with auto-deploy workflow
- Download links serve zips from GitHub raw URLs
- `exe_strings.db.zip` tracked via Git LFS
- Nginx dev server at http://linux:8088/ for local browsing

## What's Next

### Batch Decompilation (about 1,826 VB exes remaining)
The pipeline works end-to-end but needs to run at scale. Each exe takes about 2.5 minutes. Full batch is roughly 76 hours of VM time. We need:
- Batch orchestrator script with resume-on-crash and progress tracking
- Snapshot rotation (revert VM to clean state every 50 exes)
- Metadata parser for form layouts, control names, API calls from decompiled source

### VB3/VB4 Decompilation (about 675 exes)
Different decompiler needed. Partial results expected.

### Screenshots
- Automated screenshot capture of each proggie's main form
- Animated GIF walkthroughs of menus, about dialogs, help screens
- Only 3 done so far

## How to Help

### Version Verification (549 proggies need review)
549 proggies have unknown or low-confidence AOL version detection. If you remember which AOL version a proggie worked with, check [NEEDS_REVIEW.md](../NEEDS_REVIEW.md) and submit corrections.

### Missing Proggies
We're still looking for:
- Guide Punt by Stoney (guide.exe)
- Magenta by ReDxKinG (latest version)
- Reset 1.0 by skribe
- 1-888'd by skribe
- Macro Studio by i88i
- Gemini Macro by anubis
- Macro House
- Pup Tool by Pen (puptool.zip)

If you have AOL proggies not in the archive, please contribute.

### Metadata Corrections
If you recognize a proggie and know the correct author, AOL version, password, or program name, open an issue or PR.

### Code Contributions
- Python: batch decompilation orchestrator, metadata parsers
- HTML/CSS/JS: analysis page improvements
- VB6 knowledge: help interpret decompiled source, identify shared base modules

### Screenshots
If you can run these proggies (Wine, VM, or old Windows), screenshot the main form, about dialog, and anything interesting.

## Repository Structure

```
programs/AOL/proggies-sorted-deduped/
  proggies-by-version/          # 2,138 deduped zips sorted by AOL version
    2.5/ 3.0/ 4.0/ 5.0/ 6.0/ 7.0/ 8.0/ 9.0/ unknown/
  <proggie-name>.html           # Per-proggie analysis pages (1,821 generated)
  <proggie-name>/               # Assets (screenshots, source, etc.)

tools/
  build_proggie_db.py           # Build/rebuild the SQLite database
  query_proggies.py             # Search and query proggies
  query_strings.py              # Search the strings database
  detect_vb_version.py          # VB version detection engine
  generate_analysis.py          # HTML analysis page generator
  generate_index.py             # Interactive search page generator

proggie_db.sqlite               # The database (2,138 proggies, all metadata)
exe_strings.db.zip              # 11.6M strings (unzip before querying)
proggie-index.html              # Interactive web search
proggie-index.txt               # Tab-delimited greppable index
```

## Quick Start

```bash
# Clone (install Git LFS first)
git lfs install
git clone https://github.com/ssstonebraker/aolunderground-proggies.git
cd aolunderground-proggies

# Search for a proggie
python3 tools/query_proggies.py --search "punter"

# VB version stats
python3 tools/query_proggies.py --stats

# Search strings across all exes (unzip first)
unzip exe_strings.db.zip  # only needed once
python3 tools/query_strings.py "AOL Frame25"
```

## Links

- **Live Site:** https://ssstonebraker.github.io/aolunderground-proggies/
- **Repository:** https://github.com/ssstonebraker/aolunderground-proggies
- **Podcast:** https://aolunderground.com
