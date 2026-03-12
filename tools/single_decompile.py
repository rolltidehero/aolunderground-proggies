#!/usr/bin/env python3
"""Single proggie pipeline: decompile + metadata + screenshots + DB update + HTML regen.

Usage:
    python3 tools/single_decompile.py <zip_stem> [--skip-decompile] [--skip-screenshots]

Steps:
    1. Push exe to VM, decompile via C2 agent, pull output
    2. Parse decompiled output → metadata.json
    3. Run screenshot walkthrough (if menus exist)
    4. Update proggie_db.sqlite
    5. Regenerate HTML analysis page
"""
import argparse, json, logging, os, re, sqlite3, subprocess, sys, time
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
DECOMPILED = REPO / 'decompiled'
SORTED = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped'
DB_PATH = REPO / 'proggie_db.sqlite'

sys.path.insert(0, str(REPO / 'tools' / 'vm' / 'host'))
from virtio_serial_client import VirtioSerialClient
from push_file import push_file

log = logging.getLogger('single_decompile')
logging.basicConfig(level=logging.INFO, format='%(message)s')

# ── Step 1: Decompile ────────────────────────────────────────────────

def decompile_exe(zip_stem, exe_name, exe_path):
    """Push exe to VM, decompile, pull output back."""
    guest_exe = rf'C:\work\{exe_name}'
    guest_out = rf'C:\work\decompiled\{exe_name}'
    local_out = DECOMPILED / zip_stem / exe_name

    log.info(f'Pushing {exe_name} to VM...')
    # Ensure C:\work exists on guest
    c2g = VirtioSerialClient('/tmp/vm-c2gui.sock')
    c2g.connect()
    c2g.send_command("shell", command=r"mkdir C:\work 2>nul & echo ok")
    c2g.close()
    push_file(str(exe_path), guest_exe)

    # Also push bundled deps from the same zip
    dep_dir = exe_path.parent
    for f in dep_dir.iterdir():
        if f.suffix.lower() in ('.dll', '.ocx') and f.name.lower() != exe_name.lower():
            push_file(str(f), rf'C:\work\{f.name}')

    log.info('Decompiling via C2 agent...')
    c2 = VirtioSerialClient('/tmp/vm-c2.sock')
    c2.connect()
    c2.sock.settimeout(300)  # decompile can take 3-5 min
    result = c2.decompile(guest_exe, guest_out)
    c2.close()

    if result.get('status') != 'ok':
        log.error(f'Decompile failed: {result}')
        return None

    log.info(f'Decompile OK, {result.get("count", 0)} files. Pulling output...')
    local_out.mkdir(parents=True, exist_ok=True)
    pull_decompiled(guest_out, local_out)
    return local_out


def pull_decompiled(guest_dir, local_dir):
    """Pull decompiled files from VM via QGA."""
    import socket, base64
    QGA = '/tmp/vm-qga.sock'

    def qga(cmd, args=None):
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.connect(QGA)
        s.settimeout(30)
        req = {'execute': cmd}
        if args: req['arguments'] = args
        s.sendall(json.dumps(req).encode() + b'\n')
        buf = b''
        while True:
            buf += s.recv(65536)
            try:
                r = json.loads(buf)
                s.close()
                return r
            except json.JSONDecodeError:
                continue

    # List files via C2 shell
    c2 = VirtioSerialClient('/tmp/vm-c2.sock')
    c2.connect()
    r = c2.shell(f'dir /s /b "{guest_dir}"')
    c2.close()
    if r.get('returncode') != 0:
        log.error(f'dir failed: {r}')
        return

    files = [l.strip() for l in r.get('stdout', '').splitlines() if l.strip() and '.' in l]
    for guest_path in files:
        rel = guest_path.replace(guest_dir + '\\', '').replace('\\', '/')
        local_path = local_dir / rel
        local_path.parent.mkdir(parents=True, exist_ok=True)
        try:
            qga('guest-sync', {'id': 7777})
            h = qga('guest-file-open', {'path': guest_path, 'mode': 'r'})['return']
            data = b''
            while True:
                chunk = qga('guest-file-read', {'handle': h, 'count': 1048576})['return']
                data += base64.b64decode(chunk['buf-b64'])
                if chunk.get('eof'): break
            qga('guest-file-close', {'handle': h})
            local_path.write_bytes(data)
        except Exception as e:
            log.warning(f'Failed to pull {rel}: {e}')

    log.info(f'Pulled {len(files)} files to {local_dir}')


# ── Step 2: Build metadata.json ──────────────────────────────────────

def build_metadata(zip_stem, exe_name):
    """Parse decompiled .frm/.vbp/info.txt → metadata.json."""
    base = DECOMPILED / zip_stem / exe_name
    if not base.exists():
        return None

    meta = {'exe_name': exe_name, 'zip_stem': zip_stem,
            'compile_type': 'unknown', 'is_packed': False, 'compiler': 0}

    # info.txt (plugin output only)
    info = base / 'info.txt'
    if info.exists():
        txt = info.read_text(errors='replace')
        meta['compile_type'] = 'native' if 'native=1' in txt else 'p-code'
        meta['is_packed'] = 'packed=1' in txt
        m = re.search(r'compiler=(\d+)', txt)
        meta['compiler'] = int(m.group(1)) if m else 0

    # project.vbp (case-insensitive search)
    vbp = None
    for f in base.iterdir():
        if f.name.lower() == 'project.vbp':
            vbp = f
            break
    proj = {}
    if vbp and vbp.exists():
        txt = vbp.read_text(errors='replace')
        for line in txt.splitlines():
            if '=' in line:
                k, _, v = line.partition('=')
                proj[k.strip()] = v.strip()
    meta['project'] = proj
    meta['vb_version'] = _detect_vb(proj, base)
    meta['base_module'] = _identify_base_module(proj, base)
    # Compile type from VBP if not already set from info.txt
    if meta['compile_type'] == 'unknown' and 'CompilationType' in proj:
        meta['compile_type'] = 'p-code' if proj['CompilationType'].strip() == '1' else 'native'

    # Forms — check both layouts: forms/ subdir (plugin) or flat .frm files (old)
    forms = []
    forms_dir = base / 'forms'
    frm_files = list(forms_dir.glob('*.frm')) if forms_dir.exists() else list(base.glob('*.frm'))
    for frm in sorted(frm_files):
        forms.append(_parse_frm(frm))
    meta['forms'] = forms

    # Modules (function names) — check both layouts, track type (bas/frm)
    modules = []
    mods_dir = base / 'modules'
    if mods_dir.exists():
        for func_dir in sorted(mods_dir.iterdir()):
            if func_dir.is_dir() and func_dir.name.endswith('_funcs'):
                mod_name = func_dir.name.replace('_funcs', '')
                funcs = []
                for vb in sorted(func_dir.glob('*.vb')):
                    first = vb.read_text(errors='replace').split('\n')[0].strip()
                    m = re.match(r"(?:Public |Private )?(?:Sub|Function)\s+(\S+)", first)
                    funcs.append(m.group(1) if m else vb.stem)
                # Determine type from VBP or presence of .frm
                is_frm = any(f.stem.lower() == mod_name.lower() for f in (base / 'forms').glob('*.frm')) if (base / 'forms').exists() else False
                modules.append({'name': mod_name, 'type': 'frm' if is_frm else 'bas', 'functions': funcs})
    else:
        # Old layout: .bas files contain function code inline
        for bas in sorted(base.glob('*.bas')):
            funcs = []
            for line in bas.read_text(errors='replace').splitlines():
                m = re.match(r"(?:Public |Private )?(?:Sub|Function)\s+(\S+)", line.strip())
                if m:
                    funcs.append(m.group(1))
            modules.append({'name': bas.stem, 'type': 'bas', 'functions': funcs})
        # Also extract functions from .frm files (code section after Attribute lines)
        for frm in frm_files:
            funcs = []
            in_code = False
            for line in frm.read_text(errors='replace').splitlines():
                ls = line.strip()
                if ls.startswith('Attribute ') or ls.startswith('Option '):
                    in_code = True
                if in_code:
                    m = re.match(r"(?:Public |Private )?(?:Sub|Function)\s+(\S+)", ls)
                    if m:
                        funcs.append(m.group(1))
            if funcs:
                modules.append({'name': frm.stem, 'type': 'frm', 'functions': funcs})
    meta['modules'] = modules
    # Collect .bas filenames for easy access
    meta['bas_modules'] = [m['name'] + '.bas' for m in modules if m.get('type') == 'bas']

    # Strings — check both layouts
    strings = []
    string_dirs = []
    if (base / 'modules').exists():
        string_dirs.append(base / 'modules')
    else:
        string_dirs.append(base)  # flat layout: .strings might be alongside .frm
    for sd in string_dirs:
        for sf in sd.rglob('*.strings'):
            for line in sf.read_text(errors='replace').splitlines():
                line = line.strip().lstrip('\ufeff')
                line = re.sub(r'^[\da-fA-F]+:\s*', '', line)
                if len(line) > 2:
                    strings.append(line)
    # If no .strings files, extract from .bas/.frm code (string literals per line)
    if not strings:
        for f in list(base.glob('*.bas')) + list(frm_files):
            for line in f.read_text(errors='replace').splitlines():
                for m in re.finditer(r'"([^"]{3,})"', line):
                    strings.append(m.group(1))
    meta['strings'] = list(dict.fromkeys(strings))  # dedup, preserve order

    # Extract author, greets, passwords from strings
    meta['author_evidence'] = _find_authors(meta['strings'])
    meta['greets'] = _find_greets(meta['strings'], forms)
    meta['passwords'] = _find_passwords(meta['strings'])
    meta['aol_version_signals'] = []  # TODO: detect from API calls

    # File count
    meta['decompile_file_count'] = sum(1 for _ in base.rglob('*') if _.is_file())

    # Call graph analysis: trace which base module functions are actually called from UI
    meta['code_breakdown'] = _analyze_call_graph(base, frm_files, meta, zip_stem)

    out = base / 'metadata.json'
    out.write_text(json.dumps(meta, indent=2))
    log.info(f'Metadata: {len(forms)} forms, {sum(len(m["functions"]) for m in modules)} functions, {len(strings)} strings')
    return meta


def _detect_vb(proj, base):
    """Detect VB version from project references and runtime DLL."""
    refs = proj.get('Reference', '')
    if 'MSVBVM60' in str(base) or 'VB6' in refs:
        return 'VB6'
    if 'MSVBVM50' in str(base):
        return 'VB5'
    info = base / 'info.txt'
    if info.exists():
        txt = info.read_text(errors='replace')
        if 'compiler=1' in txt:
            return 'VB6'
    return 'VB6'


# Known AOL proggie base modules — filename → metadata
_KNOWN_MODULES = {
    'dos32':     {'name': 'dos32.bas',     'author': 'DoS', 'era': 'AOL 4.0-5.0'},
    'jaguar32':  {'name': 'jaguar32.bas',  'author': 'Jaguar', 'era': 'AOL 2.5-4.0'},
    'genozide':  {'name': 'genozide.bas',  'author': 'GenOziDe', 'era': 'AOL 2.5-3.0'},
    'genozi~1':  {'name': 'genozide.bas',  'author': 'GenOziDe', 'era': 'AOL 2.5-3.0'},
    'livid32':   {'name': 'livid32.bas',   'author': 'LiviD', 'era': 'AOL 4.0'},
    'hiwind':    {'name': 'hiwind.bas',    'author': 'HiWind', 'era': 'AOL 3.0-4.0'},
    'skybox':    {'name': 'skybox.bas',    'author': 'SkyBox', 'era': 'AOL 4.0'},
    'kin2000':   {'name': 'kin2000.bas',   'author': 'Kin', 'era': 'AOL 4.0'},
    'premier32': {'name': 'premier32.bas', 'author': 'Premier', 'era': 'AOL 4.0'},
    'm0ss32':    {'name': 'm0ss32.bas',    'author': 'm0ss', 'era': 'AOL 4.0'},
    'bas32':     {'name': 'bas32.bas',     'author': 'unknown', 'era': 'AOL 4.0'},
    'bdp32':     {'name': 'bdp32.bas',     'author': 'BDP', 'era': 'AOL 4.0'},
    'arc':       {'name': 'arc.bas',       'author': 'Arc', 'era': 'AOL 3.0-4.0'},
    'arc3':      {'name': 'arc3.bas',      'author': 'Arc', 'era': 'AOL 3.0'},
    'arc5':      {'name': 'arc5.bas',      'author': 'Arc', 'era': 'AOL 5.0'},
    'x2k':       {'name': 'x2k.bas',      'author': 'unknown', 'era': 'AOL 4.0-5.0'},
}

def _identify_base_module(proj, base):
    """Identify the known AOL base module (.bas) used by this proggie."""
    # Check VBP Module= lines for known names
    for key in ('Module', 'module'):
        val = proj.get(key, '')
        # Module=dos32; dos32.bas  OR  Module=modFoo; modFoo.bas
        mod_name = val.split(';')[0].strip().lower() if val else ''
        if mod_name in _KNOWN_MODULES:
            return _KNOWN_MODULES[mod_name]

    # Check .bas filenames directly
    bas_files = list(base.glob('*.bas'))
    if not bas_files and (base / 'modules').exists():
        bas_files = list((base / 'modules').glob('*.declarations'))
    for f in bas_files:
        stem = f.stem.lower()
        if stem in _KNOWN_MODULES:
            return _KNOWN_MODULES[stem]

    # Check VBP for ALL Module= lines (there may be multiple)
    vbp = None
    for f in base.iterdir():
        if f.name.lower() == 'project.vbp':
            vbp = f
            break
    if vbp:
        for line in vbp.read_text(errors='replace').splitlines():
            if line.strip().lower().startswith('module='):
                mod_name = line.split('=', 1)[1].split(';')[0].strip().lower()
                if mod_name in _KNOWN_MODULES:
                    return _KNOWN_MODULES[mod_name]

    return None


def _find_screenshot(zip_stem):
    """Find the screenshot.png path for this proggie."""
    for ver_dir in (REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped').iterdir():
        if not ver_dir.is_dir():
            continue
        ss = ver_dir / zip_stem / 'screenshot.png'
        if ss.exists():
            return ss
    return None


def _ocr_control_crop(screenshot_path, form_w, form_h, left, top, width, height):
    """Crop a control's region from the screenshot and OCR it."""
    try:
        from PIL import Image
        img = Image.open(screenshot_path)
        sw, sh = img.size
        sx, sy = sw / form_w, sh / form_h
        px, py = int(left * sx), int(top * sy)
        pw, ph = int(width * sx), int(height * sy)
        if pw < 5 or ph < 5:
            return ''
        crop = img.crop((px, py, px + pw, py + ph))
        # Upscale for OCR
        crop = crop.resize((pw * 4, ph * 4), Image.NEAREST)
        import tempfile
        with tempfile.NamedTemporaryFile(suffix='.png', delete=False) as tmp:
            crop.save(tmp.name)
            tmp_path = tmp.name
        r = subprocess.run(['tesseract', tmp_path, 'stdout', '--psm', '7'],
                           capture_output=True, timeout=10)
        os.unlink(tmp_path)
        text = r.stdout.decode('utf-8', errors='replace').strip()
        # Strip common OCR junk
        text = re.sub(r'[|{}\[\]~`]+$', '', text).strip()
        return text if len(text) >= 2 else ''
    except Exception:
        return ''


def _analyze_call_graph(base, frm_files, meta, zip_stem):
    """Trace which base module functions are actually called from UI event handlers."""
    _proc_re = re.compile(r'(Proc_(\d+)_(\d+))_[A-F0-9]+')
    _func_re = re.compile(r'(?:Public |Private )?(?:Sub|Function) (\S+)')

    # Determine which module indices are base modules vs forms
    bas_indices = set()
    frm_indices = set()
    for mod in meta.get('modules', []):
        # Module index is encoded in Proc_N_M — N is the module index
        if mod.get('type') == 'bas':
            for fn in mod.get('functions', []):
                m = _proc_re.match(fn)
                if m:
                    bas_indices.add(m.group(2))
                    break
        elif mod.get('type') == 'frm':
            for fn in mod.get('functions', []):
                m = _proc_re.match(fn)
                if m:
                    frm_indices.add(m.group(2))
                    break

    if not bas_indices:
        return None  # No base module to analyze

    # Load canonical function name reference for known base modules
    _ref_path = Path(__file__).parent / 'basmod_reference.json'
    _basmod_ref = json.loads(_ref_path.read_text()) if _ref_path.exists() else {}
    # Build proc index → canonical name mapping
    proc_to_canonical = {}
    base_mod = meta.get('base_module')
    if base_mod:
        mod_key = base_mod['name'].replace('.bas', '').lower()
        ref_funcs = _basmod_ref.get(mod_key, [])
        if ref_funcs:
            # Find which module index corresponds to this base module
            for mod in meta.get('modules', []):
                if mod.get('type') == 'bas' and mod['name'].lower() == mod_key:
                    for fn in mod.get('functions', []):
                        m = _proc_re.match(fn)
                        if m:
                            mod_idx = m.group(2)
                            # Map Proc_N_M → canonical name by function index M
                            for i, canon_name in enumerate(ref_funcs):
                                proc_to_canonical[f'Proc_{mod_idx}_{i}'] = canon_name
                            break
                    break

    # Parse all functions from all source files
    all_funcs = {}  # full_name -> {calls: set of short_names, size: int, code: str, module_idx: str}
    source_files = list(base.glob('*.bas')) + list(frm_files)
    for sf in source_files:
        data = sf.read_bytes().decode('latin-1')
        for m in re.finditer(
            r'((?:Public |Private )?(?:Sub|Function) (\S+)[^\n]*\n(?:.*?\n)*?)(?=(?:Public |Private )?(?:Sub|Function) |\Z)',
            data
        ):
            block, name = m.group(1), m.group(2)
            # Skip Declare statements (API imports, not real functions)
            if ' Lib "' in block.split('\n')[0]:
                continue
            short_m = _proc_re.match(name)
            short = short_m.group(1) if short_m else name
            mod_idx = short_m.group(2) if short_m else None
            calls = set(_proc_re.findall(block))
            call_shorts = {c[0] for c in calls} - {short}
            all_funcs[name] = {
                'calls': call_shorts, 'size': len(block.encode('latin-1')),
                'code': block, 'module_idx': mod_idx, 'short': short,
                'source_file': sf.name,
            }

    # Map short names to full names
    short_to_full = {}
    for name, info in all_funcs.items():
        short_to_full[info['short']] = name

    # Identify UI entry points: form event handlers (not Proc_N_M, not Declare stubs)
    ui_entries = [n for n in all_funcs
                  if not n.startswith('Proc_')
                  and 'Declare ' not in all_funcs[n]['code'].split('\n')[0]]

    # Trace reachable functions from UI entry points
    reachable_bas = set()
    visited = set()

    def trace(fname):
        if fname in visited:
            return
        visited.add(fname)
        info = all_funcs.get(fname)
        if not info:
            return
        for call_short in info['calls']:
            full = short_to_full.get(call_short)
            if full:
                fi = all_funcs[full]
                if fi['module_idx'] in bas_indices:
                    reachable_bas.add(full)
                trace(full)

    for entry in ui_entries:
        trace(entry)

    # Compute sizes
    app_size = sum(v['size'] for k, v in all_funcs.items()
                   if v['module_idx'] not in bas_indices or k in ui_entries)
    reachable_size = sum(all_funcs[f]['size'] for f in reachable_bas)
    dead_size = sum(v['size'] for k, v in all_funcs.items()
                    if v['module_idx'] in bas_indices and k not in reachable_bas)
    total = app_size + reachable_size + dead_size

    # Helper: resolve canonical name for a proc
    def _canon(fname):
        short = all_funcs[fname]['short'] if fname in all_funcs else fname
        return proc_to_canonical.get(short, '')

    # Build result — include source code for reachable base functions
    reachable_funcs = []
    for fname in sorted(reachable_bas):
        info = all_funcs[fname]
        reachable_funcs.append({
            'name': fname,
            'canonical_name': _canon(fname),
            'size': info['size'],
            'code': info['code'],
            'source_file': info.get('source_file', 'unknown.bas'),
        })

    # Build control name → caption/type map from form metadata
    # OCR controls with no caption from screenshot crop
    ctrl_info = {}
    screenshot = None
    for form in meta.get('forms', []):
        fw = form.get('client_width', 0)
        fh = form.get('client_height', 0)
        for c in form.get('controls', []):
            caption = c.get('caption', '') or c.get('text', '')
            ci = {'caption': caption, 'type': c.get('type', '')}
            # If no caption and we have position + screenshot, crop and OCR
            if not caption and fw and fh and all(k in c for k in ('left', 'top', 'width', 'height')):
                if screenshot is None:
                    screenshot = _find_screenshot(zip_stem)
                if screenshot:
                    ocr = _ocr_control_crop(screenshot, fw, fh,
                                            c['left'], c['top'], c['width'], c['height'])
                    if ocr:
                        ci['caption'] = ocr
            ctrl_info[c['name'].lower()] = ci

    app_funcs = []
    for fname in sorted(ui_entries):
        info = all_funcs.get(fname)
        if info:
            # Match ControlName_Event() pattern
            ctrl_caption = ''
            ctrl_type = ''
            code_hint = ''
            m = re.match(r'(\w+?)_(\w+)\(', fname)
            if m:
                ci = ctrl_info.get(m.group(1).lower(), {})
                ctrl_caption = ci.get('caption', '')
                ctrl_type = ci.get('type', '')
            # If no caption, extract a hint from the first action line
            if not ctrl_caption and ctrl_type:
                for line in info['code'].splitlines()[1:]:
                    ls = re.sub(r'^loc_[0-9A-Fa-f]+:\s*', '', line.strip())
                    if not ls or ls.startswith("'") or ls.startswith('Dim ') or ls.startswith('Exit ') or ls == 'End Sub':
                        continue
                    # Resolve proc names in hint
                    for short, canon in proc_to_canonical.items():
                        ls = ls.replace(short, canon)
                    ls = re.sub(r'Proc_\d+_\d+_[A-F0-9]+', '', ls)
                    code_hint = ls[:80]
                    break
            app_funcs.append({
                'name': fname,
                'size': info['size'],
                'code': info['code'],
                'source_file': info.get('source_file', 'unknown.bas'),
                'control_caption': ctrl_caption,
                'control_type': ctrl_type,
                'code_hint': code_hint,
                'calls_base': sorted(
                    f for s in info['calls']
                    if (f := short_to_full.get(s)) and f in reachable_bas
                ),
                'calls_base_names': sorted(
                    _canon(f) or f for s in info['calls']
                    if (f := short_to_full.get(s)) and f in reachable_bas
                ),
            })

    # Match non-base module functions against known .bas files (cherry-pick detection)
    from match_functions import match_decompiled_functions
    # Collect all .bas module functions that aren't from a known base
    known_base_key = base_mod['name'].replace('.bas', '').lower() if base_mod else None
    cherrypick_input = []
    for fname, info in all_funcs.items():
        if info['module_idx'] in bas_indices:
            continue  # skip known base module functions
        if fname in ui_entries:
            continue  # skip form event handlers
        cherrypick_input.append({'name': fname, 'code': info['code'], 'size': info['size']})
    # Also match reachable base functions if base module is NOT known
    if not known_base_key:
        for fname in reachable_bas:
            info = all_funcs[fname]
            cherrypick_input.append({'name': fname, 'code': info['code'], 'size': info['size']})

    cherry_picked = []
    if cherrypick_input:
        exclude = {known_base_key} if known_base_key else set()
        matched = match_decompiled_functions(cherrypick_input, exclude_modules=exclude)
        for m in matched:
            if m['matched_module']:
                cherry_picked.append(m)
                # Add to proc_names so _replace_procs can resolve these
                short_m = _proc_re.match(m['name'])
                if short_m:
                    proc_to_canonical[short_m.group(1)] = m['matched_func']

    return {
        'total_base_funcs': sum(1 for v in all_funcs.values() if v['module_idx'] in bas_indices),
        'reachable_base_funcs': len(reachable_bas),
        'dead_base_funcs': sum(1 for v in all_funcs.values() if v['module_idx'] in bas_indices) - len(reachable_bas),
        'app_funcs_count': len(ui_entries),
        'app_size': app_size,
        'reachable_size': reachable_size,
        'dead_size': dead_size,
        'total_size': total,
        'app_pct': round(100 * app_size / total, 1) if total else 0,
        'reachable_pct': round(100 * reachable_size / total, 1) if total else 0,
        'dead_pct': round(100 * dead_size / total, 1) if total else 0,
        'reachable_functions': reachable_funcs,
        'app_functions': app_funcs,
        'cherry_picked': cherry_picked,
        'proc_names': {k: v for k, v in proc_to_canonical.items()},
    }


def _parse_frm(frm_path):
    """Parse a .frm file for controls, menus, timers."""
    txt = frm_path.read_text(errors='replace').replace('\r\n', '\n').replace('\r', '\n')
    name = frm_path.stem
    controls, menus, timers = [], [], []
    form_width, form_height = 0, 0

    # Simple approach: find every Begin <Type> <Name> and grab properties until End
    lines = txt.split('\n')
    i = 0
    while i < len(lines):
        m = re.match(r'\s*Begin\s+(?:VB\.)?(\w+)\s+(\w+)', lines[i])
        if m:
            ctrl_type, ctrl_name = m.group(1), m.group(2)
            if ctrl_type == 'Form':
                # Grab form dimensions and caption
                j = i + 1
                form_caption = ''
                while j < len(lines):
                    pl = lines[j].strip()
                    if pl.startswith('Begin'):
                        break
                    cw = re.match(r'ClientWidth\s*=\s*(\d+)', pl)
                    ch = re.match(r'ClientHeight\s*=\s*(\d+)', pl)
                    cc = re.match(r'Caption\s*=\s*"([^"]*)"', pl)
                    if cw: form_width = int(cw.group(1))
                    if ch: form_height = int(ch.group(1))
                    if cc: form_caption = cc.group(1).strip()
                    j += 1
                name = ctrl_name
                i += 1
                continue
            # Grab immediate properties (until next Begin or End)
            props = {}
            j = i + 1
            while j < len(lines):
                pl = lines[j].strip()
                if pl.startswith('Begin') or pl == 'End':
                    break
                pm = re.match(r'(\w+)\s*=\s*"?([^"]*)"?', pl)
                if pm:
                    props[pm.group(1)] = pm.group(2).strip()
                j += 1
            caption = props.get('Caption', '')

            if ctrl_type == 'Menu':
                menus.append({'name': ctrl_name, 'caption': caption})
            elif ctrl_type == 'Timer':
                timers.append({'name': ctrl_name, 'interval': int(props.get('Interval', 0))})
            else:
                ctrl = {'name': ctrl_name, 'type': ctrl_type}
                if caption:
                    ctrl['caption'] = caption
                text = props.get('Text', '')
                if text:
                    ctrl['text'] = text
                # Store position for screenshot cropping
                for pk in ('Left', 'Top', 'Width', 'Height'):
                    if pk in props:
                        try: ctrl[pk.lower()] = int(props[pk])
                        except ValueError: pass
                controls.append(ctrl)
        i += 1

    return {'name': name, 'controls': controls, 'menus': menus, 'timers': timers,
            'client_width': form_width, 'client_height': form_height}


def _find_authors(strings):
    """Find author evidence in strings."""
    pats = [
        re.compile(r'(?:coded|created|programmed|written|made|designed)\s+by\s+(\S+)', re.I),
        re.compile(r'\bby\s+([A-Za-z0-9_][\w ]{1,28}[A-Za-z0-9_])', re.I),
        re.compile(r'-\s*([A-Za-z0-9_]{3,20})\s*$'),
    ]
    # Skip strings that look like code/API, not attribution
    code_words = {'val', 'ref', 'any', 'long', 'string', 'integer', 'byte',
                  'going', 'clicking', 'pressing', 'using', 'calling',
                  'the', 'this', 'that', 'sc4m'}
    evidence = []
    for s in strings:
        for p in pats:
            m = p.search(s)
            if m:
                first_word = m.group(1).split()[0].lower()
                if first_word not in code_words:
                    evidence.append(s)
                break
    return evidence


def _find_greets(strings, forms):
    """Find greet-related strings."""
    greets = []
    for s in strings:
        if re.search(r'greet|shout|props|thank|respect', s, re.I):
            greets.append(s)
    for f in forms:
        if 'greet' in f['name'].lower():
            greets.append(f['name'])
    return list(dict.fromkeys(greets))


def _find_passwords(strings):
    """Find password-like strings."""
    pws = []
    for s in strings:
        if re.search(r'password|passwd|pass:', s, re.I) and len(s) < 100:
            pws.append(s)
    return pws


# ── Step 3: Screenshots ─────────────────────────────────────────────

def run_screenshots(zip_stem, exe_name, meta):
    """Run capture_walkthrough if the proggie has menus, or basic screenshot if not."""
    has_menus = any(f.get('menus') for f in meta.get('forms', []))
    if has_menus:
        log.info('Running screenshot walkthrough...')
        r = subprocess.run(
            [sys.executable, str(REPO / 'tools' / 'capture_walkthrough.py'), zip_stem],
            capture_output=True, text=True, timeout=300
        )
        if r.returncode != 0:
            log.error(f'Screenshot walkthrough failed:\n{r.stdout}\n{r.stderr}')
            return None
        log.info(r.stdout.strip().split('\n')[-1])
        return True

    # No menus — just capture a basic screenshot of the main form
    log.info('No menus, capturing basic screenshot...')
    r = subprocess.run(
        [sys.executable, str(REPO / 'tools' / 'capture_walkthrough.py'), zip_stem, '--screenshot-only'],
        capture_output=True, text=True, timeout=120
    )
    if r.returncode != 0:
        log.error(f'Basic screenshot failed:\n{r.stdout}\n{r.stderr}')
        return None
    log.info(r.stdout.strip().split('\n')[-1])
    return True


# ── Step 4: Update DB ────────────────────────────────────────────────

def update_db(zip_stem, exe_name, meta, has_screenshots):
    """Update proggie_db.sqlite with decompile results."""
    if not DB_PATH.exists():
        log.warning('No proggie_db.sqlite found')
        return

    conn = sqlite3.connect(str(DB_PATH))

    # Ensure base_module column exists
    cols = {r[1] for r in conn.execute('PRAGMA table_info(exes)').fetchall()}
    if 'base_module' not in cols:
        conn.execute('ALTER TABLE exes ADD COLUMN base_module TEXT')

    # Build base_module value: comma-separated .bas filenames
    bas_modules = ','.join(meta.get('bas_modules', []))

    # Update exe record
    conn.execute('''
        UPDATE exes SET decompile_status='done',
            decompile_file_count=?,
            decompile_output=?,
            base_module=?
        WHERE exe_name=? AND proggie_id IN (SELECT id FROM proggies WHERE zip_stem=?)
    ''', (meta.get('decompile_file_count', 0),
          str(DECOMPILED / zip_stem / exe_name),
          bas_modules or None,
          exe_name, zip_stem))

    # Update author if found
    authors = meta.get('author_evidence', [])
    if authors:
        name = None
        for a in authors:
            m = re.search(r'(?:coded|created|programmed|written|made|designed)\s+by\s+(\S+)', a, re.I)
            if m:
                name = m.group(1); break
            m = re.search(r'\bby\s+([\w][\w ]{1,28}[\w])', a, re.I)
            if m:
                name = m.group(1).strip(); break
            m = re.search(r'-\s*([A-Za-z0-9_]{3,20})\s*$', a)
            if m:
                name = m.group(1); break
        if name:
            conn.execute('UPDATE proggies SET author=? WHERE zip_stem=? AND (author IS NULL OR author="")',
                         (name, zip_stem))

    conn.commit()
    conn.close()
    log.info(f'DB updated: decompile_status=done')


# ── Step 5: Regenerate HTML ──────────────────────────────────────────

def regen_html(zip_stem):
    """Regenerate the HTML analysis page."""
    # Find the HTML file
    for ver_dir in SORTED.iterdir():
        html = ver_dir / f'{zip_stem}.html'
        if html.exists():
            r = subprocess.run(
                [sys.executable, str(REPO / 'tools' / 'generate_analysis.py'), str(html)],
                capture_output=True, text=True, timeout=60
            )
            log.info(f'HTML regenerated: {html.name}')
            return
    log.warning(f'No HTML file found for {zip_stem}')


# ── Helpers ──────────────────────────────────────────────────────────

def find_exe(zip_stem):
    """Find the primary exe for a zip_stem from the DB."""
    if not DB_PATH.exists():
        return None, None
    conn = sqlite3.connect(str(DB_PATH))
    row = conn.execute('''
        SELECT e.exe_name, e.exe_path, p.aol_version
        FROM exes e JOIN proggies p ON e.proggie_id = p.id
        WHERE p.zip_stem=? AND e.vb_version IN ('VB5','VB6')
        ORDER BY e.is_primary DESC, e.file_size DESC LIMIT 1
    ''', (zip_stem,)).fetchone()
    conn.close()
    if not row:
        return None, None
    exe_name = row[0]
    # Find extracted exe
    extract_dir = SORTED / '_extracted' / zip_stem
    exe_path = extract_dir / exe_name
    if not exe_path.exists():
        # Try case-insensitive
        for f in extract_dir.iterdir() if extract_dir.exists() else []:
            if f.name.lower() == exe_name.lower():
                exe_path = f
                break
    return exe_name, exe_path if exe_path.exists() else None


def _write_cleaned_source(zip_stem, exe_name, meta):
    """Write cleaned .bas/.frm source files alongside raw decompiled output."""
    cb = meta.get('code_breakdown')
    if not cb:
        return
    from clean_code import clean_file
    base = DECOMPILED / zip_stem / exe_name
    out_dir = base / 'cleaned'
    if out_dir.exists():
        import shutil
        shutil.rmtree(out_dir)
    out_dir.mkdir(exist_ok=True)

    proc_names = cb.get('proc_names', {})

    # Clean each raw .frm/.bas file, preserving headers and structure
    count = 0
    for raw in list(base.glob('*.frm')) + list(base.glob('*.bas')):
        cleaned = clean_file(raw.read_bytes().decode('latin-1'), proc_names)
        (out_dir / raw.name).write_text(cleaned)
        count += 1

    # Also write cherry-picked source (already clean canonical .bas code)
    cherry_by_mod = {}
    for cp in cb.get('cherry_picked', []):
        src_code = cp.get('matched_source', '')
        if src_code:
            mod = cp.get('matched_module', 'unknown')
            cherry_by_mod.setdefault(mod, []).append(src_code)
    for mod, blocks in cherry_by_mod.items():
        (out_dir / f'cherry_{mod}.bas').write_text('\n\n'.join(blocks) + '\n')
        count += 1

    log.info(f'Cleaned source: {count} files → {out_dir}')


# ── Main ─────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description='Single proggie pipeline')
    parser.add_argument('zip_stem', help='Proggie zip stem (e.g. anexbust)')
    parser.add_argument('--skip-decompile', action='store_true', help='Skip decompile, use existing output')
    parser.add_argument('--skip-screenshots', action='store_true', help='Skip screenshot walkthrough')
    args = parser.parse_args()

    zip_stem = args.zip_stem
    exe_name, exe_path = find_exe(zip_stem)
    if not exe_name:
        log.error(f'No VB5/VB6 exe found for {zip_stem}')
        sys.exit(1)
    log.info(f'=== {zip_stem} / {exe_name} ===')

    # Step 1: Decompile
    decomp_dir = DECOMPILED / zip_stem / exe_name
    if not args.skip_decompile:
        if not exe_path:
            log.error(f'Exe not found on disk: {exe_name}')
            sys.exit(1)
        result = decompile_exe(zip_stem, exe_name, exe_path)
        if not result:
            update_db_error(zip_stem, exe_name, 'decompile failed')
            sys.exit(1)
    elif not decomp_dir.exists():
        log.error(f'No decompiled output at {decomp_dir}')
        sys.exit(1)

    # Step 2: Build metadata
    meta = build_metadata(zip_stem, exe_name)
    if not meta:
        log.error('Failed to build metadata')
        sys.exit(1)

    # Step 2b: Write cleaned source files
    _write_cleaned_source(zip_stem, exe_name, meta)

    # Step 3: Screenshots
    has_screenshots = False
    if not args.skip_screenshots:
        has_screenshots = run_screenshots(zip_stem, exe_name, meta)

    # Step 4: Update DB
    update_db(zip_stem, exe_name, meta, has_screenshots)

    # Step 5: Regen HTML
    regen_html(zip_stem)

    log.info(f'=== Done: {zip_stem} ===')


def update_db_error(zip_stem, exe_name, error_msg):
    """Mark exe as failed in DB."""
    if not DB_PATH.exists(): return
    conn = sqlite3.connect(str(DB_PATH))
    conn.execute('''
        UPDATE exes SET decompile_status='error', decompile_error=?
        WHERE exe_name=? AND proggie_id IN (SELECT id FROM proggies WHERE zip_stem=?)
    ''', (error_msg, exe_name, zip_stem))
    conn.commit()
    conn.close()


if __name__ == '__main__':
    main()
