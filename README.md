# AOL Underground Proggies Archive

About 2,800 unique AOL/AIM proggie archives from the late 1990s and early 2000s. Punters, phishers, chat tools, mail bombers, scrollers, faders, the whole underground scene, preserved and cataloged.

Let's repopulate the Gibson!

Brought to you by the [AOL Underground Podcast](https://aolunderground.com)

[Browse the archive](https://ssstonebraker.github.io/aolunderground-proggies/) | [Search proggies](https://ssstonebraker.github.io/aolunderground-proggies/proggie-index.html) | [Full project status](docs/PROJECT_STATUS.md)

## Quick Start

```bash
# Install Git LFS (required for the strings database)
git lfs install

# Clone the repo
git clone https://github.com/ssstonebraker/aolunderground-proggies.git
cd aolunderground-proggies

# Search for a proggie by name
python3 tools/query_proggies.py --search "punter"
```

Output:
```
  Name                          Author       AOL  VB      Zip
  Punt                          Unknown      2.5  VB3     programs/AOL/.../2.5/punt.zip
  PuntStat                      Unknown      3.0  VB3     programs/AOL/.../3.0/puntstat.zip
  bodini                        bodini       4.0  VB6     programs/AOL/.../4.0/bodini.zip
  ...
Found 47 matches
```

```bash
# See stats
python3 tools/query_proggies.py --stats
```

Output:
```
Total proggies: 2,138
  AOL: 2,118  AIM: 20
  With author: 1,198  With password: 36
VB versions: VB6=805 VB5=349 VB4-32=458 VB3=211 non-VB=112
```

```bash
# Search 11.6 million extracted strings across all exes
unzip exe_strings.db.zip    # one-time, extracts 2.4GB database
python3 tools/query_strings.py "AOL Frame25"
```

Output:
```
  anexbust.exe: AOL Frame25
  bodini.exe: FindWindow "AOL Frame25"
  ...
Found in 342 executables
```

## Current Stats

| What | Count |
|------|-------|
| Deduplicated AOL proggies | 2,138 |
| AIM proggies | 649 |
| HTML analysis pages | 1,821 |
| Programs with author attribution | 1,198 |
| Detected executables | 1,941 |
| VB exes (decompilable) | 1,829 |
| Strings extracted | 11.6 million |
| Decompiled so far | 3 (pipeline proven, batch run next) |

## Finding Proggies

- [proggie-index.html](https://ssstonebraker.github.io/aolunderground-proggies/proggie-index.html) - Interactive web search with filters and sorting
- [proggie-index.md](proggie-index.md) - Browse by category with markdown tables
- [proggie-index.txt](proggie-index.txt) - Greppable tab-delimited file

## 2026 Reorganization

This repository has been reorganized for better discoverability:
- **Duplicate Detection:** 6,061 archives merged down to 2,138 unique proggies via SHA256
- **Version Tagging:** Sorted by AOL version (2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
- **Metadata Database:** SQLite DB with names, authors, VB versions, dependencies, compile dates
- **Analysis Pages:** Per-proggie HTML pages with API refs, string analysis, dependency trees
- **API-Based Version Detection:** Accurate detection using actual AOL API signatures ([details](docs/old-plans/AOL_VERSION_DETECTION.md))

Old links broken? Check [REDIRECTS.md](.github/REDIRECTS.md) or switch to the `archive-original` branch.

## Contributing

We need help! See [CONTRIBUTING.md](CONTRIBUTING.md) for details, or check the [full project status](docs/PROJECT_STATUS.md#how-to-help).

Quick wins:
- Got proggies? Submit them! Even duplicates help verify our collection
- Remember which AOL version a proggie worked with? [549 need verification](NEEDS_REVIEW.md)
- Know the author of a proggie? Open an issue with corrections
- Can run proggies? We need screenshots (Wine, VM, or real old Windows)

## Missing Proggies

- Guide Punt by Stoney (guide.exe)
- Magenta by ReDxKinG (latest version)
- Reset 1.0 by skribe
- 1-888'd by skribe
- Macro Studio by i88i
- Gemini Macro by anubis
- Macro House
- Pup Tool by Pen (puptool.zip)

## Repository Structure

```
programs/AOL/proggies-sorted-deduped/
  proggies-by-version/          # 2,138 zips sorted by AOL version
  <name>.html                   # Per-proggie analysis pages
  <name>/                       # Assets (screenshots, source)

tools/
  build_proggie_db.py           # Build the SQLite database
  query_proggies.py             # Search and query
  query_strings.py              # Search 11.6M extracted strings
  detect_vb_version.py          # VB version detection
  generate_analysis.py          # HTML page generator
  generate_index.py             # Interactive search page generator

proggie_db.sqlite               # The database
exe_strings.db.zip              # 11.6M extracted strings (unzip before querying)
proggie-index.html              # Interactive search
```

## Thank You

Contributors and sources:
* Len from Lens Hell
* https://web.archive.org/web/20220321112058/http://kadeklizem.com/AOL%20Progs%20ARCHIVE.rar
* http://www.aciddr0p.net/
* https://koin.org
* https://progs.rexflex.net/
* https://github.com/darcfx/darcfx-submissions
* https://github.com/raysuelzer/ProgzRescue

## Committing Large Files

`exe_strings.db.zip` is tracked via [Git LFS](https://git-lfs.github.com/). Install LFS before cloning:
```bash
git lfs install
git clone https://github.com/ssstonebraker/aolunderground-proggies.git
```
