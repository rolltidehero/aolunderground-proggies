"""Code graph SQLite schema and query functions.

Stores function definitions, class definitions, imports, and call edges
for structural codebase queries.
"""
from __future__ import annotations

import os
import sqlite3
from collections import deque
from pathlib import Path

# DB lives at repo root by default; override with CODE_GRAPH_DB env var
DB_PATH = Path(os.environ["CODE_GRAPH_DB"]) if os.environ.get("CODE_GRAPH_DB") else (
    Path(__file__).resolve().parent.parent.parent / ".code-graph.db"
)

SCHEMA = """
CREATE TABLE IF NOT EXISTS functions (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    file TEXT NOT NULL,
    line INTEGER NOT NULL,
    end_line INTEGER,
    class_name TEXT,
    is_public BOOLEAN DEFAULT 1,
    signature TEXT
);
CREATE TABLE IF NOT EXISTS classes (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    file TEXT NOT NULL,
    line INTEGER NOT NULL,
    bases TEXT
);
CREATE TABLE IF NOT EXISTS imports (
    id INTEGER PRIMARY KEY,
    source_file TEXT NOT NULL,
    imported_module TEXT NOT NULL,
    imported_name TEXT,
    line INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS calls (
    id INTEGER PRIMARY KEY,
    caller_file TEXT NOT NULL,
    caller_func TEXT,
    callee_name TEXT NOT NULL,
    line INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS file_meta (
    file TEXT PRIMARY KEY,
    mtime REAL NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_functions_name ON functions(name);
CREATE INDEX IF NOT EXISTS idx_calls_callee ON calls(callee_name);
CREATE INDEX IF NOT EXISTS idx_calls_caller ON calls(caller_func);
CREATE INDEX IF NOT EXISTS idx_imports_name ON imports(imported_name);
CREATE INDEX IF NOT EXISTS idx_imports_module ON imports(imported_module);
"""


def get_db(path: Path = DB_PATH) -> sqlite3.Connection:
    """Open (or create) the code graph database."""
    conn = sqlite3.connect(str(path))
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA journal_mode=WAL")
    conn.executescript(SCHEMA)
    return conn


def callers_of(name: str, db: sqlite3.Connection | None = None) -> list[dict]:
    """Find all call sites of a function."""
    conn = db or get_db()
    method_name = f".{name}"
    rows = conn.execute(
        """
        SELECT caller_file, caller_func, line
        FROM calls
        WHERE callee_name = ?
           OR substr(callee_name, -?) = ?
        """,
        (name, len(method_name), method_name),
    ).fetchall()
    return [dict(r) for r in rows]


def callees_of(name: str, db: sqlite3.Connection | None = None) -> list[dict]:
    """Find all functions called by a function."""
    conn = db or get_db()
    rows = conn.execute(
        "SELECT callee_name, line, caller_file FROM calls WHERE caller_func = ?",
        (name,),
    ).fetchall()
    return [dict(r) for r in rows]


def who_imports(name: str, db: sqlite3.Connection | None = None) -> list[dict]:
    """Find all files that import a module or name."""
    conn = db or get_db()
    rows = conn.execute(
        "SELECT source_file, imported_module, imported_name, line FROM imports "
        "WHERE imported_name = ? OR imported_module LIKE ?",
        (name, f"%{name}%"),
    ).fetchall()
    return [dict(r) for r in rows]


def implementations_of(name: str, db: sqlite3.Connection | None = None) -> list[dict]:
    """Find all definitions of a function/method."""
    conn = db or get_db()
    rows = conn.execute(
        "SELECT name, file, line, class_name, signature FROM functions WHERE name = ?",
        (name,),
    ).fetchall()
    return [dict(r) for r in rows]


def call_chain(source: str, target: str, db: sqlite3.Connection | None = None,
               max_depth: int = 5) -> list[str] | None:
    """BFS shortest call path from source function to target function."""
    conn = db or get_db()
    queue: deque[list[str]] = deque([[source]])
    visited: set[str] = {source}

    for _ in range(max_depth):
        if not queue:
            break
        next_queue: deque[list[str]] = deque()
        while queue:
            path = queue.popleft()
            current = path[-1]
            rows = conn.execute(
                "SELECT DISTINCT callee_name FROM calls WHERE caller_func = ?",
                (current,),
            ).fetchall()
            for row in rows:
                callee = row["callee_name"].rsplit(".", 1)[-1]
                if callee == target:
                    return path + [callee]
                if callee not in visited:
                    visited.add(callee)
                    next_queue.append(path + [callee])
        queue = next_queue
    return None


def neighbors(filepath: str, db: sqlite3.Connection | None = None) -> dict:
    """1-hop architectural context for a file: imports, imported-by, called-by."""
    conn = db or get_db()
    imports_out = conn.execute(
        "SELECT imported_module, imported_name FROM imports WHERE source_file = ?",
        (filepath,),
    ).fetchall()
    imported_by = conn.execute(
        "SELECT source_file, imported_name FROM imports WHERE imported_module LIKE ?",
        (f"%{Path(filepath).stem}%",),
    ).fetchall()
    called_by = conn.execute(
        """SELECT DISTINCT c.caller_file, c.caller_func
           FROM calls c
           JOIN functions f ON f.file = ? AND c.callee_name = f.name""",
        (filepath,),
    ).fetchall()
    return {
        "imports": [dict(r) for r in imports_out],
        "imported_by": [dict(r) for r in imported_by],
        "called_by": [dict(r) for r in called_by],
    }


def stats(db: sqlite3.Connection | None = None) -> dict:
    """Return graph statistics."""
    conn = db or get_db()
    return {
        "functions": conn.execute("SELECT COUNT(*) FROM functions").fetchone()[0],
        "classes": conn.execute("SELECT COUNT(*) FROM classes").fetchone()[0],
        "imports": conn.execute("SELECT COUNT(*) FROM imports").fetchone()[0],
        "calls": conn.execute("SELECT COUNT(*) FROM calls").fetchone()[0],
        "files": conn.execute("SELECT COUNT(*) FROM file_meta").fetchone()[0],
    }
