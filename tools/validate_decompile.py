#!/usr/bin/env python3
"""Validate decompiled output completeness.

Checks every decompiled proggie:
  1. VBP form count == actual .frm file count
  2. VBP module count == actual .bas/.declarations file count
  3. metadata.json form count matches VBP

Usage:
  python3 tools/validate_decompile.py              # scan all, report problems
  python3 tools/validate_decompile.py --fix-list   # output list of stems needing re-decompile
  python3 tools/validate_decompile.py bodini        # check one proggie
"""
import re, sys, json
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
DECOMPILED = REPO / 'decompiled'


def validate_one(stem):
    """Validate a single decompiled proggie. Returns dict with results."""
    stem_dir = DECOMPILED / stem
    if not stem_dir.exists():
        return {'stem': stem, 'status': 'missing', 'errors': ['no decompiled dir']}

    # Find the exe subdir (e.g. decompiled/bodini/bodini.exe/)
    exe_dirs = [d for d in stem_dir.iterdir() if d.is_dir() and d.name.endswith('.exe')]
    if not exe_dirs:
        return {'stem': stem, 'status': 'missing', 'errors': ['no exe subdir']}

    errors = []
    for exe_dir in exe_dirs:
        vbp = exe_dir / 'Project.vbp'
        if not vbp.exists():
            vbp = exe_dir / 'project.vbp'
        if not vbp.exists():
            errors.append(f'{exe_dir.name}: no Project.vbp')
            continue

        vbp_text = vbp.read_text(errors='replace')

        # Count forms in VBP
        vbp_forms = set()
        for m in re.finditer(r'^Form=(\S+)\.frm', vbp_text, re.MULTILINE):
            vbp_forms.add(m.group(1).lower())

        # Count modules in VBP
        vbp_modules = set()
        for m in re.finditer(r'^Module=\w+;\s*(\S+)\.bas', vbp_text, re.MULTILINE):
            vbp_modules.add(m.group(1).lower())

        # Count actual .frm files (check both root and forms/ subdir)
        disk_forms = set()
        for f in exe_dir.glob('*.frm'):
            disk_forms.add(f.stem.lower())
        forms_dir = exe_dir / 'forms'
        if forms_dir.exists():
            for f in forms_dir.glob('*.frm'):
                disk_forms.add(f.stem.lower())

        # Count actual .bas files (or _funcs directories from plugin)
        disk_modules = set()
        for f in exe_dir.glob('*.bas'):
            disk_modules.add(f.stem.lower())
        mods_dir = exe_dir / 'modules'
        if mods_dir.exists():
            for f in mods_dir.glob('*.declarations'):
                disk_modules.add(f.stem.lower())
            for d in mods_dir.iterdir():
                if d.is_dir() and d.name.endswith('_funcs'):
                    disk_modules.add(d.name[:-6].lower())

        # Check metadata
        meta_path = exe_dir / 'metadata.json'
        meta_forms = 0
        if meta_path.exists():
            try:
                meta = json.loads(meta_path.read_text())
                meta_forms = len(meta.get('forms', []))
            except Exception:
                errors.append(f'{exe_dir.name}: corrupt metadata.json')

        # Validate
        missing_forms = sorted(vbp_forms - disk_forms)
        missing_mods = sorted(vbp_modules - disk_modules)

        if missing_forms:
            errors.append(
                f'{exe_dir.name}: {len(missing_forms)}/{len(vbp_forms)} forms missing: '
                f'{", ".join(missing_forms[:10])}{"..." if len(missing_forms) > 10 else ""}'
            )

        if missing_mods:
            errors.append(
                f'{exe_dir.name}: {len(missing_mods)}/{len(vbp_modules)} modules missing: '
                f'{", ".join(missing_mods)}'
            )

        if meta_forms and meta_forms != len(vbp_forms):
            errors.append(
                f'{exe_dir.name}: metadata says {meta_forms} forms but VBP has {len(vbp_forms)}'
            )

    status = 'FAIL' if errors else 'ok'
    return {'stem': stem, 'status': status, 'errors': errors}


def scan_all():
    """Scan all decompiled proggies."""
    results = []
    for stem_dir in sorted(DECOMPILED.iterdir()):
        if not stem_dir.is_dir():
            continue
        results.append(validate_one(stem_dir.name))
    return results


def main():
    fix_list = '--fix-list' in sys.argv
    targets = [a for a in sys.argv[1:] if not a.startswith('-')]

    if targets:
        results = [validate_one(t) for t in targets]
    else:
        results = scan_all()

    failures = [r for r in results if r['status'] == 'FAIL']
    ok_count = sum(1 for r in results if r['status'] == 'ok')

    if fix_list:
        for r in failures:
            print(r['stem'])
    else:
        for r in failures:
            print(f"FAIL: {r['stem']}")
            for e in r['errors']:
                print(f"  {e}")
        print(f"\n{ok_count} ok, {len(failures)} FAILED out of {len(results)} checked")

    sys.exit(1 if failures else 0)


if __name__ == '__main__':
    main()
