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
import subprocess
import sys
import html as H
from pathlib import Path

SORTED_DIR = Path("programs/AOL/proggies-sorted-deduped")
DB_PATH = Path("exe_strings.db")
DECOMPILED_DIR = Path("decompiled")

# AOL API → version range mapping
# Evidence: strings extracted from installed AOL 2.5, 4.0, 5.0 binaries (2026-03-24)
# Classes marked 2.5+ verified in C:\AOL25A\TOOL\MANAGER.AOL / MORG.AOL / JGAOL.DLL
# Classes marked 4.0+ first appear in C:\America Online 4.0\objwrap.dll
# Upper bounds unknown beyond 5.0 — using proggie DB evidence for later versions
AOL_API_VERSIONS = {
    'AOL Frame25': '2.5–3.0', 'AOL Frame': '4.0+',
    '_AOL_Button': '2.5+', '_AOL_Combobox': '2.5+',
    '_AOL_Edit': '2.5+', '_AOL_Glyph': '2.5+',
    '_AOL_Icon': '2.5+', '_AOL_Listbox': '2.5+',
    '_AOL_Modal': '2.5+', '_AOL_Palette': '2.5+',
    '_AOL_Spin': '2.5+', '_AOL_Static': '2.5+',
    '_AOL_View': '2.5+', '_AOL_Tree': '2.5+',
    '_AOL_Checkbox': '4.0+', '_AOL_FontCombo': '4.0+',
    '_AOL_Timer': '6.0+', '_AOL_Icone': '6.0+',
    '_AOL_RadioBox': '6.0+',
    'AOL Child': '4.0+', 'AOL Toolbar': '4.0+',
    'RICHCNTL': '2.5+', 'MDIClient': '2.5+',
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
    r'^(?:_adj_f|_CI|__vba|EVENT_SINK_|DllFunctionCall$|_allmul$|'
    r'TDESTap|040904B0$|[0-9a-f]{6,}$|'
    r'MethCallEngine$|ProcCallEngine$|'
    r'C:\\Program Files\\Microsoft Visual Studio\\|'
    r'A\*\\A[A-Z]:\\)'
)

HIGHLIGHT_PATTERNS = [
    # Author patterns — no .+ needed, we just detect presence then use the full string
    (re.compile(r'\b(?:coded|programmed|made|created|written|designed|developed)\s+by\b', re.I), 'author'),
    (re.compile(r'\bby\s*:\s*\S', re.I), 'author'),
    (re.compile(r'\b(?:author|coder|programmer)\s*:', re.I), 'author'),
    (re.compile(r'\bpresents\b', re.I), 'author'),
    (re.compile(r'\b(?:credits?|greets?|greetz)\b', re.I), 'credits'),
    (re.compile(r'AOL Frame|AOL Child|_AOL_\w+|FindWindow\w*|SendMessage\w*|SetWindowText', re.I), 'api'),
    (re.compile(r'frm\w+\.FRM|\.FRM\b', re.I), 'form'),
    (re.compile(r'MSVBVM\d+|VB\d+RUN|\.ocx|\.vbx', re.I), 'dep'),
]

PHISHING_RE = re.compile(
    r'(?:billing\s+(?:dept|rep|department|info)|credit\s+card\s+(?:number|info)|'
    r'expiration\s+date|log.?on\s+password|click\s+respond|'
    r'verify\s+(?:your|that\s+you)|re-?verify|account\s+(?:will\s+be\s+(?:credited|deleted|terminated)|deletion)|'
    r'enter\s+your\s+(?:log|password|full\s+name|screen)|'
    r'we\s+(?:have\s+lost|seem\s+to\s+have|need\s+you\s+to)|'
    r'failure\s+to\s+(?:respond|comply)|terminate\s+your\s+account|'
    r'bank\s+name|billing\s+information|'
    r'dear\s+(?:aol\s+)?(?:member|user|customer)|(?:screen\s*name|s/?n)\s+and\s+password)',
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
    # Binary art: dominated by /oO@`_?PpP0 and spaces
    art_chars = sum(1 for c in s if c in '/oO@`_?Pp0 ')
    if len(s) >= 8 and art_chars / len(s) > 0.75: return True
    # Short fragments with mostly non-alpha
    if len(s) <= 8:
        alpha = sum(1 for c in s if c.isalpha())
        if alpha / len(s) < 0.6: return True
    # Short asm-like: "Qj h", "jPh R@", "h ]@"
    if len(s) <= 10 and re.match(r'^[A-Za-z]{1,2}[jhJH ]+[A-Za-z@\[\]\\^ ]*$', s): return True
    # VB control/menu names: camelCase identifiers like lblStop, options_greets
    if re.match(r'^(?:lbl|txt|cmd|opt|chk|frm|pic|tmr|lst|cbo|hsb|vsb|img|shp|drv|dir|fil)[A-Z]\w*$', s, re.I): return True
    if re.match(r'^(?:options|menu|mnu)_\w+$', s, re.I): return True
    if re.match(r'^(?:mod|cls|bas)\w+$', s) and len(s) <= 20: return True
    if re.match(r'^(?:Picture|Text|Label|Command|Frame|Timer|Image|List|Combo)\d+$', s): return True
    if re.match(r'^Project\d*$', s): return True
    # Font names with trailing junk
    if re.match(r'^(?:Tahoma|Arial|Verdana|Courier|Times|Comic|Microsoft|MS Sans)\w*\d*$', s, re.I): return True
    # Path fragments
    if re.match(r'^[\w]*\\+$', s): return True
    # Truncated label fragments: "loads [", "tries ["
    if re.match(r'^\w+\s*\[$', s): return True
    # Bare internal names (no spaces, short, lowercase)
    if re.match(r'^[a-z][a-z0-9]+$', s) and len(s) <= 15: return True
    # Short fragments without full words
    if len(s) <= 8 and not re.search(r'[A-Za-z]{4}', s): return True
    # Bare exe/project names
    if re.match(r'^\w+\.exe$', s, re.I): return True
    return False

def classify(s: str) -> str | None:
    for pat, cls in HIGHLIGHT_PATTERNS:
        if pat.search(s): return cls
    return None

def is_interesting(s: str) -> bool:
    # Must have actual words (3+ alpha chars in a row)
    if not re.search(r'[A-Za-z]{3}', s): return False
    if re.search(r'v\d|version|\d\.\d', s, re.I): return True
    if re.search(r'\.\w{2,4}$', s) and len(s) >= 6: return True
    # Sentences / phrases with real words
    if ' ' in s and len(s) >= 12:
        alpha = sum(1 for c in s if c.isalpha())
        if alpha / len(s) > 0.5: return True
    # Bracketed labels like [Loaded], [stop]
    if re.match(r'\[.{3,}\]$', s): return True
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


def get_meta_from_db(zip_stem, conn=None):
    """Get metadata from proggie_db.sqlite — primary source."""
    own_conn = conn is None
    if own_conn:
        db = Path("proggie_db.sqlite")
        if not db.exists(): return None
        conn = sqlite3.connect(str(db))
    row = conn.execute(
        "SELECT p.name, p.author, p.aol_version, p.category, e.exe_name, e.vb_version, e.compile_type, e.exe_path, p.zip_path "
        "FROM proggies p LEFT JOIN exes e ON e.proggie_id = p.id WHERE p.zip_stem = ? LIMIT 1",
        (zip_stem,)
    ).fetchone()
    if own_conn: conn.close()
    if not row: return None
    meta = {
        'program': row[0] or zip_stem, 'author': row[1] or 'Unknown',
        'aol_version': row[2] or '?', 'category': row[3] or '?',
        'exe': row[4] or '?', 'vb': row[5] or '?', 'compile': row[6] or '?',
        'zip_path': row[8] or '',
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
    """Return all strings (with duplicates for frequency counting). Cap at 5000 to avoid pathological regex on bloated exes."""
    rows = conn.execute("SELECT value FROM strings WHERE exe_path = ? ORDER BY id LIMIT 5000", (exe_path,)).fetchall()
    return [v.strip() for (v,) in rows if v.strip()]


def _build_exe_path_index(conn):
    """Build basename->paths lookup from exe_strings.db (once, ~0.7s)."""
    from collections import defaultdict
    idx = defaultdict(list)
    for (p,) in conn.execute("SELECT DISTINCT exe_path FROM strings"):
        idx[os.path.basename(p).lower()].append(p)
    return dict(idx)

# Module-level cache, populated on first use or by workers
_exe_path_index = None

def find_exe_in_db(conn, exe_name, archive_base):
    global _exe_path_index
    if not exe_name or exe_name == '?': return None
    if _exe_path_index is None:
        _exe_path_index = _build_exe_path_index(conn)
    candidates = _exe_path_index.get(exe_name.lower(), [])
    if len(candidates) == 1: return candidates[0]
    # Prefer AOL proggies paths over AIM or other
    aol = [p for p in candidates if 'proggies/' in p.lower()]
    pool = aol or candidates
    for p in pool:
        if archive_base.lower() in p.lower(): return p
    return pool[0] if pool else None


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
.breakdown-bar{display:flex;height:24px;border-radius:6px;overflow:hidden;margin:8px 0;border:1px solid #30363d}
.breakdown-bar div{display:flex;align-items:center;justify-content:center;font-size:0.7em;font-weight:bold;color:#fff;min-width:30px}
.bar-app{background:#238636}
.bar-used{background:#8957e5}
.bar-dead{background:#21262d;color:#484f58 !important}
.breakdown-legend{display:flex;flex-wrap:wrap;gap:12px;margin:8px 0;font-size:0.8em;color:#8b949e}
.dot{display:inline-block;width:10px;height:10px;border-radius:50%;margin-right:4px;vertical-align:middle}
.dot-app{background:#238636}
.dot-used{background:#8957e5}
.dot-dead{background:#21262d;border:1px solid #484f58}
details{margin:4px 0}
summary{cursor:pointer}
summary:hover{color:#58a6ff}
.screenshot{margin:12px 0}
.screenshot img{max-width:100%;border:1px solid #30363d;border-radius:6px}
.screenshot .caption{color:#484f58;font-size:0.8em;margin-top:4px}
.ocr-text{color:#8b949e;font-size:0.8em;margin:4px 0;padding:4px 8px;background:#0d1117;border:1px solid #21262d;border-radius:4px;white-space:pre-wrap;font-family:monospace}
@media print{body{background:#fff;color:#000}.hero{background:#f6f8fa;border-color:#d0d7de}.card{border-color:#d0d7de}}
@media(max-width:600px){body{padding:10px}.hero h1{font-size:1.3em}}
.topnav{display:flex;justify-content:space-between;align-items:center;padding:8px 0;margin-bottom:16px;border-bottom:1px solid #21262d;font-size:0.85em}
.topnav a{color:#58a6ff;text-decoration:none}
.topnav a:hover{text-decoration:underline}
.topnav .dl-btn{background:#238636;color:#fff;padding:4px 12px;border-radius:6px;font-weight:600}
.topnav .dl-btn:hover{background:#2ea043;text-decoration:none}
</style>"""

GITHUB_RAW = "https://github.com/ssstonebraker/aolunderground-proggies/raw/main/"


def _extract_program_name(decomp):
    """Try to extract real program name from decompiled data."""
    cb = decomp.get('code_breakdown') or {}
    # Method 1: "About <name>" in decompiled strings
    for s in decomp.get('strings', []):
        v = s if isinstance(s, str) else s.get('value', '')
        m = re.match(r'About\s+(.+?)[\s\-:]*$', v)
        if m and 4 <= len(m.group(1)) <= 40:
            return m.group(1).strip()
    # Method 2: ChatSend announcement in Form_Load
    for f in cb.get('app_functions', []):
        if 'Form_Load' not in f.get('name', ''):
            continue
        m = re.search(r'(?:ChatSend|Proc_1_36\w*)\("([^"]+)"', f.get('code', ''))
        if m:
            raw = m.group(1)
            clean = re.sub(r'[\u0080-\u00bf\u0095\u0086\u00b7()\[\]]+', ' ', raw).strip()
            clean = re.sub(r'\s*(Loaded|loaded)\s*$', '', clean).strip()
            if len(clean) >= 4:
                return clean
        break
    return None


def render_hero(meta, archive_name, decomp):
    e = H.escape
    program = meta.get('program', archive_name.replace('.zip', ''))
    author = meta.get('author', 'Unknown')

    # Try to extract real program name from decompiled source
    if decomp:
        proj_name = (decomp.get('project') or {}).get('name', '')
        if proj_name:
            program = proj_name
        elif program == meta.get('exe', '').replace('.exe', ''):
            program = _extract_program_name(decomp) or program
    author = meta.get('author', 'Unknown')
    version = meta.get('aol_version', '?')
    cat = meta.get('category', '?')
    exe = meta.get('exe', '?')
    vb = meta.get('vb', '?')
    compile_type = meta.get('compile', '?')

    # Fall back to decompile metadata for VB version / compile type
    if decomp:
        if vb == '?': vb = decomp.get('vb_version', '?')
        if compile_type == '?': compile_type = decomp.get('compile_type', '?')

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
    # Exe name badge — fall back to decomp exe_name
    exe_display = exe
    if exe_display == '?' and decomp:
        exe_display = decomp.get('exe_name', '?')
    if exe_display != '?':
        lines.append(f'<span class="badge" style="background:#1a1a2a;color:#8b949e;border:1px solid #30363d">{e(exe_display)}</span>')
    compile_date = meta.get('compile_date')
    if compile_date:
        lines.append(f'<span class="badge" style="background:#1a2a1a;color:#8b949e;border:1px solid #30363d">Compiled {e(compile_date)}</span>')
    if decomp and decomp.get('has_original_source'):
        lines.append('<span class="badge" style="background:#1a2a1a;color:#3fb950;border:1px solid #238636">Original Source Code</span>')
    # Base module badges from decompile data (skip for original source — all modules are app code)
    if decomp and not decomp.get('has_original_source'):
        for bas in decomp.get('bas_modules', []):
            known = decomp.get('base_module')
            if known and known.get('name', '').lower() == bas.lower():
                # Known shared module — highlight it
                lines.append(f'<span class="badge" style="background:#2a1a2a;color:#d2a8ff;border:1px solid #8b5cf6" title="Known AOL base module by {e(known.get("author","?"))} ({e(known.get("era","?"))})">{e(bas)}</span>')
            else:
                lines.append(f'<span class="badge" style="background:#1a1a2a;color:#79c0ff;border:1px solid #1f6feb">{e(bas)}</span>')
    lines.append('</div></div>')
    return '\n'.join(lines)


def _ocr_screenshot(img_path):
    """OCR a screenshot, upscaling first for better results on small images."""
    try:
        import tempfile
        with tempfile.NamedTemporaryFile(suffix='.png', delete=False) as tmp:
            tmp_path = tmp.name
        subprocess.run(
            ['convert', str(img_path), '-resize', '400%', tmp_path],
            capture_output=True, timeout=10
        )
        r = subprocess.run(
            ['tesseract', tmp_path, 'stdout', '--psm', '4'],
            capture_output=True, timeout=10
        )
        os.unlink(tmp_path)
        return r.stdout.decode('utf-8', errors='replace').strip() if r.returncode == 0 else ''
    except Exception:
        return ''


def render_screenshots(zip_stem, html_path):
    """Render interactive app simulator or fallback screenshot gallery."""
    img_dir = html_path.parent / zip_stem
    if not img_dir.exists():
        return ''
    lines = ['<section class="screenshot">']
    found = False
    import json as _json

    wt_path = img_dir / 'walkthrough.json'
    if wt_path.exists():
        wt = _json.loads(wt_path.read_text())
        if isinstance(wt, list):
            categories, form_info, label_info = wt, None, None
        else:
            categories = wt.get('categories', [])
            form_info, label_info = wt.get('form'), wt.get('labels', {})

        if form_info and label_info and (img_dir / form_info.get('image', '')).exists():
            fw, fh = form_info['width'], form_info['height']
            nc_x, nc_y = form_info.get('nc_x', 3), form_info.get('nc_y', 3)
            form_img = f'{zip_stem}/{form_info["image"]}'
            main_in_shot_x = form_info.get('screen_x', 0) - form_info.get('crop_x0', 0)
            sorted_labels = sorted(label_info.items(), key=lambda kv: kv[1]['left'])

            cat_data = []
            for ci, cat in enumerate(categories):
                items_js = []
                for item in cat['items']:
                    img_name = item.get('image', '')
                    exists = (img_dir / img_name).exists() if img_name else False
                    d = {'caption': item['caption'],
                         'image': f'{zip_stem}/{img_name}' if exists else '',
                         'type': item.get('type', '')}
                    if item.get('child_h') and item['child_h'] < 460:
                        d['ch'] = item['child_h']
                    if item.get('child_title'):
                        d['ct'] = item['child_title']
                    items_js.append(d)
                lbl = sorted_labels[ci][1] if ci < len(sorted_labels) else None
                cat_data.append({'name': cat['category'], 'items': items_js, 'label': lbl})

            # Stage: flexbox — main form left, child forms right
            lines.append(f'<div class="app-sim">')
            lines.append(f'<div class="app-sim-hint">&#x1f5b1; Click the menu labels to explore this proggie</div>')
            lines.append(f'<div class="app-stage" id="app-stage">')
            lines.append(f'<div class="app-form" id="app-form" style="width:{fw}px;height:{fh}px;position:relative;flex-shrink:0">')
            lines.append(f'<img src="{form_img}" width="{fw}" height="{fh}" draggable="false">')
            for ci, cd in enumerate(cat_data):
                if cd['label']:
                    l = cd['label']
                    lines.append(f'<div class="app-label" data-cat="{ci}" style="left:{nc_x+l["left"]}px;top:{nc_y+l["top"]}px;width:{l["width"]}px;height:{l["height"]}px"></div>')
            lines.append('<div class="app-popup" id="app-popup"></div>')
            lines.append('</div>')
            lines.append(f'<div class="app-child" id="app-child" data-cw="{main_in_shot_x - 8}"></div>')
            lines.append('</div>')
            gif_path = img_dir / 'animated.gif'
            if gif_path.exists():
                lines.append(f'<details class="app-gif-toggle"><summary>&#x25b6; Watch animated walkthrough</summary>'
                             f'<img src="{zip_stem}/animated.gif" loading="lazy"></details>')
            lines.append('</div>')

            greets = wt.get('greets', [])
            lines.append(f'<script>var appCats={_json.dumps(cat_data)},mainX={main_in_shot_x},greetNames={_json.dumps(greets)};')
            lines.append(r'''
var openCat=-1,popup=document.getElementById("app-popup"),
    childEl=document.getElementById("app-child");
var cw=+childEl.dataset.cw;
document.querySelectorAll(".app-label").forEach(function(el){
  el.addEventListener("click",function(e){
    e.stopPropagation();
    var ci=+this.dataset.cat;
    if(openCat===ci){closePopup();return}
    openCat=ci;
    var cat=appCats[ci],lbl=cat.label,h="";
    cat.items.forEach(function(it,i){
      if(it.type==="secret")return;
      h+='<div class="app-mi" data-ci="'+ci+'" data-ii="'+i+'">'+
        it.caption.replace(/</g,"&lt;")+'</div>';
    });
    popup.innerHTML=h;
    popup.style.left=(lbl.left+3)+"px";
    popup.style.top=(lbl.top+lbl.height+6)+"px";
    popup.style.display="block";
    popup.querySelectorAll(".app-mi").forEach(function(mi){
      mi.addEventListener("click",function(ev){
        ev.stopPropagation();
        showChild(appCats[+this.dataset.ci].items[+this.dataset.ii]);
        closePopup();
      });
    });
  });
});
document.addEventListener("click",function(){closePopup()});
function closePopup(){popup.style.display="none";openCat=-1}
function showChild(it){
  var cap=it.caption.replace(/</g,"&lt;");
  var bar='<div class="app-ct">'+cap+' <button onclick="hideChild()" title="Close">✕</button></div>';
  if(!it.image){
    childEl.innerHTML=bar+'<div class="app-noshot">&#x1f4f7; Screenshot not captured &mdash; dialog overlapped main form</div>';
    return;
  }
  var h=it.ch?'height:'+it.ch+'px;':'';
  var bar='<div class="app-ct">'+cap+' <button onclick="hideChild()" title="Close">✕</button></div>';
  if(it.caption==="Greets"&&greetNames.length){
    var names=greetNames.map(function(n){return'<span>'+n+'</span>'}).join('');
    childEl.innerHTML=bar+
      '<div class="app-cc app-greets" style="max-width:'+cw+'px;'+h+'"><img src="'+it.image+'" style="max-width:none">'+
      '<div class="greets-scroll"><div class="greets-track">'+names+names+'</div></div></div>';
  } else {
    childEl.innerHTML=bar+
      '<div class="app-cc" style="max-width:'+cw+'px;'+h+'"><img src="'+it.image+'" style="max-width:none"></div>';
  }
}
function hideChild(){childEl.innerHTML=""}
</script>''')
            lines.append('''<style>
.app-sim{margin:16px 0}
.app-sim-hint{color:#8b949e;font-size:0.8em;margin-bottom:8px}
.app-stage{display:flex;align-items:flex-start;gap:12px;background:#0d1117;border:1px solid #30363d;border-radius:6px;padding:8px}
.app-form{user-select:none;position:relative}
.app-form>img{display:block}
.app-label{position:absolute;cursor:pointer;border-radius:2px}
.app-label:hover{background:rgba(255,255,255,0.18)}
.app-popup{display:none;position:absolute;background:#fff;border:1px solid #999;box-shadow:2px 2px 6px rgba(0,0,0,.3);z-index:20;min-width:140px;padding:2px 0}
.app-mi{padding:3px 24px 3px 20px;font:13px/1.4 "Segoe UI",Tahoma,sans-serif;color:#000;cursor:default;white-space:nowrap}
.app-mi:hover{background:#0078d4;color:#fff}
.app-child{min-width:0;flex:1;overflow:hidden}
.app-ct{color:#8b949e;font-size:.78em;margin-bottom:3px;display:flex;align-items:center;gap:6px}
.app-ct button{background:none;border:none;color:#8b949e;cursor:pointer;font-size:.95em;padding:0}
.app-ct button:hover{color:#f85149}
.app-cc{overflow:hidden;border-radius:4px;border:1px solid #30363d;max-height:350px}
.app-noshot{color:#8b949e;font-size:.85em;padding:24px 16px;border:1px dashed #30363d;border-radius:4px}
.app-cc img{display:block}
.app-gif-toggle{margin-top:8px;color:#8b949e;font-size:.85em}
.app-gif-toggle summary{padding:4px 0;cursor:pointer}
.app-gif-toggle img{max-width:100%;margin-top:6px;border-radius:4px;border:1px solid #30363d}
.app-greets{position:relative}
.greets-scroll{position:absolute;bottom:8px;left:0;right:0;overflow:hidden;height:1.4em}
.greets-track{display:flex;gap:2em;white-space:nowrap;animation:greets-marquee 20s linear infinite;
  font:bold 13px/1.4 "Tahoma",sans-serif;color:#fff;text-shadow:0 0 6px #000,0 0 3px #900}
.greets-track span{flex-shrink:0}
@keyframes greets-marquee{0%{transform:translateX(0)}100%{transform:translateX(-50%)}}
</style>''')
            found = True
        elif categories:
            # Fallback: tab-based explorer
            lines.append('<div class="walkthrough-explorer">')
            lines.append('<div class="wt-tabs">')
            for ci, cat in enumerate(categories):
                active = ' active' if ci == 0 else ''
                lines.append(f'<button class="wt-tab{active}" onclick="wtTab(this,{ci})">{H.escape(cat["category"])}</button>')
            lines.append('</div>')
            for ci, cat in enumerate(categories):
                vis = '' if ci == 0 else ' style="display:none"'
                lines.append(f'<div class="wt-panel" id="wt-panel-{ci}"{vis}>')
                for item in cat['items']:
                    img_name = item.get('image', '')
                    cap = H.escape(item['caption'])
                    lines.append(f'<div class="wt-item" onclick="wtShow(this)"><span class="wt-label">{cap}</span>')
                    if (img_dir / img_name).exists():
                        lines.append(f'<img class="wt-img" src="{zip_stem}/{img_name}" alt="{cap}" loading="lazy" style="display:none">')
                    lines.append('</div>')
                lines.append('</div>')
            lines.append('</div>')
            lines.append('''<script>
function wtTab(b,ci){b.parentElement.querySelectorAll('.wt-tab').forEach(x=>x.classList.remove('active'));b.classList.add('active');document.querySelectorAll('.wt-panel').forEach((p,i)=>p.style.display=i===ci?'':'none')}
function wtShow(el){var i=el.querySelector('.wt-img');if(i)i.style.display=i.style.display==='none'?'':'none'}
</script><style>
.walkthrough-explorer{margin:12px 0;border:1px solid #30363d;border-radius:6px;overflow:hidden}
.wt-tabs{display:flex;background:#161b22;border-bottom:1px solid #30363d}
.wt-tab{background:none;border:none;color:#8b949e;padding:8px 14px;cursor:pointer;font-size:.85em}
.wt-tab.active{color:#58a6ff;border-bottom:2px solid #58a6ff}
.wt-panel{padding:8px}
.wt-item{cursor:pointer;padding:4px 8px;border-radius:4px;margin:2px 0}
.wt-item:hover{background:#21262d}
.wt-label{color:#c9d1d9;font-size:.85em}
.wt-img{margin:8px 0;max-width:100%;border-radius:4px;border:1px solid #30363d}
</style>''')
            found = True

    # Static screenshots only if no interactive widget
    if not found:
        for name, caption in [('screenshot.png', 'Main window'), ('animated.gif', 'Navigation walkthrough')]:
            if (img_dir / name).exists():
                lines.append(f'<img src="{zip_stem}/{name}" alt="{caption}"><div class="caption">{caption}</div>')
                found = True
        screens = sorted(img_dir.glob('screen_*.png'))
        if screens:
            lines.append('<details><summary style="color:#8b949e;font-size:.85em;margin-top:8px">Individual screenshots</summary>')
            for img in screens:
                label = img.stem.replace('screen_', '').replace('_', ' ').title()
                lines.append(f'<div style="margin:8px 0"><img src="{zip_stem}/{img.name}" alt="{label}"><div class="caption">{label}</div></div>')
            lines.append('</details>')
            found = True
        installs = sorted(img_dir.glob('install_*.png'))
        if installs:
            _inst_labels = {
                'welcome': 'Welcome', 'directory': 'Select Directory', 'overwrite': 'Overwrite Prompt',
                'searching': 'Searching for VBRUN300.DLL', 'need_vbrun': 'VBRUN300.DLL Required',
                'features_irc': 'New Features & IRC Setup', 'disclaimer': 'Disclaimer',
                'complete': 'Installation Complete', 'startmenu': 'Start Menu Shortcuts',
            }
            lines.append('<details><summary style="color:#8b949e;font-size:.85em;margin-top:8px">Installer screenshots</summary>')
            for img in installs:
                key = img.stem.replace('install_', '')
                label = _inst_labels.get(key, key.replace('_', ' ').title())
                lines.append(f'<div style="margin:8px 0"><img src="{zip_stem}/{img.name}" alt="{label}"><div class="caption">{label}</div></div>')
            lines.append('</details>')
            found = True
    lines.append('</section>')
    return '\n'.join(lines) if found else ''


def render_forms(decomp, zip_stem=None, exe_name=None):
    """Render forms as structured cards with control tables, menu trees, and SVG layouts."""
    if not decomp or not decomp.get('forms'):
        return ''
    e = H.escape

    # Build OCR caption lookup from code_breakdown
    ocr_captions = {}
    cb = decomp.get('code_breakdown') or {}
    for f in cb.get('app_functions', []):
        m = re.match(r'(\w+?)_\w+\(', f['name'])
        if m and f.get('control_caption'):
            ocr_captions[m.group(1).lower()] = f['control_caption']

    lines = ['<h2>&#x1f5bc; Forms &amp; Controls</h2>']
    form_count = len(decomp['forms'])
    ctrl_count = sum(len(f.get('controls', [])) for f in decomp['forms'])
    lines.append(f'<details><summary>{form_count} forms, {ctrl_count} controls</summary>')
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
            lines.append('<table class="ctrl-table"><tr><th>Type</th><th>Name</th><th>Caption/Text</th></tr>')
            for c in controls:
                cap = c.get('caption', '') or c.get('text', '') or ocr_captions.get(c['name'].lower(), '')
                if cap:
                    cap_html = e(cap)
                else:
                    cap_html = '<span style="color:#30363d">—</span>'
                lines.append(f'<tr><td>{e(c["type"])}</td><td>{e(c["name"])}</td><td>{cap_html}</td></tr>')
            lines.append('</table>')
        menus = form.get('menus', [])
        if menus:
            lines.append('<div style="margin-top:8px;color:#8b949e;font-size:0.85em">Menu:</div>')
            lines.append(_render_menu_tree(menus))
        timers = form.get('timers', [])
        if timers:
            lines.append(f'<div style="margin-top:6px;color:#484f58;font-size:0.8em">Timers: {", ".join(e(t["name"]) if isinstance(t, dict) else e(t) for t in timers)}</div>')
        lines.append('</div>')
    lines.append('</details>')
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


def _make_proc_resolver(decomp):
    """Build a proc name resolver from decompile metadata.

    Returns (replace_in_code, resolve_name) tuple:
    - replace_in_code(code_text) → HTML with Proc_ refs replaced by colored spans
    - resolve_name(raw_name) → resolved canonical name string
    """
    if not decomp:
        return (lambda t: H.escape(t), lambda n: n)
    cb = decomp.get('code_breakdown') or {}
    proc_names = cb.get('proc_names', {})
    addr_names = decomp.get('addr_to_name', {})
    e = H.escape

    def resolve_name(raw_name):
        m = re.match(r'(Proc_\d+)_(\d+)_([A-F0-9]+)', raw_name)
        if not m:
            return raw_name
        short = f'{m.group(1)}_{m.group(2)}'
        return proc_names.get(short) or addr_names.get(m.group(3)) or raw_name

    def replace_in_code(code_text):
        from clean_code import clean_for_display
        cleaned = clean_for_display(code_text)
        escaped = e(cleaned)
        def _sub(m):
            short = f'{m.group(1)}_{m.group(2)}'
            addr = m.group(3)
            canon = proc_names.get(short) or addr_names.get(addr)
            if canon:
                return f'<span style="color:#d2a8ff" title="{m.group(0)}">{canon}</span>'
            return m.group(0)
        return re.sub(r'(Proc_\d+)_(\d+)_([A-F0-9]+)', _sub, escaped)

    return replace_in_code, resolve_name


def render_functions(decomp):
    """Render functions with progressive disclosure — collapsed by default."""
    if not decomp:
        return ''
    funcs_by_mod = decomp.get('_funcs_by_module', {})
    if not funcs_by_mod:
        return ''
    e = H.escape
    replace_in_code, resolve_name = _make_proc_resolver(decomp)
    lines = ['<h2>&#x1f4dc; Decompiled Functions</h2>']
    for mod_name, funcs in funcs_by_mod.items():
        lines.append(f'<details class="fn-group"><summary><b>{e(mod_name)}</b> ({len(funcs)} functions)</summary>')
        for f in funcs:
            name = f['name']
            # Clean up display name
            display = re.sub(r"^(?:Private |Public )?(?:Sub |Function )", '', name)
            display = re.sub(r"\s*'[0-9A-Fa-f]+$", '', display)  # strip address comment
            display = resolve_name(display)
            sz = f['size']
            sz_label = f'{sz}b' if sz < 1024 else f'{sz/1024:.1f}KB'
            lines.append(f'<details class="fn-item"><summary>{e(display)} <span class="sz">{sz_label}</span></summary>')
            lines.append(f'<pre>{replace_in_code(f["code"])}</pre>')
            lines.append('</details>')
        lines.append('</details>')
    return '\n'.join(lines)


def render_code_breakdown(decomp):
    """Render code breakdown: base module vs app code with collapsible source."""
    if not decomp:
        return ''
    cb = decomp.get('code_breakdown')
    if not cb:
        return ''
    e = H.escape
    bas_modules = decomp.get('bas_modules', [])
    bas_label = ', '.join(bas_modules) if bas_modules else 'base module'

    _replace_procs, _resolve_name = _make_proc_resolver(decomp)

    lines = ['<h2>&#x1f4ca; Code Breakdown</h2>']

    # Stacked bar
    app_pct, used_pct, dead_pct = cb['app_pct'], cb['reachable_pct'], cb['dead_pct']
    cherry = cb.get('cherry_picked', [])
    cherry_size = sum(f['size'] for f in cherry)
    total_size = cb.get('total_size', 1)
    cherry_pct = round(100 * cherry_size / total_size, 1) if total_size and cherry else 0
    # Adjust: cherry comes out of app_pct (since those funcs were counted as app code)
    adj_app_pct = round(app_pct - cherry_pct, 1) if cherry_pct else app_pct

    lines.append('<div class="breakdown-bar">')
    if adj_app_pct > 0:
        lines.append(f'<div class="bar-app" style="width:{adj_app_pct}%" title="App code: {adj_app_pct}%">{adj_app_pct}%</div>')
    if cherry_pct > 0:
        lines.append(f'<div style="width:{cherry_pct}%;background:#1f3a1f;color:#3fb950;text-align:center;font-size:0.75em;line-height:24px" title="Cherry-picked from known modules: {cherry_pct}%">{cherry_pct}%</div>')
    if used_pct > 0:
        lines.append(f'<div class="bar-used" style="width:{used_pct}%" title="Used {e(bas_label)}: {used_pct}%">{used_pct}%</div>')
    if dead_pct > 0:
        lines.append(f'<div class="bar-dead" style="width:{dead_pct}%" title="Unused {e(bas_label)}: {dead_pct}%">{dead_pct}%</div>')
    lines.append('</div>')

    # Legend
    lines.append('<div class="breakdown-legend">')
    lines.append(f'<span><span class="dot dot-app"></span>Custom code — {cb["app_funcs_count"]} funcs ({adj_app_pct}%)</span>')
    if cherry_pct > 0:
        mods = sorted(set(f['matched_module'] for f in cherry))
        lines.append(f'<span><span class="dot" style="background:#3fb950"></span>Cherry-picked from {", ".join(mods)}.bas — {len(cherry)} funcs ({cherry_pct}%)</span>')
    if used_pct > 0:
        remaining_used = cb["reachable_base_funcs"] - len(cherry)
        if remaining_used > 0:
            lines.append(f'<span><span class="dot dot-used"></span>Used from {e(bas_label)} — {remaining_used} of {cb["total_base_funcs"]} funcs ({used_pct}%)</span>')
    if dead_pct > 0:
        lines.append(f'<span><span class="dot dot-dead"></span>Unused from {e(bas_label)} — {cb["dead_base_funcs"]} funcs ({dead_pct}%)</span>')
    lines.append('</div>')

    # App functions section (unique code)
    app_funcs = cb.get('app_functions', [])
    if app_funcs:
        lines.append(f'<details open><summary><b>Application Code</b> ({len(app_funcs)} event handlers)</summary>')
        for f in app_funcs:
            name = f['name']
            sz = f['size']
            sz_label = f'{sz}b' if sz < 1024 else f'{sz/1024:.1f}KB'
            # Control caption annotation
            caption = f.get('control_caption', '')
            ctype = f.get('control_type', '')
            hint = f.get('code_hint', '')
            if caption:
                cap_note = f' <span style="color:#3fb950;font-style:italic">"{e(caption)}"</span>'
            elif hint:
                cap_note = f' <span style="color:#484f58;font-style:italic">[{e(ctype)}] {e(hint)}</span>'
            elif ctype:
                cap_note = f' <span style="color:#484f58;font-style:italic">[{e(ctype)}]</span>'
            else:
                cap_note = ''
            call_names = f.get('calls_base_names', [])
            # Resolve any remaining Proc_N_M names
            resolved = [_resolve_name(cn) for cn in call_names]
            call_note = f' → calls: {", ".join(resolved)}' if resolved else ''
            lines.append(f'<details class="fn-item"><summary>{e(name)}{cap_note} <span class="sz">{sz_label}{call_note}</span></summary>')
            lines.append(f'<pre>{_replace_procs(f["code"])}</pre>')
            lines.append('</details>')
        lines.append('</details>')

    # Cherry-picked functions (matched to known .bas modules)
    cherry_raw = cb.get('cherry_picked', [])
    # Deduplicate: if multiple decompiled funcs match the same canonical func, keep best score
    seen_funcs = {}
    for f in cherry_raw:
        key = f'{f["matched_module"]}.{f["matched_func"]}'
        if key not in seen_funcs or f['match_score'] > seen_funcs[key]['match_score']:
            seen_funcs[key] = f
    cherry = list(seen_funcs.values())
    if cherry:
        # Group by source module
        by_mod = {}
        for f in cherry:
            mod = f['matched_module']
            by_mod.setdefault(mod, []).append(f)
        cherry_size = sum(f['size'] for f in cherry)
        cherry_label = f'{len(cherry)} functions cherry-picked'
        lines.append(f'<details><summary><b>Cherry-Picked Code</b> ({cherry_label})</summary>')
        for mod, funcs in sorted(by_mod.items()):
            lines.append(f'<div style="margin:8px 0 4px;color:#d2a8ff;font-size:0.85em">'
                         f'From <b>{e(mod)}.bas</b> ({len(funcs)} functions):</div>')
            for f in funcs:
                mf = f['matched_func']
                score = f['match_score']
                pct = f'{score:.0%}'
                sz = f['size']
                sz_label = f'{sz}b' if sz < 1024 else f'{sz/1024:.1f}KB'
                badge = f'<span style="color:#3fb950">{pct}</span>' if score >= 0.8 else f'<span style="color:#d29922">{pct}</span>'
                src = f.get('matched_source', '')
                lines.append(f'<details class="fn-item"><summary>{e(mf)}() '
                             f'<span class="sz">{badge} match · {sz_label}</span></summary>')
                if src:
                    lines.append(f'<pre>{e(src)}</pre>')
                else:
                    lines.append(f'<pre>{_replace_procs(f["code"])}</pre>')
                lines.append('</details>')
        lines.append('</details>')

    # Reachable base module functions (exclude cherry-picked ones)
    cherry_names = {f['name'] for f in cherry}
    reachable = [f for f in cb.get('reachable_functions', []) if f['name'] not in cherry_names]
    if reachable:
        lines.append(f'<details><summary><b>Used {e(bas_label)} Functions</b> ({len(reachable)} called)</summary>')
        for f in reachable:
            canon = f.get('canonical_name', '') or _resolve_name(f['name'])
            display = f'{canon}()' if canon != f['name'] else _resolve_name(f['name'])
            proc_note = f' <span style="color:#484f58">({e(f["name"])})</span>' if canon != f['name'] else ''
            sz = f['size']
            sz_label = f'{sz}b' if sz < 1024 else f'{sz/1024:.1f}KB'
            lines.append(f'<details class="fn-item"><summary>{e(display)}{proc_note} <span class="sz">{sz_label}</span></summary>')
            lines.append(f'<pre>{_replace_procs(f["code"])}</pre>')
            lines.append('</details>')
        lines.append('</details>')

    return '\n'.join(lines)


def render_api_refs(api_strings, decomp=None):
    """Render API references split into AOL Classes vs Win32 Calls.
    When decomp has code_breakdown, scan reachable code for known API strings."""
    if not api_strings:
        return ''
    e = H.escape

    # When we have code_breakdown, scan reachable code for all known API strings
    cb = (decomp or {}).get('code_breakdown') or {}
    if cb:
        reachable_code = ''
        for f in cb.get('app_functions', []):
            reachable_code += f.get('code', '')
        for f in cb.get('reachable_functions', []):
            reachable_code += f.get('code', '')
        if reachable_code:
            found = set()
            for name in AOL_API_VERSIONS:
                if name in reachable_code:
                    found.add(name)
            # Use only the found set
            api_strings = list(found)

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

    total = len(aol_classes) + len(win32_calls) + len(other_api)
    if not total:
        return ''
    lines = [f'<h2>&#x2699; API References ({total})</h2>']
    if aol_classes:
        aol_classes.sort(key=lambda x: x[0].lstrip('_').lower())
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


def render_deps_from_db(zip_stem, conn=None):
    """Render structured dependencies from proggie_db."""
    own_conn = conn is None
    if own_conn:
        db = Path("proggie_db.sqlite")
        if not db.exists(): return ''
        conn = sqlite3.connect(str(db))
    rows = conn.execute('''
        SELECT d.dep_name, d.dep_type, d.source, d.in_zip, d.system_dll, d.vb_runtime
        FROM deps d JOIN exes e ON d.exe_id = e.id JOIN proggies p ON e.proggie_id = p.id
        WHERE p.zip_stem = ?
    ''', (zip_stem,)).fetchall()
    if own_conn: conn.close()
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

    # Non-visual control types to skip
    NONVISUAL = {'Timer', 'VBMsg', 'CommonDialog', 'MCI', 'InvisibleIcon',
                 'OLE', 'Data', 'Winsock', 'Inet', 'MAPI'}

    # Parse nested Begin/End blocks with parent offset tracking
    lines = text.splitlines()
    stack = []  # (ctrl_type, ctrl_name, offset_x, offset_y)
    ox, oy = 0, 0
    for line in lines:
        stripped = line.strip()
        m = re.match(r'Begin\s+(\S+)\s+(\w+)', stripped)
        if m:
            raw_type = m.group(1).split('.')[-1] if '.' in m.group(1) else m.group(1)
            stack.append((raw_type, m.group(2), ox, oy))
            continue
        if stripped == 'End' and stack:
            _, _, ox, oy = stack.pop()
            continue
        if not stack:
            continue
        pm = re.match(r'(\w+)\s*=\s*(.+)', stripped)
        if not pm:
            continue
        key, val = pm.group(1), pm.group(2).strip()
        cur_type, cur_name = stack[-1][0], stack[-1][1]
        # When we see Left/Top of a container (Frame/SSFrame/SSPanel), record its offset for children
        if key == 'Left' and cur_type in ('Frame', 'SSFrame', 'SSPanel', 'PictureBox'):
            try:
                parent_ox, parent_oy = stack[-2][2], stack[-2][3] if len(stack) > 1 else (0, 0)
            except IndexError:
                parent_ox = 0
            # Update stack entry with this container's absolute position
            pox = stack[-2][2] if len(stack) > 1 else 0
            stack[-1] = (cur_type, cur_name, pox + int(val.split("'")[0].strip()), stack[-1][3])
        elif key == 'Top' and cur_type in ('Frame', 'SSFrame', 'SSPanel', 'PictureBox'):
            poy = stack[-2][3] if len(stack) > 1 else 0
            stack[-1] = (cur_type, cur_name, stack[-1][2], poy + int(val.split("'")[0].strip()))

    # Re-parse with proper nesting using a simpler recursive approach
    controls = []
    _parse_nested(text.splitlines(), controls, 0, 0, NONVISUAL)
    return controls, form_w, form_h


def _parse_nested(lines, controls, ox, oy, nonvisual, start=0):
    """Recursively parse Begin/End blocks, accumulating parent offsets."""
    i = start
    props = {}
    cur_type = cur_name = None
    while i < len(lines):
        stripped = lines[i].strip()
        m = re.match(r'Begin\s+(\S+)\s+(\w+)', stripped)
        if m:
            raw = m.group(1)
            ctype = raw.split('.')[-1] if '.' in raw else raw
            cname = m.group(2)
            if ctype == 'Form' or ctype == 'MDIForm':
                i = _parse_nested(lines, controls, 0, 0, nonvisual, i + 1)
                continue
            # Collect this control's props and children
            child_props = {}
            children_start = i + 1
            # Find matching End, collecting props and recursing into children
            j = i + 1
            depth = 1
            child_lines = []
            while j < len(lines) and depth > 0:
                s = lines[j].strip()
                if re.match(r'Begin\s+', s):
                    depth += 1
                elif s == 'End':
                    depth -= 1
                    if depth == 0:
                        break
                elif depth == 1:
                    pm = re.match(r'(\w+)\s*=\s*(.+)', s)
                    if pm:
                        val = pm.group(2).strip().split("'")[0].strip().strip('"')
                        child_props[pm.group(1)] = val
                j += 1

            if ctype not in nonvisual and 'Left' in child_props and 'Top' in child_props:
                try:
                    left = int(child_props.get('Left', 0))
                    top = int(child_props.get('Top', 0))
                    width = int(child_props.get('Width', 600))
                    height = int(child_props.get('Height', 300))
                except ValueError:
                    i = j + 1
                    continue
                controls.append({
                    'type': ctype, 'name': cname,
                    'caption': child_props.get('Caption', ''),
                    'left': ox + left, 'top': oy + top,
                    'width': width, 'height': height,
                })
                # Recurse into children with this control's offset
                if ctype in ('Frame', 'SSFrame', 'SSPanel', 'PictureBox'):
                    _parse_nested(lines, controls, ox + left, oy + top, nonvisual, i + 1)

            i = j + 1
            continue
        if stripped == 'End':
            return i + 1
        i += 1
    return i


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
    lines.append('<style>svg .ctrl:hover{opacity:0.8;stroke-width:2}</style>')
    for c in controls:
        x = int(c['left'] * scale)
        y = int(c['top'] * scale)
        w = max(int(c['width'] * scale), 4)
        h = max(int(c['height'] * scale), 4)
        fill = colors.get(c['type'], '#2a2a2a')
        stroke = border_colors.get(c['type'], '#484f58')
        cap = c['caption'][:20] if c['caption'] else c['name'][:15]
        tip = f'{c["type"]}: {c["name"]}'
        if c['caption']: tip += f' — "{c["caption"][:30]}"'
        lines.append(f'<rect class="ctrl" x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="{stroke}" stroke-width="1" rx="2" style="cursor:pointer"><title>{e(tip)}</title></rect>')
        # Only add text if control is big enough
        if w > 20 and h > 10:
            tx = x + 3
            ty = y + min(h, 12)
            lines.append(f'<text x="{tx}" y="{ty}" fill="{stroke}" font-size="8" font-family="monospace" style="pointer-events:none">{e(cap)}</text>')
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


def generate_html(meta, strings, archive_name, html_path, conn=None):
    """Generate the full HTML page."""
    e = H.escape
    zip_stem = archive_name.replace('.zip', '')
    exe_name = meta.get('exe', '?')

    # Load decompile data if available
    decomp = load_decompile_data(zip_stem, exe_name) if exe_name != '?' else None
    # Fallback: if no exe in DB, check decompiled dir for any metadata.json
    if not decomp:
        decomp_base = DECOMPILED_DIR / zip_stem
        if decomp_base.exists():
            for sub in decomp_base.iterdir():
                if sub.is_dir() and (sub / 'metadata.json').exists():
                    decomp = load_decompile_data(zip_stem, sub.name)
                    if decomp:
                        exe_name = sub.name
                        break

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
        elif (cls := classify(s)):
            # DLLs go to dep, not interesting
            if cls == 'dep':
                categorized['dep'].append(s)
            else:
                categorized[cls].append(s)
        elif is_junk(s):
            junk.append(s)
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
        # Short strings with "by" pattern are likely real credits
        # Long strings are almost always help text that happens to contain "by"
        is_credit = re.search(r'(?:coded|programmed|made|created|written|designed|developed)\s+by\s*:?\s*\S', s, re.I)
        is_byline = re.match(r'^.{0,60}\bby\s*:\s*\S', s, re.I)
        is_presents = re.search(r'presents\s*$', s, re.I)
        if len(s) > 80 and not is_credit and not is_byline:
            interesting.append(s)
        elif is_credit or is_byline or is_presents or len(s) <= 60:
            real_author.append(s)
        else:
            interesting.append(s)
    categorized['author'] = real_author

    # Deduplicate author evidence by normalized whitespace
    seen_norm = set()
    deduped_author = []
    for s in categorized['author']:
        norm = re.sub(r'\s+', ' ', s).strip().lower()
        if norm not in seen_norm:
            deduped_author.append(s)
            seen_norm.add(norm)
    categorized['author'] = deduped_author

    # Merge author_evidence from metadata.json (decompiled source may have strings not in exe_strings.db)
    if decomp:
        for ev in decomp.get('author_evidence', []):
            norm = re.sub(r'\s+', ' ', ev).strip().lower()
            if norm not in seen_norm:
                categorized['author'].append(ev)
                seen_norm.add(norm)

    # Build page
    lines = [f'<!DOCTYPE html><html><head><meta charset="utf-8"><title>{e(archive_name)} — Analysis</title>{CSS}</head><body><div class="container">']

    # Nav bar (back to index + download)
    zip_path = meta.get('zip_path', '')
    dl_link = f'{GITHUB_RAW}{zip_path}' if zip_path else ''
    lines.append('<div class="topnav">')
    lines.append('<a href="../../../../proggie-index.html">&#x2190; All Proggies</a>')
    if dl_link:
        lines.append(f'<a class="dl-btn" href="{e(dl_link)}">&#x2b07; Download {e(archive_name)}</a>')
    # Source code zip if decompiled source exists
    source_dir = html_path.parent / zip_stem / 'source'
    if source_dir.exists() and any(source_dir.rglob('*')):
        src_zip = html_path.parent / zip_stem / f'{zip_stem}-source.zip'
        if not src_zip.exists():
            import zipfile
            with zipfile.ZipFile(src_zip, 'w', zipfile.ZIP_DEFLATED) as zf:
                for f in sorted(source_dir.rglob('*')):
                    if f.is_file():
                        zf.write(f, f.relative_to(source_dir))
        src_gh = f'{GITHUB_RAW}programs/AOL/proggies-sorted-deduped/{html_path.parent.name}/{zip_stem}/{zip_stem}-source.zip'
        lines.append(f'<a class="dl-btn" href="{e(src_gh)}" style="background:#238636">&#x1f4c4; Download Source</a>')
    lines.append('</div>')

    # Hero
    lines.append(render_hero(meta, archive_name, decomp))

    # Screenshots
    ss = render_screenshots(zip_stem, html_path)
    if ss: lines.append(ss)

    # About text from decompiled code
    about = render_about_text(decomp)
    if about: lines.append(about)

    # Author evidence (only real signals)
    if categorized['author']:
        lines.append(f'<h2>&#x1f58a; Author Evidence ({len(categorized["author"])})</h2>')
        for s in categorized['author']:
            lines.append(f'<span class="s author-str">{e(s)}</span>')

    # Dependencies from DB (structured) — right after author info
    deps_html = render_deps_from_db(zip_stem, conn)
    if deps_html:
        lines.append(deps_html)
    elif categorized['dep']:
        lines.append(f'<h2>&#x1f4e6; Dependencies ({len(categorized["dep"])})</h2>')
        for s in categorized['dep']:
            lines.append(f'<span class="s dep-str">{e(s)}</span>')

    # Decompiled project info
    if decomp:
        proj = decomp.get('project', {})
        info_parts = []
        if proj.get('Startup'): info_parts.append(f'Startup: {e(proj["Startup"].strip(chr(34)))}')
        ver = '.'.join(filter(None, [proj.get('MajorVer'), proj.get('MinorVer'), proj.get('RevisionVer')]))
        if ver and ver != '0.00.0': info_parts.append(f'Version: {e(ver)}')
        co = proj.get('VersionCompanyName', '').strip('"')
        if co and co not in ('?', 'None', ''): info_parts.append(f'Company: {e(co)}')
        if decomp.get('is_packed'): info_parts.append('Packed: Yes')
        if info_parts:
            lines.append('<h2>&#x1f4cb; Project Info</h2>')
            lines.append('<div class="card">')
            lines.append(' · '.join(info_parts))
            lines.append('</div>')

    # Phishing
    if categorized['phishing']:
        lines.append(f'<h2>&#x1f3a3; Phishing Template ({len(categorized["phishing"])})</h2>')
        for s in categorized['phishing']:
            lines.append(f'<span class="s phishing-str">{e(s)}</span>')

    # Greets
    lines.append(render_greets(sorted(greet_names), greet_text))

    # API refs split into subsections
    lines.append(render_api_refs(categorized['api'], decomp))

    # Forms & Controls with SVG layouts
    lines.append(render_forms(decomp, zip_stem, exe_name))

    # Code breakdown (base module vs app code) — single code section
    lines.append(render_code_breakdown(decomp))

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

    # Stats footer (only if there are strings to report)
    total = len(seen)
    if interesting or other:
        lines.append(f'<div class="stats">Total unique strings: {total} · Interesting: {len(interesting)} · Noise filtered: {len(junk)}</div>')
    lines.append('</div></body></html>')
    return '\n'.join(lines)


def _process_one(html_path_str):
    """Worker function for multiprocessing — generates one HTML page."""
    html_path = Path(html_path_str)
    conn = sqlite3.connect(str(DB_PATH))
    pdb = sqlite3.connect("proggie_db.sqlite") if Path("proggie_db.sqlite").exists() else None

    meta = get_meta_from_db(html_path.stem, pdb) or parse_existing_meta(html_path)
    exe_name = meta.get('exe', '')
    archive_name = html_path.stem + '.zip'
    archive_base = html_path.stem

    exe_path = find_exe_in_db(conn, exe_name, archive_base)
    strings = get_strings_from_db(conn, exe_path) if exe_path else []

    if not strings:
        decomp = load_decompile_data(archive_base, exe_name) if exe_name and exe_name != '?' else None
        if not decomp:
            decomp_base = DECOMPILED_DIR / archive_base
            if decomp_base.exists():
                for sub in decomp_base.iterdir():
                    if sub.is_dir() and (sub / 'metadata.json').exists():
                        decomp = load_decompile_data(archive_base, sub.name)
                        if decomp:
                            exe_name = sub.name
                            break
        if decomp and decomp.get('strings'):
            strings = decomp['strings']
        elif not exe_path:
            conn.close()
            if pdb: pdb.close()
            return 'skip'

    page = generate_html(meta, strings, archive_name, html_path, pdb)
    html_path.write_text(page, encoding='utf-8')
    conn.close()
    if pdb: pdb.close()
    return 'ok'


def main() -> int:
    if not DB_PATH.exists():
        print(f"Error: {DB_PATH} not found", file=sys.stderr)
        return 1

    # Support single-file mode
    if len(sys.argv) > 1:
        target = Path(sys.argv[1])
        html_files = [target] if target.exists() else []
    else:
        html_files = sorted(SORTED_DIR.rglob("*.html"))

    total = len(html_files)
    print(f"Processing {total} HTML pages", file=sys.stderr)

    if total > 4:
        import multiprocessing
        workers = max(1, multiprocessing.cpu_count() - 1)
        generated = skipped = 0
        with multiprocessing.Pool(workers) as pool:
            for i, result in enumerate(pool.imap_unordered(_process_one, [str(p) for p in html_files], chunksize=16)):
                if result == 'ok':
                    generated += 1
                else:
                    skipped += 1
                if (i + 1) % 200 == 0:
                    print(f"  {i+1}/{total} processed, {generated} regenerated", file=sys.stderr)
    else:
        conn = sqlite3.connect(str(DB_PATH))
        pdb = sqlite3.connect("proggie_db.sqlite") if Path("proggie_db.sqlite").exists() else None
        generated = skipped = 0
        for html_path in html_files:
            meta = get_meta_from_db(html_path.stem, pdb) or parse_existing_meta(html_path)
            exe_name = meta.get('exe', '')
            archive_name = html_path.stem + '.zip'
            archive_base = html_path.stem
            exe_path = find_exe_in_db(conn, exe_name, archive_base)
            strings = get_strings_from_db(conn, exe_path) if exe_path else []
            if not strings:
                decomp = load_decompile_data(archive_base, exe_name) if exe_name and exe_name != '?' else None
                if not decomp:
                    decomp_base = DECOMPILED_DIR / archive_base
                    if decomp_base.exists():
                        for sub in decomp_base.iterdir():
                            if sub.is_dir() and (sub / 'metadata.json').exists():
                                decomp = load_decompile_data(archive_base, sub.name)
                                if decomp:
                                    exe_name = sub.name
                                    break
                if decomp and decomp.get('strings'):
                    strings = decomp['strings']
                elif not exe_path:
                    skipped += 1
                    continue
            page = generate_html(meta, strings, archive_name, html_path, pdb)
            html_path.write_text(page, encoding='utf-8')
            generated += 1
        conn.close()
        if pdb: pdb.close()

    print(f"Done: {generated} regenerated, {skipped} skipped")

    # Generate landing page
    generate_landing_page()

    return 0


def generate_landing_page():
    """Generate index.html landing page with auto-detected featured proggies."""
    from jinja2 import Environment, FileSystemLoader, select_autoescape

    db = Path("proggie_db.sqlite")
    if not db.exists():
        print("Warning: proggie_db.sqlite not found, skipping landing page", file=sys.stderr)
        return

    conn = sqlite3.connect(str(db))

    # Stats
    total_proggies = conn.execute("SELECT COUNT(*) FROM proggies").fetchone()[0]
    total_decompiled = conn.execute("SELECT COUNT(*) FROM exes WHERE decompile_status='done'").fetchone()[0]
    total_decompilable = conn.execute("SELECT COUNT(*) FROM exes WHERE vb_version != 'non-VB'").fetchone()[0]
    total_html = sum(1 for _ in SORTED_DIR.rglob("*.html"))

    # Auto-detect featured: any proggie with a screenshot
    featured = []
    for asset_dir in sorted(SORTED_DIR.rglob("screenshot.png")):
        stem = asset_dir.parent.name
        ver_dir = asset_dir.parent.parent.name
        row = conn.execute(
            "SELECT p.name, p.author, p.aol_version, e.vb_version "
            "FROM proggies p LEFT JOIN exes e ON e.proggie_id=p.id WHERE p.zip_stem=? LIMIT 1",
            (stem,)
        ).fetchone()
        if not row:
            continue
        detail_url = f"programs/AOL/proggies-sorted-deduped/{ver_dir}/{stem}.html"
        screenshot_url = f"programs/AOL/proggies-sorted-deduped/{ver_dir}/{stem}/screenshot.png"
        # Check for main_form.png (preferred, larger)
        # Prefer screenshot.png (trimmed) for thumbnails; main_form.png is full-screen
        main_form = asset_dir.parent / "main_form.png"
        if main_form.exists() and not asset_dir.exists():
            screenshot_url = f"programs/AOL/proggies-sorted-deduped/{ver_dir}/{stem}/main_form.png"
        featured.append({
            'name': row[0] or stem,
            'author': row[1] or 'Unknown',
            'aol_version': row[2] or '?',
            'vb': row[3] or '?',
            'detail_url': detail_url,
            'screenshot_url': screenshot_url,
            'has_source': (asset_dir.parent / "source").is_dir(),
            'has_gif': (asset_dir.parent / "animated.gif").exists(),
        })
    conn.close()

    # Render
    env = Environment(
        loader=FileSystemLoader(str(Path(__file__).parent / 'templates')),
        autoescape=select_autoescape(['html']),
        trim_blocks=True,
        lstrip_blocks=True,
    )
    template = env.get_template('index.html')
    html = template.render(
        total_proggies=f"{total_proggies:,}",
        total_html=f"{total_html:,}",
        total_decompiled=total_decompiled,
        total_decompilable=f"{total_decompilable:,}",
        total_strings='11.6M',
        remaining=f"{total_decompilable - total_decompiled:,}",
        featured=featured,
    )
    Path("index.html").write_text(html, encoding='utf-8')
    print(f"Landing page: index.html ({len(featured)} featured proggies)")


if __name__ == '__main__':
    sys.exit(main())
