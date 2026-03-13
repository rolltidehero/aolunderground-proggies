#!/usr/bin/env python3
"""Query exe_strings.db — the 2.4GB strings database."""
import argparse, sqlite3, sys, os

DB = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "exe_strings.db")

def main():
    p = argparse.ArgumentParser(description="Query exe strings database")
    p.add_argument("pattern", nargs="?", help="Search for strings matching pattern (SQL LIKE)")
    p.add_argument("--exe", help="Filter by exe path (substring match)")
    p.add_argument("--list-exes", action="store_true", help="List all unique exe paths")
    p.add_argument("--stats", action="store_true", help="Show database stats")
    p.add_argument("--limit", type=int, default=50, help="Max results (default 50)")
    p.add_argument("--db", default=DB, help="Database path")
    args = p.parse_args()

    if not os.path.exists(args.db):
        print(f"ERROR: {args.db} not found", file=sys.stderr)
        sys.exit(1)

    db = sqlite3.connect(args.db)

    if args.stats:
        rows = db.execute("SELECT count(*) FROM strings").fetchone()[0]
        exes = db.execute("SELECT count(DISTINCT exe_path) FROM strings").fetchone()[0]
        print(f"Strings: {rows:,}")
        print(f"Exes: {exes:,}")
        print(f"DB size: {os.path.getsize(args.db) / 1e9:.1f} GB")
        return

    if args.list_exes:
        for r in db.execute("SELECT DISTINCT exe_path FROM strings ORDER BY exe_path"):
            print(r[0])
        return

    if not args.pattern:
        p.print_help()
        return

    sql = "SELECT exe_path, encoding, value FROM strings WHERE value LIKE ?"
    params = [f"%{args.pattern}%"]
    if args.exe:
        sql += " AND exe_path LIKE ?"
        params.append(f"%{args.exe}%")
    sql += f" LIMIT {args.limit}"

    for path, enc, val in db.execute(sql, params):
        print(f"{path}\t[{enc}]\t{val}")

if __name__ == "__main__":
    main()
