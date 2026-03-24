#!/usr/bin/env python3
"""Parse decompiled .bas files to extract navigation graphs.

Extracts from each app:
  - forms: list of form/object names
  - clickable: controls with _Click handlers (name, form they belong to)
  - navigation: control_Click -> formname.Show mappings
  - dangerous: controls that call Unload Me / End / App.End
  - menus: mnu*_Click handlers (menu items)

This is "Tier 1" of the screenshot pipeline — zero-cost static analysis
that tells us WHERE to navigate without running the app.

IMPORTANT: The .decompiled.bas format does NOT contain control coordinates
(Left/Top/Width/Height). VB Decompiler's "Save All To One BAS" only outputs
Object headers and Sub code. Control positions must be discovered at runtime
via ENUMCHILDREN (windowed controls) or c2vb.dll (lightweight controls).

Usage:
    python3 parse_nav_graph.py                    # parse all, write nav_graphs.json
    python3 parse_nav_graph.py --one <bas_file>   # parse one, print JSON
    python3 parse_nav_graph.py --stats            # print summary stats
"""
import sys, os, re, json, logging
from pathlib import Path

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
OUTPUT_FILE = os.path.join(REPO_ROOT, 'tools/c2/nav_graphs.json')

logger = logging.getLogger('nav_graph')

# Patterns
RE_OBJECT = re.compile(r"^'Object:\s+(\w+)")
RE_CLICK_SUB = re.compile(
    r"^(?:Private|Public)\s+Sub\s+(\w+)_Click\s*\(", re.IGNORECASE)
RE_SHOW = re.compile(r"(\w+)\.\s*Show\b", re.IGNORECASE)
RE_UNLOAD_ME = re.compile(r"\bUnload\s+Me\b", re.IGNORECASE)
RE_END = re.compile(r"(?<!\.)(?<!\w)End(?!\s+Sub|If|Select|With|Function|Property|Type|Enum)", re.IGNORECASE)
RE_APP_END = re.compile(r"App\s*\.\s*End\b", re.IGNORECASE)


def parse_bas(bas_path):
    """Parse a .decompiled.bas file and return navigation graph."""
    with open(bas_path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()
    lines = content.split('\n')

    result = {
        'forms': [],
        'clickable': [],
        'navigation': [],
        'dangerous': [],
        'menus': [],
    }

    current_form = None
    current_sub = None
    sub_body = []

    for line in lines:
        line = line.rstrip('\r')

        # Track which form/object we're in
        m = RE_OBJECT.match(line)
        if m:
            # Flush previous sub
            if current_sub:
                _analyze_sub(result, current_form, current_sub, sub_body)
                current_sub = None
                sub_body = []
            current_form = m.group(1)
            result['forms'].append(current_form)
            continue

        # Track Sub start
        m = RE_CLICK_SUB.match(line.strip())
        if m:
            # Flush previous sub
            if current_sub:
                _analyze_sub(result, current_form, current_sub, sub_body)
            current_sub = m.group(1)
            sub_body = []
            continue

        # Track Sub end
        if re.match(r'^End\s+Sub', line.strip(), re.IGNORECASE):
            if current_sub:
                _analyze_sub(result, current_form, current_sub, sub_body)
                current_sub = None
                sub_body = []
            continue

        # Accumulate sub body
        if current_sub:
            sub_body.append(line)

    # Flush final sub
    if current_sub:
        _analyze_sub(result, current_form, current_sub, sub_body)

    return result


def _analyze_sub(result, form_name, ctrl_name, body_lines):
    """Analyze a _Click sub body for navigation and danger."""
    body = '\n'.join(body_lines)
    is_menu = ctrl_name.lower().startswith('mnu')

    entry = {'control': ctrl_name, 'form': form_name or ''}
    result['clickable'].append(entry)
    if is_menu:
        result['menus'].append(ctrl_name)

    # Find .Show calls
    for m in RE_SHOW.finditer(body):
        target = m.group(1)
        # Skip self-references and variable names
        if target.lower() in ('var_eax', 'var_18', 'me', 'var_ret_1'):
            continue
        result['navigation'].append({
            'from_control': ctrl_name,
            'from_form': form_name or '',
            'to_form': target,
            'is_menu': is_menu,
        })

    # Check for dangerous operations
    is_dangerous = False
    if RE_UNLOAD_ME.search(body):
        is_dangerous = True
    if RE_APP_END.search(body):
        is_dangerous = True
    # Bare "End" statement (not End Sub/If/etc)
    for bline in body_lines:
        stripped = bline.strip().rstrip('\r')
        # Match lines that are just "End" or "loc_XXXX: End"
        if re.match(r'^(?:loc_[0-9A-Fa-f]+:\s*)?End$', stripped):
            is_dangerous = True
            break

    if is_dangerous:
        result['dangerous'].append({
            'control': ctrl_name,
            'form': form_name or '',
        })


def parse_all(programs_dir=PROGRAMS_DIR):
    """Parse all .decompiled.bas files, return dict keyed by bas path."""
    all_graphs = {}
    stats = {'total': 0, 'with_nav': 0, 'with_menus': 0,
             'with_danger': 0, 'multi_form': 0}

    for root, dirs, files in os.walk(programs_dir):
        for fname in files:
            if not fname.endswith('.decompiled.bas'):
                continue
            bas_path = os.path.join(root, fname)
            rel_path = os.path.relpath(bas_path, REPO_ROOT)
            stats['total'] += 1

            try:
                graph = parse_bas(bas_path)
                all_graphs[rel_path] = graph

                if graph['navigation']:
                    stats['with_nav'] += 1
                if graph['menus']:
                    stats['with_menus'] += 1
                if graph['dangerous']:
                    stats['with_danger'] += 1
                if len([f for f in graph['forms']
                        if f.lower() not in ('module1', 'module2', 'module3',
                                             'module4', 'module5')]) > 1:
                    stats['multi_form'] += 1
            except Exception as e:
                logger.warning("Error parsing %s: %s", bas_path, e)

    return all_graphs, stats


def main():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--one', help='Parse single .bas file')
    parser.add_argument('--stats', action='store_true', help='Print stats only')
    args = parser.parse_args()

    if args.one:
        graph = parse_bas(args.one)
        print(json.dumps(graph, indent=2))
        return

    all_graphs, stats = parse_all()

    if not args.stats:
        with open(OUTPUT_FILE, 'w') as f:
            json.dump(all_graphs, f, indent=2)
        print("Wrote %d nav graphs to %s" % (len(all_graphs), OUTPUT_FILE))

    print("\nNav Graph Stats:")
    print("  Total .bas files: %d" % stats['total'])
    print("  With navigation (.Show): %d" % stats['with_nav'])
    print("  With menu items: %d" % stats['with_menus'])
    print("  With dangerous controls: %d" % stats['with_danger'])
    print("  Multi-form (visual): %d" % stats['multi_form'])

    # Top navigation targets
    if not args.stats:
        nav_targets = {}
        for g in all_graphs.values():
            for nav in g['navigation']:
                t = nav['to_form'].lower()
                nav_targets[t] = nav_targets.get(t, 0) + 1
        top = sorted(nav_targets.items(), key=lambda x: -x[1])[:20]
        print("\n  Top navigation targets:")
        for name, count in top:
            print("    %s: %d apps" % (name, count))


if __name__ == '__main__':
    main()
