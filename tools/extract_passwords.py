#!/usr/bin/env python3
"""Extract passwords from decompiled VB source code.

Scans decompiled .frm/.vb files for password gate patterns:
- TextBox + Button with "incorrect"/"wrong" error strings
- Direct If Text1.Text = "password" comparisons (p-code)
- Button-sequence passwords (numeric strings near "hitting buttons" context)
- Binary strings near password functions

Usage:
    python3 tools/extract_passwords.py <zip_stem>
    python3 tools/extract_passwords.py --all
"""
import argparse, json, logging, os, re, sqlite3, time
from pathlib import Path

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s.%(msecs)03d [%(levelname)-8s] %(name)s: %(message)s',
    datefmt='%H:%M:%S',
)
log = logging.getLogger(Path(__file__).stem)

REPO = Path(__file__).resolve().parent.parent
DECOMPILED = REPO / 'decompiled'
DB_PATH = REPO / 'proggie_db.sqlite'

# Strings that indicate a password check failure
FAIL_STRINGS = re.compile(
    r'incorrect|wrong\s+password|invalid|denied|try\s+again|not\s+correct',
    re.I
)

# Strings that are NOT passwords (error messages, UI text, common words)
NOT_PASSWORD = re.compile(
    r'password|incorrect|wrong|invalid|denied|error|warning|cancel|'
    r'the |this |that |you |your |please|enter|type |click|button|'
    r'bodini|aol|america|online|billing|credit|account|screen\s*name|'
    r'http|www\.|\.exe|\.dll|\.frm|\.bas|vbcrlf|vbnullstring|msgbox|'
    r'^\d{6,}$|^[A-Z_]{4,}$|^Form\d|^Label\d|^Command\d|^Text\d|^Timer\d',
    re.I
)


def find_password_forms(base):
    """Find forms that have TextBox + Button (potential password gates).
    Returns list of {form_name, textbox, button, frm_path}."""
    _t0 = time.monotonic()
    log.debug('find_password_forms: ENTER base=%s', base)
    results = []
    frm_files = list(base.rglob('*.frm'))
    log.debug('find_password_forms: scanning %d .frm files', len(frm_files))

    for frm in frm_files:
        if '/cleaned/' in str(frm):
            continue
        text = frm.read_text(errors='replace')
        has_textbox = bool(re.search(r'Begin\s+(?:VB\.)?TextBox\s+(\w+)', text))
        has_button = bool(re.search(r'Begin\s+(?:VB\.)?CommandButton\s+(\w+)', text))
        if has_textbox and has_button:
            tb = re.search(r'Begin\s+(?:VB\.)?TextBox\s+(\w+)', text).group(1)
            btn = re.search(r'Begin\s+(?:VB\.)?CommandButton\s+(\w+)', text).group(1)
            form_name = frm.stem
            log.debug('find_password_forms: candidate form=%s textbox=%s button=%s', form_name, tb, btn)
            results.append({'form_name': form_name, 'textbox': tb, 'button': btn, 'frm_path': frm})

    log.debug('find_password_forms: EXIT found=%d elapsed=%.3fs', len(results), time.monotonic() - _t0)
    return results


def scan_click_handlers_for_passwords(base, password_forms):
    """Scan button click handlers on password forms for password strings.
    Returns list of {form, password, gate_type, evidence}."""
    _t0 = time.monotonic()
    log.debug('scan_click_handlers: ENTER forms=%d', len(password_forms))
    found = []

    for pf in password_forms:
        form_name = pf['form_name']
        btn = pf['button']
        frm_path = pf['frm_path']

        # Collect handler code — try both layouts
        handler_code = ''
        handler_strings = []

        # Layout 1: modules/<form>_funcs/*_<Button>_Click.vb
        funcs_dir = base / 'modules' / f'{form_name}_funcs'
        if funcs_dir.exists():
            for vb in funcs_dir.glob(f'*{btn}_Click.vb'):
                handler_code += vb.read_text(errors='replace')
                log.debug('scan_click_handlers: found handler %s', vb.name)
            for sf in funcs_dir.glob(f'*{btn}_Click.strings'):
                handler_strings.extend(sf.read_text(errors='replace').splitlines())
                log.debug('scan_click_handlers: found strings %s', sf.name)

        # Layout 2: inline in .frm (flat layout)
        frm_text = frm_path.read_text(errors='replace')
        m = re.search(rf'(?:Private\s+)?Sub\s+{re.escape(btn)}_Click\b.*?End Sub', frm_text, re.S | re.I)
        if m:
            handler_code += m.group(0)
            log.debug('scan_click_handlers: found inline handler for %s_%s_Click', form_name, btn)

        if not handler_code:
            log.debug('scan_click_handlers: no handler found for %s.%s_Click', form_name, btn)
            continue

        # Check if handler has failure strings (confirms it's a password check)
        has_fail = bool(FAIL_STRINGS.search(handler_code))
        if not has_fail and not FAIL_STRINGS.search(' '.join(handler_strings)):
            log.debug('scan_click_handlers: %s.%s_Click has no failure strings, skipping', form_name, btn)
            continue

        log.info('Password gate found: %s.%s_Click', form_name, btn)

        # Method 1: Direct comparison in p-code — If Text1.Text = "password"
        for m in re.finditer(r'If\s+\w+\.Text\s*=\s*"([^"]+)"', handler_code):
            candidate = m.group(1)
            if not NOT_PASSWORD.search(candidate) and 3 <= len(candidate) <= 30:
                log.info('  P-code password: "%s"', candidate)
                found.append({'form': form_name, 'password': candidate,
                              'gate_type': 'textbox', 'evidence': 'p-code comparison'})

        # Method 2: Strings from the handler function (native code)
        all_strings = []
        for line in handler_strings:
            # Strip address prefix
            s = re.sub(r'^[\da-fA-F]+:\s*', '', line).strip()
            if s:
                all_strings.append(s)
        # Also extract string literals from handler code
        for m in re.finditer(r'"([^"]{2,})"', handler_code):
            all_strings.append(m.group(1))

        # Filter: short strings that aren't error messages = password candidates
        for s in all_strings:
            s = s.strip()
            if NOT_PASSWORD.search(s):
                continue
            if 2 <= len(s) <= 25 and s not in [p['password'] for p in found]:
                log.info('  String candidate: "%s"', s)
                found.append({'form': form_name, 'password': s,
                              'gate_type': 'textbox', 'evidence': 'handler string'})

    log.debug('scan_click_handlers: EXIT found=%d elapsed=%.3fs', len(found), time.monotonic() - _t0)
    return found


def scan_binary_strings(exe_path):
    """Scan exe binary for password patterns using strings near password context.
    Returns list of {form, password, gate_type, evidence}."""
    _t0 = time.monotonic()
    log.debug('scan_binary_strings: ENTER exe=%s', exe_path)
    found = []

    if not exe_path or not exe_path.exists():
        log.debug('scan_binary_strings: EXIT no exe')
        return found

    import subprocess
    try:
        # Scan both ASCII and Unicode strings
        raw = ''
        for flag in ['-a', '-el']:
            r = subprocess.run(['strings', flag, str(exe_path)],
                               capture_output=True, text=True, timeout=10)
            raw += r.stdout + '\n'
    except Exception as exc:
        log.warning('scan_binary_strings: strings failed exc=%s', exc)
        return found

    lines = raw.splitlines()
    for i, line in enumerate(lines):
        lo = line.lower()

        # Pattern: "Wrong Password" nearby → look for short strings around it
        if ('wrong password' in lo) or ('incorrect' in lo and 'password' in lo):
            for j in range(max(0, i - 5), min(len(lines), i + 5)):
                candidate = lines[j].strip()
                if candidate and 2 <= len(candidate) <= 20 and not NOT_PASSWORD.search(candidate):
                    if re.match(r'^[\w\d]+$', candidate):
                        log.info('  Binary candidate near "%s": "%s"', line.strip()[:40], candidate)
                        found.append({'form': 'startup', 'password': candidate,
                                      'gate_type': 'binary_context', 'evidence': f'near: {line.strip()[:40]}'})

        # Pattern: "hitting buttons" → button sequence password
        if 'hitting buttons' in lo or 'involves.*buttons' in lo:
            for j in range(max(0, i - 3), min(len(lines), i + 3)):
                candidate = lines[j].strip()
                if re.match(r'^\d{3,10}$', candidate):
                    log.info('  Button sequence: "%s"', candidate)
                    found.append({'form': 'startup', 'password': candidate,
                                  'gate_type': 'button_sequence', 'evidence': 'near button hint'})

        # Pattern: "type my first name" → name is a few lines after
        if 'type' in lo and 'first name' in lo:
            for j in range(i + 1, min(len(lines), i + 5)):
                w = lines[j].strip()
                if w and w[0].isupper() and w.isalpha() and 3 <= len(w) <= 15:
                    log.info('  "Type my first name" password: "%s"', w)
                    found.append({'form': 'unknown', 'password': w,
                                  'gate_type': 'textbox', 'evidence': 'type my first name'})
                    break

        # Pattern: "secret area" caption followed by a short name = password
        if 'secret' in lo and 'area' in lo and i + 1 < len(lines):
            nxt = lines[i + 1].strip()
            if nxt and nxt[0].isupper() and nxt.isalpha() and 3 <= len(nxt) <= 15:
                log.info('  Secret area password: "%s" (after "%s")', nxt, line.strip()[:40])
                found.append({'form': line.strip(), 'password': nxt,
                              'gate_type': 'textbox', 'evidence': 'secret area + next line'})

    log.debug('scan_binary_strings: EXIT found=%d elapsed=%.3fs', len(found), time.monotonic() - _t0)
    return found


def get_db_password(zip_stem):
    """Check if DB already has a password for this proggie."""
    if not DB_PATH.exists():
        return None
    conn = sqlite3.connect(str(DB_PATH))
    row = conn.execute('SELECT password FROM proggies WHERE zip_stem=?', (zip_stem,)).fetchone()
    conn.close()
    if row and row[0]:
        log.debug('get_db_password: DB has password for %s: "%s"', zip_stem, row[0])
        return row[0]
    return None


def find_exe_path(zip_stem):
    """Find the extracted exe for a zip_stem."""
    extract_dir = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / '_extracted' / zip_stem
    if extract_dir.exists():
        for f in extract_dir.iterdir():
            if f.suffix.lower() == '.exe' and f.stat().st_size > 10000:
                return f
    return None


def extract_passwords(zip_stem):
    """Main entry: extract all passwords for a proggie. Returns list of password dicts."""
    _t0 = time.monotonic()
    log.info('extract_passwords: ENTER zip_stem=%s', zip_stem)

    all_passwords = []

    # Check DB first
    db_pw = get_db_password(zip_stem)
    if db_pw:
        all_passwords.append({'form': 'db', 'password': db_pw,
                              'gate_type': 'known', 'evidence': 'proggie_db'})

    # Find decompiled base dir
    decomp_dir = DECOMPILED / zip_stem
    if not decomp_dir.exists():
        log.info('extract_passwords: no decompiled dir for %s', zip_stem)
        # Still try binary scan
        exe = find_exe_path(zip_stem)
        if exe:
            all_passwords.extend(scan_binary_strings(exe))
        log.info('extract_passwords: EXIT passwords=%d elapsed=%.3fs',
                 len(all_passwords), time.monotonic() - _t0)
        return all_passwords

    # Find exe subdir
    exe_dirs = [d for d in decomp_dir.iterdir() if d.is_dir() and not d.name.startswith('.')]
    for base in exe_dirs:
        if base.name == 'cleaned':
            continue
        log.debug('extract_passwords: scanning %s', base)

        # Scan decompiled source
        password_forms = find_password_forms(base)
        if password_forms:
            all_passwords.extend(scan_click_handlers_for_passwords(base, password_forms))

    # Scan binary
    exe = find_exe_path(zip_stem)
    if exe:
        all_passwords.extend(scan_binary_strings(exe))

    # Deduplicate by password value
    seen = set()
    deduped = []
    for p in all_passwords:
        if p['password'] not in seen:
            seen.add(p['password'])
            deduped.append(p)

    log.info('extract_passwords: EXIT passwords=%d elapsed=%.3fs',
             len(deduped), time.monotonic() - _t0)
    return deduped


def update_metadata(zip_stem, passwords):
    """Update metadata.json with extracted passwords."""
    _t0 = time.monotonic()
    log.debug('update_metadata: ENTER zip_stem=%s passwords=%d', zip_stem, len(passwords))

    decomp_dir = DECOMPILED / zip_stem
    if not decomp_dir.exists():
        log.debug('update_metadata: EXIT no decompiled dir')
        return

    for base in decomp_dir.iterdir():
        meta_path = base / 'metadata.json'
        if meta_path.exists():
            meta = json.loads(meta_path.read_text())
            meta['extracted_passwords'] = passwords
            meta_path.write_text(json.dumps(meta, indent=2))
            log.info('update_metadata: wrote %d passwords to %s', len(passwords), meta_path)

    log.debug('update_metadata: EXIT elapsed=%.3fs', time.monotonic() - _t0)


def main():
    parser = argparse.ArgumentParser(description='Extract passwords from decompiled VB source')
    parser.add_argument('zip_stem', nargs='?', help='Proggie zip stem')
    parser.add_argument('--all', action='store_true', help='Scan all decompiled proggies')
    parser.add_argument('-q', '--quiet', action='store_true', help='Suppress console (WARNING+ only)')
    args = parser.parse_args()

    if args.quiet:
        logging.getLogger().setLevel(logging.WARNING)

    log.info('extract_passwords: pid=%d', os.getpid())

    if args.all:
        if not DECOMPILED.exists():
            log.error('No decompiled directory')
            return
        total = 0
        for d in sorted(DECOMPILED.iterdir()):
            if d.is_dir() and not d.name.startswith('.'):
                passwords = extract_passwords(d.name)
                if passwords:
                    update_metadata(d.name, passwords)
                    total += len(passwords)
                    for p in passwords:
                        print(f'  {d.name}: {p["password"]} ({p["gate_type"]}, {p["evidence"]})')
        print(f'\nTotal: {total} passwords found')
    elif args.zip_stem:
        passwords = extract_passwords(args.zip_stem)
        if passwords:
            update_metadata(args.zip_stem, passwords)
        for p in passwords:
            print(f'  {p["form"]}: {p["password"]} ({p["gate_type"]}, {p["evidence"]})')
        print(f'\nFound {len(passwords)} passwords for {args.zip_stem}')
    else:
        parser.print_help()


if __name__ == '__main__':
    main()
