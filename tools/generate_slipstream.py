#!/usr/bin/env python3
"""Generate analysis HTML for Slipstream's AOL File Downloader (AutoIt source).

Output: programs/AOL/proggies-sorted-deduped/9.0/aol-file-downloader-by-slipstream.html

Run from repo root:
    python3 tools/generate_slipstream.py
"""
import html as html_mod
import re
from pathlib import Path
from datetime import datetime, timezone

from static_loader import load_css

import hunter
_hunter_log = (Path.home() / 'traces' / Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
hunter.trace(stdlib=False, action=hunter.CallPrinter(stream=open(_hunter_log, 'a')))

import logging
logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
log = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent
ZIP_STEM = 'aol-file-downloader-by-slipstream'
AOL_VERSION = '9.0'
SRC_AU3 = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / AOL_VERSION / f'{ZIP_STEM}.au3'
OUT_HTML = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped' / AOL_VERSION / f'{ZIP_STEM}.html'

GITHUB_RAW = (
    'https://github.com/ssstonebraker/aolunderground-proggies/raw/main/'
    f'programs/AOL/proggies-sorted-deduped/{AOL_VERSION}/{ZIP_STEM}.au3'
)


# ---------------------------------------------------------------------------
# AutoIt parsing
# ---------------------------------------------------------------------------

AU3_KEYWORDS = [
    'Func', 'EndFunc', 'Return',
    'If', 'Then', 'Else', 'ElseIf', 'EndIf',
    'While', 'WEnd', 'For', 'To', 'Next',
    'Do', 'Until', 'Loop',
    'ExitLoop', 'ContinueLoop', 'Exit',
    'Local', 'Global', 'Const', 'ByRef',
    'And', 'Or', 'Not',
    'True', 'False',
    'Select', 'Case', 'EndSelect',
    'With', 'EndWith',
    'ReDim', 'UBound',
]

AU3_BUILTINS = [
    'Sleep', 'Exit', 'MsgBox', 'ConsoleWrite',
    'WinGetHandle', 'WinGetTitle', 'WinKill', 'WinClose',
    'WinActivate', 'WinWait', 'WinWaitClose', 'WinExists', 'WinSetState',
    'ControlGetHandle', 'ControlGetText', 'ControlSetText',
    'ControlSend', 'ControlEnable', 'ControlFocus',
    'DllStructCreate', 'DllStructGetPtr', 'DllStructGetData',
    'DirCreate', 'FileWrite', 'FileExists',
    'StringSplit', 'StringStripWS', 'StringTrimLeft', 'StringInStr',
    'StringReplace', 'BitAnd', 'BitOr', 'IsArray',
    'UBound', 'ReDim',
]

WIN32_API_CALLS = [
    ('_WinAPI_ReadProcessMemory', 'kernel32.dll', 'Reads data from process memory — used to extract AOL listbox item text'),
    ('_WinAPI_OpenProcess',       'kernel32.dll', 'Opens handle to AOL process for memory reads'),
    ('_WinAPI_GetWindowThreadProcessId', 'user32.dll', 'Gets PID from AOL window handle'),
    ('_WinAPI_GetWindow',         'user32.dll', 'Enumerates child windows (GW_CHILD, GW_HWNDNEXT)'),
    ('_WinAPI_GetClassName',      'user32.dll', 'Gets window class name — matches _AOL_* classes'),
    ('_WinAPI_GetWindowText',     'user32.dll', 'Gets window title/text for classification'),
]

AOL_CLASSES = [
    ('_AOL_Modal',   'Modal dialog — errors, prompts, confirmations'),
    ('AOL Child',    'Content window — file library listing'),
    ('_AOL_Edit',    'Address/navigation bar — receives aol://4400: URLs'),
    ('_AOL_Listbox', 'File list control — enumerated via ReadProcessMemory'),
    ('_AOL_Static',  'Static text — error messages and file descriptions'),
    ('_AOL_Icon',    'Clickable icon/button — including "List More Files" (instance 5)'),
    ('_AOL_View',    'Content viewer — file detail display'),
]

FUNCTIONS = [
    (
        'AOLList_GetCount($hwnd)',
        'Returns the number of items in an AOL listbox via LB_GETCOUNT message.',
        'Uses SendMessage with LB_GETCOUNT — standard Windows listbox message, works on AOL\'s custom _AOL_Listbox class.',
    ),
    (
        'AOLList_Select($hwnd, $index)',
        'Selects a listbox item by index via SendMessage.',
        'Sends the index as the message parameter — note the AOL-specific calling convention differs slightly from standard LB_SETCURSEL.',
    ),
    (
        'AOLList_GetText($hwnd, $index)',
        'Reads item text directly from AOL process memory — the core technique of this script.',
        'LB_GETITEMDATA returns a pointer into AOL\'s heap. Adds 28-byte offset to reach the string pointer structure, then reads 6 bytes past that for the actual string data. Uses ReadProcessMemory for cross-process access. Buffer is 2048 bytes.',
    ),
    (
        'MakeValidFilename($fn)',
        'Sanitizes file/folder names by replacing illegal Windows filesystem characters with underscores.',
        'Handles: \\ / : * ? " < > |',
    ),
    (
        'WinGetFirstChild($hwnd, $class)',
        'Recursive depth-first search through window hierarchy. Returns first child matching a class name or array of class names.',
        'Accepts either a string or array of class names. Uses GW_CHILD to descend, GW_HWNDNEXT to iterate siblings. Returns 0 if not found.',
    ),
    (
        'WinListChildren($hWnd, ByRef $avArr)',
        'Recursively enumerates all child windows into a 2D array [hwnd, title, classname].',
        'Used for debugging and discovery. Pre-allocates in chunks of 10 to avoid constant ReDim overhead.',
    ),
]


def esc(s):
    return html_mod.escape(str(s))


def highlight_au3(code: str) -> str:
    """AutoIt syntax highlighting."""
    e = esc(code)

    # Comments (;...)
    e = re.sub(r'(;[^\n]*)', r'<span class="cmt">\1</span>', e)

    # Block comments (#cs...#ce) — already escaped
    e = re.sub(r'(#cs\b.*?#ce\b)', r'<span class="cmt">\1</span>', e, flags=re.S)

    # Strings ("...")
    e = re.sub(r'(&quot;[^&\n]*?&quot;)', r'<span class="str">\1</span>', e)

    # Keywords (word boundary sensitive)
    for kw in AU3_KEYWORDS:
        e = re.sub(rf'\b({re.escape(esc(kw))})\b', r'<span class="kw">\1</span>', e)

    # Built-in functions
    for fn in AU3_BUILTINS:
        e = re.sub(rf'\b({re.escape(fn)})\b', r'<span class="builtin">\1</span>', e)

    # Variables ($name)
    e = re.sub(r'(\$\w+)', r'<span class="var">\1</span>', e)

    # Preprocessor directives (#include, #cs, #ce)
    e = re.sub(r'^(<span[^>]*>)?(#\w+)', r'\1<span class="pre">\2</span>', e, flags=re.M)

    # WinAPI calls (_WinAPI_*)
    e = re.sub(r'\b(_WinAPI_\w+|_SendMessage|_ArrayDisplay)\b',
               r'<span class="api">\1</span>', e)

    return e


def parse_functions(source: str) -> list[dict]:
    """Extract Func...EndFunc blocks."""
    funcs = []
    for m in re.finditer(
        r'^(Func\s+(\w+)\s*\([^)]*\))\s*\n(.*?)^EndFunc',
        source, re.M | re.S
    ):
        sig = m.group(1).strip()
        name = m.group(2)
        body = m.group(3)
        line_count = body.count('\n') + 2
        funcs.append({'name': name, 'sig': sig, 'body': body, 'code': m.group(0),
                      'lines': line_count})
    return funcs


def parse_constants(source: str) -> list[tuple]:
    """Extract top-level $var = value assignments and Const declarations."""
    consts = []
    for m in re.finditer(r'^(Const\s+\$\w+\s*=\s*.+|\$\w+\s*=\s*\d[\d\w]*)\s*$',
                         source, re.M):
        line = m.group(0).strip()
        consts.append(line)
    return consts


def parse_includes(source: str) -> list[str]:
    return re.findall(r'^#include\s+<([^>]+)>', source, re.M)


def extract_aol_classes(source: str) -> list[str]:
    return sorted(set(re.findall(r'"(_AOL_\w+|AOL Child)"', source)))


def extract_lbmessages(source: str) -> list[str]:
    return sorted(set(re.findall(r'\$LB_\w+', source)))


# ---------------------------------------------------------------------------
# HTML generation
# ---------------------------------------------------------------------------

def generate():
    if not SRC_AU3.exists():
        log.error(f'Source not found: {SRC_AU3}')
        log.error('Run build_slipstream_metadata.py first.')
        raise SystemExit(1)

    source = SRC_AU3.read_text(encoding='utf-8', errors='replace').replace('\r\n', '\n')
    lines = source.split('\n')
    funcs = parse_functions(source)
    consts = parse_constants(source)
    includes = parse_includes(source)
    aol_classes_found = extract_aol_classes(source)
    lb_messages = extract_lbmessages(source)

    # Main loop line count (everything not in a Func block)
    func_lines = sum(f['lines'] for f in funcs)
    main_lines = len(lines) - func_lines

    h = []

    h.append(f'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AOL File Downloader — by Slipstream</title>
<style>{load_css("slipstream.css")}</style>
</head>
<body>
<div class="container">
<div class="nav">
<a href="../../../../proggie-index.html">&larr; All Proggies</a> &middot;
<a href="../../../../index.html">Home</a> &middot;
<a href="{esc(GITHUB_RAW)}">Download .au3</a>
</div>
''')

    # Hero block
    h.append(f'''<div class="hero">
<h1>AOL File Downloader</h1>
<div style="color:#666; margin: 4px 0 10px">
  by <strong style="color:#0cf">Slipstream</strong> &middot;
  2014 &middot; AutoIt v3 &middot; Targets AOL 9.7
</div>
<div>
  <span class="badge b-lang">AutoIt v3</span>
  <span class="badge b-src">Original Source</span>
  <span class="badge b-year">2014</span>
  <span class="badge b-ver">AOL 9.7</span>
</div>
<div class="stats">
  <div class="stat"><div class="n">{len(lines):,}</div><div class="l">lines</div></div>
  <div class="stat"><div class="n">{len(funcs)}</div><div class="l">functions</div></div>
  <div class="stat"><div class="n">40,000</div><div class="l">areas scanned</div></div>
  <div class="stat"><div class="n">{len(aol_classes_found)}</div><div class="l">AOL window classes</div></div>
  <div class="stat"><div class="n">{len(includes)}</div><div class="l">AutoIt includes</div></div>
</div>
</div>

<div class="callout">
<strong>What this is:</strong> An AutoIt automation script that runs alongside AOL 9.7
and bulk-downloads every file from every file library area
(<code>aol://4400:1</code> through <code>aol://4400:40000</code>). Written by
Slipstream in 2014 as a preservation tool. The key technique: instead of parsing
the AOL UI, it reads the listbox item data <em>directly from AOL&rsquo;s process
memory</em> via <code>ReadProcessMemory</code>, bypassing the display layer entirely.
Version 0.31 — described by the author as &ldquo;VERY MUCH BETA.&rdquo;
</div>
''')

    # aol://4400: scheme
    h.append('''<h2>The aol://4400: Area Scheme</h2>
<p class="section-intro">
AOL file libraries were organized into numbered "areas." Each area had a title,
a list of uploaded files, and a category. The script navigates each one sequentially.
</p>
<table>
<tr><th>URL format</th><td><code>aol://4400:&lt;area_number&gt;</code></td></tr>
<tr><th>Range scanned</th><td>1 &ndash; 40,000</td></tr>
<tr><th>Navigation method</th><td>Types URL into <code>_AOL_Edit</code> (address bar) + Enter</td></tr>
<tr><th>"List More Files"</th><td>Clicks <code>[CLASS:_AOL_Icon; INSTANCE:5]</code> until greyed out, loading all items</td></tr>
<tr><th>Output structure</th><td><code>C:\\AOLDLs\\&lt;library_title&gt;\\&lt;subject&gt;\\&lt;filename&gt;</code></td></tr>
<tr><th>Metadata saved</th><td><code>url.txt</code> (area URL) + <code>info.txt</code> (file description) per item</td></tr>
</table>
''')

    # ReadProcessMemory technique
    h.append('''<h2>Core Technique: ReadProcessMemory on the AOL Listbox</h2>
<p class="section-intro">
The standard AutoIt <code>ControlGetText</code> cannot read AOL&#x27;s custom
<code>_AOL_Listbox</code> items. Slipstream solved this by reading directly from
AOL&#x27;s heap.
</p>
<div class="callout">
<strong>Memory layout (per listbox item):</strong><br>
<code>LB_GETITEMDATA</code> → pointer into AOL heap<br>
<code>+28 bytes</code> → pointer to string structure<br>
<code>+6 bytes</code> → null-terminated ASCII string (up to 2048 bytes)<br><br>
This offset (<code>+28</code>, then <code>+6</code>) is specific to AOL 9.7&#x27;s
internal listbox item structure and was determined by reverse engineering.
</div>
''')

    # Functions section
    h.append('<h2>Functions</h2>')
    # FUNCTIONS is list of (sig, short_desc, detail) tuples — key by first word of sig
    known = {}
    for sig, short_desc, detail in FUNCTIONS:
        fn_name = re.match(r'\w+', sig).group(0)
        known[fn_name] = (sig, short_desc, detail)

    for fn in funcs:
        meta = known.get(fn['name'])
        h.append(f'<div class="fn-block">')
        h.append(f'<details><summary><strong>{esc(fn["sig"])}</strong>'
                 f' &mdash; {fn["lines"]} lines</summary>')
        if meta:
            h.append(f'<p style="color:#888; margin:8px 0 4px; font-size:0.9em">{esc(meta[1])}</p>')
            h.append(f'<p style="color:#555; margin-bottom:8px; font-size:0.85em">{esc(meta[2])}</p>')
        h.append(f'<pre class="code">{highlight_au3(fn["code"])}</pre>')
        h.append('</details></div>')

    # Main loop
    h.append('<h2>Main Loop</h2>')
    h.append('<p class="section-intro">The main body iterates areas 1&ndash;40,000. '
             'For each area it kills modal dialogs, navigates to the file library, '
             'exhausts the "List More Files" button, then downloads each file '
             'in the listing.</p>')

    # Extract main loop (everything after last EndFunc)
    last_func_end = 0
    for m in re.finditer(r'^EndFunc', source, re.M):
        last_func_end = m.end()
    main_body = source[last_func_end:].strip() if last_func_end else ''
    if main_body:
        h.append(f'<details><summary>Show main loop ({main_lines} lines)</summary>')
        h.append(f'<pre class="code">{highlight_au3(main_body)}</pre>')
        h.append('</details>')

    # Error handling
    h.append('''<h2>Error Handling</h2>
<table>
<tr><th>Condition</th><th>Detection</th><th>Recovery</th></tr>
<tr>
  <td>No access to library</td>
  <td><code>_AOL_Static</code> text contains "you do not have access"</td>
  <td>Kill modal, continue to next area</td>
</tr>
<tr>
  <td>No released files</td>
  <td><code>_AOL_Static</code> text contains "There are no released files."</td>
  <td>Kill window, ContinueLoop</td>
</tr>
<tr>
  <td>Download failure</td>
  <td>Download Manager window never appears after 10 attempts</td>
  <td>Kill dialog, advance listbox down, clean up modals</td>
</tr>
<tr>
  <td>File already downloaded</td>
  <td>Download Manager text contains "You have already downloaded this file"</td>
  <td>Kill dialogs, advance listbox, continue</td>
</tr>
<tr>
  <td>Filename collision</td>
  <td><code>FileExists()</code> check</td>
  <td>Prefix with incrementing counter: <code>2_filename, 3_filename...</code></td>
</tr>
</table>
''')

    # AOL window classes
    h.append('<h2>AOL Window Classes Targeted</h2>')
    h.append('<table><tr><th>Class</th><th>Role in script</th></tr>')
    for cls, desc in AOL_CLASSES:
        found_marker = ' <span style="color:#0f0">✓</span>' if cls in aol_classes_found else ''
        h.append(f'<tr><td><code class="aol-class">{esc(cls)}</code>{found_marker}</td>'
                 f'<td class="desc">{esc(desc)}</td></tr>')
    h.append('</table>')

    # Win32 API
    h.append(f'<h2>Win32 API Calls ({len(WIN32_API_CALLS)})</h2>')
    h.append('<table><tr><th>Function</th><th>DLL</th><th>Purpose</th></tr>')
    for fn, dll, desc in WIN32_API_CALLS:
        h.append(f'<tr><td><code>{esc(fn)}</code></td><td><code style="color:#666">{esc(dll)}</code></td>'
                 f'<td class="desc">{esc(desc)}</td></tr>')
    h.append('</table>')

    # Listbox messages
    if lb_messages:
        h.append('<h2>Windows Listbox Messages Used</h2>')
        h.append('<table><tr><th>Message</th><th>Meaning</th></tr>')
        lb_docs = {
            '$LB_GETCOUNT':    'Returns number of items in listbox',
            '$LB_GETITEMDATA': 'Returns application-defined value (pointer) for an item',
            '$LB_SETCURSEL':   'Selects a string and scrolls it into view',
        }
        for msg in lb_messages:
            h.append(f'<tr><td><code style="color:#9cdcfe">{esc(msg)}</code></td>'
                     f'<td class="desc">{esc(lb_docs.get(msg, ""))}</td></tr>')
        h.append('</table>')

    # AutoIt includes
    h.append('<h2>AutoIt Includes</h2>')
    h.append('<ul style="list-style:none; margin:6px 0">')
    for inc in includes:
        h.append(f'<li><code style="color:#c586c0">&lt;{esc(inc)}&gt;</code></li>')
    h.append('</ul>')

    # Full source
    h.append('<h2>Full Source</h2>')
    h.append(f'<p class="section-intro"><a href="{esc(GITHUB_RAW)}">Download raw .au3</a></p>')
    h.append(f'<pre class="code">{highlight_au3(source)}</pre>')

    # Footer
    h.append(f'''<div class="footer">
<a href="{esc(GITHUB_RAW)}">Download .au3</a> &middot;
Script by Slipstream, 2014 &middot; AutoIt v3 &middot; AOL 9.7 &middot;
<a href="../../../../proggie-index.html">All Proggies</a>
</div>
</div>
</body>
</html>''')

    OUT_HTML.write_text('\n'.join(h), encoding='utf-8')
    size = OUT_HTML.stat().st_size
    log.info(f'Generated: {OUT_HTML} ({size:,} bytes)')
    print(f'\nDone. {OUT_HTML} ({size:,} bytes)')
    print('\nNext: regenerate the index')
    print('  python3 tools/generate_index.py')


if __name__ == '__main__':
    generate()
