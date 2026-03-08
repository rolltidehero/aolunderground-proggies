#!/usr/bin/env python3
"""Build the canonical proggie database (proggie_db.sqlite).

Usage:
    python3 tools/build_proggie_db.py                    # full build (extract + import)
    python3 tools/build_proggie_db.py --extract-only     # just extract/catalog
    python3 tools/build_proggie_db.py --import-only      # just import metadata
    python3 tools/build_proggie_db.py --stats            # print stats from existing DB
"""
import sqlite3, zipfile, struct, hashlib, os, sys, json, re, logging
from pathlib import Path
from collections import Counter

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
log = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'
DEDUPED = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / 'proggies-by-version'
EXTRACT_BASE = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / '_extracted'
INDEX_FILE = REPO / 'proggie-index.txt'
METADATA_JSON = REPO / 'tools' / 'c2' / 'metadata.json'
NAV_GRAPHS_JSON = REPO / 'tools' / 'c2' / 'nav_graphs.json'
PASSWORDS_JSON = REPO / 'tools' / 'passwords.json'

# --- System DLL / VB runtime classification ---

SYSTEM_DLLS = {s.lower() for s in [
    'kernel32.dll', 'user32.dll', 'gdi32.dll', 'advapi32.dll', 'shell32.dll',
    'ole32.dll', 'oleaut32.dll', 'olepro32.dll', 'comctl32.dll', 'comdlg32.dll',
    'wsock32.dll', 'ws2_32.dll', 'winmm.dll', 'wininet.dll', 'version.dll',
    'shlwapi.dll', 'msvcrt.dll', 'msvcrt40.dll', 'ntdll.dll', 'rpcrt4.dll',
    'mpr.dll', 'winspool.drv', 'netapi32.dll', 'crypt32.dll', 'urlmon.dll',
    'msimg32.dll', 'imm32.dll', 'uxtheme.dll', 'dwmapi.dll', 'secur32.dll',
    'setupapi.dll', 'cfgmgr32.dll', 'psapi.dll', 'iphlpapi.dll', 'dnsapi.dll',
    'msi.dll', 'cabinet.dll', 'imagehlp.dll', 'dbghelp.dll', 'powrprof.dll',
    'avicap32.dll', 'avifil32.dll', 'msacm32.dll', 'lz32.dll',
]}

VB_RUNTIMES = {s.lower() for s in [
    'MSVBVM60.DLL', 'MSVBVM50.DLL', 'VB40032.DLL', 'VB40016.DLL',
    'VBRUN300.DLL', 'VBRUN200.DLL', 'VBRUN100.DLL', 'VBA6.DLL', 'VBA5.DLL',
]}

SKIP_EXES = {'setup.exe', 'install.exe', 'uninstall.exe', 'regsvr32.exe',
             'unwise.exe', 'st6unst.exe', '_setup.exe', 'setup1.exe'}

# --- VB detection (from detect_vb_version.py) ---

def detect_vb(data):
    if len(data) < 64 or data[:2] != b'MZ':
        return None
    try:
        pe_off = struct.unpack_from('<I', data, 0x3C)[0]
    except struct.error:
        return None
    if pe_off >= len(data) - 2:
        return None
    sig = data[pe_off:pe_off+2]
    if sig == b'NE':
        return _detect_ne(data, pe_off)
    elif sig == b'PE':
        return _detect_pe(data, pe_off)
    return None

def _detect_ne(data, ne_off):
    try:
        num_mod = struct.unpack_from('<H', data, ne_off + 0x1E)[0]
        mod_tab = struct.unpack_from('<H', data, ne_off + 0x28)[0]
        imp_tab = struct.unpack_from('<H', data, ne_off + 0x2A)[0]
    except struct.error:
        return None
    dll_map = {'VBRUN300': ('VB3','VBRUN300.DLL'), 'VBRUN200': ('VB2','VBRUN200.DLL'),
               'VBRUN100': ('VB1','VBRUN100.DLL'), 'VB40016': ('VB4-16','VB40016.DLL')}
    for i in range(num_mod):
        try:
            ref_off = ne_off + mod_tab + i * 2
            name_off = struct.unpack_from('<H', data, ref_off)[0]
            abs_off = ne_off + imp_tab + name_off
            n = data[abs_off]
            name = data[abs_off+1:abs_off+1+n].decode('ascii', errors='replace').upper()
        except (struct.error, IndexError):
            continue
        for prefix, (ver, dll) in dll_map.items():
            if name.startswith(prefix):
                return {'version': ver, 'compile_type': 'p-code', 'runtime_dll': dll, 'exe_type': 'NE/16-bit'}
    return None

def _detect_pe(data, pe_off):
    upper = data.upper()
    dll_map = {b'MSVBVM60.DLL': ('VB6','MSVBVM60.DLL'), b'MSVBVM50.DLL': ('VB5','MSVBVM50.DLL'),
               b'VB40032.DLL': ('VB4-32','VB40032.DLL')}
    version = runtime = None
    for dll_bytes, (ver, dll_name) in dll_map.items():
        if dll_bytes in upper:
            version, runtime = ver, dll_name
            break
    if not version:
        return None
    compile_type = 'unknown'
    vb5_pos = data.find(b'VB5!')
    if vb5_pos >= 0:
        try:
            image_base = struct.unpack_from('<I', data, pe_off + 0x34)[0]
            num_sec = struct.unpack_from('<H', data, pe_off + 6)[0]
            opt_sz = struct.unpack_from('<H', data, pe_off + 20)[0]
            sec_off = pe_off + 24 + opt_sz
            def va2raw(va):
                rva = va - image_base
                for s in range(num_sec):
                    so = sec_off + s * 40
                    sva = struct.unpack_from('<I', data, so + 12)[0]
                    svs = struct.unpack_from('<I', data, so + 8)[0]
                    srs = struct.unpack_from('<I', data, so + 16)[0]
                    srp = struct.unpack_from('<I', data, so + 20)[0]
                    if sva <= rva < sva + max(svs, srs):
                        return srp + (rva - sva)
                return None
            pi_va = struct.unpack_from('<I', data, vb5_pos + 0x30)[0]
            pi_raw = va2raw(pi_va)
            if pi_raw and pi_raw + 0x24 <= len(data):
                nc = struct.unpack_from('<I', data, pi_raw + 0x20)[0]
                compile_type = 'p-code' if nc == 0 else 'native'
        except (struct.error, TypeError):
            pass
    return {'version': version, 'compile_type': compile_type, 'runtime_dll': runtime, 'exe_type': 'PE/32-bit'}

# --- PE import table parsing ---

def parse_pe_imports(data):
    """Extract imported DLL names from PE import directory."""
    imports = []
    if len(data) < 64 or data[:2] != b'MZ':
        return imports
    try:
        pe_off = struct.unpack_from('<I', data, 0x3C)[0]
    except struct.error:
        return imports
    if pe_off >= len(data) - 4 or data[pe_off:pe_off+2] != b'PE':
        return imports
    try:
        num_sec = struct.unpack_from('<H', data, pe_off + 6)[0]
        opt_sz = struct.unpack_from('<H', data, pe_off + 20)[0]
        sec_off = pe_off + 24 + opt_sz
        # Import directory RVA is at optional header offset 104 (0x68) for PE32
        import_rva = struct.unpack_from('<I', data, pe_off + 24 + 104)[0]
        import_size = struct.unpack_from('<I', data, pe_off + 24 + 108)[0]
    except struct.error:
        return imports
    if import_rva == 0:
        return imports

    def rva2raw(rva):
        for s in range(num_sec):
            so = sec_off + s * 40
            sva = struct.unpack_from('<I', data, so + 12)[0]
            srs = struct.unpack_from('<I', data, so + 16)[0]
            srp = struct.unpack_from('<I', data, so + 20)[0]
            svs = struct.unpack_from('<I', data, so + 8)[0]
            if sva <= rva < sva + max(svs, srs):
                return srp + (rva - sva)
        return None

    raw = rva2raw(import_rva)
    if raw is None:
        return imports
    # Each import descriptor is 20 bytes, terminated by all-zero entry
    i = 0
    while True:
        off = raw + i * 20
        if off + 20 > len(data):
            break
        name_rva = struct.unpack_from('<I', data, off + 12)[0]
        if name_rva == 0:
            break
        name_raw = rva2raw(name_rva)
        if name_raw and name_raw < len(data):
            end = data.find(b'\x00', name_raw, name_raw + 256)
            if end > name_raw:
                try:
                    imports.append(data[name_raw:end].decode('ascii', errors='replace'))
                except Exception:
                    pass
        i += 1
        if i > 500:  # safety
            break
    return imports

# --- String scan for OCX/DLL/VBX refs ---

_DEP_PATTERN = re.compile(rb'[\w\-\.]+\.(ocx|dll|vbx|drv)', re.IGNORECASE)

def scan_string_deps(data):
    """Scan binary for *.ocx, *.dll, *.vbx filename patterns."""
    found = set()
    for m in _DEP_PATTERN.finditer(data):
        name = m.group(0).decode('ascii', errors='replace')
        # Filter out garbage: must start with letter, reasonable length
        if len(name) <= 50 and name[0].isalpha():
            found.add(name)
    return found

# --- DB schema ---

SCHEMA = """
CREATE TABLE IF NOT EXISTS proggies (
    id INTEGER PRIMARY KEY,
    zip_path TEXT NOT NULL UNIQUE,
    zip_stem TEXT NOT NULL,
    aol_version TEXT,
    extract_dir TEXT,
    name TEXT, author TEXT, password TEXT,
    platform TEXT DEFAULT 'AOL', category TEXT,
    duplicates INTEGER DEFAULT 1,
    extract_status TEXT DEFAULT 'pending',
    extract_error TEXT,
    created_at TEXT DEFAULT (datetime('now'))
);
CREATE TABLE IF NOT EXISTS exes (
    id INTEGER PRIMARY KEY,
    proggie_id INTEGER NOT NULL REFERENCES proggies(id),
    exe_path TEXT NOT NULL, exe_name TEXT NOT NULL,
    exe_hash TEXT, file_size INTEGER,
    vb_version TEXT, compile_type TEXT, runtime_dll TEXT, exe_type TEXT,
    is_primary INTEGER DEFAULT 0,
    decompile_status TEXT DEFAULT 'pending',
    decompile_output TEXT, decompile_file_count INTEGER, decompile_error TEXT
);
CREATE TABLE IF NOT EXISTS deps (
    id INTEGER PRIMARY KEY,
    exe_id INTEGER NOT NULL REFERENCES exes(id),
    dep_name TEXT NOT NULL, dep_type TEXT, source TEXT,
    in_zip INTEGER DEFAULT 0, system_dll INTEGER DEFAULT 0, vb_runtime INTEGER DEFAULT 0
);
CREATE TABLE IF NOT EXISTS files (
    id INTEGER PRIMARY KEY,
    proggie_id INTEGER NOT NULL REFERENCES proggies(id),
    file_path TEXT NOT NULL, file_name TEXT NOT NULL,
    file_type TEXT, file_size INTEGER
);
CREATE INDEX IF NOT EXISTS idx_exes_vb ON exes(vb_version);
CREATE INDEX IF NOT EXISTS idx_exes_proggie ON exes(proggie_id);
CREATE INDEX IF NOT EXISTS idx_exes_decompile ON exes(decompile_status);
CREATE INDEX IF NOT EXISTS idx_exes_hash ON exes(exe_hash);
CREATE INDEX IF NOT EXISTS idx_deps_exe ON deps(exe_id);
CREATE INDEX IF NOT EXISTS idx_deps_missing ON deps(in_zip, system_dll, vb_runtime);
"""

def create_db():
    if DB_PATH.exists():
        DB_PATH.unlink()
    db = sqlite3.connect(str(DB_PATH))
    db.executescript(SCHEMA)
    db.execute("PRAGMA journal_mode=WAL")
    return db

# --- Extraction + cataloging ---

def extract_and_catalog(db):
    """Extract all deduped zips, detect VB versions, deps, catalog files."""
    zips = sorted(DEDUPED.rglob('*.zip'))
    log.info(f"Found {len(zips)} deduped zips")
    EXTRACT_BASE.mkdir(parents=True, exist_ok=True)

    stats = Counter()
    for i, zp in enumerate(zips):
        rel = str(zp.relative_to(REPO))
        stem = zp.stem
        aol_ver = zp.parent.name  # e.g. "4.0", "unknown"
        extract_dir = str((EXTRACT_BASE / stem).relative_to(REPO))

        # Extract
        dest = EXTRACT_BASE / stem
        status, error = 'ok', None
        try:
            with zipfile.ZipFile(zp) as z:
                z.extractall(dest)
        except RuntimeError as e:
            if 'password' in str(e).lower() or 'encrypted' in str(e).lower():
                status, error = 'password', str(e)
            else:
                status, error = 'error', str(e)
        except Exception as e:
            status, error = 'error', str(e)

        # Insert proggie
        db.execute(
            "INSERT INTO proggies (zip_path, zip_stem, aol_version, extract_dir, extract_status, extract_error) "
            "VALUES (?,?,?,?,?,?)",
            (rel, stem, aol_ver, extract_dir, status, error))
        pid = db.execute("SELECT last_insert_rowid()").fetchone()[0]

        if status != 'ok':
            stats[status] += 1
            if (i + 1) % 200 == 0:
                log.info(f"  {i+1}/{len(zips)} processed")
            continue

        # Catalog all files in zip
        zip_files_lower = set()
        for fp in dest.rglob('*'):
            if fp.is_file():
                fname = fp.name
                frel = str(fp.relative_to(REPO))
                ext = fp.suffix.lower().lstrip('.')
                ftype = ext if ext in ('dll','ocx','vbx','txt','dat','ini','frm','bas','cls','vbp','frx','exe','hlp','cnt','rtf','bmp','ico','wav','jpg','gif') else 'other'
                try:
                    fsize = fp.stat().st_size
                except OSError:
                    fsize = 0
                db.execute("INSERT INTO files (proggie_id, file_path, file_name, file_type, file_size) VALUES (?,?,?,?,?)",
                           (pid, frel, fname, ftype, fsize))
                zip_files_lower.add(fname.lower())

        # Find and analyze exes
        exe_rows = []
        for fp in dest.rglob('*.exe'):
            if fp.name.lower() in SKIP_EXES:
                continue
            try:
                data = fp.read_bytes()
            except OSError:
                continue
            exe_hash = hashlib.sha256(data).hexdigest()
            vb = detect_vb(data)
            vb_ver = vb['version'] if vb else 'non-VB'
            comp = vb['compile_type'] if vb else 'n/a'
            rt = vb['runtime_dll'] if vb else None
            etype = vb['exe_type'] if vb else 'unknown'

            frel = str(fp.relative_to(REPO))
            db.execute(
                "INSERT INTO exes (proggie_id, exe_path, exe_name, exe_hash, file_size, "
                "vb_version, compile_type, runtime_dll, exe_type) VALUES (?,?,?,?,?,?,?,?,?)",
                (pid, frel, fp.name, exe_hash, len(data), vb_ver, comp, rt, etype))
            eid = db.execute("SELECT last_insert_rowid()").fetchone()[0]
            exe_rows.append((eid, fp.name, len(data), vb_ver, data))

            # Dependencies: PE imports
            pe_imports = parse_pe_imports(data)
            seen_deps = set()
            for imp in pe_imports:
                dep_lower = imp.lower()
                if dep_lower in seen_deps:
                    continue
                seen_deps.add(dep_lower)
                ext = dep_lower.rsplit('.', 1)[-1] if '.' in dep_lower else 'dll'
                db.execute(
                    "INSERT INTO deps (exe_id, dep_name, dep_type, source, in_zip, system_dll, vb_runtime) "
                    "VALUES (?,?,?,?,?,?,?)",
                    (eid, imp, ext, 'pe-import',
                     1 if dep_lower in zip_files_lower else 0,
                     1 if dep_lower in SYSTEM_DLLS else 0,
                     1 if dep_lower in VB_RUNTIMES else 0))

            # Dependencies: string scan
            str_deps = scan_string_deps(data)
            for dep in str_deps:
                dep_lower = dep.lower()
                if dep_lower in seen_deps:
                    continue
                seen_deps.add(dep_lower)
                ext = dep_lower.rsplit('.', 1)[-1] if '.' in dep_lower else 'dll'
                # Skip if it's the exe itself
                if dep_lower == fp.name.lower():
                    continue
                db.execute(
                    "INSERT INTO deps (exe_id, dep_name, dep_type, source, in_zip, system_dll, vb_runtime) "
                    "VALUES (?,?,?,?,?,?,?)",
                    (eid, dep, ext, 'string-scan',
                     1 if dep_lower in zip_files_lower else 0,
                     1 if dep_lower in SYSTEM_DLLS else 0,
                     1 if dep_lower in VB_RUNTIMES else 0))

            stats[vb_ver] += 1

        # Select primary exe
        if exe_rows:
            # Prefer largest VB exe
            vb_exes = [(eid, name, sz) for eid, name, sz, vv, _ in exe_rows if vv != 'non-VB']
            if vb_exes:
                primary_eid = max(vb_exes, key=lambda x: x[2])[0]
            else:
                primary_eid = max(exe_rows, key=lambda x: x[2])[0]
            db.execute("UPDATE exes SET is_primary=1 WHERE id=?", (primary_eid,))

        if (i + 1) % 200 == 0:
            db.commit()
            log.info(f"  {i+1}/{len(zips)} processed")

    db.commit()
    log.info(f"Extraction complete. Stats: {dict(stats)}")

# --- Metadata import ---

def import_metadata(db):
    """Import metadata from proggie-index.txt, metadata.json, passwords.json."""
    imported = Counter()

    # 1. passwords.json
    if PASSWORDS_JSON.exists():
        with open(PASSWORDS_JSON) as f:
            passwords = json.load(f)
        # Keys are proggie names, values are password lists
        for name, pwds in passwords.items():
            pw = pwds[0] if isinstance(pwds, list) else str(pwds)
            # Try matching by zip_stem similarity
            rows = db.execute("SELECT id, zip_stem FROM proggies").fetchall()
            name_lower = name.lower().replace(' ', '')
            for pid, stem in rows:
                if stem.lower().replace(' ', '') in name_lower or name_lower in stem.lower().replace(' ', ''):
                    db.execute("UPDATE proggies SET password=? WHERE id=? AND password IS NULL", (pw, pid))
                    imported['passwords'] += 1
                    break
        db.commit()
        log.info(f"Imported {imported['passwords']} passwords")

    # 2. proggie-index.txt
    if INDEX_FILE.exists():
        with open(INDEX_FILE, encoding='utf-8', errors='replace') as f:
            lines = f.readlines()
        if lines and lines[0].startswith('NAME'):
            lines = lines[1:]  # skip header
        for line in lines:
            parts = line.rstrip('\n').split('\t')
            if len(parts) < 7:
                continue
            name, author, platform, versions, vb, compile_type, filepath = parts[:7]
            dupes = int(parts[7]) if len(parts) > 7 and parts[7].isdigit() else 1
            password = parts[8] if len(parts) > 8 and parts[8] else None
            # Match by zip stem from FILE column: data/merged/foo.zip -> foo
            if '/' in filepath:
                idx_stem = filepath.rsplit('/', 1)[-1].replace('.zip', '')
            else:
                idx_stem = filepath.replace('.zip', '')
            row = db.execute("SELECT id FROM proggies WHERE zip_stem=?", (idx_stem,)).fetchone()
            if row:
                db.execute(
                    "UPDATE proggies SET name=?, author=?, platform=?, category=?, duplicates=?, password=COALESCE(password,?) WHERE id=?",
                    (name if name != 'None' else None,
                     author if author != 'None' else None,
                     platform, versions, dupes, password, row[0]))
                imported['index'] += 1
        db.commit()
        log.info(f"Imported {imported['index']} entries from proggie-index.txt")

    # 3. metadata.json — map by exe name to deduped exes
    if METADATA_JSON.exists():
        with open(METADATA_JSON) as f:
            meta = json.load(f)
        # Build lookup: exe_name.lower() -> list of metadata entries
        meta_by_exe = {}
        for path, entry in meta.items():
            if not path.startswith('programs/AOL/'):
                continue
            exe_name = os.path.basename(path).lower()
            meta_by_exe.setdefault(exe_name, []).append(entry)

        # For each exe in DB, try to find matching metadata
        rows = db.execute("SELECT e.id, e.exe_name, p.id FROM exes e JOIN proggies p ON e.proggie_id=p.id").fetchall()
        for eid, exe_name, pid in rows:
            entries = meta_by_exe.get(exe_name.lower(), [])
            if not entries:
                continue
            entry = entries[0]  # take first match
            # Update proggie with author/name if not already set
            if entry.get('author'):
                db.execute("UPDATE proggies SET author=COALESCE(author,?) WHERE id=?", (entry['author'], pid))
            if entry.get('name'):
                db.execute("UPDATE proggies SET name=COALESCE(name,?) WHERE id=?", (entry['name'], pid))
            imported['metadata'] += 1
        db.commit()
        log.info(f"Matched {imported['metadata']} exes from metadata.json")

    log.info(f"Import complete: {dict(imported)}")

# --- Stats ---

def print_stats(db):
    print("\n=== Proggie Database Stats ===\n")
    total = db.execute("SELECT COUNT(*) FROM proggies").fetchone()[0]
    print(f"Total proggies: {total}")
    for status, cnt in db.execute("SELECT extract_status, COUNT(*) FROM proggies GROUP BY extract_status ORDER BY COUNT(*) DESC"):
        print(f"  {status}: {cnt}")

    print(f"\nExes: {db.execute('SELECT COUNT(*) FROM exes').fetchone()[0]}")
    print("\nVB versions:")
    for ver, cnt in db.execute("SELECT vb_version, COUNT(*) FROM exes GROUP BY vb_version ORDER BY COUNT(*) DESC"):
        print(f"  {ver}: {cnt}")

    print("\nCompile types:")
    for ct, cnt in db.execute("SELECT compile_type, COUNT(*) FROM exes GROUP BY compile_type ORDER BY COUNT(*) DESC"):
        print(f"  {ct}: {cnt}")

    print(f"\nDependencies: {db.execute('SELECT COUNT(*) FROM deps').fetchone()[0]}")
    missing = db.execute("SELECT COUNT(DISTINCT exe_id) FROM deps WHERE in_zip=0 AND system_dll=0 AND vb_runtime=0").fetchone()[0]
    print(f"Exes with missing deps: {missing}")

    print("\nTop 20 missing deps (not in zip, not system, not VB runtime):")
    for name, cnt in db.execute(
            "SELECT dep_name, COUNT(*) FROM deps WHERE in_zip=0 AND system_dll=0 AND vb_runtime=0 "
            "GROUP BY LOWER(dep_name) ORDER BY COUNT(*) DESC LIMIT 20"):
        print(f"  {name}: {cnt}")

    print(f"\nFiles cataloged: {db.execute('SELECT COUNT(*) FROM files').fetchone()[0]}")
    named = db.execute("SELECT COUNT(*) FROM proggies WHERE name IS NOT NULL").fetchone()[0]
    authored = db.execute("SELECT COUNT(*) FROM proggies WHERE author IS NOT NULL").fetchone()[0]
    pw = db.execute("SELECT COUNT(*) FROM proggies WHERE password IS NOT NULL").fetchone()[0]
    print(f"\nMetadata: {named} named, {authored} with author, {pw} with password")

def generate_index(db):
    """Generate proggie-index.txt and proggie-index.md from DB."""
    repo = DB_PATH.parent
    rows = db.execute("""
        SELECT p.name, p.author, p.platform, p.aol_version,
               e.vb_version, e.compile_type, p.zip_path, p.duplicates, p.password
        FROM proggies p
        LEFT JOIN exes e ON e.proggie_id = p.id AND e.is_primary = 1
        ORDER BY LOWER(COALESCE(p.name, p.zip_stem))
    """).fetchall()

    # TSV
    tsv = repo / 'proggie-index.txt'
    with open(tsv, 'w') as f:
        f.write("NAME\tAUTHOR\tPLATFORM\tVERSIONS\tVB\tCOMPILE\tFILE\tDUPLICATES\tPASSWORD\n")
        for r in rows:
            name = r[0] or ''
            author = r[1] or 'None'
            platform = r[2] or 'AOL'
            versions = r[3] or 'Unknown'
            vb = r[4] or 'unknown'
            compile_type = r[5] or 'unknown'
            file_path = r[6] or ''
            dupes = r[7] or 1
            pw = r[8] or ''
            f.write(f"{name}\t{author}\t{platform}\t{versions}\t{vb}\t{compile_type}\t{file_path}\t{dupes}\t{pw}\n")

    # Markdown
    md = repo / 'proggie-index.md'
    # Group by aol_version
    from collections import defaultdict
    by_ver = defaultdict(list)
    for r in rows:
        ver = r[3] or 'Unknown'
        # Take first version if comma-separated
        primary_ver = ver.split(',')[0].strip()
        by_ver[primary_ver].append(r)

    ver_order = ['2.5', '3.0', '4.0', '5.0', '6.0', '7.0', '8.0', '9.0', 'Unknown']
    with open(md, 'w') as f:
        f.write("# AOL Proggie Index\n\n")
        f.write(f"**{len(rows)} proggies** cataloged from the AOL Underground archive.\n\n")
        f.write("## By AOL Version\n\n")
        for ver in ver_order:
            group = by_ver.get(ver, [])
            if not group:
                continue
            f.write(f"### AOL {ver} ({len(group)} proggies)\n\n")
            f.write("| Name | Author | VB | Compile | File |\n")
            f.write("|------|--------|----|---------|------|\n")
            for r in group:
                name = (r[0] or '').replace('|', '\\|')
                author = (r[1] or 'None').replace('|', '\\|')
                vb = r[4] or '?'
                ct = r[5] or '?'
                zp = r[6] or ''
                f.write(f"| {name} | {author} | {vb} | {ct} | {zp} |\n")
            f.write("\n")

    log.info(f"Index: {tsv} ({len(rows)} entries)")
    log.info(f"Index: {md}")


def main():
    args = sys.argv[1:]
    if '--stats' in args:
        db = sqlite3.connect(str(DB_PATH))
        print_stats(db)
        db.close()
        return

    if '--index' in args:
        db = sqlite3.connect(str(DB_PATH))
        generate_index(db)
        db.close()
        return

    extract = '--import-only' not in args
    do_import = '--extract-only' not in args

    if extract:
        log.info("Creating database and extracting zips...")
        db = create_db()
        extract_and_catalog(db)
    else:
        db = sqlite3.connect(str(DB_PATH))

    if do_import:
        log.info("Importing metadata...")
        import_metadata(db)

    print_stats(db)
    db.close()
    log.info(f"Database written to {DB_PATH}")

if __name__ == '__main__':
    main()
