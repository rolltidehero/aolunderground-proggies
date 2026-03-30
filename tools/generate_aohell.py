#!/usr/bin/env python3
"""Generate a showcase page for AOHell 95 original source code.

Output: programs/AOL/proggies-sorted-deduped/2.5/aohell 95 for aol 2.5-3.0.html
(matches the zip stem so it integrates with the existing index/nav)
"""
import os
import re
import html as html_mod
from pathlib import Path
from datetime import datetime

# Hunter deep tracing — always on, timestamped per-run, file only
import hunter
from pathlib import Path as _Path
from datetime import datetime, timezone
_hunter_log = (_Path.home() / 'traces' / _Path(__file__).stem
               / datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
               / 'hunter.log')
_hunter_log.parent.mkdir(parents=True, exist_ok=True)
hunter.trace(stdlib=False, action=hunter.CallPrinter(
    stream=open(_hunter_log, 'a')))

SRC = Path('programming/vb/aol/25-30/_extracted/AOHELL95_source_code/AOH')
OUT = Path('programs/AOL/proggies-sorted-deduped/2.5/aohell 95 for aol 2.5-3.0.html')
ZIP_PATH = 'programs/AOL/proggies-sorted-deduped/proggies-by-version/2.5/aohell 95 for aol 2.5-3.0.zip'
# Source files committed here for browsing
SOURCE_DIR = Path('programs/AOL/proggies-sorted-deduped/2.5/aohell-source')


def read_file(name):
    return (SRC / name).read_text(errors='replace').replace('\r\n', '\n').replace('\r', '\n')


def parse_mak():
    content = read_file('AOHELL.MAK')
    bas, frm, vbx = [], [], []
    title = exe = ''
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
        elif line.startswith('ExeName='):
            exe = line.split('=', 1)[1].strip('"')
    return title, exe, bas, frm, vbx


def extract_code_blocks(content):
    """Extract all Sub/Function blocks from file content."""
    blocks = []
    for m in re.finditer(r'^((?:Sub|Function)\s+\w+[^\n]*)\n(.*?)^(End (?:Sub|Function))',
                         content, re.M | re.S):
        sig = m.group(1).strip()
        body = m.group(2)
        end = m.group(3).strip()
        blocks.append((sig, body.strip(), end))
    return blocks


def extract_globals(content):
    return [l.strip() for l in content.split('\n')
            if re.match(r'\s*(Global |Declare )', l)]


def esc(text):
    return html_mod.escape(text)


def highlight(code):
    """Minimal VB syntax highlighting."""
    e = esc(code)
    # Keywords
    for kw in ['Sub ', 'Function ', 'End Sub', 'End Function', 'End If',
               'End Select', 'If ', ' Then', 'Else', 'ElseIf ', 'For ',
               'Next', 'Do ', 'Loop', 'While ', 'Wend', 'GoTo ', 'Dim ',
               'Global ', 'Declare ', 'Exit Sub', 'Exit Function',
               'Select Case', 'Case ', 'ByVal ', 'As ', 'Integer', 'String',
               'Long', 'Single', 'Variant', 'True', 'False']:
        e = e.replace(esc(kw), f'<span class="kw">{esc(kw)}</span>')
    # Strings
    e = re.sub(r'(&quot;[^&]*?&quot;)', r'<span class="str">\1</span>', e)
    # Comments
    e = re.sub(r"(&#x27;.*?)$", r'<span class="cmt">\1</span>', e, flags=re.M)
    e = re.sub(r"^(\s*REM\b.*?)$", r'<span class="cmt">\1</span>', e, flags=re.M | re.I)
    return e


def copy_source_files():
    """Copy .BAS and .FRM source files to browsable location."""
    SOURCE_DIR.mkdir(parents=True, exist_ok=True)
    copied = 0
    for f in os.listdir(SRC):
        if f.upper().endswith(('.BAS', '.FRM', '.MAK')):
            src_path = SRC / f
            dst_path = SOURCE_DIR / f
            content = src_path.read_bytes()
            dst_path.write_bytes(content)
            copied += 1
    return copied


def generate():
    title, exe_name, bas_files, frm_files, vbx_files = parse_mak()

    # Copy source for browsing
    copied = copy_source_files()
    print(f'Copied {copied} source files to {SOURCE_DIR}')

    # Count totals
    total_lines = 0
    for f in bas_files + frm_files:
        try:
            total_lines += len(read_file(f).split('\n'))
        except FileNotFoundError:
            pass

    # Parse all modules
    modules = {}  # name -> (globals, blocks, line_count)
    for bf in bas_files:
        try:
            content = read_file(bf)
            modules[bf] = (extract_globals(content), extract_code_blocks(content), len(content.split('\n')))
        except FileNotFoundError:
            pass

    # Parse all forms
    forms = {}  # name -> (caption, blocks, line_count)
    for ff in frm_files:
        try:
            content = read_file(ff)
            m = re.search(r'^\s*Caption\s*=\s*"([^"]*)"', content, re.M)
            caption = m.group(1).strip() if m else ff.replace('.FRM', '')
            forms[ff] = (caption, extract_code_blocks(content), len(content.split('\n')))
        except FileNotFoundError:
            pass

    # Collect all API declares
    api_declares = set()
    for bf, (globals_, _, _) in modules.items():
        for g in globals_:
            if g.startswith('Declare '):
                api_declares.add(g)
    for ff, (_, blocks, _) in forms.items():
        try:
            content = read_file(ff)
            for g in extract_globals(content):
                if g.startswith('Declare '):
                    api_declares.add(g)
        except FileNotFoundError:
            pass

    # AOL window classes referenced
    aol_classes = set()
    for f in bas_files + frm_files:
        try:
            content = read_file(f)
            aol_classes.update(re.findall(r'"(_AOL_\w+)"', content))
        except FileNotFoundError:
            pass

    # VBX info from actual binary strings
    vbx_info = {
        'THREED.VBX': '3D controls — buttons, panels, frames (Sheridan Software)',
        'CMDIALOG.VBX': 'Common dialog boxes — file open/save (Microsoft)',
        'VBMSG.VBX': 'Window message subclassing — sends WM_* messages to AOL windows',
        'CSPICTUR.VBX': 'Picture/image display (Crescent Software)',
        'PERCNT2.VBX': 'Progress bar / percentage display',
        'INICON3.VBX': 'System tray notification icon',
        'CHRONIC.VBX': 'Tooltip control (actually Mabry TIPS.VBX, renamed)',
        'MCI.VBX': 'Multimedia Control Interface — CD audio playback (Microsoft)',
        'VBCTL3D.VBX': '3D visual effects for standard controls',
        'CSPICT.VBX': 'Picture control (Crescent Software)',
    }

    # Feature map: form -> (category, brief factual description)
    feature_map = {
        'PHISH.FRM': ('Phishing', 'Sends fake TOS-style IMs, captures replies'),
        'EBOMB.FRM': ('Email Bombing', 'Sends repeated emails to a target address'),
        'EBSTAT.FRM': ('Email Bombing', 'Status display for email bomb progress'),
        'MM2.FRM': ('Mass Mailer', 'Bulk email sender with list management'),
        'MMCOM.FRM': ('Mass Mailer', 'Comment attachment for mass mail'),
        'MMSTAT.FRM': ('Mass Mailer', 'Mailbox status during mass mail'),
        'MMWAIT.FRM': ('Mass Mailer', 'Wait dialog during mass mail send'),
        'CHATROO.FRM': ('Chat Bot', 'AI chat bot with auto-responses and room management'),
        'MULTICHA.FRM': ('Chat Bot', 'Multi-room chat monitoring'),
        'IMROOM.FRM': ('Chat Tools', 'Sends IMs to all users in a chat room'),
        'ROOMBUST.FRM': ('Room Busting', 'Floods chat rooms to disrupt them'),
        'SCROLL.FRM': ('Scrolling', 'Rapid text scrolling in chat rooms'),
        'PUNT.FRM': ('Punting', 'Disconnects users via IM exploit'),
        'PUNTSTAT.FRM': ('Punting', 'Punt status display'),
        'WAREZBOT.FRM': ('Warez Bot', 'Automated file trading bot for chat rooms'),
        'IMANAGER.FRM': ('IM Tools', 'IM automation — auto-reply, logging, bulk send'),
        'IMESSAGE.FRM': ('IM Tools', 'Auto-answer message configuration'),
        'RESETSN.FRM': ('Account Tools', 'Resets AOL account to new-user status'),
        'RESETSN1.FRM': ('Account Tools', 'Guest account fix'),
        'FAKEFOR.FRM': ('Account Tools', 'Spoofs email forwarding headers'),
        'INSULTS.FRM': ('Insults', 'Sends randomized insults via IM'),
        'KTENCODE.FRM': ('Encryption', 'XOR encryption for file lists and bot commands'),
        'MAIN.FRM': ('Main UI', 'Main application window and menu'),
        'AOHELL.FRM': ('Main UI', 'Primary MDI form'),
        'ACTION.FRM': ('Automation', 'Action scripting / macro execution'),
        'FORM4.FRM': ('Utilities', 'Utility form'),
        'FORM5.FRM': ('Utilities', 'Utility form'),
        'FORM6.FRM': ('Utilities', 'Utility form'),
        'FORM7.FRM': ('Utilities', 'Utility form'),
        'FORM10.FRM': ('Utilities', 'Utility form'),
        'FORM11.FRM': ('Utilities', 'Utility form'),
        'CD.FRM': ('Utilities', 'CD audio player'),
        'DRIVEH.FRM': ('Utilities', 'Drive/file browser'),
        'QUICKFTP.FRM': ('Utilities', 'FTP file transfer'),
        'SEARCH.FRM': ('Utilities', 'Member search'),
        'THEBOT.FRM': ('Bot', 'General-purpose bot framework'),
        'DICE.FRM': ('Games', 'Dice game'),
        'SUGGEST.FRM': ('UI', 'Suggestion/feedback form'),
        'STATUS.FRM': ('UI', 'Status display'),
        'LISTSTAT.FRM': ('UI', 'List status display'),
        'PACKSTAT.FRM': ('UI', 'Packet status display'),
        'ABOUTBOX.FRM': ('UI', 'About dialog'),
        'INTRO.FRM': ('UI', 'Intro/splash screen'),
        'ATTENTIO.FRM': ('UI', 'Attention dialog'),
        'DUPEKILL.FRM': ('Utilities', 'Duplicate entry remover'),
        'MAILFIX.FRM': ('Utilities', 'Mailbox repair'),
        'ISCHRON.FRM': ('UI', 'Chronic info display'),
        'LISTB.FRM': ('UI', 'List builder'),
        'ANNOY.FRM': ('Annoyance', 'Annoyance tools'),
        'ELITE1.FRM': ('Utilities', 'Elite text converter'),
        'SGROUP.FRM': ('Utilities', 'Group management'),
        'SHOWWIN.FRM': ('Utilities', 'Window display helper'),
        'SMALLPAC.FRM': ('UI', 'Small packet display'),
        'RANDOM.FRM': ('Utilities', 'Random generator'),
        'GETMBOX.FRM': ('Utilities', 'Mailbox getter'),
        'ENUM.FRM': ('Utilities', 'Window enumeration'),
        'FINDENUM.FRM': ('Utilities', 'Find/enumerate windows'),
        'WAIT.FRM': ('UI', 'Wait dialog'),
        'PWAIT.FRM': ('UI', 'Pause/wait dialog'),
        'WNOTE.FRM': ('UI', 'Note display'),
        'WELCOME.FRM': ('UI', 'Welcome screen'),
        'AORIPOFF.FRM': ('Utilities', 'AO ripoff detector'),
        'ARIPOFF.FRM': ('Utilities', 'Ripoff form'),
    }

    # Group forms by category for the attack features section
    attack_categories = ['Phishing', 'Email Bombing', 'Mass Mailer', 'Chat Bot',
                         'Room Busting', 'Scrolling', 'Punting', 'Warez Bot',
                         'IM Tools', 'Account Tools', 'Insults', 'Encryption',
                         'Annoyance', 'Automation', 'Bot']
    attack_forms = {}
    for cat in attack_categories:
        cat_forms = [(ff, forms[ff]) for ff in frm_files
                     if ff in forms and feature_map.get(ff, ('', ''))[0] == cat]
        if cat_forms:
            attack_forms[cat] = cat_forms

    # File dates for timeline
    file_dates = {}
    for f in os.listdir(SRC):
        if f.upper().endswith(('.FRM', '.BAS')):
            mtime = os.path.getmtime(SRC / f)
            dt = datetime.fromtimestamp(mtime)
            key = dt.strftime('%Y-%m')
            file_dates.setdefault(key, []).append((f, dt.strftime('%b %d, %Y')))

    # GitHub raw URL for zip download
    zip_url = f'https://github.com/ssstonebraker/aolunderground-proggies/raw/reorganize/{ZIP_PATH.replace(" ", "%20")}'

    # --- BUILD HTML ---
    h = []
    h.append(f'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AOHell 95 v3.0 — Original Source Code</title>
<style>
* {{ box-sizing: border-box; margin: 0; padding: 0; }}
body {{ font-family: 'Courier New', monospace; background: #0a0a0a; color: #c0c0c0; padding: 20px; line-height: 1.6; }}
.container {{ max-width: 1100px; margin: 0 auto; }}
a {{ color: #0f0; }}
a:hover {{ text-decoration: underline; }}
h1 {{ color: #ff0000; font-size: 2em; text-shadow: 0 0 15px #ff000066; margin-bottom: 5px; }}
h2 {{ color: #ff4444; margin: 30px 0 12px; border-bottom: 1px solid #333; padding-bottom: 5px; }}
h3 {{ color: #aaa; margin: 15px 0 8px; font-size: 0.95em; }}
.nav {{ margin-bottom: 20px; font-size: 0.9em; }}
.hero {{ background: #111; border: 1px solid #333; border-radius: 6px; padding: 20px; margin-bottom: 25px; }}
.stats {{ display: flex; flex-wrap: wrap; gap: 12px; margin-top: 12px; }}
.stat {{ background: #0a0a0a; border: 1px solid #333; border-radius: 4px; padding: 6px 14px; }}
.stat .n {{ color: #ff4444; font-size: 1.2em; font-weight: bold; }}
.stat .l {{ color: #666; font-size: 0.8em; }}
.badge {{ display: inline-block; padding: 2px 8px; border-radius: 3px; font-size: 0.8em; margin: 2px; }}
.b-vb {{ background: #1a1a00; color: #ff0; border: 1px solid #ff0; }}
.b-src {{ background: #001a00; color: #0f0; border: 1px solid #0f0; }}
.b-date {{ background: #001a1a; color: #0ff; border: 1px solid #0ff; }}
details {{ margin-bottom: 8px; }}
summary {{ cursor: pointer; padding: 6px 0; }}
summary:hover {{ color: #fff; }}
.cat {{ background: #111; border: 1px solid #333; border-radius: 4px; padding: 12px; margin-bottom: 12px; }}
.cat > summary {{ color: #ff6666; font-size: 1.05em; }}
.file-block > summary {{ color: #4ec9b0; font-size: 0.95em; }}
.fn-block > summary {{ color: #dcdcaa; font-size: 0.9em; }}
pre.code {{ background: #0d0d0d; border: 1px solid #1a1a1a; border-radius: 3px; padding: 10px; overflow-x: auto; font-size: 0.82em; line-height: 1.45; color: #b0b0b0; white-space: pre; margin: 5px 0 10px; max-height: 500px; overflow-y: auto; }}
.kw {{ color: #569cd6; }}
.str {{ color: #ce9178; }}
.cmt {{ color: #6a9955; }}
.api-list {{ column-count: 2; column-gap: 20px; font-size: 0.85em; list-style: none; }}
.api-list li {{ margin-bottom: 2px; }}
.api-list code {{ color: #dcdcaa; }}
.api-list .lib {{ color: #666; }}
table {{ width: 100%; border-collapse: collapse; margin: 8px 0; font-size: 0.9em; }}
th {{ background: #151515; color: #aaa; text-align: left; padding: 6px 10px; border: 1px solid #222; }}
td {{ padding: 6px 10px; border: 1px solid #1a1a1a; }}
.tl {{ border-left: 2px solid #ff444466; padding-left: 15px; margin: 10px 0; }}
.tl-entry {{ margin-bottom: 8px; }}
.tl-date {{ color: #ff4444; }}
.tl-files {{ color: #666; font-size: 0.85em; }}
.footer {{ margin-top: 40px; padding-top: 15px; border-top: 1px solid #222; color: #444; text-align: center; font-size: 0.85em; }}
.aol-class {{ color: #ff0; }}
</style>
</head>
<body>
<div class="container">
<div class="nav">
<a href="../../../../proggie-index.html">&larr; All Proggies</a> &middot;
<a href="../../../../index.html">Home</a> &middot;
<a href="{esc(zip_url)}">Download ZIP</a>
</div>
''')

    # Hero
    h.append(f'''<div class="hero">
<h1>AOHell 95 v3.0</h1>
<div style="color:#888; margin: 5px 0">by Da Chronic &middot; AOL 2.5 / 3.0</div>
<div>
<span class="badge b-vb">VB3 16-bit</span>
<span class="badge b-src">Original Source Code</span>
<span class="badge b-date">File dates: Mar 1994 &ndash; Sep 1995</span>
</div>
<div class="stats">
<div class="stat"><div class="n">{total_lines:,}</div><div class="l">lines</div></div>
<div class="stat"><div class="n">{len(frm_files)}</div><div class="l">forms</div></div>
<div class="stat"><div class="n">{len(bas_files)}</div><div class="l">modules</div></div>
<div class="stat"><div class="n">{len(api_declares)}</div><div class="l">API declares</div></div>
<div class="stat"><div class="n">{len(vbx_files)}</div><div class="l">VBX controls</div></div>
</div>
</div>
''')

    # --- ATTACK FEATURES ---
    h.append('<h2>Features</h2>')
    for cat, cat_forms in attack_forms.items():
        total_code = sum(len(blocks) for _, (_, blocks, _) in cat_forms)
        total_lines_cat = sum(lc for _, (_, _, lc) in cat_forms)
        h.append(f'<details class="cat"><summary>{esc(cat)} &mdash; {len(cat_forms)} form{"s" if len(cat_forms)>1 else ""}, {total_lines_cat:,} lines</summary>')
        for ff, (caption, blocks, lc) in cat_forms:
            desc = feature_map.get(ff, ('', ''))[1]
            src_link = f'aohell-source/{ff}'
            h.append(f'<details class="file-block"><summary><code><a href="{esc(src_link)}" style="color:#4ec9b0">{esc(ff)}</a></code> &mdash; {esc(caption)} ({lc} lines, {len(blocks)} functions)</summary>')
            if desc:
                h.append(f'<div style="color:#666; margin:5px 0; font-size:0.9em">{esc(desc)}</div>')
            for sig, body, end in blocks:
                h.append(f'<details class="fn-block"><summary>{esc(sig)}</summary>')
                h.append(f'<pre class="code">{highlight(sig + chr(10) + body + chr(10) + end)}</pre>')
                h.append('</details>')
            h.append('</details>')
        h.append('</details>')

    # --- ALL FORMS (non-attack) ---
    other_forms = [(ff, forms[ff]) for ff in frm_files
                   if ff in forms and feature_map.get(ff, ('', ''))[0] not in attack_categories]
    if other_forms:
        h.append('<h2>Other Forms</h2>')
        for ff, (caption, blocks, lc) in other_forms:
            cat_name = feature_map.get(ff, ('', ''))[0] or 'Unknown'
            desc = feature_map.get(ff, ('', ''))[1]
            src_link = f'aohell-source/{ff}'
            h.append(f'<details class="file-block"><summary><code><a href="{esc(src_link)}" style="color:#4ec9b0">{esc(ff)}</a></code> &mdash; {esc(caption)} ({lc} lines)</summary>')
            if desc:
                h.append(f'<div style="color:#666; margin:5px 0; font-size:0.9em">{esc(desc)}</div>')
            for sig, body, end in blocks:
                h.append(f'<details class="fn-block"><summary>{esc(sig)}</summary>')
                h.append(f'<pre class="code">{highlight(sig + chr(10) + body + chr(10) + end)}</pre>')
                h.append('</details>')
            h.append('</details>')

    # --- SOURCE MODULES ---
    h.append('<h2>Source Modules</h2>')
    for bf in sorted(modules.keys(), key=lambda x: -modules[x][2]):
        globals_, blocks, lc = modules[bf]
        src_link = f'aohell-source/{bf}'
        parts = []
        if lc:
            parts.append(f'{lc} lines')
        if blocks:
            parts.append(f'{len(blocks)} functions')
        if globals_:
            parts.append(f'{len(globals_)} declarations')
        h.append(f'<details class="file-block"><summary><code><a href="{esc(src_link)}" style="color:#4ec9b0">{esc(bf)}</a></code> &mdash; {", ".join(parts)}</summary>')
        if globals_:
            h.append(f'<h3>Declarations</h3>')
            h.append(f'<pre class="code">{highlight(chr(10).join(globals_))}</pre>')
        for sig, body, end in blocks:
            h.append(f'<details class="fn-block"><summary>{esc(sig)}</summary>')
            h.append(f'<pre class="code">{highlight(sig + chr(10) + body + chr(10) + end)}</pre>')
            h.append('</details>')
        h.append('</details>')

    # --- AOL WINDOW CLASSES ---
    h.append('<h2>AOL Window Classes Referenced</h2>')
    h.append('<p style="color:#888; font-size:0.9em">These are the AOL 2.5/3.0 internal window class names targeted by FindChildByClass calls:</p>')
    h.append('<ul style="list-style:none; margin:10px 0">')
    for cls in sorted(aol_classes):
        h.append(f'<li><code class="aol-class">{esc(cls)}</code></li>')
    h.append('</ul>')

    # --- WIN16 API ---
    h.append(f'<h2>Win16 API Calls ({len(api_declares)})</h2>')
    h.append('<ul class="api-list">')
    for decl in sorted(api_declares):
        m = re.match(r'Declare (?:Function|Sub)\s+(\w+)\s+Lib\s+"([^"]+)"', decl)
        if m:
            func, lib = m.group(1), m.group(2)
            h.append(f'<li><code>{esc(func)}</code> <span class="lib">({esc(lib)})</span></li>')
    h.append('</ul>')

    # --- VBX DEPS ---
    h.append('<h2>VBX Dependencies</h2>')
    h.append('<table><tr><th>File</th><th>Description</th></tr>')
    for vbx in vbx_files:
        name = os.path.basename(vbx).upper()
        desc = vbx_info.get(name, '')
        h.append(f'<tr><td><code>{esc(name)}</code></td><td>{esc(desc)}</td></tr>')
    h.append('</table>')

    # --- FILE DATES ---
    h.append('<h2>File Dates</h2>')
    h.append('<p style="color:#888; font-size:0.9em; margin-bottom:10px">Modification timestamps from the source archive. May reflect extraction date rather than authoring date.</p>')
    h.append('<div class="tl">')
    for ym in sorted(file_dates.keys()):
        files = sorted(file_dates[ym], key=lambda x: x[1])
        dt = datetime.strptime(ym, '%Y-%m')
        label = dt.strftime('%B %Y')
        names = [f for f, _ in files]
        h.append(f'<div class="tl-entry"><span class="tl-date">{esc(label)}</span> ')
        h.append(f'<span class="tl-files">&mdash; {", ".join(esc(n) for n in names[:10])}')
        if len(names) > 10:
            h.append(f' + {len(names)-10} more')
        h.append('</span></div>')
    h.append('</div>')

    # Footer
    h.append(f'''<div class="footer">
<a href="{esc(zip_url)}">Download ZIP</a> &middot;
Source: <code>programming/vb/aol/25-30/_extracted/AOHELL95_source_code/AOH/</code>
</div>
</div>
</body>
</html>''')

    OUT.write_text('\n'.join(h), encoding='utf-8')
    print(f'Generated: {OUT} ({os.path.getsize(OUT):,} bytes)')


if __name__ == '__main__':
    generate()
