#!/usr/bin/env python3
"""Generate per-proggie HTML analysis pages from strings DB + decompile data.

Reads metadata from existing HTML pages, pulls strings from exe_strings.db,
loads decompile metadata.json when available, and generates rich analysis pages
with progressive disclosure, version-annotated API refs, and structured forms.
"""
import json
import os
import re
import sqlite3
import sys
import html as H
from pathlib import Path

SORTED_DIR = Path("programs/AOL/proggies-sorted-deduped")
DB_PATH = Path("exe_strings.db")
DECOMPILED_DIR = Path("decompiled")

# AOL API → version range mapping (from docs/old-plans/AOL_VERSION_DETECTION.md)
AOL_API_VERSIONS = {
    'AOL Frame25': '2.5–3.0', 'AOL Frame': '4.0+',
    '_AOL_Modal': '2.5–7.0', '_AOL_Palette': '2.5–5.0',
    '_AOL_Glyph': '4.0–7.0', '_AOL_Timer': '6.0–7.0',
    '_AOL_Icone': '6.0–7.0', '_AOL_RadioBox': '6.0–7.0',
    '_AOL_FontCombo': '4.0–7.0', '_AOL_Edit': '4.0–7.0',
    '_AOL_Listbox': '4.0–9.0', '_AOL_Static': '4.0–9.0',
    '_AOL_Button': '4.0–7.0', '_AOL_Checkbox': '4.0–7.0',
    '_AOL_Combobox': '4.0–9.0', '_AOL_Icon': '4.0–9.0',
    '_AOL_Spin': '4.0–7.0', 'AOL Child': '4.0–9.0',
    'AOL Toolbar': '4.0–9.0', 'RICHCNTL': '2.5+',
    'MDIClient': '4.0–9.0',
    'FindWindowA': 'Win32 API', 'FindWindowExA': 'Win32 API',
    'SendMessageA': 'Win32 API', 'PostMessageA': 'Win32 API',
    'GetWindowTextA': 'Win32 API', 'SetWindowPos': 'Win32 API',
    'ShowWindow': 'Win32 API', 'SetCursorPos': 'Win32 API',
    'GetCursorPos': 'Win32 API', 'ShellExecuteA': 'Win32 API',
    'GetMenu': 'Win32 API', 'GetMenuItemCount': 'Win32 API',
    'GetMenuItemID': 'Win32 API', 'GetMenuStringA': 'Win32 API',
    'GetSubMenu': 'Win32 API', 'IsWindowVisible': 'Win32 API',
    'ReleaseCapture': 'Win32 API', 'ShowCursor': 'Win32 API',
    'OpenProcess': 'Win32 API', 'ReadProcessMemory': 'Win32 API',
    'GetWindowThreadProcessId': 'Win32 API',
    'RtlMoveMemory': 'Win32 API', 'CloseHandle': 'Win32 API',
    'WritePrivateProfileStringA': 'Win32 API',
    'GetPrivateProfileStringA': 'Win32 API',
    'GetWindowTextLengthA': 'Win32 API',
    'mciSendStringA': 'Multimedia', 'sndPlaySoundA': 'Multimedia',
}

# PE/compiler artifact strings to always filter out
PE_ARTIFACTS = {
    '!This program cannot be run in DOS mode.', 'VS_VERSION_INFO',
    'VarFileInfo', 'Translation', 'StringFileInfo', 'ProductName',
    'InternalName', 'OriginalFilename', 'FileVersion', 'ProductVersion',
    'CompanyName', 'FileDescription', 'LegalCopyright', 'LegalTrademarks',
    'PrivateBuild', 'SpecialBuild', 'Comments', 'Rich', '.text', '.data',
    '.rsrc', '`.data', 'VB5!',
}

PE_ARTIFACT_RE = re.compile(
    r'^(?:_adj_fp|_CI|__vba|EVENT_SINK_|DllFunctionCall$|_allmul$|'
    r'TDESTap|040904B0$|[0-9a-f]{6,}$|'
    r'C:\\Program Files\\Microsoft Visual Studio\\)'
)

HIGHLIGHT_PATTERNS = [
    (re.compile(r'(\b(?:coded|programmed|made|created|written|designed|developed)\s+by\s*:?\s*.+)', re.I), 'author'),
    (re.compile(r'(\bby\s*:\s*\S.+)', re.I), 'author'),
    (re.compile(r'(\bBy\s+[A-Z][\w\-]+(?:\s*[&+]\s*[A-Z][\w\-]+)*)', re.I), 'author'),
    (re.compile(r'(\b(?:author|coder|programmer)\s*:?\s*.+)', re.I), 'author'),
    (re.compile(r'(.+\s+presents\b)', re.I), 'author'),
    (re.compile(r'(\b(?:credits?|greets?|greetz)\b)', re.I), 'credits'),
    (re.compile(r'(AOL Frame|AOL Child|_AOL_\w+|FindWindow\w*|SendMessage\w*|SetWindowText)', re.I), 'api'),
    (re.compile(r'(frm\w+\.FRM|\.FRM\b)', re.I), 'form'),
    (re.compile(r'(MSVBVM\d+|VB\d+RUN|\.ocx|\.vbx)', re.I), 'dep'),
]

PHISHING_RE = re.compile(
    r'(?:password|billing\s+(?:dept|rep|department|info)|credit\s+card|'
    r'expiration\s+date|log.?on\s+password|click\s+respond|'
    r'verify\s+(?:your|that\s+you)|re-?verify|account\s+(?:will\s+be\s+(?:credited|deleted|terminated)|deletion)|'
    r'enter\s+your\s+(?:log|password|full\s+name)|'
    r'we\s+(?:have\s+lost|seem\s+to\s+have|need\s+you\s+to)|'
    r'failure\s+to\s+(?:respond|comply)|terminate\s+your\s+account|'
    r'bank\s+name|credit\s+checkers|billing\s+information)',
    re.I
)

JUNK_RE = re.compile(r'|'.join([
    r'^[!-/:-@\[-`{-~]{2,}',
    r'^.{0,2}XI42',
    r'^.{0,2}KI[!@z]\S{0,4}$',
    r'^.{0,2}5?XI@SKI$',
    r'^\w?j[79]M$',
    r'^[A-Z]{1,2}[#%<>@]\S{0,4}$',
    r'^[!-~]{2,6}$',
]))


def is_pe_artifact(s: str) -> bool:
    return s in PE_ARTIFACTS or bool(PE_ARTIFACT_RE.match(s))

def is_phishing(s: str) -> bool:
    return len(s) > 40 and bool(PHISHING_RE.search(s))

def is_junk(s: str) -> bool:
    if len(s) < 4: return True
    if JUNK_RE.match(s): return True
    if len(s) <= 8 and ' ' not in s:
        if sum(1 for c in s if c.isalpha()) / len(s) < 0.7: return True
    if len(s) >= 6 and len(set(s)) <= 3: return True
    return False

def classify(s: str) -> str | None:
    for pat, cls in HIGHLIGHT_PATTERNS:
        if pat.search(s): return cls
    return None

def is_interesting(s: str) -> bool:
    if ' ' in s and len(s) >= 8: return True
    if re.match(r'[\[(*\-~`].*[\])*\-~`]', s) and len(s) >= 6: return True
    if re.search(r'v\d|version|\d\.\d', s, re.I): return True
    if re.search(r'\.\w{2,4}$', s) and len(s) >= 6: return True
    return False


def parse_existing_meta(html_path: Path) -> dict:
    text = html_path.read_text(encoding='utf-8', errors='ignore')
    meta = {}
    # Try old format: <div class="meta">
    m = re.search(r'<div class="meta">(.*?)</div>', text)
    if m:
        raw = m.group(1)
        for field in ['Program', 'Author', 'AOL Version', 'Category', 'Exe', 'VB', 'Compile']:
            fm = re.search(rf'<b>{re.escape(field)}:</b>\s*([^|<]+)', raw)
            if fm: meta[field.lower().replace(' ', '_')] = H.unescape(fm.group(1).strip())
    # Try new format: hero section
    if not meta:
        m = re.search(r'<div class="hero">.*?<h1>(.*?)</h1>', text, re.S)
        if m:
            meta['program'] = H.unescape(re.sub(r'<[^>]+>', '', m.group(1)).strip())
    return meta


def get_meta_from_db(zip_stem):
    """Get metadata from proggie_db.sqlite — primary source."""
    db = Path("proggie_db.sqlite")
    if not db.exists(): return None
    conn = sqlite3.connect(str(db))
    row = conn.execute(
        "SELECT p.name, p.author, p.aol_version, p.category, e.exe_name, e.vb_version, e.compile_type, e.exe_path "
        "FROM proggies p LEFT JOIN exes e ON e.proggie_id = p.id WHERE p.zip_stem = ? LIMIT 1",
        (zip_stem,)
    ).fetchone()
    conn.close()
    if not row: return None
    meta = {
        'program': row[0] or zip_stem, 'author': row[1] or 'Unknown',
        'aol_version': row[2] or '?', 'category': row[3] or '?',
        'exe': row[4] or '?', 'vb': row[5] or '?', 'compile': row[6] or '?',
    }
    # Read PE timestamp for compile date
    if row[7]:
        exe_path = SORTED_DIR / '_extracted' / zip_stem / row[4]
        if exe_path.exists():
            meta['compile_date'] = _read_pe_timestamp(exe_path)
    return meta


def _read_pe_timestamp(exe_path):
    """Read compile date from PE header TimeDateStamp field."""
    import struct, datetime
    try:
        with open(exe_path, 'rb') as f:
            f.seek(0x3C)
            pe_off = struct.unpack('<I', f.read(4))[0]
            f.seek(pe_off + 8)
            ts = struct.unpack('<I', f.read(4))[0]
            if ts < 631152000 or ts > 1893456000:  # 1990-2030 sanity check
                return None
            dt = datetime.datetime.fromtimestamp(ts, datetime.UTC)
            return dt.strftime('%Y-%m-%d')
    except Exception:
        return None


def get_strings_from_db(conn, exe_path):
    """Return all strings (with duplicates for frequency counting)."""
    rows = conn.execute("SELECT value FROM strings WHERE exe_path = ? ORDER BY id", (exe_path,)).fetchall()
    return [v.strip() for (v,) in rows if v.strip()]


def find_exe_in_db(conn, exe_name, archive_base):
    if not exe_name or exe_name == '?': return None
    rows = conn.execute("SELECT DISTINCT exe_path FROM strings WHERE exe_path LIKE ?", (f"%/{exe_name}",)).fetchall()
    if len(rows) == 1: return rows[0][0]
    for (p,) in rows:
        if archive_base.lower() in p.lower(): return p
    return rows[0][0] if rows else None


def load_decompile_data(zip_stem, exe_name):
    """Load metadata.json and function code from decompiled output."""
    meta_path = DECOMPILED_DIR / zip_stem / exe_name / "metadata.json"
    if not meta_path.exists(): return None
    data = json.loads(meta_path.read_text(encoding='utf-8'))
    # Load function code from .vb files
    base = DECOMPILED_DIR / zip_stem / exe_name / "modules"
    funcs_by_module = {}
    if base.exists():
        for mod_dir in sorted(base.iterdir()):
            if not mod_dir.is_dir(): continue
            mod_name = mod_dir.name.replace('_funcs', '')
            funcs = []
            for vb in sorted(mod_dir.glob('*.vb')):
                code = vb.read_text(encoding='utf-8-sig', errors='ignore').strip()
                # Extract function name from first line
                first_line = code.split('\n')[0].strip() if code else ''
                m = re.match(r"(?:Public |Private )?(?:Sub|Function)\s+(\S+)", first_line)
                name = m.group(1) if m else vb.stem.split('_', 1)[-1] if '_' in vb.stem else vb.stem
                size = len(code.encode('utf-8'))
                funcs.append({'name': name, 'code': code, 'size': size, 'file': vb.name})
            if funcs:
                funcs_by_module[mod_name] = funcs
    data['_funcs_by_module'] = funcs_by_module
    return data


CSS = """<style>
*{box-sizing:border-box}
body{font-family:'Segoe UI',system-ui,sans-serif;background:#0d1117;color:#c9d1d9;margin:0;padding:20px;line-height:1.5}
.container{max-width:960px;margin:0 auto}
.hero{padding:24px;margin-bottom:24px;border-radius:8px;background:linear-gradient(135deg,#161b22,#1a2332);border:1px solid #30363d}
.hero h1{margin:0;font-size:1.8em;color:#58a6ff;display:inline}
.hero .author{font-size:1.1em;color:#8b949e;margin-bottom:12px;display:inline;margin-left:12px}
.hero .author b{color:#f0883e}
.badges{display:flex;gap:8px;flex-wrap:wrap;margin-top:8px}
.badge{padding:3px 10px;border-radius:12px;font-size:0.8em;font-weight:600}
.badge-ver{background:#1f3a1f;color:#3fb950;border:1px solid #238636}
.badge-cat{background:#1f2a3f;color:#58a6ff;border:1px solid #1f6feb}
.badge-vb{background:#2a1f3f;color:#bc8cff;border:1px solid #8957e5}
.badge-compile{background:#3f2a1f;color:#f0883e;border:1px solid #d18616}
.badge-api{background:#2a2a0a;color:#e3b341;border:1px solid #9e6a03;font-size:0.7em;padding:1px 6px;border-radius:8px}
section{margin-bottom:20px}
h2{color:#8b949e;font-size:1em;margin:20px 0 8px;padding-bottom:4px;border-bottom:1px solid #21262d}
.card{background:#161b22;border:1px solid #30363d;border-radius:6px;padding:12px 16px;margin-bottom:8px}
.card h3{margin:0 0 8px;color:#58a6ff;font-size:0.95em}
.ctrl-table{width:100%;border-collapse:collapse;font-size:0.85em}
.ctrl-table th{text-align:left;color:#8b949e;padding:4px 8px;border-bottom:1px solid #30363d;font-weight:normal}
.ctrl-table td{padding:4px 8px;border-bottom:1px solid #21262d}
.ctrl-table td:first-child{color:#bc8cff}
.menu-tree{margin:8px 0;padding-left:0;list-style:none;font-size:0.85em}
.menu-tree li{padding:2px 0;color:#c9d1d9}
.menu-tree li::before{content:'├─ ';color:#30363d}
.menu-tree li:last-child::before{content:'└─ ';color:#30363d}
.menu-tree .submenu{padding-left:20px;list-style:none}
.menu-tree .submenu li::before{content:'├─ ';color:#30363d}
.menu-tree .submenu li:last-child::before{content:'└─ ';color:#30363d}
.fn-group{margin-bottom:12px}
.fn-group summary{cursor:pointer;color:#58a6ff;font-size:0.9em;padding:4px 0}
.fn-group summary:hover{color:#79c0ff}
.fn-item{margin:2px 0}
.fn-item summary{cursor:pointer;color:#c9d1d9;font-size:0.85em;font-family:monospace;padding:2px 4px;border-radius:3px}
.fn-item summary:hover{background:#1c2333}
.fn-item summary .sz{color:#484f58;font-size:0.8em;margin-left:8px}
.fn-item pre{margin:4px 0 8px 16px;padding:12px;background:#0d1117;border:1px solid #21262d;border-radius:4px;overflow-x:auto;font-size:0.8em;line-height:1.4;color:#c9d1d9}
.api-item{display:flex;align-items:center;gap:8px;padding:3px 0;font-size:0.9em}
.api-name{color:#e3b341;font-family:monospace}
.s{padding:4px 8px;margin:2px 0;display:block;font-size:0.85em;border-radius:3px}
.author-str{background:#2a0a2a;border-left:3px solid #f0883e;color:#f8f}
.credits-str{background:#0a2a2a;border-left:3px solid #3fb950;color:#afa}
.phishing-str{background:#2a1a1a;border-left:3px solid #f85149;color:#faa}
.dep-str{background:#2a1a0a;border-left:3px solid #d18616;color:#fca}
.interesting-str{background:#161b22;border-left:3px solid #58a6ff;color:#c9d1d9}
.plain-str{color:#484f58;font-size:0.8em}
blockquote{margin:8px 0;padding:8px 16px;border-left:3px solid #30363d;color:#8b949e;font-style:italic;background:#161b22;border-radius:0 4px 4px 0}
.greet-tags{display:flex;flex-wrap:wrap;gap:6px;margin:8px 0}
.greet-tag{background:#1f2a1f;color:#3fb950;padding:2px 8px;border-radius:10px;font-size:0.8em;border:1px solid #238636}
.stats{color:#484f58;font-size:0.8em;margin:4px 0}
details{margin:4px 0}
summary{cursor:pointer}
summary:hover{color:#58a6ff}
.screenshot{margin:12px 0}
.screenshot img{max-width:100%;border:1px solid #30363d;border-radius:6px}
.screenshot .caption{color:#484f58;font-size:0.8em;margin-top:4px}
@media print{body{background:#fff;color:#000}.hero{background:#f6f8fa;border-color:#d0d7de}.card{border-color:#d0d7de}}
@media(max-width:600px){body{padding:10px}.hero h1{font-size:1.3em}}
</style>"""


def render_hero(meta, archive_name, decomp):
    e = H.escape
    program = meta.get('program', archive_name.replace('.zip', ''))
    author = meta.get('author', 'Unknown')
    version = meta.get('aol_version', '?')
    cat = meta.get('category', '?')
    exe = meta.get('exe', '?')
    vb = meta.get('vb', '?')
    compile_type = meta.get('compile', '?')

    # Try to get better author from decompile data
    if decomp and author in ('Unknown', '?'):
        for ev in decomp.get('author_evidence', []):
            m = re.search(r'(?:by|coded by|programmed by|made by)\s+(\S+)', ev, re.I)
            if m:
                author = m.group(1).rstrip('.,;:')
                break

    lines = [f'<div class="hero">']
    lines.append(f'<div><h1>{e(program)}</h1><span class="author">by <b>{e(author)}</b></span></div>')
    lines.append(f'<div class="badges" style="margin-top:10px">')
    if version != '?':
        lines.append(f'<span class="badge badge-ver">AOL {e(version)}</span>')
    lines.append(f'<span class="badge badge-vb">{e(vb)}</span>')
    if compile_type != '?':
        ct_label = {'native': 'Native Code', 'p-code': 'P-Code'}.get(compile_type, compile_type)
        lines.append(f'<span class="badge badge-compile">{e(ct_label)}</span>')
    lines.append(f'<span class="badge" style="background:#1a1a2a;color:#8b949e;border:1px solid #30363d">{e(exe)}</span>')
    compile_date = meta.get('compile_date')
    if compile_date:
        lines.append(f'<span class="badge" style="background:#1a2a1a;color:#8b949e;border:1px solid #30363d">Compiled {e(compile_date)}</span>')
    lines.append('</div></div>')
    return '\n'.join(lines)


def render_screenshots(zip_stem, html_path):
    """Render screenshot gallery from images directory."""
    img_dir = html_path.parent / zip_stem
    if not img_dir.exists():
        return ''
    lines = ['<section class="screenshot">']
    found = False
    for name, caption in [
        ('screenshot.png', 'Program running in Windows'),
        ('animated.gif', 'Navigation walkthrough'),
    ]:
        img = img_dir / name
        if img.exists():
            lines.append(f'<img src="{zip_stem}/{name}" alt="{caption}">')
            lines.append(f'<div class="caption">{caption}</div>')
            found = True
    lines.append('</section>')
    return '\n'.join(lines) if found else ''


def render_forms(decomp, zip_stem=None, exe_name=None):
    """Render forms as structured cards with control tables, menu trees, and SVG layouts."""
    if not decomp or not decomp.get('forms'):
        return ''
    e = H.escape
    lines = ['<h2>&#x1f5bc; Forms &amp; Controls</h2>']
    for form in decomp['forms']:
        lines.append('<div class="card">')
        lines.append(f'<h3>{e(form["name"])}</h3>')
        # SVG layout from .frm file
        if zip_stem and exe_name:
            frm_path = DECOMPILED_DIR / zip_stem / exe_name / 'forms' / f'{form["name"]}.frm'
            if frm_path.exists():
                svg = render_form_layout(form['name'], frm_path)
                if svg:
                    lines.append(svg)
        controls = [c for c in form.get('controls', []) if c.get('type') not in ('Shape', 'Line')]
        if controls:
            lines.append('<table class="ctrl-table"><tr><th>Type</th><th>Name</th><th>Caption</th></tr>')
            for c in controls:
                cap = e(c.get('caption', '')) if c.get('caption') else '<span style="color:#30363d">—</span>'
                lines.append(f'<tr><td>{e(c["type"])}</td><td>{e(c["name"])}</td><td>{cap}</td></tr>')
            lines.append('</table>')
        menus = form.get('menus', [])
        if menus:
            lines.append('<div style="margin-top:8px;color:#8b949e;font-size:0.85em">Menu:</div>')
            lines.append(_render_menu_tree(menus))
        timers = form.get('timers', [])
        if timers:
            lines.append(f'<div style="margin-top:6px;color:#484f58;font-size:0.8em">Timers: {", ".join(e(t["name"]) if isinstance(t, dict) else e(t) for t in timers)}</div>')
        lines.append('</div>')
    return '\n'.join(lines)


def _render_menu_tree(menus):
    """Build nested menu tree from flat menu list."""
    e = H.escape
    # Build hierarchy from menu names (parent_child naming convention)
    roots = []
    children = {}
    for m in menus:
        name = m['name'] if isinstance(m, dict) else m
        caption = m.get('caption', name) if isinstance(m, dict) else name
        parts = name.split('_')
        if len(parts) <= 1:
            roots.append((name, caption, []))
        else:
            parent = '_'.join(parts[:-1])
            children.setdefault(parent, []).append((name, caption))

    def build(name, caption):
        kids = children.get(name, [])
        if caption == '-':
            return ''
        s = f'<li>{e(caption)}'
        if kids:
            s += '<ul class="submenu">'
            for cn, cc in kids:
                sub = build(cn, cc)
                if sub:
                    s += sub
            s += '</ul>'
        s += '</li>'
        return s

    html = '<ul class="menu-tree">'
    for name, caption, _ in roots:
        r = build(name, caption)
        if r:
            html += r
    html += '</ul>'
    return html


def render_functions(decomp):
    """Render functions with progressive disclosure — collapsed by default."""
    if not decomp:
        return ''
    funcs_by_mod = decomp.get('_funcs_by_module', {})
    if not funcs_by_mod:
        return ''
    e = H.escape
    lines = ['<h2>&#x1f4dc; Decompiled Functions</h2>']
    for mod_name, funcs in funcs_by_mod.items():
        lines.append(f'<details class="fn-group"><summary><b>{e(mod_name)}</b> ({len(funcs)} functions)</summary>')
        for f in funcs:
            name = f['name']
            # Clean up display name
            display = re.sub(r"^(?:Private |Public )?(?:Sub |Function )", '', name)
            display = re.sub(r"\s*'[0-9A-Fa-f]+$", '', display)  # strip address comment
            sz = f['size']
            sz_label = f'{sz}b' if sz < 1024 else f'{sz/1024:.1f}KB'
            lines.append(f'<details class="fn-item"><summary>{e(display)} <span class="sz">{sz_label}</span></summary>')
            lines.append(f'<pre>{e(f["code"])}</pre>')
            lines.append('</details>')
        lines.append('</details>')
    return '\n'.join(lines)


def render_api_refs(api_strings):
    """Render API references split into AOL Classes vs Win32 Calls."""
    if not api_strings:
        return ''
    e = H.escape
    aol_classes = []
    win32_calls = []
    other_api = []
    for s in api_strings:
        ver = AOL_API_VERSIONS.get(s, '')
        if ver and ver != 'Win32 API' and ver != 'Multimedia':
            aol_classes.append((s, ver))
        elif ver in ('Win32 API', 'Multimedia'):
            win32_calls.append((s, ver))
        else:
            other_api.append((s, ''))

    lines = [f'<h2>&#x2699; API References ({len(api_strings)})</h2>']
    if aol_classes:
        lines.append('<div class="card"><h3>AOL Window Classes</h3>')
        for s, ver in aol_classes:
            lines.append(f'<div class="api-item"><span class="api-name">{e(s)}</span> <span class="badge-api">{e(ver)}</span></div>')
        lines.append('</div>')
    if win32_calls:
        lines.append('<div class="card"><h3>Win32 API Calls</h3>')
        for s, ver in win32_calls:
            lines.append(f'<div class="api-item"><span class="api-name">{e(s)}</span></div>')
        lines.append('</div>')
    if other_api:
        lines.append('<div class="card"><h3>Other</h3>')
        for s, ver in other_api:
            lines.append(f'<div class="api-item"><span class="api-name">{e(s)}</span></div>')
        lines.append('</div>')
    return '\n'.join(lines)


def render_greets(greet_names, greet_text):
    """Render greet names as tags and closing text."""
    if not greet_names and not greet_text:
        return ''
    e = H.escape
    lines = ['<h2>&#x1f91d; Greets &amp; Shoutouts</h2>']
    if greet_names:
        lines.append('<div class="greet-tags">')
        for name in greet_names:
            lines.append(f'<span class="greet-tag">{e(name)}</span>')
        lines.append('</div>')
    # Only show closing text (not "Greets to..." headers)
    for t in greet_text:
        if not re.match(r'^greets?\s*(?:to)?\.{0,3}$', t, re.I):
            lines.append(f'<div style="color:#8b949e;font-size:0.85em;margin-top:6px;font-style:italic">{e(t)}</div>')
    return '\n'.join(lines)


def render_deps_from_db(zip_stem):
    """Render structured dependencies from proggie_db."""
    db = Path("proggie_db.sqlite")
    if not db.exists(): return ''
    conn = sqlite3.connect(str(db))
    rows = conn.execute('''
        SELECT d.dep_name, d.dep_type, d.source, d.in_zip, d.system_dll, d.vb_runtime
        FROM deps d JOIN exes e ON d.exe_id = e.id JOIN proggies p ON e.proggie_id = p.id
        WHERE p.zip_stem = ?
    ''', (zip_stem,)).fetchall()
    conn.close()
    if not rows: return ''
    e = H.escape
    runtime = [(r[0], r[1]) for r in rows if r[5]]  # vb_runtime
    system = [(r[0], r[1]) for r in rows if r[4] and not r[5]]  # system_dll
    bundled = [(r[0], r[1]) for r in rows if r[3] and not r[4] and not r[5]]  # in_zip, not system
    other = [(r[0], r[1]) for r in rows if not r[3] and not r[4] and not r[5]]

    lines = [f'<h2>&#x1f4e6; Dependencies ({len(rows)})</h2>']
    for label, deps in [('VB Runtime', runtime), ('System DLLs', system),
                        ('Bundled in Archive', bundled), ('Other', other)]:
        if not deps: continue
        lines.append(f'<div class="card"><h3>{label}</h3>')
        for name, dtype in deps:
            badge = f' <span style="color:#484f58;font-size:0.75em">({dtype})</span>' if dtype != 'dll' else ''
            lines.append(f'<div style="padding:2px 0"><span class="api-name">{e(name)}</span>{badge}</div>')
        lines.append('</div>')
    return '\n'.join(lines)


def _parse_frm_controls(frm_path):
    """Parse .frm file to extract control positions and sizes."""
    text = frm_path.read_text(encoding='utf-8-sig', errors='ignore')
    controls = []
    form_w = form_h = 0
    # Get form dimensions
    m = re.search(r'ClientWidth\s*=\s*(\d+)', text)
    if m: form_w = int(m.group(1))
    m = re.search(r'ClientHeight\s*=\s*(\d+)', text)
    if m: form_h = int(m.group(1))

    # Parse controls
    for block in re.finditer(r'Begin\s+(\w+(?:\.\w+)?)\s+(\w+)\s*\r?\n(.*?)End\r?\n', text, re.S):
        ctrl_type = block.group(1).split('.')[-1] if '.' in block.group(1) else block.group(1)
        ctrl_name = block.group(2)
        body = block.group(3)
        props = {}
        for pm in re.finditer(r'(\w+)\s*=\s*(.+)', body):
            props[pm.group(1)] = pm.group(2).strip().strip('"')
        if 'Left' in props and 'Top' in props:
            controls.append({
                'type': ctrl_type, 'name': ctrl_name,
                'caption': props.get('Caption', ''),
                'left': int(props.get('Left', 0)),
                'top': int(props.get('Top', 0)),
                'width': int(props.get('Width', 600)),
                'height': int(props.get('Height', 300)),
            })
    return controls, form_w, form_h


def render_form_layout(form_name, frm_path):
    """Render SVG visual layout of a form from .frm control positions."""
    controls, form_w, form_h = _parse_frm_controls(frm_path)
    if not controls or not form_w: return ''
    e = H.escape
    # Convert twips to pixels (15 twips ≈ 1 pixel)
    scale = 1.0 / 15.0
    svg_w = max(int(form_w * scale), 100)
    svg_h = max(int(form_h * scale), 60)

    # Color map for control types
    colors = {
        'TextBox': '#264f78', 'Label': '#3b3b3b', 'PictureBox': '#1a3a1a',
        'CommandButton': '#4a3060', 'Timer': '#3a3a0a', 'Shape': '#2a2a2a',
        'ComboBox': '#264f78', 'ListBox': '#264f78', 'CheckBox': '#3a3a0a',
        'Frame': '#2a2a3a', 'Image': '#1a3a1a', 'OptionButton': '#3a3a0a',
    }
    border_colors = {
        'TextBox': '#58a6ff', 'Label': '#8b949e', 'PictureBox': '#3fb950',
        'CommandButton': '#bc8cff', 'Timer': '#e3b341', 'Shape': '#484f58',
        'ComboBox': '#58a6ff', 'ListBox': '#58a6ff', 'CheckBox': '#e3b341',
        'Frame': '#8b949e', 'Image': '#3fb950', 'OptionButton': '#e3b341',
    }

    lines = [f'<svg width="{svg_w}" height="{svg_h}" style="background:#161b22;border:1px solid #30363d;border-radius:4px;margin:8px 0">']
    for c in controls:
        x = int(c['left'] * scale)
        y = int(c['top'] * scale)
        w = max(int(c['width'] * scale), 4)
        h = max(int(c['height'] * scale), 4)
        fill = colors.get(c['type'], '#2a2a2a')
        stroke = border_colors.get(c['type'], '#484f58')
        cap = c['caption'][:20] if c['caption'] else c['name'][:15]
        lines.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="{stroke}" stroke-width="1" rx="2"/>')
        # Only add text if control is big enough
        if w > 20 and h > 10:
            tx = x + 3
            ty = y + min(h, 12)
            lines.append(f'<text x="{tx}" y="{ty}" fill="{stroke}" font-size="8" font-family="monospace">{e(cap)}</text>')
    lines.append('</svg>')
    return '\n'.join(lines)
    """Extract and render About/Help dialog text as blockquotes."""
    if not decomp:
        return ''
    funcs = decomp.get('_funcs_by_module', {})
    lines = []
    for mod_name, fn_list in funcs.items():
        for f in fn_list:
            if not re.search(r'about|help', f['name'], re.I):
                continue
            # Extract string literals from the code
            texts = re.findall(r'"([^"]{20,})"', f['code'])
            for t in texts:
                # Skip if it's just a variable name or short
                t = t.replace('vbCrLf', '\n').strip()
                if len(t) > 30 and not t.startswith('loc_'):
                    lines.append(t)
    if not lines:
        return ''
    e = H.escape
    out = ['<h2>&#x1f4ac; About This Program</h2>']
    for t in lines:
        out.append(f'<blockquote>{e(t)}</blockquote>')
    return '\n'.join(out)


def render_about_text(decomp):
    """Extract and render About/Help dialog text as blockquotes."""
    if not decomp: return ''
    funcs = decomp.get('_funcs_by_module', {})
    lines = []
    for mod_name, fn_list in funcs.items():
        for f in fn_list:
            if not re.search(r'about|help', f['name'], re.I): continue
            texts = re.findall(r'"([^"]{20,})"', f['code'])
            for t in texts:
                t = t.replace('vbCrLf', '\n').strip()
                if len(t) > 30 and not t.startswith('loc_'):
                    lines.append(t)
    if not lines: return ''
    e = H.escape
    out = ['<h2>&#x1f4ac; About This Program</h2>']
    for t in lines:
        out.append(f'<blockquote>{e(t)}</blockquote>')
    return '\n'.join(out)


def generate_html(meta, strings, archive_name, html_path):
    """Generate the full HTML page."""
    e = H.escape
    zip_stem = archive_name.replace('.zip', '')
    exe_name = meta.get('exe', '?')

    # Load decompile data if available
    decomp = load_decompile_data(zip_stem, exe_name) if exe_name != '?' else None

    # Build string frequency map (count before dedup)
    str_freq = {}
    for s in strings:
        s = s.strip()
        str_freq[s] = str_freq.get(s, 0) + 1

    # Classify strings (deduplicated)
    seen = set()
    categorized = {'phishing': [], 'author': [], 'credits': [], 'api': [], 'form': [], 'dep': []}
    interesting = []
    other = []
    junk = []

    # Collect greet names early so we can filter them from other sections
    greet_names = set()
    greet_text = []
    SKIP_GREET = {'Greets', 'greets', 'Tahoma', 'Arial', 'Verdana', 'Times New Roman',
                  'Courier New', 'MS Sans Serif', 'Comic Sans MS', 'Microsoft Sans Serif'}
    if decomp:
        dstrings = decomp.get('strings', [])
        in_greets = False
        for ds in dstrings:
            s = ds if isinstance(ds, str) else ds.get('value', '')
            if re.search(r'greets?\s+to', s, re.I):
                in_greets = True
                greet_text.append(s)
                continue
            if in_greets:
                if s in SKIP_GREET: continue
                if len(s) < 30 and not re.search(r'[.!?]$', s):
                    greet_names.add(s)
                else:
                    in_greets = False
                    if len(s) > 5: greet_text.append(s)

    # Decompiled string set for dedup
    decomp_str_set = set()
    if decomp:
        for ds in decomp.get('strings', []):
            decomp_str_set.add(ds if isinstance(ds, str) else ds.get('value', ''))

    for s in strings:
        s = s.strip()
        if not s or s in seen: continue
        seen.add(s)
        if is_pe_artifact(s):
            junk.append(s)
        elif s in greet_names:
            continue  # shown in greet tags
        elif is_phishing(s):
            categorized['phishing'].append(s)
        elif classify(s):
            cls = classify(s)
            # DLLs go to dep, not interesting
            if cls == 'dep':
                categorized['dep'].append(s)
            else:
                categorized[cls].append(s)
        elif is_junk(s):
            junk.append(s)
        elif s in decomp_str_set:
            continue  # shown in decompile sections
        elif is_interesting(s):
            # Filter DLL-like strings from interesting
            if re.match(r'^[\w.-]+\.(dll|ocx|vbx|tlb|olb)$', s, re.I):
                categorized['dep'].append(s)
            else:
                interesting.append(s)
        else:
            other.append(s)

    # Filter author evidence: remove help text, keep only real author signals
    real_author = []
    for s in categorized.get('author', []):
        # Skip generic help/instruction text
        if re.search(r'you can|click on|going to|options>', s, re.I) and not re.search(r'coded by|made by|programmed by|written by|by\s*:', s, re.I):
            interesting.append(s)  # move to interesting instead
        else:
            real_author.append(s)
    categorized['author'] = real_author

    # Build page
    lines = [f'<!DOCTYPE html><html><head><meta charset="utf-8"><title>{e(archive_name)} — Analysis</title>{CSS}</head><body><div class="container">']

    # Hero
    lines.append(render_hero(meta, archive_name, decomp))

    # Screenshots
    ss = render_screenshots(zip_stem, html_path)
    if ss: lines.append(ss)

    # About text from decompiled code
    about = render_about_text(decomp)
    if about: lines.append(about)

    # Phishing
    if categorized['phishing']:
        lines.append(f'<h2>&#x1f3a3; Phishing Template ({len(categorized["phishing"])})</h2>')
        for s in categorized['phishing']:
            lines.append(f'<span class="s phishing-str">{e(s)}</span>')

    # Author evidence (only real signals)
    if categorized['author']:
        lines.append(f'<h2>&#x1f58a; Author Evidence ({len(categorized["author"])})</h2>')
        for s in categorized['author']:
            lines.append(f'<span class="s author-str">{e(s)}</span>')

    # Greets
    lines.append(render_greets(sorted(greet_names), greet_text))

    # API refs split into subsections
    lines.append(render_api_refs(categorized['api']))

    # Forms & Controls with SVG layouts
    lines.append(render_forms(decomp, zip_stem, exe_name))

    # Functions (progressive disclosure)
    lines.append(render_functions(decomp))

    # Dependencies from DB (structured)
    deps_html = render_deps_from_db(zip_stem)
    if deps_html:
        lines.append(deps_html)
    elif categorized['dep']:
        lines.append(f'<h2>&#x1f4e6; Dependencies ({len(categorized["dep"])})</h2>')
        for s in categorized['dep']:
            lines.append(f'<span class="s dep-str">{e(s)}</span>')

    # Decompiled project info
    if decomp:
        proj = decomp.get('project', {})
        lines.append('<h2>&#x1f4cb; Project Info</h2>')
        lines.append('<div class="card">')
        info_parts = []
        if proj.get('startup'): info_parts.append(f'Startup: {e(proj["startup"])}')
        ver = '.'.join(filter(None, [proj.get('major_ver'), proj.get('minor_ver'), proj.get('revision_ver')]))
        if ver: info_parts.append(f'Version: {e(ver)}')
        if proj.get('company') and proj['company'] != '?': info_parts.append(f'Company: {e(proj["company"])}')
        ct = decomp.get('compile_type', '')
        if ct: info_parts.append(f'Compile: {e(ct)}')
        if decomp.get('is_packed'): info_parts.append('Packed: Yes')
        lines.append(' · '.join(info_parts) if info_parts else 'No project info')
        lines.append('</div>')

    # Interesting strings with frequency
    if interesting:
        lines.append(f'<h2>&#x2b50; Interesting Strings ({len(interesting)})</h2>')
        for s in interesting:
            freq = str_freq.get(s, 1)
            freq_badge = f' <span style="color:#484f58;font-size:0.75em">×{freq}</span>' if freq > 1 else ''
            lines.append(f'<span class="s interesting-str">{e(s)}{freq_badge}</span>')

    # Other (collapsed)
    if other:
        lines.append(f'<details><summary style="color:#484f58;font-size:0.85em">Other Strings ({len(other)})</summary>')
        for s in other:
            freq = str_freq.get(s, 1)
            freq_badge = f' <span style="color:#30363d;font-size:0.75em">×{freq}</span>' if freq > 1 else ''
            lines.append(f'<span class="s plain-str">{e(s)}{freq_badge}</span>')
        lines.append('</details>')

    # Stats footer
    total = len(seen)
    lines.append(f'<div class="stats">Total unique strings: {total} · Interesting: {len(interesting)} · Noise filtered: {len(junk)}</div>')
    lines.append('</div></body></html>')
    return '\n'.join(lines)


def main() -> int:
    if not DB_PATH.exists():
        print(f"Error: {DB_PATH} not found", file=sys.stderr)
        return 1

    conn = sqlite3.connect(str(DB_PATH))
    generated = skipped = 0

    # Support single-file mode
    if len(sys.argv) > 1:
        target = Path(sys.argv[1])
        html_files = [target] if target.exists() else []
    else:
        html_files = sorted(SORTED_DIR.rglob("*.html"))

    total = len(html_files)
    print(f"Processing {total} HTML pages", file=sys.stderr)

    for i, html_path in enumerate(html_files):
        meta = get_meta_from_db(html_path.stem) or parse_existing_meta(html_path)
        exe_name = meta.get('exe', '')
        archive_name = html_path.stem + '.zip'
        archive_base = html_path.stem

        exe_path = find_exe_in_db(conn, exe_name, archive_base)
        if not exe_path:
            skipped += 1
            continue

        strings = get_strings_from_db(conn, exe_path)
        if not strings:
            skipped += 1
            continue

        page = generate_html(meta, strings, archive_name, html_path)
        html_path.write_text(page, encoding='utf-8')
        generated += 1

        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{total} processed, {generated} regenerated", file=sys.stderr)

    conn.close()
    print(f"Done: {generated} regenerated, {skipped} skipped")
    return 0


if __name__ == '__main__':
    sys.exit(main())
