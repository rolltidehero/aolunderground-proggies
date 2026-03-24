# Contributing to AOL Underground Proggies

Thanks for your interest! This is a community preservation project. every contribution helps.

## Ways to Help (No Coding Required)

### Submit Proggies
Got AOL proggies sitting on an old hard drive? Submit them! Even if we already have them, duplicates help verify our collection. Open a PR or an issue with a link.

### Metadata Corrections
If you recognize a proggie and know the correct author, AOL version, password, or program name. open an issue. Many programs are mislabeled from years of redistribution.

### Version Verification
549 proggies need AOL version verification. See [NEEDS_REVIEW.md](NEEDS_REVIEW.md) for the full list. If you remember which AOL version a proggie worked with, let us know.

### Screenshots
If you can run these proggies (Wine, VM, or actual old Windows), we need:
- Main form screenshot
- About dialog
- Any interesting features or easter eggs

## Ways to Help (Developers)

### Python
- Batch decompilation orchestrator (push exe → decompile → pull source)
- Metadata parsers for decompiled VB source
- HTML analysis page improvements

### HTML/CSS/JS
- Analysis page design improvements
- Interactive features for the proggie index

### VB6 Knowledge
- Help interpret decompiled source code
- Identify shared base modules and techniques across proggies
- Document AOL API patterns and window classes

## Getting Started

```bash
git clone https://github.com/ssstonebraker/aolunderground-proggies.git
cd aolunderground-proggies

# Explore the database
python3 tools/query_proggies.py --stats
python3 tools/query_proggies.py --search "punter"

# Search strings across all exes (unzip first)
unzip exe_strings.db.zip  # only needed once
python3 tools/query_strings.py "AOL Frame25"
```

## Project Status

See **[docs/PROJECT_STATUS.md](docs/PROJECT_STATUS.md)** for the full picture. what we've accomplished, what's in progress, and detailed task breakdowns.

## Branches

| Branch | Purpose |
|--------|---------|
| `main` | Active development (submit PRs here) |
| `archive-original` | Snapshot of original repo structure |

## Submitting Changes

1. Fork the repo
2. Create a branch from `main`
3. Make your changes
4. Open a PR against `main`

For metadata corrections (author names, AOL versions, passwords), opening an issue is fine. no PR needed.
