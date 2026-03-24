#!/usr/bin/env python3
"""Repack deduped zips with missing dependencies.

Adds DLLs/OCXs/VBXs and VB runtimes to each zip so it's self-contained.
Sources: programs/AOL/required_files/, other zips in the collection.

Usage:
    python3 tools/repack_zips.py              # repack all zips with missing deps
    python3 tools/repack_zips.py --dry-run    # show what would be added
    python3 tools/repack_zips.py --stats      # show missing dep stats
"""
import sqlite3, zipfile, os, sys, shutil, logging
from pathlib import Path
from collections import Counter

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
log = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'
EXTRACT_BASE = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / '_extracted'
REQUIRED = REPO / 'programs' / 'AOL' / 'required_files'

# Additional system DLLs that were false-positive missing deps
EXTRA_SYSTEM = {s.lower() for s in [
    'shdocvw.dll', 'icmp.dll', 'mmsystem.dll', 'shell.dll', 'lzexpand.dll',
    'riched32.dll', 'riched20.dll', 'oledlg.dll', 'tapi32.dll', 'tapi.dll',
    'mswsock.dll', 'rasapi32.dll', 'penwin.dll', 'sound.drv', 'winsock.dll',
    'setupx.dll', 'ver.dll', 'w32sys.dll', 'ieframe.dll', 'quartz.dll',
    'wmp.dll', 'mfc42.dll', 'mfc40.dll',
]}

def build_source_inventory():
    """Build a map of dep_name.lower() -> source file path."""
    inventory = {}

    # 1. Curated required_files dirs
    for subdir in ['dll', 'ocx', 'vbx', 'vb_runtimes']:
        d = REQUIRED / subdir
        if not d.exists():
            continue
        for f in d.iterdir():
            if f.is_file() and f.suffix.lower() in ('.dll', '.ocx', '.vbx'):
                inventory[f.name.lower()] = f

    # VB runtime dir
    vb6rt = REQUIRED / 'vb_runtimes' / 'vb6_runtime'
    if vb6rt.exists():
        for f in vb6rt.iterdir():
            if f.is_file() and f.suffix.lower() in ('.dll', '.ocx', '.vbx'):
                inventory[f.name.lower()] = f

    # 2. Scan all extracted dirs for additional sources
    if EXTRACT_BASE.exists():
        for f in EXTRACT_BASE.rglob('*'):
            if f.is_file() and f.suffix.lower() in ('.dll', '.ocx', '.vbx'):
                key = f.name.lower()
                if key not in inventory:
                    inventory[key] = f

    return inventory


def repack(dry_run=False):
    db = sqlite3.connect(str(DB_PATH))
    inventory = build_source_inventory()
    log.info(f"Source inventory: {len(inventory)} unique DLLs/OCXs/VBXs available")

    # Get all missing deps grouped by proggie zip
    rows = db.execute("""
        SELECT p.id, p.zip_path, p.zip_stem, d.dep_name, d.dep_type, d.id as dep_id, d.vb_runtime
        FROM deps d
        JOIN exes e ON d.exe_id = e.id
        JOIN proggies p ON e.proggie_id = p.id
        WHERE d.in_zip = 0 AND d.system_dll = 0
        ORDER BY p.id
    """).fetchall()

    # Group by proggie
    from itertools import groupby
    by_proggie = {}
    for row in rows:
        pid = row[0]
        by_proggie.setdefault(pid, []).append(row)

    stats = Counter()
    updated_zips = 0

    for pid, deps in by_proggie.items():
        zip_path = REPO / deps[0][1]
        zip_stem = deps[0][2]
        extract_dir = EXTRACT_BASE / zip_stem

        to_add = []  # (dep_name, source_path, dep_id)
        for _, _, _, dep_name, dep_type, dep_id, vb_runtime in deps:
            dep_lower = dep_name.lower()

            # Skip extra system DLLs
            if dep_lower in EXTRA_SYSTEM:
                stats['skip_system'] += 1
                continue

            source = inventory.get(dep_lower)
            if source:
                to_add.append((dep_name, source, dep_id))
                stats['resolved'] += 1
            elif vb_runtime:
                stats['skip_vb_runtime_missing'] += 1
            else:
                stats['unresolved'] += 1

        if not to_add:
            continue

        if dry_run:
            for dep_name, source, _ in to_add:
                print(f"  {zip_stem}.zip += {dep_name} (from {source.relative_to(REPO)})")
            continue

        # Add files to the zip and extracted dir
        try:
            with zipfile.ZipFile(zip_path, 'a') as z:
                existing = {n.lower() for n in z.namelist()}
                for dep_name, source, dep_id in to_add:
                    if dep_name.lower() not in existing:
                        z.write(source, dep_name)
                        existing.add(dep_name.lower())
                    # Copy to extracted dir too
                    if extract_dir.exists():
                        # Case-insensitive check for extracted dir
                        existing_files = {f.name.lower(): f for f in extract_dir.iterdir()} if extract_dir.exists() else {}
                        if dep_name.lower() not in existing_files:
                            shutil.copy2(source, extract_dir / dep_name)
                    # Update DB
                    db.execute("UPDATE deps SET in_zip=1 WHERE id=?", (dep_id,))
            updated_zips += 1
        except Exception as e:
            log.warning(f"Failed to update {zip_stem}.zip: {e}")
            stats['zip_error'] += 1

    if not dry_run:
        db.commit()

    db.close()
    log.info(f"Stats: {dict(stats)}")
    if not dry_run:
        log.info(f"Updated {updated_zips} zips")


def print_stats():
    db = sqlite3.connect(str(DB_PATH))
    inventory = build_source_inventory()

    rows = db.execute("""
        SELECT dep_name, COUNT(*) as cnt
        FROM deps
        WHERE in_zip=0 AND system_dll=0
        GROUP BY LOWER(dep_name)
        ORDER BY cnt DESC
    """).fetchall()

    resolvable = 0
    unresolvable = 0
    print(f"\nMissing deps ({len(rows)} unique):\n")
    for name, cnt in rows:
        if name.lower() in inventory:
            print(f"  ✓ {cnt:4d}  {name}")
            resolvable += cnt
        elif name.lower() in EXTRA_SYSTEM:
            print(f"  S {cnt:4d}  {name}  (system)")
        else:
            print(f"  ✗ {cnt:4d}  {name}")
            unresolvable += cnt

    print(f"\n✓ Resolvable: {resolvable} instances")
    print(f"✗ Unresolvable: {unresolvable} instances")
    print(f"S System (skip): shown above")
    print(f"Source inventory: {len(inventory)} files available")
    db.close()


def main():
    if '--stats' in sys.argv:
        print_stats()
    elif '--dry-run' in sys.argv:
        repack(dry_run=True)
    else:
        repack(dry_run=False)

if __name__ == '__main__':
    main()
