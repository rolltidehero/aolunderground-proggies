#!/usr/bin/env python3
"""Extract ASCII and hex strings from all .exe files in _extracted/ dirs into a searchable SQLite DB."""
from __future__ import annotations

import argparse
import logging
import sqlite3
import subprocess
import sys
from pathlib import Path

logger = logging.getLogger(__name__)


def setup_logging(verbose: bool = False, log_file: Path | None = None) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    datefmt = "%Y-%m-%d %H:%M:%S"
    handlers: list[logging.Handler] = [logging.StreamHandler()]
    if log_file:
        log_file.parent.mkdir(parents=True, exist_ok=True)
        handlers.append(logging.FileHandler(log_file, encoding="utf-8"))
    logging.basicConfig(level=level, format=fmt, datefmt=datefmt, handlers=handlers)


def init_db(db_path: Path) -> sqlite3.Connection:
    conn = sqlite3.connect(str(db_path))
    conn.execute("PRAGMA journal_mode=WAL")
    conn.execute(
        "CREATE TABLE IF NOT EXISTS strings ("
        "  id INTEGER PRIMARY KEY,"
        "  exe_path TEXT NOT NULL,"
        "  encoding TEXT NOT NULL,"
        "  value TEXT NOT NULL"
        ")"
    )
    conn.execute("CREATE INDEX IF NOT EXISTS idx_value ON strings(value)")
    conn.execute("CREATE INDEX IF NOT EXISTS idx_exe ON strings(exe_path)")
    return conn


def extract_strings(exe: Path, encoding: str, min_len: int = 4) -> list[str]:
    flag = "-e s" if encoding == "ascii" else "-e l"
    try:
        result = subprocess.run(
            ["strings", "-n", str(min_len)] + flag.split() + [str(exe)],
            capture_output=True, text=True, timeout=30,
        )
        return result.stdout.splitlines()
    except (subprocess.TimeoutExpired, OSError) as e:
        logger.warning("strings failed on %s (%s): %s", exe, encoding, e)
        return []


def main() -> int:
    parser = argparse.ArgumentParser(description="Build searchable strings DB from extracted exes")
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("-d", "--db", default=str(Path(__file__).resolve().parent.parent / "exe_strings.db"), help="Output SQLite DB path")
    parser.add_argument("--root", default=".", help="Root directory to scan")
    parser.add_argument("--min-len", type=int, default=4, help="Minimum string length")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose, log_file=Path("logs/build_strings_db.log"))
    root = Path(args.root)
    db_path = Path(args.db)

    exes = sorted(root.rglob("_extracted/**/*.exe"))
    # Also grab case variants
    exes += sorted(p for p in root.rglob("_extracted/**/*.EXE") if p not in exes)
    logger.info("Found %d exe files", len(exes))

    conn = init_db(db_path)
    batch: list[tuple[str, str, str]] = []
    batch_size = 5000

    for i, exe in enumerate(exes, 1):
        rel = str(exe.relative_to(root))
        for enc in ("ascii", "unicode"):
            for s in extract_strings(exe, enc, args.min_len):
                batch.append((rel, enc, s))
                if len(batch) >= batch_size:
                    conn.executemany("INSERT INTO strings (exe_path, encoding, value) VALUES (?,?,?)", batch)
                    conn.commit()
                    batch.clear()
        if i % 100 == 0:
            logger.info("Processed %d/%d exes", i, len(exes))

    if batch:
        conn.executemany("INSERT INTO strings (exe_path, encoding, value) VALUES (?,?,?)", batch)
        conn.commit()

    total = conn.execute("SELECT COUNT(*) FROM strings").fetchone()[0]
    conn.close()
    logger.info("Done. %d strings from %d exes stored in %s", total, len(exes), db_path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
