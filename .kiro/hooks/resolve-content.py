#!/usr/bin/env python3
# stdout-ok
"""Resolve final file content for fs_write hook events.

Reads hook event JSON from stdin. For 'create', outputs file_text.
For str_replace/append/insert, reads the existing file and applies
the mutation, then outputs the result.

Exit 0 + stdout = resolved content.
Exit 1 = error (stderr has message).
"""
from __future__ import annotations

import json
import sys
from pathlib import Path


def main() -> int:
    try:
        event = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError) as exc:
        print(f"resolve-content: invalid JSON on stdin: {exc}", file=sys.stderr)
        return 1

    ti = event.get("tool_input", {})
    path = ti.get("path", "")
    cmd = ti.get("command", "")

    if cmd == "create":
        print(ti.get("file_text", ""))
        return 0

    if cmd not in ("str_replace", "append", "insert"):
        return 0

    p = Path(path)
    if not p.exists():
        print(f"resolve-content: file not found: {path}", file=sys.stderr)
        return 1

    src = p.read_text(encoding="utf-8")

    if cmd == "str_replace":
        old = ti.get("old_str", "")
        new = ti.get("new_str", "")
        if old:
            src = src.replace(old, new, 1)
    elif cmd == "append":
        extra = ti.get("new_str", "")
        if src and not src.endswith("\n"):
            src += "\n"
        src += extra
    elif cmd == "insert":
        line_num = int(ti.get("insert_line", 0))
        extra = ti.get("new_str", "")
        lines = src.splitlines(True)
        lines.insert(line_num, extra + "\n")
        src = "".join(lines)

    print(src)
    return 0


if __name__ == "__main__":
    sys.exit(main())
