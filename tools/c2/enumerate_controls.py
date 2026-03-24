#!/usr/bin/env python3
"""Extract full control inventory from VB6 apps.

Combines three sources:
1. Decompiled source (.decompiled.bas) — event handlers reveal control names/types
2. Binary exe — menu names and captions from raw string scanning
3. Runtime ENUMCHILDREN — windowed controls visible to Win32 API

Usage:
    python3 enumerate_controls.py <bas_or_exe_path>
    python3 enumerate_controls.py --batch [--json]
"""
import sys, os, re, json, struct, argparse, logging

log = logging.getLogger('enumctrl')

REPO_ROOT = '/home/braker/git/aolunderground-proggies'

# VB6 control name prefixes → types
PREFIX_MAP = {
    'cmd': 'CommandButton', 'command': 'CommandButton',
    'txt': 'TextBox', 'text': 'TextBox',
    'lst': 'ListBox', 'list': 'ListBox',
    'chk': 'CheckBox', 'check': 'CheckBox',
    'opt': 'OptionButton', 'option': 'OptionButton',
    'cbo': 'ComboBox', 'combo': 'ComboBox',
    'lbl': 'Label', 'label': 'Label',
    'img': 'Image', 'image': 'Image',
    'pic': 'PictureBox', 'picture': 'PictureBox',
    'tmr': 'Timer', 'timer': 'Timer',
    'frm': 'Form', 'form': 'Form',
    'mnu': 'Menu', 'menu': 'Menu',
    'tab': 'TabStrip', 'sstab': 'SSTab',
    'fra': 'Frame', 'frame': 'Frame',
    'hsb': 'HScrollBar', 'vsb': 'VScrollBar',
    'shp': 'Shape', 'lin': 'Line',
    'drv': 'DriveListBox', 'dir': 'DirListBox', 'fil': 'FileListBox',
    'dat': 'Data', 'ole': 'OLE',
    'rch': 'RichTextBox', 'rtb': 'RichTextBox',
    'prg': 'ProgressBar', 'sld': 'Slider',
    'sta': 'StatusBar', 'tlb': 'Toolbar', 'tbr': 'Toolbar',
    'trv': 'TreeView', 'lvw': 'ListView',
    'ani': 'Animation', 'cld': 'Calendar',
    'inet': 'Inet', 'wsk': 'Winsock', 'winsock': 'Winsock',
}

# Events that indicate control type
EVENT_TYPE_MAP = {
    'timer': 'Timer',
    'scroll': 'ScrollBar',
    'change': 'TextBox',  # weak signal
    'validate': 'TextBox',
    'nodeclick': 'TreeView',
    'columnclick': 'ListView',
    'itemclick': 'TabStrip',
}


def infer_type(name, events):
    """Infer VB6 control type from name prefix and events."""
    nl = name.lower()
    for prefix, ctype in sorted(PREFIX_MAP.items(), key=lambda x: -len(x[0])):
        if nl.startswith(prefix):
            return ctype
    for event in events:
        el = event.lower()
        if el in EVENT_TYPE_MAP:
            return EVENT_TYPE_MAP[el]
    if 'click' in [e.lower() for e in events]:
        return 'CommandButton'
    return 'Unknown'


def parse_decompiled_source(bas_path):
    """Extract controls from decompiled .bas file."""
    with open(bas_path, 'r', errors='replace') as f:
        source = f.read()

    controls = {}

    # Event handlers: ControlName_EventName()
    for m in re.finditer(
            r"(?:Private|Public)\s+Sub\s+(\w+)_(\w+)\s*\(", source):
        ctrl, event = m.group(1), m.group(2)
        if ctrl == 'Class' or ctrl == 'UserControl':
            continue
        if ctrl not in controls:
            controls[ctrl] = {'name': ctrl, 'events': [], 'type': 'Unknown',
                              'source': 'decompiled'}
        controls[ctrl]['events'].append(event)

    # Object comments
    forms = re.findall(r"^'Object:\s+(\w+)", source, re.MULTILINE)

    # Caption assignments (works for p-code decompiled source)
    for m in re.finditer(r'(\w+)\.Caption\s*=\s*"([^"]*)"', source):
        ctrl, cap = m.group(1), m.group(2)
        if ctrl in controls:
            controls[ctrl]['caption'] = cap

    # Infer types
    for name, info in controls.items():
        info['type'] = infer_type(name, info['events'])

    return {'forms': forms, 'controls': controls}


def scan_exe_strings(exe_path):
    """Scan exe binary for VB6 control/menu names and captions."""
    with open(exe_path, 'rb') as f:
        data = f.read()

    if b'VB5!' not in data:
        return None

    result = {'menus': [], 'captions': [], 'form_names': []}

    # Find menu names: look for null-terminated strings starting with 'mnu'
    for m in re.finditer(rb'\x00(mnu\w{2,40})\x00', data):
        name = m.group(1).decode('ascii', errors='replace')
        result['menus'].append(name)

    # Find form names: 'frm' prefix
    for m in re.finditer(rb'\x00(frm\w{2,30})\x00', data):
        name = m.group(1).decode('ascii', errors='replace')
        result['form_names'].append(name)

    # Find captions near menu names (property 0x01 followed by length + string)
    # Look for patterns: menu_name\x00\x13\x03<len>\x00<caption>
    for m in re.finditer(rb'\x00(mnu\w{2,40})\x00\x13[\x02\x03](.)\x00', data):
        menu_name = m.group(1).decode('ascii', errors='replace')
        cap_len = m.group(2)[0]
        cap_start = m.end()
        if cap_start + cap_len <= len(data):
            caption = data[cap_start:cap_start+cap_len]
            if all(32 <= b < 127 for b in caption):
                result['captions'].append({
                    'control': menu_name,
                    'caption': caption.decode('ascii').rstrip('\x00')
                })

    # Deduplicate
    result['menus'] = sorted(set(result['menus']))
    result['form_names'] = sorted(set(result['form_names']))

    return result


def enumerate_app(bas_path, exe_path=None):
    """Full control enumeration for a single app."""
    result = parse_decompiled_source(bas_path)

    if exe_path and os.path.exists(exe_path):
        exe_data = scan_exe_strings(exe_path)
        if exe_data:
            # Add menu items found in binary but not in decompiled source
            for menu_name in exe_data['menus']:
                if menu_name not in result['controls']:
                    result['controls'][menu_name] = {
                        'name': menu_name, 'type': 'Menu',
                        'events': [], 'source': 'binary'
                    }
            # Add captions
            for cap_info in exe_data.get('captions', []):
                ctrl = cap_info['control']
                if ctrl in result['controls']:
                    result['controls'][ctrl]['caption'] = cap_info['caption']
            # Add form names
            for fname in exe_data.get('form_names', []):
                if fname not in result['forms']:
                    result['forms'].append(fname)

    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', nargs='?', help='Path to .bas or .exe file')
    parser.add_argument('--batch', action='store_true')
    parser.add_argument('--json', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')
    args = parser.parse_args()

    logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO,
                       format='%(message)s')

    if args.path:
        path = args.path
        if path.endswith('.exe'):
            bas = path.replace('.exe', '.decompiled.bas')
            exe = path
        else:
            bas = path
            exe = path.replace('.decompiled.bas', '.exe')

        if not os.path.exists(bas):
            print(f'No decompiled source: {bas}')
            sys.exit(1)

        result = enumerate_app(bas, exe if os.path.exists(exe) else None)

        if args.json:
            # Serialize
            out = {'forms': result['forms'], 'controls': list(result['controls'].values())}
            print(json.dumps(out, indent=2))
        else:
            print(f"Forms: {', '.join(result['forms'])}")
            print(f"Controls ({len(result['controls'])}):")
            by_type = {}
            for info in result['controls'].values():
                t = info['type']
                if t not in by_type:
                    by_type[t] = []
                by_type[t].append(info)
            for t in sorted(by_type.keys()):
                print(f"\n  {t} ({len(by_type[t])}):")
                for info in sorted(by_type[t], key=lambda x: x['name']):
                    cap = f' "{info["caption"]}"' if info.get('caption') else ''
                    src = f' [{info["source"]}]' if info.get('source') == 'binary' else ''
                    print(f"    {info['name']}{cap}{src}")

    elif args.batch:
        all_results = {}
        count = 0
        for root, dirs, files in os.walk(os.path.join(REPO_ROOT, 'programs')):
            for f in files:
                if f.endswith('.decompiled.bas'):
                    bas = os.path.join(root, f)
                    exe = bas.replace('.decompiled.bas', '.exe')
                    try:
                        result = enumerate_app(bas, exe if os.path.exists(exe) else None)
                        total = len(result['controls'])
                        if total > 0:
                            key = os.path.relpath(bas, REPO_ROOT)
                            all_results[key] = {
                                'forms': result['forms'],
                                'controls': list(result['controls'].values()),
                            }
                            count += 1
                    except Exception as e:
                        log.debug('Error: %s: %s', bas, e)

        log.info('Processed %d apps with controls', count)

        # Stats
        total_controls = sum(len(r['controls']) for r in all_results.values())
        type_counts = {}
        for r in all_results.values():
            for c in r['controls']:
                t = c['type']
                type_counts[t] = type_counts.get(t, 0) + 1

        log.info('Total controls: %d', total_controls)
        log.info('By type:')
        for t, n in sorted(type_counts.items(), key=lambda x: -x[1]):
            log.info('  %s: %d', t, n)

        if args.json:
            print(json.dumps(all_results, indent=2))
    else:
        parser.print_help()


if __name__ == '__main__':
    main()
