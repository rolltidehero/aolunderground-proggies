#!/usr/bin/env python3
"""Search the exe strings database."""
from __future__ import annotations

import argparse
import logging
import sqlite3
import sys
from pathlib import Path

logger = logging.getLogger(__name__)
REPO_ROOT = Path(__file__).resolve().parent.parent


def setup_logging(verbose: bool = False) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def hex_dump(data: bytes, offset: int, width: int = 16) -> str:
    """Format bytes as a classic hex dump."""
    lines = []
    for i in range(0, len(data), width):
        chunk = data[i : i + width]
        hex_part = " ".join(f"{b:02x}" for b in chunk)
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        lines.append(f"  {offset + i:08x}  {hex_part:<{width * 3}}  |{ascii_part}|")
    return "\n".join(lines)


def show_hex_context(exe_path: str, value: str, context_bytes: int = 64) -> str:
    """Find string in exe binary and show hex dump around it."""
    full_path = REPO_ROOT / exe_path
    if not full_path.exists():
        return f"  (file not found: {exe_path})"
    data = full_path.read_bytes()
    needle = value.encode("ascii", errors="ignore")
    idx = data.find(needle)
    if idx == -1:
        needle = value.encode("utf-16-le", errors="ignore")
        idx = data.find(needle)
    if idx == -1:
        return "  (string not found in binary)"
    start = max(0, idx - context_bytes)
    end = min(len(data), idx + len(needle) + context_bytes)
    return hex_dump(data[start:end], start)


def show_string_context(conn: sqlite3.Connection, exe_path: str, match_id: int, context: int) -> list[str]:
    """Get neighboring strings from the same exe."""
    rows = conn.execute(
        "SELECT id, encoding, value FROM strings WHERE exe_path = ? AND id BETWEEN ? AND ? ORDER BY id",
        (exe_path, match_id - context, match_id + context),
    ).fetchall()
    lines = []
    for row_id, enc, val in rows:
        marker = " >>>" if row_id == match_id else "    "
        lines.append(f"{marker} [{enc:7s}] {val}")
    return lines


def main() -> int:
    parser = argparse.ArgumentParser(description="Search exe strings DB")
    parser.add_argument("query", help="Search term (SQL LIKE pattern, use %% for wildcards)")
    parser.add_argument("-d", "--db", default=str(REPO_ROOT / "exe_strings.db"))
    parser.add_argument("-e", "--exe-filter", default=None, help="Filter by exe path (LIKE pattern)")
    parser.add_argument("-n", "--limit", type=int, default=50)
    parser.add_argument("-c", "--context", type=int, default=0, metavar="N",
                        help="Show N neighboring strings around each match")
    parser.add_argument("-x", "--hex", action="store_true",
                        help="Show hex dump around each match in the binary")
    parser.add_argument("--hex-bytes", type=int, default=64, metavar="N",
                        help="Bytes of hex context before/after match (default: 64)")
    parser.add_argument("--encoding", choices=["ascii", "unicode"], default=None)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)

    if not Path(args.db).exists():
        logger.error("DB not found: %s — run build_strings_db.py first", args.db)
        return 1

    conn = sqlite3.connect(args.db)
    sql = "SELECT id, exe_path, encoding, value FROM strings WHERE value LIKE ?"
    params: list[str] = [f"%{args.query}%"]

    if args.encoding:
        sql += " AND encoding = ?"
        params.append(args.encoding)
    if args.exe_filter:
        sql += " AND exe_path LIKE ?"
        params.append(f"%{args.exe_filter}%")

    sql += f" LIMIT {args.limit}"

    rows = conn.execute(sql, params).fetchall()
    for row_id, exe_path, enc, value in rows:
        print(f"[{enc:7s}] {exe_path}: {value}")

        if args.context > 0:
            for line in show_string_context(conn, exe_path, row_id, args.context):
                print(line)
            print()

        if args.hex:
            print(show_hex_context(exe_path, value, args.hex_bytes))
            print()

    total = conn.execute(
        "SELECT COUNT(*) FROM strings WHERE value LIKE ?", [f"%{args.query}%"]
    ).fetchone()[0]

    if total > args.limit:
        logger.info("Showing %d of %d matches (use -n to increase)", args.limit, total)
    else:
        logger.info("%d matches", total)

    conn.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
