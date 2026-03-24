# Canonical Proggie Database — Requirements

## Problem Statement

The repository has three overlapping layers of organization that were never
reconciled:

1. **Old category dirs** (`programs/AOL/proggies/punters/`, `idlers/`,
   `unsorted-zip-[A-O]/`, etc.) — 6,061 raw zips with heavy duplication,
   26 ad-hoc `_extracted/` dirs containing 2,109 exes. This is what all
   current tooling (screenshots, decompilation) operates on.

2. **Deduped sorted set** (`programs/AOL/proggies-sorted-deduped/proggies-by-version/`)
   — 2,138 deduplicated zips sorted by AOL version. Output of the
   reorganization Tasks 1-4. But **zero extractions** — the exes were
   never pulled out of these zips.

3. **proggie-index.txt** — references `data/merged/*.zip` paths that are
   gitignored and no longer exist locally. Has VB version, compile type,
   author, passwords for 2,793 entries but the FILE column doesn't map
   to anything on disk.

Every time we need to know which exes are VB5/VB6, we re-scan from scratch.
The decompiler pipeline has no reliable input list. The index is broken.
Many zips are missing required DLL/OCX dependencies that the exe needs to run.

## Goals

1. **One database** — `proggie_db.sqlite` at the repo root. This is THE
   single source of truth for every proggie: which zip it's in, which
   exes it contains, what VB version, what DLLs/OCXs it needs, what's
   missing, author, password, AOL version — everything.

2. **Self-contained zips** — each deduped zip should contain the exe AND
   all required DLLs/OCXs. If a zip is missing a dependency, flag it in
   the DB and (where possible) add the missing file from the repo's
   runtime collection or other zips that have it.

3. **Predictable paths** — the deduped zips live at:
   `programs/AOL/proggies-sorted-deduped/proggies-by-version/<aol_ver>/<name>.zip`
   These are committed to git. This does NOT change.

4. **Local extraction for tooling** — when you need the actual exes (for
   decompilation, screenshots, etc.), a build script extracts the zips
   to a local gitignored directory. The DB tells the tools where to find
   everything.

5. **Working index** — `proggie-index.txt` regenerated with paths that
   actually exist.

## What Lives Where

```
COMMITTED TO GIT (permanent):
  proggie_db.sqlite                    ← THE database (small, metadata only)
  proggie-index.txt                    ← regenerated from DB
  proggie-index.md                     ← regenerated from DB
  programs/AOL/proggies-sorted-deduped/
    proggies-by-version/
      2.5/*.zip                        ← 33 deduped zips
      3.0/*.zip                        ← 37 deduped zips
      4.0/*.zip                        ← 1,746 deduped zips
      5.0/*.zip                        ← 57 deduped zips
      6.0/*.zip  7.0/*.zip  8.0/*.zip  9.0/*.zip  unknown/*.zip

LOCAL ONLY (gitignored, rebuilt on demand):
  programs/AOL/proggies-sorted-deduped/_extracted/
    411/                               ← extracted from 411.zip
      411.exe
      vb40032.dll
    newbreed/
      - -New Breed- -.exe
      msvbvm60.dll
    ...

OLD (still in git, no longer used by tooling):
  programs/AOL/proggies/punters/       ← original category dirs
  programs/AOL/proggies/idlers/        ← with their _extracted/ subdirs
  programs/AOL/proggies/unsorted-zip-[A-O]/
  ...
```

## Scope

- AOL proggies only (2,138 deduped zips). AIM proggies (649) later.
- Extract exes + supporting files from each zip.
- VB version detection on every exe.
- Dependency detection (PE imports + string scanning for OCX refs).
- Merge existing metadata from `proggie-index.txt` into the DB.
- Do NOT delete or move the old category dirs.

## Functional Requirements

1. **Extract all 2,138 deduped zips** to local `_extracted/<stem>/` dirs.

2. **Build `proggie_db.sqlite`** with tables for proggies, exes, files,
   and dependencies.

3. **Detect VB version** for every exe (PE/NE import analysis).

4. **Detect dependencies** for every exe:
   - PE import table → required DLLs
   - Binary string scan → referenced OCX controls
   - Filter out Windows system DLLs (kernel32, user32, etc.)
   - Check if each dependency exists in the zip
   - Flag missing dependencies in the DB

5. **Import existing metadata** from `proggie-index.txt`.

6. **Regenerate `proggie-index.txt`** from the DB with real paths.

7. **Query CLI** — `tools/query_proggies.py` for filtering/querying.

## Non-Functional Requirements

- Handle: password-protected zips (skip), corrupt zips (skip), filename
  encoding issues.
- DB committed to git (<5MB). Extractions gitignored.
- Idempotent — re-running skips already-processed zips.
- Runs on Linux, no VM needed.

## Success Criteria

- DB has entries for all 2,138 deduped zips.
- Every exe has vb_version + dependency list.
- Missing dependencies flagged (count reported).
- `proggie-index.txt` FILE paths resolve to real files after extraction.
- `query_proggies.py --vb VB5,VB6` returns ~1,500 exe paths.
