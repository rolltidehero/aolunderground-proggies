#!/usr/bin/env python3
"""Build metadata.json for AOHell 95 from original VB3 source code.

Creates the same structure that single_decompile.py produces from decompiled output,
so generate_analysis.py can render a standard analysis page.
"""
import json
import os
import re
import shutil
from pathlib import Path

SRC = Path('programming/vb/aol/25-30/_extracted/AOHELL95_source_code/AOH')
ZIP_STEM = 'aohell 95 for aol 2.5-3.0'
# Fake exe name — there's no exe, but the pipeline needs one
EXE_NAME = 'AOHELL.EXE'
DECOMP_DIR = Path('decompiled') / ZIP_STEM / EXE_NAME


def read_file(name):
    return (SRC / name).read_text(errors='replace').replace('\r\n', '\n').replace('\r', '\n')


def parse_mak():
    content = read_file('AOHELL.MAK')
    bas, frm, vbx = [], [], []
    title = ''
    for line in content.split('\n'):
        line = line.strip()
        up = line.upper()
        if up.endswith('.BAS'):
            bas.append(os.path.basename(line))
        elif up.endswith('.FRM'):
            frm.append(os.path.basename(line))
        elif up.endswith('.VBX'):
            vbx.append(os.path.basename(line))
        elif line.startswith('Title='):
            title = line.split('=', 1)[1].strip('"')
    return title, bas, frm, vbx


def parse_frm(name):
    """Parse a VB3 .FRM file into metadata format."""
    content = read_file(name)
    form_name = name.replace('.FRM', '').lower()

    # Form dimensions
    form_w = form_h = 0
    m = re.search(r'ClientWidth\s*=\s*(\d+)', content)
    if m: form_w = int(m.group(1))
    m = re.search(r'ClientHeight\s*=\s*(\d+)', content)
    if m: form_h = int(m.group(1))
    # Fallback to Width/Height
    if not form_w:
        m = re.search(r'^  Width\s*=\s*(\d+)', content, re.M)
        if m: form_w = int(m.group(1))
    if not form_h:
        m = re.search(r'^  Height\s*=\s*(\d+)', content, re.M)
        if m: form_h = int(m.group(1))

    # Caption
    caption = ''
    m = re.search(r'^\s*Caption\s*=\s*"([^"]*)"', content, re.M)
    if m: caption = m.group(1).strip()

    # Controls — parse Begin/End blocks (only top-level, not nested)
    controls = []
    # VB3 format: Begin ControlType ControlName
    for block in re.finditer(r'^\s{4}Begin\s+(\S+)\s+(\w+)\s*\n(.*?)^\s{4}End\n',
                             content, re.M | re.S):
        ctrl_type_raw = block.group(1)
        ctrl_name = block.group(2)
        body = block.group(3)

        # Normalize type name
        type_map = {
            'SSCommand': 'CommandButton', 'SSPanel': 'Panel', 'SSFrame': 'Frame',
            'SSCheck': 'CheckBox', 'SSOption': 'OptionButton',
            'Command3D': 'CommandButton', 'Option3D': 'OptionButton',
            'Check3D': 'CheckBox', 'Frame3D': 'Frame',
            'VBMsg': 'VBMsg', 'Percent': 'ProgressBar',
            'MCI': 'MCI', 'CSPicture': 'PictureBox',
            'InvisibleIcon': 'TrayIcon',
        }
        ctrl_type = type_map.get(ctrl_type_raw, ctrl_type_raw)

        props = {}
        for pm in re.finditer(r'(\w+)\s*=\s*(.+)', body):
            props[pm.group(1)] = pm.group(2).strip().strip('"')

        ctrl = {
            'name': ctrl_name,
            'type': ctrl_type,
            'left': int(props.get('Left', 0)),
            'top': int(props.get('Top', 0)),
            'width': int(props.get('Width', 600)),
            'height': int(props.get('Height', 300)),
        }
        cap = props.get('Caption', '')
        if cap:
            ctrl['caption'] = cap
        text = props.get('Text', '')
        if text:
            ctrl['text'] = text
        controls.append(ctrl)

    # Menus
    menus = []
    for m in re.finditer(r'Begin\s+Menu\s+(\w+)\s*\n(.*?)(?=Begin\s+Menu|\Z)',
                         content, re.S):
        menu_name = m.group(1)
        body = m.group(2)
        cap_m = re.search(r'Caption\s*=\s*"([^"]*)"', body)
        if cap_m:
            menus.append({'name': menu_name, 'caption': cap_m.group(1)})

    # Timers
    timers = [c['name'] for c in controls if c['type'] == 'Timer']

    # Code blocks (Sub/Function) — allow leading whitespace for VB3 FRM files
    code_blocks = []
    for m in re.finditer(r'^\s*((?:Sub|Function)\s+(\w+)[^\n]*)\n(.*?)^\s*End (?:Sub|Function)',
                         content, re.M | re.S):
        code_blocks.append({
            'name': m.group(2),
            'signature': m.group(1).strip(),
            'code': m.group(0),
        })

    return {
        'name': form_name,
        'caption': caption,
        'controls': controls,
        'menus': menus,
        'timers': timers,
        'client_width': form_w,
        'client_height': form_h,
        'code_blocks': code_blocks,
    }


def parse_bas(name):
    """Parse a .BAS module."""
    content = read_file(name)
    mod_name = name.replace('.BAS', '').lower()

    globals_ = []
    for line in content.split('\n'):
        line = line.strip()
        if line.startswith(('Global ', 'Declare ')):
            globals_.append(line)

    code_blocks = []
    for m in re.finditer(r'^\s*((?:Sub|Function)\s+(\w+)[^\n]*)\n(.*?)^\s*End (?:Sub|Function)',
                         content, re.M | re.S):
        code_blocks.append({
            'name': m.group(2),
            'signature': m.group(1).strip(),
            'code': m.group(0),
        })

    return {
        'name': mod_name,
        'globals': globals_,
        'code_blocks': code_blocks,
        'line_count': len(content.split('\n')),
    }


def extract_strings(bas_files, frm_files):
    """Extract interesting strings from source code."""
    strings = set()
    for f in bas_files + frm_files:
        try:
            content = read_file(f)
        except FileNotFoundError:
            continue
        # For FRM files, skip binary form header — start from first Sub/Function
        if f.upper().endswith('.FRM'):
            code_start = -1
            for marker in ('Sub ', 'Function ', 'Attribute VB_'):
                idx = content.find(marker)
                if idx >= 0 and (code_start < 0 or idx < code_start):
                    code_start = idx
            if code_start > 0:
                content = content[code_start:]
        for m in re.finditer(r'"([^"\r\n]{4,})"', content):
            s = m.group(1).strip()
            if s and not s.startswith(('PHISH.FRX', 'AOHELL.FRX')) and len(s) < 200:
                strings.add(s)
    return sorted(strings)


def build_code_breakdown(form_data, module_data):
    """Build code_breakdown structure from parsed source."""
    app_functions = []

    for form in form_data:
        for cb in form['code_blocks']:
            # Determine if it's an event handler
            parts = cb['name'].split('_', 1)
            ctrl_name = parts[0] if len(parts) > 1 else ''
            event = parts[1] if len(parts) > 1 else cb['name']

            fn = {
                'name': f"{form['name']}.{cb['name']}",
                'display_name': cb['name'],
                'module': form['name'],
                'code': cb['code'],
                'size': len(cb['code'].encode('utf-8')),
                'line_count': len(cb['code'].split('\n')),
                'is_event': '_' in cb['name'],
            }
            if form.get('caption'):
                fn['form_caption'] = form['caption']
            # Try to get control caption
            for c in form['controls']:
                if c['name'].lower() == ctrl_name.lower():
                    fn['control_type'] = c['type']
                    fn['control_caption'] = c.get('caption', '')
                    break
            app_functions.append(fn)

    for mod in module_data:
        for cb in mod['code_blocks']:
            app_functions.append({
                'name': f"{mod['name']}.{cb['name']}",
                'display_name': cb['name'],
                'module': mod['name'],
                'code': cb['code'],
                'size': len(cb['code'].encode('utf-8')),
                'line_count': len(cb['code'].split('\n')),
                'is_event': False,
            })

    total_size = sum(len(f['code'].encode('utf-8')) for f in app_functions) or 1
    return {
        'app_functions': app_functions,
        'base_functions': [],
        'cherry_picked': [],
        'total_functions': len(app_functions),
        'app_funcs_count': len(app_functions),
        'app_pct': 100, 'reachable_pct': 0, 'dead_pct': 0,
        'reachable_base_funcs': 0, 'total_base_funcs': 0, 'dead_base_funcs': 0,
        'total_size': total_size,
    }


def extract_author_evidence(strings, form_data=None, module_data=None):
    """Find author-related strings from extracted strings, form captions, and raw source."""
    evidence = set()
    author_re = re.compile(
        r'(?:coded|programmed|made|created|written|designed|modified|brought to you)\s+by\s+\S|'
        r'\bby\s*:\s*\S|'
        r'\bby\s+Da\s+Chronic',
        re.I
    )
    for s in strings:
        if author_re.search(s) and len(s) < 120:
            evidence.add(s)
    for form in (form_data or []):
        cap = form.get('caption', '')
        if cap and author_re.search(cap):
            evidence.add(cap)
    # Scan all raw source files for quoted strings with author patterns
    for f in SRC.glob('**/*.[FfBb][RrAa][MmSs]'):
        try:
            content = f.read_text(errors='replace')
        except Exception:
            continue
        for m in re.finditer(r'"([^"\r\n]{4,120})"', content):
            s = m.group(1).strip()
            if author_re.search(s):
                evidence.add(s)
    return sorted(evidence)


def main():
    title, bas_files, frm_files, vbx_files = parse_mak()
    print(f'Project: {title}')
    print(f'Files: {len(bas_files)} .BAS, {len(frm_files)} .FRM, {len(vbx_files)} .VBX')

    # Parse all forms
    form_data = []
    for ff in frm_files:
        try:
            form_data.append(parse_frm(ff))
        except FileNotFoundError:
            print(f'  SKIP: {ff} not found')

    # Parse all modules
    module_data = []
    for bf in bas_files:
        try:
            module_data.append(parse_bas(bf))
        except FileNotFoundError:
            print(f'  SKIP: {bf} not found')

    # Extract strings
    strings = extract_strings(bas_files, frm_files)

    # Build metadata
    code_breakdown = build_code_breakdown(form_data, module_data)

    # Dependencies from VBX list
    deps = []
    for vbx in vbx_files:
        deps.append(os.path.basename(vbx).upper())

    metadata = {
        'exe_name': EXE_NAME,
        'zip_stem': ZIP_STEM,
        'compile_type': 'p-code',
        'is_packed': False,
        'compiler': 'VB3',
        'project': {'name': title, 'exe_name': EXE_NAME},
        'vb_version': 'VB3',
        'base_module': '',
        'forms': [{
            'name': f['name'],
            'controls': f['controls'],
            'menus': f['menus'],
            'timers': f['timers'],
            'client_width': f['client_width'],
            'client_height': f['client_height'],
        } for f in form_data],
        'modules': [m['name'] for m in module_data],
        'bas_modules': [m['name'] for m in module_data],
        'strings': strings,
        'author_evidence': extract_author_evidence(strings, form_data, module_data),
        'greets': [],
        'passwords': [],
        'aol_version_signals': {'2.5': ['_AOL_Edit', '_AOL_Tree', '_AOL_Button']},
        'decompile_file_count': len(bas_files) + len(frm_files),
        'code_breakdown': code_breakdown,
        'addr_to_name': {},
        'has_original_source': True,
        'original_source_path': str(SRC),
        'dependencies': deps,
    }

    # Create decompiled directory structure
    DECOMP_DIR.mkdir(parents=True, exist_ok=True)
    forms_dir = DECOMP_DIR / 'forms'
    forms_dir.mkdir(exist_ok=True)

    # Copy .FRM files so render_form_layout can find them
    for ff in frm_files:
        src = SRC / ff
        dst = forms_dir / ff.lower().replace('.frm', '.frm')
        if src.exists():
            shutil.copy2(src, dst)

    # Copy .BAS files
    modules_dir = DECOMP_DIR / 'modules'
    modules_dir.mkdir(exist_ok=True)
    for bf in bas_files:
        src = SRC / bf
        if src.exists():
            shutil.copy2(src, modules_dir / bf)

    # Create .vb files from source code so generate_analysis.py can find them
    # It expects: modules/<modname>_funcs/<funcname>.vb
    for form in form_data:
        if not form['code_blocks']:
            continue
        func_dir = DECOMP_DIR / 'modules' / f"{form['name']}_funcs"
        func_dir.mkdir(parents=True, exist_ok=True)
        for i, cb in enumerate(form['code_blocks']):
            vb_path = func_dir / f"{i}_{cb['name']}.vb"
            vb_path.write_text(cb['code'], encoding='utf-8')

    for mod in module_data:
        if not mod['code_blocks']:
            continue
        func_dir = DECOMP_DIR / 'modules' / f"{mod['name']}_funcs"
        func_dir.mkdir(parents=True, exist_ok=True)
        for i, cb in enumerate(mod['code_blocks']):
            vb_path = func_dir / f"{i}_{cb['name']}.vb"
            vb_path.write_text(cb['code'], encoding='utf-8')

    # Write metadata
    meta_path = DECOMP_DIR / 'metadata.json'
    with open(meta_path, 'w') as f:
        json.dump(metadata, f, indent=2)

    # Also copy source to the browsable location
    source_dir = Path('programs/AOL/proggies-sorted-deduped/2.5/aohell-source')
    source_dir.mkdir(parents=True, exist_ok=True)
    copied = 0
    for f in os.listdir(SRC):
        if f.upper().endswith(('.BAS', '.FRM', '.MAK')):
            shutil.copy2(SRC / f, source_dir / f)
            copied += 1

    print(f'Metadata: {len(form_data)} forms, {code_breakdown["total_functions"]} functions, {len(strings)} strings')
    print(f'Written: {meta_path}')
    print(f'Copied {copied} source files to {source_dir}')
    print(f'Copied {len(frm_files)} .FRM files to {forms_dir}')


if __name__ == '__main__':
    main()
