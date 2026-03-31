#!/usr/bin/env python3
"""PreToolUse hook: block fs_write if the written Python file has code quality violations.

Reads hook event JSON from STDIN. Checks the file being written for:
- Bare except clauses
- Functions > 50 lines
- Mutable module-level state (non-constant assignments)
- No type hints on public functions

Exit 0 = allow, exit 2 = block (STDERR returned to LLM).
"""
import ast
import json
import sys


def check_violations(source: str, filepath: str) -> list[str]:
    violations: list[str] = []
    try:
        tree = ast.parse(source)
    except SyntaxError as e:
        violations.append(f"SyntaxError: {e}")
        return violations

    for node in ast.walk(tree):
        # Bare except
        if isinstance(node, ast.ExceptHandler) and node.type is None:
            violations.append(f"line {node.lineno}: bare 'except:' — must specify exception type (Google §2.4)")

    # Function checks
    for node in ast.iter_child_nodes(tree):
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            _check_function(node, violations, top_level=True)
        elif isinstance(node, ast.ClassDef):
            for item in ast.iter_child_nodes(node):
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    _check_function(item, violations, top_level=True)

    # Mutable module-level state
    for node in ast.iter_child_nodes(tree):
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name):
                    name = target.id
                    # Constants (UPPER_SNAKE) and dunders are OK
                    if name.startswith("__") or name == name.upper():
                        continue
                    # Type aliases OK
                    if isinstance(node.value, ast.Subscript):
                        continue
                    # logger = logging.getLogger(...) is OK
                    if name == "logger" and isinstance(node.value, ast.Call):
                        continue
                    violations.append(
                        f"line {node.lineno}: mutable module-level variable '{name}' — "
                        f"use UPPER_SNAKE for constants or pass via config object (Google §2.5)"
                    )

    return violations


def _check_function(node, violations, top_level):
    name = node.name
    is_private = name.startswith("_") and not (name.startswith("__") and name.endswith("__"))
    if is_private:
        return  # skip private, but check dunders

    # Function length
    if node.end_lineno and node.lineno:
        length = node.end_lineno - node.lineno + 1
        if length > 50:
            violations.append(
                f"line {node.lineno}: function '{name}' is {length} lines — "
                f"consider decomposing (Google §3.18 recommends ~40)"
            )

    # Missing return type hint on public functions
    if top_level and not name.startswith("_") and node.returns is None:
        violations.append(
            f"line {node.lineno}: public function '{name}' missing return type hint (Google §2.21)"
        )


def main():
    event = json.load(sys.stdin)
    tool_input = event.get("tool_input", {})

    # fs_write tool_input has 'path' and optionally 'file_text' or 'new_str'
    filepath = tool_input.get("path", "")
    if not filepath.endswith((".py", ".pyw")):
        sys.exit(0)

    # Skip test files
    basename = filepath.rsplit("/", 1)[-1] if "/" in filepath else filepath
    if basename.startswith("test_") or basename.endswith("_test.py") or basename in (
        "conftest.py", "__init__.py", "setup.py"
    ):
        sys.exit(0)

    # Get the content being written
    command = tool_input.get("command", "")
    if command == "create":
        source = tool_input.get("file_text", "")
    elif command in ("str_replace", "append", "insert"):
        try:
            source = open(filepath, encoding="utf-8").read()
        except OSError:
            sys.exit(0)
        if command == "str_replace":
            old_str = tool_input.get("old_str", "")
            new_str = tool_input.get("new_str", "")
            if old_str:
                source = source.replace(old_str, new_str, 1)
        elif command == "append":
            extra = tool_input.get("new_str", "")
            if source and not source.endswith("\n"):
                source += "\n"
            source += extra
        elif command == "insert":
            line_num = int(tool_input.get("insert_line", 0))
            extra = tool_input.get("new_str", "")
            lines = source.splitlines(True)
            lines.insert(line_num, extra + "\n")
            source = "".join(lines)
    else:
        sys.exit(0)

    if not source.strip():
        sys.exit(0)

    violations = check_violations(source, filepath)
    if violations:
        msg = f"BLOCKED: {len(violations)} code quality violation(s) in {filepath}:\n"
        for v in violations:
            msg += f"  ✗ {v}\n"
        msg += "\nFix violations before writing. See .kiro/skills/code-quality/SKILL.md"
        print(msg, file=sys.stderr)
        sys.exit(2)

    sys.exit(0)


if __name__ == "__main__":
    main()
