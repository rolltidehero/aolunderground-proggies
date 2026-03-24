# AOL Underground Proggies Archive

Historic vault of ~2,800 unique AOL/AIM proggie archives from the late 1990s and early 2000s. Punters, phishers, chat tools, mail bombers, scrollers, faders — the whole underground scene, preserved and cataloged.

Let's repopulate the Gibson!

Brought to you by the [AOL Underground Podcast](https://aolunderground.com)

## 📊 Current Stats

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

📄 **[Full Project Status](docs/PROJECT_STATUS.md)** — what we've done, what's next, how to help

## 🔎 Finding Proggies

- **[proggie-index.html](proggie-index.html)** — Interactive web search (recommended)
- **[proggie-index.md](proggie-index.md)** — Browse by category with markdown tables
- **[proggie-index.txt](proggie-index.txt)** — Greppable tab-delimited file

```bash
# Search by name
python3 tools/query_proggies.py --search "punter"

# Search strings across all exes (unzip first)
unzip exe_strings.db.zip  # only needed once
python3 tools/query_strings.py "AOL Frame25"

# VB version breakdown
python3 tools/query_proggies.py --stats
```

## 🎉 2026 Reorganization

This repository has been reorganized for better discoverability:
- **Duplicate Detection:** 6,061 archives merged down to 2,138 unique proggies via SHA256
- **Version Tagging:** Sorted by AOL version (2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
- **Metadata Database:** SQLite DB with names, authors, VB versions, dependencies, compile dates
- **Analysis Pages:** Per-proggie HTML pages with API refs, string analysis, dependency trees
- **API-Based Version Detection:** Accurate detection using actual AOL API signatures ([details](docs/old-plans/AOL_VERSION_DETECTION.md))

**Old links broken?** Check [REDIRECTS.md](.github/REDIRECTS.md) or switch to the `archive-original` branch.

## 🤝 Contributing

**We need help!** See [CONTRIBUTING.md](CONTRIBUTING.md) for ways to contribute, or check the [full project status](docs/PROJECT_STATUS.md#how-to-help).

Quick wins:
- **Got proggies?** Submit them! Even duplicates help verify our collection
- **Remember which AOL version a proggie worked with?** [549 need verification](NEEDS_REVIEW.md)
- **Know the author of a proggie?** Open an issue with corrections
- **Can run proggies?** We need screenshots (Wine, VM, or real old Windows)

## 📦 Missing Proggies

- Guide Punt by Stoney (guide.exe)
- Magenta by ReDxKinG (latest version)
- Reset 1.0 by skribe
- 1-888'd by skribe
- Macro Studio by i88i
- Gemini Macro by anubis
- Macro House
- Pup Tool by Pen (puptool.zip)

## 📁 Repository Structure

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
