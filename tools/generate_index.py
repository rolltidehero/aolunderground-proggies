#!/usr/bin/env python3
"""Generate proggie-index.html from proggie_db.sqlite."""
import json
import sqlite3
from pathlib import Path

GITHUB_RAW = "https://github.com/ssstonebraker/aolunderground-proggies/raw/main/"
DB_PATH = Path(__file__).resolve().parent.parent / "proggie_db.sqlite"
OUT_PATH = Path(__file__).resolve().parent.parent / "proggie-index.html"


def load_proggies():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    rows = conn.execute("""
        SELECT p.name, p.author, p.platform, p.aol_version,
               p.zip_path, p.zip_stem, p.password,
               e.vb_version, e.compile_type
        FROM proggies p
        LEFT JOIN exes e ON e.proggie_id = p.id AND e.is_primary = 1
        ORDER BY LOWER(COALESCE(p.name, p.zip_stem))
    """).fetchall()
    conn.close()
    proggies = []
    for r in rows:
        html_path = Path(r['zip_path']).parent.parent / r['aol_version'] / (r['zip_stem'] + '.html')
        proggies.append({
            'name': r['name'] or r['zip_stem'] or 'Unknown',
            'author': r['author'] or '',
            'versions': [r['aol_version']],
            'primary': r['aol_version'],
            'file': r['zip_path'],
            'password': r['password'] or '',
            'platform': r['platform'] or 'AOL',
            'vb_version': r['vb_version'] or 'unknown',
            'compile_type': r['compile_type'] or 'unknown',
            'html': str(html_path),
        })
    return proggies


def generate_html(proggies):
    data_json = json.dumps(proggies, ensure_ascii=False)
    return f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>AOL Underground Proggies — Search</title>
<style>
body {{ background: #0a0a0a; color: #0f0; font-family: 'Courier New', monospace; margin: 20px; }}
h1 {{ color: #0ff; text-align: center; }}
.controls {{ text-align: center; margin: 20px 0; }}
input, select {{ background: #111; color: #0f0; border: 1px solid #0f0; padding: 8px 12px; font-family: inherit; font-size: 14px; margin: 4px; }}
input::placeholder {{ color: #060; }}
table {{ width: 100%; border-collapse: collapse; margin-top: 10px; }}
th {{ background: #111; color: #0ff; padding: 10px; text-align: left; border: 1px solid #0f0; cursor: pointer; }}
td {{ padding: 8px 10px; border: 1px solid #030; }}
tr:hover {{ background: #111; }}
a {{ color: #0ff; text-decoration: none; }}
a:hover {{ text-decoration: underline; }}
.aim {{ color: #f0f; }}
.password {{ color: #ff0; }}
.stats {{ text-align: center; color: #060; margin: 10px 0; }}
.dl {{ color: #0f0; }}
</style>
</head>
<body>
<h1>&#x1f4be; AOL Underground Proggies Archive</h1>
<div class="controls">
<input type="text" id="search" placeholder="Search by name, author, or filename..." size="40">
<select id="platform-filter"><option value="">All Platforms</option><option value="AOL">AOL</option><option value="AIM">AIM</option></select>
<select id="version-filter"><option value="">All Versions</option></select>
</div>
<div class="stats">Showing <span id="showing">0</span> of {len(proggies)} proggies</div>
<table><thead><tr><th>Name</th><th>Author</th><th>Platform</th><th>Version</th><th>Download</th><th>Password</th></tr></thead><tbody id="results"></tbody></table>
<script>
const GITHUB_RAW = {json.dumps(GITHUB_RAW)};
const proggies = {data_json};
const versions = new Set();
proggies.forEach(p => versions.add(p.primary));
const vf = document.getElementById('version-filter');
Array.from(versions).sort().forEach(v => {{ const o = document.createElement('option'); o.value = v; o.textContent = v; vf.appendChild(o); }});
function render(list) {{
  const tb = document.getElementById('results');
  tb.innerHTML = '';
  list.forEach(p => {{
    const r = tb.insertRow();
    const nc = r.insertCell(0); if(p.html) {{ const na = document.createElement('a'); na.href = p.html; na.textContent = p.name; na.style.color='#0ff'; nc.appendChild(na); }} else {{ nc.textContent = p.name; }}
    r.insertCell(1).textContent = p.author;
    const pc = r.insertCell(2); pc.textContent = p.platform; if(p.platform==='AIM') pc.className='aim';
    r.insertCell(3).textContent = p.primary;
    const fc = r.insertCell(4); const a = document.createElement('a'); a.href = GITHUB_RAW + p.file; a.textContent = p.file.split('/').pop(); a.className='dl'; fc.appendChild(a);
    const pw = r.insertCell(5); pw.textContent = p.password; if(p.password) pw.className='password';
  }});
  document.getElementById('showing').textContent = list.length;
}}
function filter() {{
  const s = document.getElementById('search').value.toLowerCase();
  const pf = document.getElementById('platform-filter').value;
  const vf = document.getElementById('version-filter').value;
  render(proggies.filter(p =>
    (!s || p.name.toLowerCase().includes(s) || p.author.toLowerCase().includes(s) || p.file.toLowerCase().includes(s)) &&
    (!pf || p.platform === pf) &&
    (!vf || p.primary === vf)
  ));
}}
document.getElementById('search').addEventListener('input', filter);
document.getElementById('platform-filter').addEventListener('change', filter);
document.getElementById('version-filter').addEventListener('change', filter);
render(proggies);
</script>
</body>
</html>"""


def main():
    proggies = load_proggies()
    html = generate_html(proggies)
    OUT_PATH.write_text(html, encoding='utf-8')
    print(f"Created: {OUT_PATH} ({len(proggies)} proggies)")


if __name__ == '__main__':
    main()
