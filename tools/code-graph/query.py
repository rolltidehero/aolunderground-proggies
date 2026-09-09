#!/usr/bin/env python3
"""Query the code graph. Auto-rebuilds if stale.

Usage:
    python3 tools/code-graph/query.py callers <function>
    python3 tools/code-graph/query.py callees <function>
    python3 tools/code-graph/query.py imports <name>
    python3 tools/code-graph/query.py impl <function>
    python3 tools/code-graph/query.py chain <source> <target>
    python3 tools/code-graph/query.py neighbors <file>
    python3 tools/code-graph/query.py stats
    python3 tools/code-graph/query.py rebuild
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from graph_db import (
    DB_PATH,
    call_chain,
    callers_of,
    callees_of,
    get_db,
    implementations_of,
    neighbors,
    stats,
    who_imports,
)


def ensure_fresh():
    """Incrementally rebuild if any indexed files are newer than the DB."""
    if not DB_PATH.exists():
        try:
            from build_graph import build
            build()
        except ImportError:
            print(
                "ERROR: .code-graph.db not found and tree-sitter not available.\n"
                "Run: pip install tree-sitter tree-sitter-python && "
                "python3 tools/code-graph/build_graph.py",
                file=sys.stderr,
            )
            sys.exit(1)
        return

    try:
        from build_graph import build, collect_py_files, needs_update

        db = get_db()
        files = collect_py_files()
        stale = [f for f in files if needs_update(f, db)]
        db.close()

        if stale:
            build(force=False)
    except ImportError:
        # tree-sitter not available — query with stale data
        import time
        age = time.time() - DB_PATH.stat().st_mtime
        if age > 3600:
            print(
                f"WARNING: .code-graph.db is {int(age / 60)}min old. "
                "Run: python3 tools/code-graph/build_graph.py",
                file=sys.stderr,
            )


def main() -> int:
    parser = argparse.ArgumentParser(description="Query code graph")
    sub = parser.add_subparsers(dest="cmd")

    p = sub.add_parser("callers", help="Who calls this function?")
    p.add_argument("name")

    p = sub.add_parser("callees", help="What does this function call?")
    p.add_argument("name")

    p = sub.add_parser("imports", help="Who imports this?")
    p.add_argument("name")

    p = sub.add_parser("impl", help="Where is this defined?")
    p.add_argument("name")

    p = sub.add_parser("chain", help="Call path from A to B")
    p.add_argument("source")
    p.add_argument("target")

    p = sub.add_parser("neighbors", help="1-hop context for a file")
    p.add_argument("file")

    sub.add_parser("stats", help="Graph statistics")
    sub.add_parser("rebuild", help="Force full rebuild")

    args = parser.parse_args()
    if not args.cmd:
        parser.print_help()
        return 1

    if args.cmd == "rebuild":
        from build_graph import build
        build(force=True)
        return 0

    ensure_fresh()
    db = get_db()

    if args.cmd == "callers":
        results = callers_of(args.name, db)
        if not results:
            print(f"No callers of '{args.name}' found.")
            return 0
        for r in results:
            print(f"  {r['caller_file']}:{r['line']} in {r['caller_func'] or '<module>'}")

    elif args.cmd == "callees":
        results = callees_of(args.name, db)
        if not results:
            print(f"No callees of '{args.name}' found.")
            return 0
        for r in results:
            print(f"  {r['callee_name']} at {r['caller_file']}:{r['line']}")

    elif args.cmd == "imports":
        results = who_imports(args.name, db)
        if not results:
            print(f"No imports of '{args.name}' found.")
            return 0
        for r in results:
            name = r["imported_name"] or r["imported_module"]
            print(f"  {r['source_file']}:{r['line']} imports {name} from {r['imported_module']}")

    elif args.cmd == "impl":
        results = implementations_of(args.name, db)
        if not results:
            print(f"No definitions of '{args.name}' found.")
            return 0
        for r in results:
            cls = f"{r['class_name']}." if r["class_name"] else ""
            print(f"  {r['file']}:{r['line']} {cls}{r['name']}{r['signature']}")

    elif args.cmd == "chain":
        result = call_chain(args.source, args.target, db)
        if result:
            print(f"  {' -> '.join(result)}")
        else:
            print(f"  No call path from '{args.source}' to '{args.target}' (max depth 5)")

    elif args.cmd == "neighbors":
        result = neighbors(args.file, db)
        if result["imports"]:
            print("Imports:")
            for r in result["imports"]:
                name = r["imported_name"] or r["imported_module"]
                print(f"  {name} from {r['imported_module']}")
        if result["imported_by"]:
            print("Imported by:")
            for r in result["imported_by"]:
                print(f"  {r['source_file']} imports {r['imported_name'] or '(module)'}")
        if result["called_by"]:
            print("Called by:")
            for r in result["called_by"]:
                print(f"  {r['caller_file']} in {r['caller_func'] or '<module>'}")
        if not any(result.values()):
            print(f"No graph edges for '{args.file}'.")

    elif args.cmd == "stats":
        s = stats(db)
        for k, v in s.items():
            print(f"  {k}: {v}")

    db.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
