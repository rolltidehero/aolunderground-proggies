#!/usr/bin/env python3
"""PostToolUse hook: lint full file after any fs_write (including str_replace).

Reads hook event JSON from STDIN. If the written file is .py/.sh/.ps1, reads it
from disk and checks for ALL steering rule violations. Exit code 1 warns the LLM.

Covers every structurally-checkable rule from:
  - python.md (20 rules)
  - bash.md (8 rules)
  - powershell.md (9 rules)
"""
from __future__ import annotations

import ast
import json
import re
import sys


# ============================================================
# PYTHON CHECKS — all 20 rules from python.md + enforce-python-steering.sh
# ============================================================

def check_python(source: str, is_lib: bool = False) -> list[str]:
    v: list[str] = []
    lines = source.splitlines()

    # Skip test files handled at caller level

    # 1. from __future__ import annotations
    if not any(re.match(r'^from __future__ import annotations', l) for l in lines):
        v.append("[MISSING] 'from __future__ import annotations'")

    # CLI-specific checks — skip for lib/ modules
    if not is_lib:
        # 2. import argparse
        if not any(re.match(r'^\s*(import argparse|from argparse)', l) for l in lines):
            v.append("[MISSING] 'import argparse'")

        # 3. setup_trace() or setup_logging() defined or imported
        if not any(re.search(r'(def setup_logging|import.*setup_logging|setup_logging\s*=|from tools\.lib\.trace import|import.*setup_trace|setup_trace\s*\()', l) for l in lines):
            v.append("[MISSING] setup_trace() from tools.lib.trace — see trace-logging.md")

        # 4. def main() -> int
        if not any(re.match(r'^\s*def main\s*\(.*\)\s*->\s*int\s*:', l) for l in lines):
            v.append("[MISSING] 'def main() -> int:' entry point")

        # 5. if __name__ == "__main__" guard
        if not any(re.search(r'if\s+__name__\s*==\s*["\']__main__["\']', l) for l in lines):
            v.append("[MISSING] if __name__ == '__main__' guard")

    # 6. except KeyboardInterrupt handler
    if not is_lib:
        if not any(re.search(r'except\s+KeyboardInterrupt', l) for l in lines):
            v.append("[MISSING] 'except KeyboardInterrupt' handler")

    # 7. logger = logging.getLogger
    if not any(re.match(r'^\s*logger\s*=\s*logging\.getLogger', l) for l in lines):
        v.append("[MISSING] 'logger = logging.getLogger(__name__)'")

    # 8. No print() calls
    print_lines = [i for i, l in enumerate(lines, 1) if re.match(r'^\s*print\s*\(', l)]
    if print_lines:
        v.append(f"[FORBIDDEN] {len(print_lines)} print() call(s) — use logger")

    # 9. All def statements must have return type annotations
    try:
        tree = ast.parse(source)
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                if node.returns is None:
                    v.append(f"[MISSING] line {node.lineno}: '{node.name}' missing return type hint")
    except SyntaxError:
        pass  # syntax errors caught separately

    # 10. No bare except: clauses
    if any(re.match(r'^\s*except\s*:', l) for l in lines):
        v.append("[FORBIDDEN] bare 'except:' — catch specific exceptions")

    # 11. No silently swallowed exceptions (except ...: pass)
    for i, l in enumerate(lines):
        if re.match(r'^\s*except\b.*:\s*$', l) and i + 1 < len(lines):
            if re.match(r'^\s*pass\s*$', lines[i + 1]):
                v.append(f"[FORBIDDEN] line {i+1}: silently swallowed exception (except: pass)")
                break

    # 12. No import * wildcard imports
    if any(re.match(r'^\s*from\s+\S+\s+import\s+\*', l) for l in lines):
        v.append("[FORBIDDEN] 'from X import *' wildcard import")

    # 13. No os.system() or subprocess with shell=True
    if any(re.search(r'os\.system\s*\(', l) for l in lines):
        v.append("[FORBIDDEN] os.system() — use subprocess.run()")
    if any(re.search(r'subprocess\.(call|run|Popen)\s*\(.*shell\s*=\s*True', l) for l in lines):
        v.append("[FORBIDDEN] subprocess with shell=True")

    # 14. No eval() or exec() calls
    if any(re.search(r'(?<!\w)(eval|exec)\s*\(', l) for l in lines):
        v.append("[FORBIDDEN] eval()/exec() call")

    # 15. No mutable default arguments
    if any(re.search(r'^\s*def\s+.*=\s*(\[\]|\{\})', l) for l in lines):
        v.append("[FORBIDDEN] mutable default argument (def f(x=[]))")

    # 16. No os.path usage
    if any(re.search(r'(import os\.path|os\.path\.)', l) for l in lines):
        v.append("[FORBIDDEN] os.path — use pathlib.Path")

    # 17. encoding="utf-8" on read_text/write_text/open calls
    # Join continuation lines first
    joined = _join_continuations(source)
    joined_lines = joined.splitlines()
    for i, l in enumerate(joined_lines, 1):
        if re.search(r'\.(read_text|write_text)\s*\(', l) and 'encoding' not in l:
            v.append(f"[MISSING] encoding='utf-8' on read_text/write_text (joined line {i})")
            break
    for i, l in enumerate(joined_lines, 1):
        if re.search(r'\bopen\s*\(', l) and 'encoding' not in l:
            if not re.search(r'["\']r?b["\']', l):  # skip binary modes
                v.append(f"[MISSING] encoding='utf-8' on open() (joined line {i})")
                break

    # 18. -o/--output argument in argparse
    has_argparse = any(re.search(r'argparse', l) for l in lines)
    if has_argparse and not any(re.search(r'(-o|--output)', l) for l in lines):
        v.append("[MISSING] -o/--output argument in argparse")

    # 19. -q/--quiet (preferred) or -v/--verbose (legacy)
    if has_argparse and not any(re.search(r'(-q|--quiet|-v|--verbose)', l) for l in lines):
        v.append("[MISSING] -q/--quiet argument in argparse")

    # 20. No hardcoded credentials
    for l in lines:
        if re.search(r'(password|passwd|secret|api_key|token)\s*=\s*["\'][^"\']{4,}["\']', l, re.I):
            if not re.search(r'(help=|#|description|\.get\(|\.add_argument)', l):
                v.append("[SECURITY] possible hardcoded credential")
                break

    # 21. No assert for input validation (Google §2.4)
    assert_lines = [i for i, l in enumerate(lines, 1) if re.match(r'^\s*assert\s+', l)]
    if assert_lines:
        v.append(f"[FORBIDDEN] {len(assert_lines)} assert statement(s) — use 'if not x: raise ValueError()' (Google §2.4)")

    # 22. No f-strings in logger calls (Google §3.10.1)
    for i, l in enumerate(lines, 1):
        if re.search(r'logger\.(debug|info|warning|error|critical|exception)\s*\(\s*f["\']', l):
            v.append(f"[FORBIDDEN] line {i}: f-string in logger call — use %s placeholders (Google §3.10.1)")
            break

    # AST-based checks: function length, mutable module-level vars
    try:
        tree = ast.parse(source)
        for node in ast.iter_child_nodes(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
                _check_py_func(node, v)
            elif isinstance(node, ast.ClassDef):
                for item in ast.iter_child_nodes(node):
                    if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                        _check_py_func(item, v)
            elif isinstance(node, ast.Assign):
                for target in node.targets:
                    if isinstance(target, ast.Name):
                        name = target.id
                        if name.startswith("__") or name == name.upper():
                            continue
                        if isinstance(node.value, ast.Subscript):
                            continue
                        # logger = logging.getLogger(...) is OK
                        if name == "logger" and isinstance(node.value, ast.Call):
                            continue
                        v.append(f"[FORBIDDEN] line {node.lineno}: mutable module-level variable '{name}'")
    except SyntaxError as e:
        v.append(f"[SYNTAX] SyntaxError: {e}")

    return v


def _check_py_func(node: ast.FunctionDef, v: list[str]) -> None:
    if node.name.startswith("_"):
        return
    if node.end_lineno and node.lineno:
        length = node.end_lineno - node.lineno + 1
        if length > 50:
            v.append(f"[FORBIDDEN] line {node.lineno}: '{node.name}' is {length} lines (max 50)")


def _join_continuations(source: str) -> str:
    lines = source.splitlines()
    result: list[str] = []
    buf = ""
    for l in lines:
        if re.search(r'[,(]\s*$', l):
            buf += l + " "
        else:
            if buf:
                result.append(buf + l)
                buf = ""
            else:
                result.append(l)
    if buf:
        result.append(buf)
    return "\n".join(result)


# ============================================================
# BASH CHECKS — all 8 rules from bash.md + enforce-bash-steering.sh
# ============================================================

def check_sh(source: str) -> list[str]:
    v: list[str] = []
    lines = source.splitlines()
    non_comment = [l for l in lines if not l.strip().startswith("#")]

    # 1. Shebang
    if not lines or not re.match(r'^#!/usr/bin/env bash|^#!/bin/bash', lines[0]):
        v.append("[MISSING] '#!/usr/bin/env bash' shebang")

    # 2. set -euo pipefail
    if not any(re.search(r'^\s*set\s+-euo\s+pipefail', l) for l in non_comment):
        v.append("[MISSING] 'set -euo pipefail'")

    # 3. Usage/help function
    if not any(re.search(r'(usage|help|--help|-h\b)', l, re.I) for l in lines):
        v.append("[MISSING] usage/help function (--help or -h)")

    # 4. Trap for cleanup on EXIT
    if not any(re.search(r'^\s*trap\s+.*EXIT', l) for l in non_comment):
        v.append("[MISSING] 'trap cleanup EXIT'")

    # 5. Trap for INT/TERM
    if not any(re.search(r'^\s*trap\s+.*(INT|TERM)', l) for l in non_comment):
        v.append("[MISSING] 'trap ... INT TERM'")

    # 6. cleanup() function (if trap references it)
    has_cleanup_trap = any(re.search(r'^\s*trap\s+.*cleanup.*EXIT', l) for l in non_comment)
    has_cleanup_func = any(re.search(r'^\s*(cleanup\s*\(\)|function\s+cleanup)', l) for l in lines)
    if has_cleanup_trap and not has_cleanup_func:
        v.append("[MISSING] cleanup() function referenced in trap but not defined")

    # 7. No backtick command substitution
    for i, l in enumerate(lines, 1):
        if l.strip().startswith("#"):
            continue
        if re.search(r'`[^`]+`', l):
            v.append(f"[FORBIDDEN] line {i}: backtick command substitution — use $()")
            break

    # 8. No single-bracket conditionals
    for i, l in enumerate(lines, 1):
        if l.strip().startswith("#"):
            continue
        if re.match(r'^\s*(if|elif|while|until)\s+\[\s+[^\[]', l):
            v.append(f"[FORBIDDEN] line {i}: single-bracket conditional — use [[ ]]")
            break
        if re.match(r'^\s*\[\s+[^\[]', l):
            v.append(f"[FORBIDDEN] line {i}: single-bracket test — use [[ ]]")
            break

    # 9. No parsing ls output (BashPitfalls #1)
    for i, l in enumerate(lines, 1):
        if re.search(r'for\s+\w+\s+in\s+\$\(ls\b', l):
            v.append(f"[FORBIDDEN] line {i}: 'for x in $(ls ...)' — never parse ls output, use globs")
            break

    # 10. No read without -r
    for i, l in enumerate(lines, 1):
        if l.strip().startswith("#"):
            continue
        if re.match(r'^\s*read\s+', l) and '-r' not in l:
            v.append(f"[FORBIDDEN] line {i}: 'read' without -r — backslashes will be mangled")
            break

    # 11. No printf "$var" format string injection (BashPitfalls #32)
    for i, l in enumerate(lines, 1):
        if l.strip().startswith("#"):
            continue
        if re.match(r'^\s*printf\s+"?\$\w', l):
            v.append(f"[FORBIDDEN] line {i}: printf \"$var\" — format string injection")
            break

    return v


# ============================================================
# POWERSHELL CHECKS — all 9 rules from powershell.md + enforce-powershell-steering.sh
# ============================================================

def check_ps1(source: str) -> list[str]:
    v: list[str] = []
    lines = source.splitlines()

    # 1. #Requires -Version
    if not any(re.match(r'^\s*#Requires\s+-Version', l) for l in lines):
        v.append("[MISSING] '#Requires -Version 5.0'")

    # 2. CmdletBinding
    if "[CmdletBinding" not in source:
        v.append("[MISSING] [CmdletBinding()]")

    # 3. param() block
    if not any(re.search(r'^\s*param\s*\(', l) for l in lines):
        v.append("[MISSING] param() block")

    # 4. ErrorActionPreference = Stop
    if "$ErrorActionPreference" not in source:
        v.append("[MISSING] $ErrorActionPreference = 'Stop'")

    # 5. Set-StrictMode
    if "Set-StrictMode" not in source:
        v.append("[MISSING] Set-StrictMode -Version 2.0")

    # 6. Comment-based help (.SYNOPSIS)
    if ".SYNOPSIS" not in source:
        v.append("[MISSING] comment-based help (.SYNOPSIS)")

    # 7. try/catch present
    if not any(re.match(r'^\s*try\s*\{', l) for l in lines):
        v.append("[MISSING] try/catch error handling")

    # 8. No hardcoded credentials
    for l in lines:
        if re.search(r'(password|passwd|secret)\s*=\s*["\'][^"\']{4,}["\']', l, re.I):
            if not re.search(r'(#|\.PARAMETER|\.EXAMPLE|help|description)', l, re.I):
                v.append("[SECURITY] possible hardcoded credential")
                break

    # 9. No Get-ADComputer
    if "Get-ADComputer" in source:
        v.append("[FORBIDDEN] Get-ADComputer — use DirectorySearcher")

    # 10. Capture $_ in catch blocks
    for i, l in enumerate(lines):
        if re.match(r'^\s*catch\s*\{', l) and i + 1 < len(lines):
            next_l = lines[i + 1]
            if not re.search(r'\$currentError\s*=\s*\$_|\$err\s*=\s*\$_', next_l):
                v.append(f"[MISSING] line {i+1}: catch block must capture $_ immediately")
                break

    return v


# ============================================================
# SQL CHECKS — rules from mssql.md
# ============================================================

def check_sql(source: str) -> list[str]:
    v: list[str] = []
    lines = source.splitlines()

    # 1. SET NOCOUNT ON
    if not any(re.search(r'(?i)SET\s+NOCOUNT\s+ON', l) for l in lines):
        v.append("[MISSING] SET NOCOUNT ON")

    # 2. No xp_cmdshell / sp_configure
    for i, l in enumerate(lines, 1):
        if re.search(r'(?i)\b(xp_cmdshell|sp_configure)\b', l):
            v.append(f"[FORBIDDEN] line {i}: xp_cmdshell/sp_configure")
            break

    # 3. No nested OPENQUERY
    for i, l in enumerate(lines, 1):
        if re.search(r'(?i)OPENQUERY.*OPENQUERY', l):
            v.append(f"[FORBIDDEN] line {i}: nested OPENQUERY — use EXEC AT")
            break

    # 4. TRY/CATCH required if EXEC/sp_executesql/OPENQUERY present
    has_exec = any(re.search(r'(?i)\b(EXEC\s|sp_executesql|OPENQUERY)\b', l) for l in lines)
    has_try = any(re.search(r'(?i)BEGIN\s+TRY', l) for l in lines)
    if has_exec and not has_try:
        v.append("[MISSING] BEGIN TRY/BEGIN CATCH for remote/dynamic calls")

    # 5. CHAR(39) in dynamic SQL
    if any(re.search(r'(?i)CHAR\s*\(\s*39\s*\)', l) for l in lines):
        v.append("[FORBIDDEN] CHAR(39) — use '''' for apostrophes in dynamic SQL")

    # 6. Subqueries inside PRINT/RAISERROR
    for i, l in enumerate(lines, 1):
        if re.search(r'(?i)(PRINT|RAISERROR)\s.*\(\s*SELECT\b', l):
            v.append(f"[FORBIDDEN] line {i}: subquery inside PRINT/RAISERROR — use variable")
            break

    return v


# ============================================================
# RUNTIME CHECKS — catch errors that static analysis misses
# ============================================================

def runtime_check_python(filepath: str, is_new: bool = False) -> list[str]:
    """Syntax check + import check + test file check for Python scripts."""
    import subprocess as _sp
    v: list[str] = []

    # 1. py_compile — catches syntax errors
    r = _sp.run(
        [sys.executable, "-m", "py_compile", filepath],
        capture_output=True, text=True, timeout=10,
    )
    if r.returncode != 0:
        err = (r.stderr or r.stdout).strip().splitlines()[-1] if (r.stderr or r.stdout) else "unknown"
        v.append(f"[SYNTAX] py_compile failed: {err}")
        return v  # no point running import check if syntax is broken

    # 2. Import check — parse AST for imports and verify they're resolvable
    #    WITHOUT executing the module (exec_module runs top-level code which
    #    could have side effects like network calls or file writes).
    #    Skip local/relative imports (tools.*, lib.*) — they depend on sys.path
    #    which varies by invocation context.
    _SKIP_LOCAL = {"tools", "lib"}
    try:
        tree = ast.parse(open(filepath, encoding="utf-8", errors="replace").read())
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                for alias in node.names:
                    _name = alias.name.split(".")[0]
                    if _name in _SKIP_LOCAL:
                        continue
                    try:
                        spec = __import__("importlib").util.find_spec(_name)
                        if spec is None:
                            v.append(f"[RUNTIME] import '{alias.name}' not found")
                    except (ModuleNotFoundError, ValueError):
                        v.append(f"[RUNTIME] import '{alias.name}' not found")
            elif isinstance(node, ast.ImportFrom):
                if node.level and node.level > 0:
                    continue  # relative import
                if node.module:
                    _name = node.module.split(".")[0]
                    if _name in _SKIP_LOCAL:
                        continue
                    try:
                        spec = __import__("importlib").util.find_spec(_name)
                        if spec is None:
                            v.append(f"[RUNTIME] import 'from {node.module}' not found")
                    except (ModuleNotFoundError, ValueError):
                        v.append(f"[RUNTIME] import 'from {node.module}' not found")
    except SyntaxError:
        pass  # already caught by py_compile above

    # 3. Test file check — new CLI scripts must have tests
    if is_new:
        from pathlib import Path as _P
        p = _P(filepath)
        stem = p.stem
        parent = p.parent

        # Skip lib/ modules — tested through parent script's tests
        if "/lib/" in filepath or "\\lib\\" in filepath:
            return v

        # Skip non-CLI modules (no def main)
        try:
            with open(filepath, encoding="utf-8") as f:
                has_main = "def main" in f.read()
        except OSError:
            has_main = False
        if not has_main:
            return v

        candidates = [
            parent / f"test_{stem}.py",
            parent / "tests" / f"test_{stem}.py",
            parent.parent / "tests" / f"test_{stem}.py",
        ]
        if not any(c.exists() for c in candidates):
            v.append(f"[MISSING] no test file found — create test_{stem}.py (python.md: Testing)")

    return v


def runtime_check_sh(filepath: str, is_new: bool = False) -> list[str]:
    """Syntax check for bash scripts."""
    import subprocess as _sp
    v: list[str] = []

    # bash -n — catches syntax errors
    r = _sp.run(
        ["bash", "-n", filepath],
        capture_output=True, text=True, timeout=10,
    )
    if r.returncode != 0:
        err = r.stderr.strip().splitlines()[-1] if r.stderr.strip() else "unknown"
        v.append(f"[SYNTAX] bash -n failed: {err}")

    return v


def runtime_check_ps1(filepath: str, is_new: bool = False) -> list[str]:
    """Test file check for PowerShell scripts."""
    v: list[str] = []
    if is_new:
        from pathlib import Path as _P
        p = _P(filepath)
        stem = p.stem
        parent = p.parent
        candidates = [
            parent / f"{stem}.Tests.ps1",
            parent / "tests" / f"{stem}.Tests.ps1",
            parent.parent / "tests" / f"{stem}.Tests.ps1",
        ]
        if not any(c.exists() for c in candidates):
            v.append(f"[MISSING] no Pester test file — create {stem}.Tests.ps1 (powershell.md: Testing)")
    return v





# ============================================================
# MAIN
# ============================================================

def main() -> None:
    event = json.load(sys.stdin)
    filepath = event.get("tool_input", {}).get("path", "")

    try:
        with open(filepath, encoding="utf-8", errors="replace") as f:
            source = f.read()
    except OSError:
        sys.exit(0)

    violations: list[str] = []
    basename = filepath.rsplit("/", 1)[-1] if "/" in filepath else filepath
    # Detect new files: untracked in git (only for files inside a git repo)
    import subprocess as _sp_git
    from pathlib import Path as _PNew
    _fpath = _PNew(filepath).resolve()
    _parent = _fpath.parent if _fpath.parent.is_dir() else _PNew.cwd()
    _in_repo = _sp_git.run(
        ["git", "rev-parse", "--git-dir"],
        capture_output=True, text=True, timeout=5,
        cwd=str(_parent),
    )
    if _in_repo.returncode == 0:
        _git = _sp_git.run(
            ["git", "ls-files", "--error-unmatch", str(_fpath)],
            capture_output=True, text=True, timeout=5,
            cwd=str(_parent),
        )
        is_new = _git.returncode != 0
    else:
        is_new = False

    if filepath.endswith((".py", ".pyw")):
        # Skip test files
        if basename.startswith("test_") or basename.endswith("_test.py") or basename in (
            "conftest.py", "__init__.py", "setup.py"
        ):
            sys.exit(0)
        is_lib = "/lib/" in filepath
        violations = check_python(source, is_lib=is_lib)
        violations.extend(runtime_check_python(filepath, is_new=is_new))
    elif filepath.endswith((".ps1", ".psm1", ".psd1")):
        violations = check_ps1(source)
        violations.extend(runtime_check_ps1(filepath, is_new=is_new))
    elif filepath.endswith((".sh", ".bash")):
        violations = check_sh(source)
        violations.extend(runtime_check_sh(filepath, is_new=is_new))
    elif filepath.endswith(".sql"):
        violations = check_sql(source)
    else:
        sys.exit(0)

    if violations:
        blockers = [vi for vi in violations if not vi.startswith("[WARNING]")]
        warnings = [vi for vi in violations if vi.startswith("[WARNING]")]

        if blockers:
            msg = f"WARNING: {len(blockers)} violation(s) in {filepath} after write:\n"
            for vi in blockers:
                msg += f"  ✗ {vi}\n"
            if warnings:
                msg += f"Also {len(warnings)} non-blocking warning(s):\n"
                for vi in warnings:
                    msg += f"  ⚠ {vi}\n"
            msg += "\nFix these before committing."
            print(msg, file=sys.stderr)
            sys.exit(2)

        if warnings:
            msg = f"NOTE: {len(warnings)} warning(s) in {filepath} (non-blocking):\n"
            for vi in warnings:
                msg += f"  ⚠ {vi}\n"
            print(msg, file=sys.stderr)

    sys.exit(0)


if __name__ == "__main__":
    main()
