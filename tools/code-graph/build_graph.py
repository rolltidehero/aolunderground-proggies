#!/usr/bin/env python3
"""Build code graph from Python source files using Tree-sitter.

Indexes all Python files under tools/, tools/c2/, tools/vm/, and tests/
into a local .code-graph.db SQLite database for structural querying
(callers, callees, imports, definitions, call chains).
"""
from __future__ import annotations

import sys
import time
from pathlib import Path

import tree_sitter_python as tspython
from tree_sitter import Language, Parser

# Import shared DB helpers — lives alongside this file
sys.path.insert(0, str(Path(__file__).parent))
from graph_db import get_db

PY_LANGUAGE = Language(tspython.language())

REPO_ROOT = Path(__file__).resolve().parent.parent.parent

SCAN_DIRS = [
    REPO_ROOT / "tools",
    REPO_ROOT / "tests",
]
# tools/c2/ and tools/vm/ are inside tools/ so they're already covered.

EXCLUDE = {".git", "node_modules", "venv", ".venv", "__pycache__",
           ".mypy_cache", "vendor", "debug", "vb_decompile_ref",
           "code-graph"}  # Don't index ourselves


def collect_py_files() -> list[Path]:
    """Collect all Python files to index.

    Returns absolute paths. All DB storage uses paths relative to REPO_ROOT.
    """
    files = []
    for d in SCAN_DIRS:
        if not d.exists():
            continue
        for f in d.rglob("*.py"):
            if any(part in EXCLUDE for part in f.parts):
                continue
            files.append(f)
    # Also pick up any top-level .py files (generic_claude_api.py, etc.)
    for f in REPO_ROOT.glob("*.py"):
        if any(part in EXCLUDE for part in f.parts):
            continue
        files.append(f)
    return files


def needs_update(filepath: Path, db) -> bool:
    """Check if a file needs re-indexing based on mtime."""
    rel = str(filepath.relative_to(REPO_ROOT))
    row = db.execute("SELECT mtime FROM file_meta WHERE file = ?", (rel,)).fetchone()
    if row is None:
        return True
    return filepath.stat().st_mtime > row["mtime"]


def _extract_import(node, rel: str, db):
    """Extract import statements."""
    line = node.start_point[0] + 1

    if node.type == "import_statement":
        for child in node.children:
            if child.type == "dotted_name":
                module = child.text.decode()
                db.execute(
                    "INSERT INTO imports (source_file, imported_module, imported_name, line) VALUES (?, ?, ?, ?)",
                    (rel, module, None, line),
                )
            elif child.type == "aliased_import":
                name_node = child.child_by_field_name("name")
                if name_node:
                    module = name_node.text.decode()
                    db.execute(
                        "INSERT INTO imports (source_file, imported_module, imported_name, line) VALUES (?, ?, ?, ?)",
                        (rel, module, None, line),
                    )

    elif node.type == "import_from_statement":
        module_node = node.child_by_field_name("module_name")
        module = module_node.text.decode() if module_node else ""

        for child in node.children:
            if child.type == "dotted_name" and child != module_node:
                name = child.text.decode()
                db.execute(
                    "INSERT INTO imports (source_file, imported_module, imported_name, line) VALUES (?, ?, ?, ?)",
                    (rel, module, name, line),
                )
            elif child.type == "aliased_import":
                name_node = child.child_by_field_name("name")
                if name_node:
                    name = name_node.text.decode()
                    db.execute(
                        "INSERT INTO imports (source_file, imported_module, imported_name, line) VALUES (?, ?, ?, ?)",
                        (rel, module, name, line),
                    )


def _extract_call(node, rel: str, func_ctx: str | None, db):
    """Extract function/method call expressions."""
    line = node.start_point[0] + 1
    func_node = node.child_by_field_name("function")
    if not func_node:
        return

    callee = func_node.text.decode()
    db.execute(
        "INSERT INTO calls (caller_file, caller_func, callee_name, line) VALUES (?, ?, ?, ?)",
        (rel, func_ctx, callee, line),
    )


def parse_file(filepath: Path, parser: Parser, db):
    """Parse a single Python file and insert graph data."""
    source = filepath.read_bytes()
    tree = parser.parse(source)
    rel = str(filepath.relative_to(REPO_ROOT))

    # Clear old data for this file
    db.execute("DELETE FROM functions WHERE file = ?", (rel,))
    db.execute("DELETE FROM classes WHERE file = ?", (rel,))
    db.execute("DELETE FROM imports WHERE source_file = ?", (rel,))
    db.execute("DELETE FROM calls WHERE caller_file = ?", (rel,))

    def walk(node, class_ctx=None, func_ctx=None):
        if node.type == "class_definition":
            name_node = node.child_by_field_name("name")
            name = name_node.text.decode() if name_node else "?"
            bases = ""
            arg_list = node.child_by_field_name("superclasses")
            if arg_list:
                bases = arg_list.text.decode().strip("()")
            db.execute(
                "INSERT INTO classes (name, file, line, bases) VALUES (?, ?, ?, ?)",
                (name, rel, node.start_point[0] + 1, bases),
            )
            for child in node.children:
                walk(child, class_ctx=name, func_ctx=func_ctx)
            return

        if node.type == "function_definition":
            name_node = node.child_by_field_name("name")
            name = name_node.text.decode() if name_node else "?"
            params_node = node.child_by_field_name("parameters")
            sig = params_node.text.decode() if params_node else "()"
            is_public = not name.startswith("_") or name.startswith("__")
            db.execute(
                "INSERT INTO functions (name, file, line, end_line, class_name, is_public, signature) VALUES (?, ?, ?, ?, ?, ?, ?)",
                (name, rel, node.start_point[0] + 1, node.end_point[0] + 1, class_ctx, is_public, sig),
            )
            for child in node.children:
                walk(child, class_ctx=class_ctx, func_ctx=name)
            return

        if node.type in ("import_statement", "import_from_statement"):
            _extract_import(node, rel, db)
            return

        if node.type == "call":
            _extract_call(node, rel, func_ctx, db)
            # Still walk children for nested calls
            for child in node.children:
                walk(child, class_ctx=class_ctx, func_ctx=func_ctx)
            return

        for child in node.children:
            walk(child, class_ctx=class_ctx, func_ctx=func_ctx)

    walk(tree.root_node)

    # Update file meta
    db.execute(
        "INSERT OR REPLACE INTO file_meta (file, mtime) VALUES (?, ?)",
        (rel, filepath.stat().st_mtime),
    )


def build(force: bool = False):
    """Build or incrementally update the code graph."""
    db = get_db()
    parser = Parser(PY_LANGUAGE)

    files = collect_py_files()

    if force:
        stale = files
    else:
        stale = [f for f in files if needs_update(f, db)]

    # Remove entries for files that no longer exist
    indexed = {row["file"] for row in db.execute("SELECT file FROM file_meta").fetchall()}
    current = {str(f.relative_to(REPO_ROOT)) for f in files}
    removed = indexed - current
    for gone in removed:
        db.execute("DELETE FROM functions WHERE file = ?", (gone,))
        db.execute("DELETE FROM classes WHERE file = ?", (gone,))
        db.execute("DELETE FROM imports WHERE source_file = ?", (gone,))
        db.execute("DELETE FROM calls WHERE caller_file = ?", (gone,))
        db.execute("DELETE FROM file_meta WHERE file = ?", (gone,))

    if not stale and not removed:
        return

    t0 = time.monotonic()
    for f in stale:
        try:
            parse_file(f, parser, db)
        except Exception as e:
            print(f"WARNING: Failed to parse {f}: {e}", file=sys.stderr)

    db.commit()
    elapsed = time.monotonic() - t0
    print(
        f"code-graph: indexed {len(stale)} files"
        f" ({len(removed)} removed) in {elapsed:.2f}s"
        f" [{db.execute('SELECT COUNT(*) FROM functions').fetchone()[0]} functions,"
        f" {db.execute('SELECT COUNT(*) FROM calls').fetchone()[0]} calls]",
        file=sys.stderr,
    )
    db.close()


if __name__ == "__main__":
    force = "--force" in sys.argv or "rebuild" in sys.argv
    build(force=force)
