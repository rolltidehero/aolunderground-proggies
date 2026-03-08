#!/usr/bin/env python3
"""Query proggie_db.sqlite — the canonical proggie catalog."""
import argparse, sqlite3, json, sys, os

DB = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "proggie_db.sqlite")

def main():
    p = argparse.ArgumentParser(description="Query proggie database")
    p.add_argument("--vb", help="Filter by VB version (comma-separated: VB5,VB6)")
    p.add_argument("--compile", help="Filter by compile type (p-code,native)")
    p.add_argument("--decompile-status", help="Filter by decompile status (pending,ok,error)")
    p.add_argument("--missing-deps", action="store_true", help="Show exes with missing dependencies")
    p.add_argument("--deps", help="Show dependencies for exe (by name or path substring)")
    p.add_argument("--search", help="Search proggies by name")
    p.add_argument("--stats", action="store_true", help="Show database stats")
    p.add_argument("--format", choices=["lines", "json", "tsv"], default="lines", help="Output format")
    p.add_argument("--limit", type=int, default=0, help="Max results (0=all)")
    p.add_argument("--db", default=DB, help="Database path")
    args = p.parse_args()

    if not os.path.exists(args.db):
        print(f"ERROR: {args.db} not found. Run build_proggie_db.py first.", file=sys.stderr)
        sys.exit(1)

    db = sqlite3.connect(args.db)
    db.row_factory = sqlite3.Row

    if args.stats:
        _stats(db)
        return

    if args.missing_deps:
        _missing_deps(db, args)
        return

    if args.deps:
        _show_deps(db, args.deps)
        return

    if args.search:
        _search(db, args)
        return

    # Default: list exes with filters
    _list_exes(db, args)

def _stats(db):
    try:
        proggies = db.execute("SELECT count(*) FROM proggies").fetchone()[0]
        exes = db.execute("SELECT count(*) FROM exes").fetchone()[0]
        print(f"Proggies (zips): {proggies}")
        print(f"Exes: {exes}")

        print("\nBy VB version:")
        for r in db.execute("SELECT vb_version, count(*) c FROM exes GROUP BY vb_version ORDER BY c DESC"):
            print(f"  {r['vb_version'] or 'unknown':10s} {r['c']}")

        print("\nBy compile type:")
        for r in db.execute("SELECT compile_type, count(*) c FROM exes GROUP BY compile_type ORDER BY c DESC"):
            print(f"  {r['compile_type'] or 'unknown':10s} {r['c']}")

        print("\nExtraction status:")
        for r in db.execute("SELECT extract_status, count(*) c FROM proggies GROUP BY extract_status ORDER BY c DESC"):
            print(f"  {r['extract_status']:10s} {r['c']}")

        print("\nDecompile status (VB5+VB6 only):")
        for r in db.execute("SELECT decompile_status, count(*) c FROM exes WHERE vb_version IN ('VB5','VB6') GROUP BY decompile_status ORDER BY c DESC"):
            print(f"  {r['decompile_status']:10s} {r['c']}")

        deps_total = db.execute("SELECT count(*) FROM deps WHERE system_dll=0 AND vb_runtime=0").fetchone()[0]
        deps_missing = db.execute("SELECT count(*) FROM deps WHERE system_dll=0 AND vb_runtime=0 AND in_zip=0").fetchone()[0]
        print(f"\nDependencies: {deps_total} total, {deps_missing} missing from zips")
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)

def _missing_deps(db, args):
    rows = db.execute("""
        SELECT e.exe_name, e.vb_version, d.dep_name, d.dep_type, p.zip_stem
        FROM deps d
        JOIN exes e ON d.exe_id = e.id
        JOIN proggies p ON e.proggie_id = p.id
        WHERE d.in_zip = 0 AND d.system_dll = 0 AND d.vb_runtime = 0
        ORDER BY d.dep_name, p.zip_stem
    """).fetchall()
    _output(rows, args, ["exe_name", "vb_version", "dep_name", "dep_type", "zip_stem"])

def _show_deps(db, pattern):
    rows = db.execute("""
        SELECT d.dep_name, d.dep_type, d.source, d.in_zip, d.system_dll, d.vb_runtime
        FROM deps d JOIN exes e ON d.exe_id = e.id
        WHERE e.exe_name LIKE ? OR e.exe_path LIKE ?
        ORDER BY d.system_dll, d.vb_runtime, d.dep_name
    """, (f"%{pattern}%", f"%{pattern}%")).fetchall()
    for r in rows:
        flags = []
        if r["system_dll"]: flags.append("sys")
        if r["vb_runtime"]: flags.append("vbrt")
        if r["in_zip"]: flags.append("in-zip")
        else: flags.append("MISSING")
        print(f"  {r['dep_name']:30s} {r['dep_type'] or '':5s} [{', '.join(flags)}] ({r['source']})")

def _search(db, args):
    rows = db.execute("""
        SELECT p.name, p.author, p.aol_version, e.vb_version, e.compile_type, e.exe_name, p.zip_path
        FROM proggies p JOIN exes e ON e.proggie_id = p.id AND e.is_primary = 1
        WHERE p.name LIKE ? OR p.zip_stem LIKE ? OR e.exe_name LIKE ?
        ORDER BY p.name
    """, (f"%{args.search}%",) * 3).fetchall()
    _output(rows, args, ["name", "author", "aol_version", "vb_version", "compile_type", "exe_name", "zip_path"])

def _list_exes(db, args):
    sql = """SELECT e.exe_path, e.exe_name, e.vb_version, e.compile_type, e.decompile_status, p.zip_stem
             FROM exes e JOIN proggies p ON e.proggie_id = p.id WHERE e.is_primary = 1"""
    params = []
    if args.vb:
        versions = [v.strip() for v in args.vb.split(",")]
        sql += f" AND e.vb_version IN ({','.join('?' * len(versions))})"
        params.extend(versions)
    if args.compile:
        types = [t.strip() for t in args.compile.split(",")]
        sql += f" AND e.compile_type IN ({','.join('?' * len(types))})"
        params.extend(types)
    if args.decompile_status:
        sql += " AND e.decompile_status = ?"
        params.append(args.decompile_status)
    sql += " ORDER BY e.vb_version, p.zip_stem"
    if args.limit:
        sql += f" LIMIT {args.limit}"

    rows = db.execute(sql, params).fetchall()
    _output(rows, args, ["exe_path", "exe_name", "vb_version", "compile_type", "decompile_status", "zip_stem"])

def _output(rows, args, keys):
    if not rows:
        print("No results.", file=sys.stderr)
        return
    if args.format == "json":
        print(json.dumps([dict(r) for r in rows], indent=2))
    elif args.format == "tsv":
        print("\t".join(keys))
        for r in rows:
            print("\t".join(str(r[k] or "") for k in keys))
    else:
        for r in rows:
            if "exe_path" in keys:
                print(r["exe_path"])
            else:
                print("\t".join(str(r[k] or "") for k in keys))
    print(f"\n({len(rows)} results)", file=sys.stderr)

if __name__ == "__main__":
    main()
