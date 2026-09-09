#!/usr/bin/env python3
"""Archive Slipstream's AOL File Downloader (AutoIt source) and add DB entry.

This is an archival/preservation tool written in AutoIt in 2014, not a VB proggie.
Follows the same pattern as build_aohell_metadata.py for source-only entries.

Usage:
    python3 tools/build_slipstream_metadata.py [--source /tmp/aol_file_downloader_by_Slipstream.txt]
"""
import argparse
import sqlite3
import shutil
from pathlib import Path
from datetime import datetime, timezone

import hunter
_hunter_log = (Path.home() / 'traces' / Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
hunter.trace(stdlib=False, action=hunter.CallPrinter(stream=open(_hunter_log, 'a')))

import logging
logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
log = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'

ZIP_STEM = 'aol-file-downloader-by-slipstream'
AOL_VERSION = '9.0'
DEST_DIR = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / AOL_VERSION
DEST_AU3 = DEST_DIR / f'{ZIP_STEM}.au3'

# Canonical path stored in DB (relative to repo root)
AU3_REPO_PATH = f'programs/AOL/proggies-sorted-deduped/{AOL_VERSION}/{ZIP_STEM}.au3'


def copy_source(src_path: Path):
    DEST_DIR.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src_path, DEST_AU3)
    size = DEST_AU3.stat().st_size
    log.info(f'Copied source → {DEST_AU3} ({size:,} bytes)')
    return size


def insert_db(file_size: int):
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row

    # Idempotent — skip if already present
    existing = conn.execute(
        "SELECT id FROM proggies WHERE zip_stem = ?", (ZIP_STEM,)
    ).fetchone()
    if existing:
        log.info(f'DB entry already exists (id={existing["id"]}), skipping insert')
        conn.close()
        return existing['id']

    now = datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S')
    cur = conn.execute("""
        INSERT INTO proggies
            (zip_path, zip_stem, aol_version, extract_dir, name, author,
             password, platform, category, duplicates, extract_status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        AU3_REPO_PATH,          # zip_path — the .au3 file itself
        ZIP_STEM,
        AOL_VERSION,
        None,                   # no extract_dir (single source file)
        'AOL File Downloader',
        'Slipstream',
        None,                   # no password
        'AOL',
        None,
        1,                      # no duplicates
        'ok',
        now,
    ))
    proggie_id = cur.lastrowid
    conn.commit()
    log.info(f'Inserted proggies row id={proggie_id}')

    # files entry for the .au3 source
    conn.execute("""
        INSERT INTO files (proggie_id, file_path, file_name, file_type, file_size)
        VALUES (?, ?, ?, ?, ?)
    """, (
        proggie_id,
        AU3_REPO_PATH,
        f'{ZIP_STEM}.au3',
        'au3',
        file_size,
    ))
    conn.commit()
    log.info(f'Inserted files row for {ZIP_STEM}.au3')

    # No exes entry — this is source-only AutoIt, not a compiled exe

    conn.close()
    return proggie_id


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', default='/tmp/aol_file_downloader_by_Slipstream.txt',
                        help='Path to the .txt source file')
    args = parser.parse_args()

    src = Path(args.source)
    if not src.exists():
        log.error(f'Source not found: {src}')
        raise SystemExit(1)

    log.info(f'Source: {src}')
    file_size = copy_source(src)
    proggie_id = insert_db(file_size)

    print()
    print(f'Done.')
    print(f'  Source archived → {DEST_AU3}')
    print(f'  DB proggie_id   = {proggie_id}')
    print()
    print('Next: python3 tools/generate_slipstream.py')


if __name__ == '__main__':
    main()
