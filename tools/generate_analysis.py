#!/usr/bin/env python3
"""Generate per-proggie HTML analysis pages with highlighted key strings."""
import zipfile, os, re, json, sys, html as htmlmod

REPORT = "data/merged/merge_report.json"
SORTED_DIR = "programs/AOL/proggies-sorted-deduped"

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

CSS = """<style>
body{font-family:monospace;background:#1a1a2e;color:#e0e0e0;margin:20px;max-width:900px}
h1{color:#0ff;font-size:1.3em}h2{color:#888;font-size:1em;margin-top:1.5em;border-bottom:1px solid #333}
.meta{color:#aaa;margin-bottom:20px}.meta b{color:#0ff}
.s{padding:2px 4px;margin:1px 0;display:block;white-space:pre-wrap;word-break:break-all}
.author{background:#2a0a2a;border-left:3px solid #f0f;color:#f8f}
.credits{background:#0a2a2a;border-left:3px solid #0ff;color:#aff}
.api{background:#2a2a0a;border-left:3px solid #ff0;color:#ffa}
.form{background:#0a2a0a;border-left:3px solid #0f0;color:#afa}
.dep{background:#2a1a0a;border-left:3px solid #fa0;color:#fca}
.plain{color:#666}
.legend{display:flex;gap:15px;flex-wrap:wrap;margin:10px 0}
.legend span{padding:2px 8px;font-size:0.85em}
a{color:#0af}
</style>"""

def classify(s):
    for pat, cls in HIGHLIGHT_PATTERNS:
        if pat.search(s):
            return cls
    return None

def extract_strings(zip_path):
    strings = []
    try:
        with zipfile.ZipFile(zip_path) as z:
            for name in z.namelist():
                if name.lower().endswith('.exe'):
                    data = z.read(name)
                    for m in re.findall(rb'[\x20-\x7e]{4,}', data):
                        strings.append(m.decode('ascii'))
                    for m in re.finditer(rb'(?:[\x20-\x7e]\x00){4,}', data):
                        try: strings.append(m.group().decode('utf-16-le'))
                        except: pass
    except:
        pass
    return strings

def generate_html(merge, strings):
    meta = merge['metadata']
    name = meta.get('archive_name', '?')
    author = meta.get('author') or 'Unknown'
    version = meta.get('primary_version', '?')
    program = meta.get('program_name', '?')
    cat = meta.get('category', '?')
    exe = meta.get('exe_name', '?')
    vb = meta.get('vb_info', {})
    vb_ver = vb.get('version', '?')
    compile_type = vb.get('compile_type', '?')

    # Dedupe strings, preserve order
    seen = set()
    unique = []
    for s in strings:
        s = s.strip()
        if s and s not in seen and len(s) >= 4:
            seen.add(s)
            unique.append(s)

    # Separate by category
    categorized = {'author': [], 'credits': [], 'api': [], 'form': [], 'dep': [], None: []}
    for s in unique:
        cls = classify(s)
        categorized[cls].append(s)

    # Skip phishing strings (they're noise)
    skip_re = re.compile(r'credit card|billing department|password|america online.*sorry|america online.*inform', re.I)

    lines = [f'<!DOCTYPE html><html><head><meta charset="utf-8"><title>{htmlmod.escape(name)} - Analysis</title>{CSS}</head><body>']
    lines.append(f'<h1>&#x1f50d; {htmlmod.escape(name)}</h1>')
    lines.append(f'<div class="meta"><b>Program:</b> {htmlmod.escape(program)} | <b>Author:</b> {htmlmod.escape(author)} | <b>AOL Version:</b> {htmlmod.escape(str(version))} | <b>Category:</b> {htmlmod.escape(cat)} | <b>Exe:</b> {htmlmod.escape(exe)} | <b>VB:</b> {htmlmod.escape(vb_ver)} | <b>Compile:</b> {htmlmod.escape(compile_type)}</div>')
    lines.append('<div class="legend"><span class="s author">Author Evidence</span><span class="s credits">Credits/Greets</span><span class="s api">AOL API</span><span class="s form">VB Forms</span><span class="s dep">Dependencies</span></div>')

    for section, label in [('author', '&#x1f58a; Author Evidence'), ('credits', '&#x1f91d; Credits &amp; Greets'),
                           ('api', '&#x2699; AOL API References'), ('form', '&#x1f4cb; VB Forms'), ('dep', '&#x1f4e6; Dependencies')]:
        items = categorized[section]
        if not items:
            continue
        lines.append(f'<h2>{label} ({len(items)})</h2>')
        for s in items[:50]:
            if skip_re.search(s):
                continue
            lines.append(f'<span class="s {section}">{htmlmod.escape(s[:200])}</span>')

    # Show some plain strings (non-phishing, non-trivial)
    plain = [s for s in categorized[None] if len(s) > 10 and not skip_re.search(s)]
    if plain:
        lines.append(f'<h2>Other Strings ({len(plain)})</h2>')
        for s in plain[:80]:
            lines.append(f'<span class="s plain">{htmlmod.escape(s[:200])}</span>')

    lines.append('</body></html>')
    return '\n'.join(lines)

def main():
    with open(REPORT) as f:
        report = json.load(f)

    generated = 0
    total = len(report['merges'])

    for i, merge in enumerate(report['merges']):
        meta = merge['metadata']
        version = meta.get('primary_version', 'unknown')
        archive = meta.get('archive_name', '')
        base = archive.rsplit('.', 1)[0] if '.' in archive else archive

        zip_path = merge['merged_archive']
        if not os.path.exists(zip_path):
            continue

        html_path = os.path.join(SORTED_DIR, str(version), base + '.html')
        os.makedirs(os.path.dirname(html_path), exist_ok=True)
        strings = extract_strings(zip_path)
        if not strings:
            continue

        page = generate_html(merge, strings)
        with open(html_path, 'w', encoding='utf-8') as f:
            f.write(page)
        generated += 1

        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{total} processed, {generated} pages generated", file=sys.stderr)

    print(f"Done: {generated} analysis pages generated")

if __name__ == '__main__':
    main()
