#!/usr/bin/env python3
"""Apply Kagi reviewer fixes to source files.

Parses cleaned fix files (from clean_kagi_output.py), extracts function
replacements, and applies them to the actual source files.

Usage:
    python3 tools/apply_kagi_fixes.py kagi-reviews/fix1-vm-infra-fixes-clean.txt --dry-run
    python3 tools/apply_kagi_fixes.py kagi-reviews/fix1-vm-infra-fixes-clean.txt --apply
    python3 tools/apply_kagi_fixes.py kagi-reviews/*-clean.txt --apply
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


# Map short filenames from reviewer to actual repo paths
FILE_MAP = {
    'virtio_serial_client.py': 'tools/vm/host/virtio_serial_client.py',
    'push_file.py': 'tools/vm/host/push_file.py',
    'qmp_client.py': 'tools/vm/host/qmp_client.py',
    'input_controller.py': 'tools/vm/host/input_controller.py',
    'screen_recorder.py': 'tools/vm/host/screen_recorder.py',
    'orchestrator.py': 'tools/vm/host/orchestrator.py',
    'config.py': 'tools/vm/host/config.py',
    'agent.py': 'tools/vm/guest/agent.py',
    'vbd_helper.py': 'tools/vm/guest/vbd_helper.py',
    'vbdecompile.py': 'tools/c2/vbdecompile.py',
    'extract_metadata.py': 'tools/c2/extract_metadata.py',
    'enumerate_controls.py': 'tools/c2/enumerate_controls.py',
    'validate_decompile.py': 'tools/validate_decompile.py',
    'clean_code.py': 'tools/clean_code.py',
    'batch_decompile.py': 'tools/c2/batch_decompile.py',
    'screenshot_proggies.py': 'tools/c2/screenshot_proggies.py',
    'single_decompile.py': 'tools/single_decompile.py',
    'capture_aohell.py': 'tools/capture_aohell.py',
    'poc_walkthrough.py': 'tools/c2/poc_walkthrough.py',
    'capture_walkthrough.py': 'tools/capture_walkthrough.py',
    'generate_analysis.py': 'tools/generate_analysis.py',
}


def resolve_file(name: str) -> str | None:
    """Resolve a reviewer filename to a repo path."""
    # Try direct match
    basename = Path(name).name
    if basename in FILE_MAP:
        return FILE_MAP[basename]
    # Try with tools/ prefix stripped
    for key, val in FILE_MAP.items():
        if name.endswith(key) or name.endswith(val):
            return val
    return None


def parse_fixes(text: str) -> list[dict]:
    """Parse a cleaned fix file into a list of fix dicts.
    
    Handles multiple formats:
      - "F1 FIX: title"           (fix1, fix2)
      - "File: X, function Y"    (fix4, fix5)
      - "F1\ndef func(..."       (fix3)
    """
    fixes = []

    # Strategy 1: "F1 FIX:" headers
    parts = re.split(r'\n(F\d+ FIX:.*)\n', text)
    if len(parts) > 2:
        i = 1
        while i < len(parts) - 1:
            header = parts[i].strip()
            body = parts[i + 1]
            i += 2
            m = re.match(r'(F\d+) FIX: (.*)', header)
            if not m:
                continue
            fix = _extract_fix_from_body(m.group(1), m.group(2), body)
            if fix:
                fixes.append(fix)
        if fixes:
            return fixes

    # Strategy 2: "File: X, function Y" blocks followed by def
    file_blocks = re.split(r'\n(File: .+)\n', text)
    if len(file_blocks) > 2:
        # Find fix IDs from earlier in the text
        fix_ids = re.findall(r'(F\d+)\s*[\(—–-]', text)
        fix_idx = 0
        i = 1
        while i < len(file_blocks) - 1:
            file_line = file_blocks[i].strip()
            body = file_blocks[i + 1]
            i += 2
            fm = re.search(r'File:\s*([\w/._-]+(?:\.py)?)', file_line)
            if not fm:
                continue
            func_m = re.search(r'function\s+(\w+)', file_line)
            fid = fix_ids[fix_idx] if fix_idx < len(fix_ids) else f'F{fix_idx+1}'
            fix_idx += 1
            fix = _extract_fix_from_body(fid, file_line, body, default_file=fm.group(1).strip(), default_func=func_m.group(1) if func_m else '')
            if fix:
                fixes.append(fix)
        if fixes:
            return fixes

    # Strategy 3: bare "F1\n" followed by code
    bare_blocks = re.split(r'\n(F\d+)\n', text)
    if len(bare_blocks) > 2:
        i = 1
        while i < len(bare_blocks) - 1:
            fid = bare_blocks[i].strip()
            body = bare_blocks[i + 1]
            i += 2
            fix = _extract_fix_from_body(fid, '', body)
            if fix:
                fixes.append(fix)

    return fixes


def _extract_fix_from_body(fix_id: str, title: str, body: str,
                           default_file: str = '', default_func: str = '') -> dict | None:
    """Extract file, function, and code from a fix body block."""
    # Extract file
    fm = re.search(r'File:\s*([\w/._-]+(?:\.py)?)', body)
    file_name = fm.group(1).strip() if fm else default_file

    # Extract function name
    func_m = re.search(r'function\s+(\w+)', body)
    func_name = func_m.group(1) if func_m else default_func
    if not func_name:
        # Try to get it from first def line
        def_m = re.search(r'^def (\w+)\s*\(', body, re.MULTILINE)
        if def_m:
            func_name = def_m.group(1)

    # Extract code block
    code_lines = []
    in_code = False
    for line in body.splitlines():
        stripped = line.rstrip()
        if not in_code:
            if re.match(r'^(def |class |@)', stripped):
                in_code = True
                code_lines.append(stripped)
        else:
            if stripped and not stripped[0].isspace() and not re.match(
                r'^(def |class |@|#|if |else:|elif |try:|except |finally:|return |raise |for |while |with |    )', stripped
            ):
                break
            code_lines.append(stripped)

    while code_lines and not code_lines[-1].strip():
        code_lines.pop()

    if not code_lines and not func_name:
        return None

    return {
        'id': fix_id,
        'title': title,
        'file': file_name,
        'func': func_name,
        'code': '\n'.join(code_lines) if code_lines else '',
        'raw': body[:300],
    }


def find_function_in_source(source: str, func_name: str) -> tuple[int, int] | None:
    """Find start and end line indices of a function in source code."""
    lines = source.splitlines()
    start = None
    indent = None

    for i, line in enumerate(lines):
        # Match "def func_name(" or "    def func_name("
        m = re.match(rf'^(\s*)def {re.escape(func_name)}\s*\(', line)
        if m:
            start = i
            indent = len(m.group(1))
            break

    if start is None:
        return None

    # Find end: next line at same or lesser indent that's not blank/comment/decorator
    end = start + 1
    while end < len(lines):
        line = lines[end]
        if line.strip() == '' or line.strip().startswith('#'):
            end += 1
            continue
        line_indent = len(line) - len(line.lstrip())
        if line_indent <= indent and line.strip() and not line.strip().startswith('@'):
            break
        end += 1

    return (start, end)


def apply_fix(source: str, func_name: str, new_code: str) -> str | None:
    """Replace a function in source with new code. Returns new source or None."""
    span = find_function_in_source(source, func_name)
    if not span:
        return None

    lines = source.splitlines()
    start, end = span
    old_indent = len(lines[start]) - len(lines[start].lstrip())

    # Detect indent of new code
    new_lines = new_code.splitlines()
    if not new_lines:
        return None
    new_indent = len(new_lines[0]) - len(new_lines[0].lstrip())

    # Re-indent new code to match source
    adjusted = []
    for nl in new_lines:
        if nl.strip() == '':
            adjusted.append('')
        else:
            cur_indent = len(nl) - len(nl.lstrip())
            new_ind = old_indent + (cur_indent - new_indent)
            adjusted.append(' ' * max(0, new_ind) + nl.lstrip())

    result = lines[:start] + adjusted + lines[end:]
    return '\n'.join(result) + '\n'


def main() -> int:
    parser = argparse.ArgumentParser(description='Apply Kagi reviewer fixes to source files.')
    parser.add_argument('files', nargs='+', type=Path, help='Cleaned fix files')
    parser.add_argument('--apply', action='store_true', help='Actually write changes (default: dry-run)')
    parser.add_argument('--dry-run', action='store_true', help='Show what would change (default)')
    args = parser.parse_args()

    total = applied = skipped = failed = 0

    for fix_file in args.files:
        if not fix_file.exists():
            print(f'SKIP: {fix_file} not found')
            continue

        text = fix_file.read_text(encoding='utf-8')
        fixes = parse_fixes(text)
        print(f'\n{"="*60}')
        print(f'{fix_file.name}: {len(fixes)} fixes parsed')
        print(f'{"="*60}')

        for fix in fixes:
            total += 1
            repo_path = resolve_file(fix['file'])

            if not repo_path:
                print(f"  {fix['id']}: SKIP — can't resolve file '{fix['file']}'")
                skipped += 1
                continue

            if not fix['func']:
                print(f"  {fix['id']}: SKIP — no function name found ({fix['title'][:50]})")
                skipped += 1
                continue

            if not fix['code']:
                print(f"  {fix['id']}: SKIP — no code block found ({fix['title'][:50]})")
                skipped += 1
                continue

            source_path = Path(repo_path)
            if not source_path.exists():
                print(f"  {fix['id']}: SKIP — {repo_path} not found on disk")
                skipped += 1
                continue

            source = source_path.read_text(encoding='utf-8')
            result = apply_fix(source, fix['func'], fix['code'])

            if result is None:
                print(f"  {fix['id']}: FAIL — function '{fix['func']}' not found in {repo_path}")
                failed += 1
                continue

            if result == source:
                print(f"  {fix['id']}: NOOP — no change to {fix['func']} in {repo_path}")
                skipped += 1
                continue

            if args.apply:
                source_path.write_text(result, encoding='utf-8')
                # Compile check
                import py_compile
                try:
                    py_compile.compile(str(source_path), doraise=True)
                    print(f"  {fix['id']}: APPLIED — {fix['func']} in {repo_path} ✓")
                    applied += 1
                except py_compile.PyCompileError as e:
                    # Revert
                    source_path.write_text(source, encoding='utf-8')
                    print(f"  {fix['id']}: REVERTED — compile error after applying to {repo_path}: {e}")
                    failed += 1
            else:
                old_lines = len(source.splitlines())
                new_lines = len(result.splitlines())
                print(f"  {fix['id']}: WOULD APPLY — {fix['func']} in {repo_path} ({old_lines}→{new_lines} lines)")
                applied += 1

    print(f'\nSummary: {total} fixes, {applied} {"applied" if args.apply else "would apply"}, {skipped} skipped, {failed} failed')
    return 0 if failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
