#!/usr/bin/env python3
"""Extract metadata from decompiled VB source (.decompiled.bas files).

For each app extracts:
  - name: application name (from App.Title, form captions, strings)
  - author: who made it (from "by <name>" patterns)
  - forms: list of form/object names
  - about_form: name of About/Credits form if any
  - dependencies: OCX/DLL references
  - features: inferred from control text, form names, API patterns
  - ui_elements: buttons, labels, menus, tabs with their text

Usage:
    python3 extract_metadata.py [--one <bas_file>] [--stats] [--dry-run]
"""
import sys, os, re, json, argparse, logging
from datetime import datetime

REPO_ROOT = '/home/braker/git/aolunderground-proggies'
PROGRAMS_DIR = os.path.join(REPO_ROOT, 'programs')
METADATA_FILE = os.path.join(REPO_ROOT, 'tools/c2/metadata.json')

logger = logging.getLogger('metadata')

# ── Patterns ──

# Author patterns: "by <name>", "coded by", "created by", "programmed by", "written by", "made by"
AUTHOR_RE = re.compile(
    r'(?:coded|created|programmed|written|made|designed)?\s*[Bb]y\s+'
    r'([A-Za-z0-9_\-@!\.]+(?:\s*(?:and|&|,)\s*[A-Za-z0-9_\-@!\.]+)*)',
)

# Version patterns
VERSION_RE = re.compile(r'[Vv](?:ersion)?\s*(\d+[\.\d]*\w*)')

# Feature keywords mapped to categories
FEATURE_KEYWORDS = {
    'punt': ['punt', 'Punt', 'PUNT', 'boot', 'Boot', 'kick'],
    'crack': ['crack', 'Crack', 'brute', 'Brute', 'password', 'Password'],
    'mail_bomb': ['mass mail', 'mail bomb', 'mailbomb', 'email bomb', 'spam'],
    'fade': ['fade', 'Fade', 'fader', 'Fader', 'phade', 'Phade'],
    'flood': ['flood', 'Flood', 'scroll', 'Scroll'],
    'chat': ['chat', 'Chat', 'room', 'Room'],
    'im': ['Instant Message', 'IM ', ' IM', 'SendIM', 'send_im'],
    'idle': ['idle', 'Idle', 'IDLE'],
    'profile': ['profile', 'Profile', 'info', 'locate'],
    'warn': ['warn', 'Warn', 'evil'],
    'toc': ['TOC', 'toc_', 'flap_', 'FLAP'],
    'oscar': ['OSCAR', 'oscar', 'SNAC', 'BOS'],
    'notify': ['notify', 'Notify', 'alert', 'Alert'],
    'sub_host': ['subhost', 'sub host', 'SubHost'],
    'ccom': ['ccom', 'CCom', 'CCOM', 'chat com'],
    'html': ['HTML', 'html', '<font', '<FONT', '<b>', '<a href'],
    'winsock': ['Winsock', 'winsock', 'mswinsck'],
    'prog_tool': ['proggie', 'Proggie', 'toolz', 'Toolz'],
}

# About form name patterns
ABOUT_FORM_RE = re.compile(r'^(?:frm)?(?:about|credits?|info|splash|greetz|greets)', re.IGNORECASE)

# Dependency patterns
DEP_RE = re.compile(r'\b(\w+\.(?:ocx|dll|tlb))\b', re.IGNORECASE)


def extract_metadata(bas_path):
    """Parse a .decompiled.bas file and return metadata dict."""
    try:
        with open(bas_path, 'r', errors='replace') as f:
            source = f.read()
    except:
        return None

    lines = source.split('\n')
    meta = {
        'name': None,
        'author': None,
        'version': None,
        'forms': [],
        'about_form': None,
        'dependencies': [],
        'features': [],
        'ui_elements': [],
        'strings': [],
    }

    # Extract all objects/forms
    for line in lines:
        line = line.strip().rstrip('\r')
        m = re.match(r"^'Object:\s+(.+)", line)
        if m:
            meta['forms'].append(m.group(1).strip())

    # Find about/credits/splash forms
    for form in meta['forms']:
        if ABOUT_FORM_RE.match(form):
            meta['about_form'] = form
            break

    # Extract all quoted strings (use non-greedy to handle unclosed quotes in native code)
    all_strings = re.findall(r'"(.{3,}?)"', source)
    # Filter out noise (hex addresses, var names, etc)
    meaningful = []
    for s in all_strings:
        s = s.strip()
        if not s or s.startswith('loc_') or s.startswith('var_'):
            continue
        if re.match(r'^[0-9A-Fa-f]{6,}$', s):
            continue
        meaningful.append(s)

    # Find app name from App.Title or form caption strings
    for s in meaningful:
        # Look for version string which often contains app name
        if VERSION_RE.search(s) and len(s) < 80:
            if not meta['name'] or len(s) > len(meta['name']):
                meta['name'] = s.strip()
                vm = VERSION_RE.search(s)
                if vm:
                    meta['version'] = vm.group(1)

    # Find author
    for s in meaningful:
        m = AUTHOR_RE.search(s)
        if m:
            author = m.group(1).strip().rstrip('.')
            # Skip garbage
            if len(author) > 2 and len(author) < 50 and not author.startswith('0'):
                meta['author'] = author
                break

    # Find dependencies
    deps = set()
    for m in DEP_RE.finditer(source):
        dep = m.group(1).lower()
        if dep not in ('vbdec_input.exe',):
            deps.add(dep)
    meta['dependencies'] = sorted(deps)

    # Infer features
    features = set()
    for feat, keywords in FEATURE_KEYWORDS.items():
        for kw in keywords:
            if kw in source:
                features.add(feat)
                break
    meta['features'] = sorted(features)

    # Extract UI elements (buttons, labels with text)
    ui = []
    # Button/command click handlers tell us button names
    for m in re.finditer(r'(?:Private|Public)\s+Sub\s+(\w+)_Click\(\)', source):
        ctrl = m.group(1)
        ui.append({'type': 'button', 'name': ctrl})
    # Caption assignments
    for m in re.finditer(r'(\w+)\.Caption\s*=\s*"([^"]*)"', source):
        ui.append({'type': 'caption', 'name': m.group(1), 'text': m.group(2)})
    # Text assignments to controls
    for m in re.finditer(r'(\w+)\.Text\s*=\s*"([^"]*)"', source):
        if len(m.group(2)) > 2:
            ui.append({'type': 'text', 'name': m.group(1), 'text': m.group(2)})

    meta['ui_elements'] = ui[:50]  # cap to avoid huge output
    meta['strings'] = meaningful[:100]

    # If no name found, try exe name from header
    if not meta['name']:
        for line in lines[:5]:
            m = re.match(r"^'\s*Application:\s+(.+)", line)
            if m:
                # Use exe basename without extension
                exe = m.group(1).strip().rstrip('\r')
                meta['name'] = os.path.splitext(os.path.basename(exe))[0]
                break

    return meta


def extract_for_exe(exe_path):
    """Find the .decompiled.bas for an exe and extract metadata."""
    bas_path = os.path.splitext(exe_path)[0] + '.decompiled.bas'
    if not os.path.isfile(bas_path):
        return None
    meta = extract_metadata(bas_path)
    if meta:
        meta['exe'] = os.path.relpath(exe_path, REPO_ROOT)
        meta['bas'] = os.path.relpath(bas_path, REPO_ROOT)
    return meta


# ── Main ──

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--one', type=str, help='Extract from one .bas or .exe')
    parser.add_argument('--stats', action='store_true')
    parser.add_argument('--dry-run', action='store_true')
    args = parser.parse_args()

    if args.one:
        path = args.one
        if path.endswith('.exe'):
            meta = extract_for_exe(path)
        else:
            meta = extract_metadata(path)
        if meta:
            print(json.dumps(meta, indent=2))
        else:
            print('No metadata found')
        return

    # Batch mode
    all_meta = {}
    count = 0
    for root, dirs, files in os.walk(PROGRAMS_DIR):
        for f in sorted(files):
            if not f.lower().endswith('.exe'):
                continue
            exe_path = os.path.join(root, f)
            rel = os.path.relpath(exe_path, REPO_ROOT)
            meta = extract_for_exe(exe_path)
            if meta:
                all_meta[rel] = meta
                count += 1
                if count % 100 == 0:
                    print(f'  {count} processed...')

    with open(METADATA_FILE, 'w') as f:
        json.dump(all_meta, f, indent=2)
    print(f'Extracted metadata for {len(all_meta)} apps → {METADATA_FILE}')

    # Stats
    has_name = sum(1 for m in all_meta.values() if m.get('name'))
    has_author = sum(1 for m in all_meta.values() if m.get('author'))
    has_about = sum(1 for m in all_meta.values() if m.get('about_form'))
    has_deps = sum(1 for m in all_meta.values() if m.get('dependencies'))
    has_features = sum(1 for m in all_meta.values() if m.get('features'))
    print(f'  Name: {has_name}  Author: {has_author}  About form: {has_about}  Deps: {has_deps}  Features: {has_features}')


if __name__ == '__main__':
    main()
