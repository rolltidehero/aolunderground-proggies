# Canonical Proggie Database — Design

## Database: `proggie_db.sqlite` (repo root)

This is the ONE database. Everything about every proggie lives here.

```sql
CREATE TABLE proggies (
    id INTEGER PRIMARY KEY,
    zip_path TEXT NOT NULL UNIQUE,       -- e.g. programs/AOL/proggies-sorted-deduped/proggies-by-version/4.0/411.zip
    zip_stem TEXT NOT NULL,              -- e.g. 411
    aol_version TEXT,                    -- e.g. 4.0 (from directory name)
    extract_dir TEXT,                    -- e.g. programs/AOL/proggies-sorted-deduped/_extracted/411
    name TEXT,                           -- display name from index
    author TEXT,
    password TEXT,
    platform TEXT DEFAULT 'AOL',
    category TEXT,
    duplicates INTEGER DEFAULT 1,
    extract_status TEXT DEFAULT 'pending', -- pending/ok/error/password
    extract_error TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE exes (
    id INTEGER PRIMARY KEY,
    proggie_id INTEGER NOT NULL REFERENCES proggies(id),
    exe_path TEXT NOT NULL,              -- relative to repo root (after extraction)
    exe_name TEXT NOT NULL,              -- basename
    exe_hash TEXT,                       -- sha256
    file_size INTEGER,
    vb_version TEXT,                     -- VB3/VB4-16/VB4-32/VB5/VB6/non-VB
    compile_type TEXT,                   -- p-code/native/unknown/n-a
    runtime_dll TEXT,                    -- MSVBVM60.DLL etc.
    exe_type TEXT,                       -- PE/32-bit, NE/16-bit
    is_primary INTEGER DEFAULT 0,       -- 1 = main exe for this proggie
    decompile_status TEXT DEFAULT 'pending',
    decompile_output TEXT,
    decompile_file_count INTEGER,
    decompile_error TEXT
);

CREATE TABLE deps (
    id INTEGER PRIMARY KEY,
    exe_id INTEGER NOT NULL REFERENCES exes(id),
    dep_name TEXT NOT NULL,              -- e.g. MSWINSCK.OCX, comdlg32.ocx
    dep_type TEXT,                       -- dll/ocx/vbx/tlb
    source TEXT,                         -- pe-import / string-scan
    in_zip INTEGER DEFAULT 0,           -- 1 = found in the zip alongside exe
    system_dll INTEGER DEFAULT 0,       -- 1 = Windows system DLL (ignore)
    vb_runtime INTEGER DEFAULT 0        -- 1 = VB runtime (MSVBVM60 etc.)
);

CREATE TABLE files (
    id INTEGER PRIMARY KEY,
    proggie_id INTEGER NOT NULL REFERENCES proggies(id),
    file_path TEXT NOT NULL,
    file_name TEXT NOT NULL,
    file_type TEXT,                      -- dll/ocx/vbx/txt/dat/other
    file_size INTEGER
);

CREATE INDEX idx_exes_vb ON exes(vb_version);
CREATE INDEX idx_exes_proggie ON exes(proggie_id);
CREATE INDEX idx_exes_decompile ON exes(decompile_status);
CREATE INDEX idx_deps_exe ON deps(exe_id);
CREATE INDEX idx_deps_missing ON deps(in_zip, system_dll, vb_runtime);
```

## Dependency Detection

For each exe, two passes:

### Pass 1: PE Import Table
Parse the PE import directory to get directly-linked DLLs. This catches:
- VB runtimes (MSVBVM60.DLL, VB40032.DLL, etc.)
- System DLLs (kernel32, user32 — marked `system_dll=1`)
- Third-party DLLs (dwspy32.dll, call32.dll, etc.)

### Pass 2: String Scan
Scan the exe binary for `*.ocx`, `*.dll`, `*.vbx` patterns. This catches:
- ActiveX controls loaded at runtime (comdlg32.ocx, mswinsck.ocx, etc.)
- DLLs loaded via Declare statements (not in import table)
- Deduplicate against Pass 1 results

### Classification
Each dependency is classified:
- `system_dll=1` if it's a known Windows system DLL (kernel32, user32,
  shell32, ole32, oleaut32, comctl32, comdlg32.dll, wsock32, winmm,
  advapi32, gdi32, version, shlwapi, msvcrt, ntdll, rpcrt4, mpr,
  wininet, olepro32, etc.)
- `vb_runtime=1` if it's a VB runtime (MSVBVM50/60, VB40032/016,
  VBRUN300, VBA5/6.DLL)
- `in_zip=1` if a file with that name exists in the same zip

### Known Common Dependencies
From scanning 100 exes, the most common non-system deps:
- comdlg32.ocx (26) — Common Dialog control
- mswinsck.ocx (12) — Winsock control
- mscomctl.ocx (9) — Common Controls (TreeView, ListView, etc.)
- richtx32.ocx (5) — Rich Textbox
- dwsbc32.ocx (5) — Desaware SpyWorks
- threed32.ocx (2) — Sheridan 3D controls
- trayicn2.ocx (2) — System tray icon

## Primary Exe Selection

Some zips contain multiple exes (~58 out of 2,138). Selection order:
1. Exe whose name matches the proggie name from the index (fuzzy)
2. Largest VB exe by file size (skips setup.exe, regsvr32.exe)
3. First exe alphabetically (fallback)

## Metadata Import Sources

Three sources of existing metadata to merge into the DB:

### 1. `proggie-index.txt` (tab-delimited, 2,793 entries)
- Columns: NAME, AUTHOR, PLATFORM, VERSIONS, VB, COMPILE, FILE, DUPLICATES, PASSWORD
- FILE column = `data/merged/<name>.zip` — match to deduped zips by basename
- Provides: name, author, aol_versions, password, compile_type

### 2. `tools/c2/metadata.json` (5.7MB, 2,152 exes)
- Keyed by old exe path (e.g. `programs/AOL/proggies/idlers/_extracted/...`)
- Per exe: forms, features, dependencies, author, ui_elements, strings, bas modules
- Map to deduped zips by exe hash (SHA256) or exe name matching
- 84 exes have dependency info (supplements PE import detection)
- 362 have author info
- 2,017 have form names

### 3. `tools/c2/nav_graphs.json` (2.3MB, 2,152 entries)
- Per exe: form names, clickable controls, navigation structure
- Used by screenshot automation pipeline

### 4. `tools/c2/decompile_checkpoint.json` (698KB)
- Tracks which exes were already decompiled in the old Wine pipeline
- Use to pre-populate decompile_status for exes already done

### Mapping Strategy
The metadata.json and nav_graphs.json are keyed by paths in the OLD
`_extracted/` dirs. The deduped zips are in `proggies-by-version/`. To map:
1. Compute SHA256 of each exe in the old paths
2. Match against SHA256 of exes extracted from deduped zips
3. Fall back to exe name matching for any misses

## Pipeline

```
tools/build_proggie_db.py --extract
  1. Find all zips in proggies-by-version/
  2. For each zip:
     a. Extract to _extracted/<stem>/
     b. For each .exe found:
        - SHA256 hash
        - VB version detection (PE/NE analysis)
        - Dependency detection (PE imports + string scan)
        - Check which deps exist in the zip
     c. Catalog all non-exe files
     d. Select primary exe
  3. Write everything to proggie_db.sqlite

tools/build_proggie_db.py --import-metadata
  1. Parse proggie-index.txt
  2. Match to DB rows by zip filename
  3. Populate name, author, password, etc.

tools/build_proggie_db.py --index
  1. Query DB
  2. Regenerate proggie-index.txt with real paths

tools/build_proggie_db.py --stats
  1. Print version/compile/dependency breakdown
```

## Query Tool: `tools/query_proggies.py`

```bash
# List all VB5/VB6 exe paths (for batch decompiler)
./tools/query_proggies.py --vb VB5,VB6

# JSON output for scripting
./tools/query_proggies.py --vb VB6 --compile p-code --format json

# Show proggies with missing dependencies
./tools/query_proggies.py --missing-deps

# Stats
./tools/query_proggies.py --stats

# Decompile status
./tools/query_proggies.py --vb VB5,VB6 --decompile-status pending
```

## Decompile Integration

The batch decompiler queries the DB directly:
```python
rows = db.execute("""
    SELECT e.id, e.exe_path, e.vb_version, p.zip_stem
    FROM exes e JOIN proggies p ON e.proggie_id = p.id
    WHERE e.vb_version IN ('VB5','VB6')
    AND e.decompile_status = 'pending'
    AND e.is_primary = 1
    ORDER BY e.vb_version, p.zip_stem
""").fetchall()
```

After each decompile, updates the DB:
```python
db.execute("UPDATE exes SET decompile_status=?, decompile_output=?, "
           "decompile_file_count=? WHERE id=?",
           (status, output_path, count, exe_id))
```

Resume-on-crash and progress tracking come for free.
