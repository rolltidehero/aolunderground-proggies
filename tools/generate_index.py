#!/usr/bin/env python3
"""Generate proggie-index.html from proggie_db.sqlite."""
import json
import sqlite3
from pathlib import Path

GITHUB_RAW = "https://github.com/ssstonebraker/aolunderground-proggies/raw/main/"
DB_PATH = Path(__file__).resolve().parent.parent / "proggie_db.sqlite"
OUT_PATH = Path(__file__).resolve().parent.parent / "proggie-index.html"
REPO_ROOT = Path(__file__).resolve().parent.parent


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

    # Detect which proggies have screenshots or source
    sorted_dir = REPO_ROOT / "programs" / "AOL" / "proggies-sorted-deduped"
    proggies = []
    for r in rows:
        stem = r['zip_stem']
        ver = r['aol_version']
        asset_dir = sorted_dir / ver / stem
        has_screenshot = (asset_dir / "screenshot.png").exists() or (asset_dir / "main_form.png").exists()
        has_source = (asset_dir / "source").exists()
        html_path = sorted_dir / ver / (stem + '.html')
        has_html = html_path.exists()

        proggies.append({
            'name': r['name'] or stem or 'Unknown',
            'author': r['author'] or '',
            'versions': [ver],
            'primary': ver,
            'file': r['zip_path'],
            'password': r['password'] or '',
            'platform': r['platform'] or 'AOL',
            'vb_version': r['vb_version'] or 'unknown',
            'compile_type': r['compile_type'] or 'unknown',
            'html': f"programs/AOL/proggies-sorted-deduped/{ver}/{stem}.html" if has_html else '',
            'has_screenshot': has_screenshot,
            'has_source': has_source,
        })
    return proggies


def generate_html(proggies):
    data_json = json.dumps(proggies, ensure_ascii=False)
    n_source = sum(1 for p in proggies if p['has_source'])
    n_screenshots = sum(1 for p in proggies if p['has_screenshot'])
    return f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>AOL Underground Proggies - Search</title>
<style>
body {{ background: #0a0a0a; color: #0f0; font-family: 'Courier New', monospace; margin: 0; padding: 0; }}
.topbar {{ background: #111; border-bottom: 1px solid #0f0; padding: 10px 20px; display: flex; align-items: center; gap: 16px; position: sticky; top: 0; z-index: 10; }}
.topbar a {{ color: #0ff; text-decoration: none; }}
.topbar a:hover {{ text-decoration: underline; }}
.topbar h1 {{ color: #0ff; font-size: 18px; margin: 0; }}
.content {{ padding: 20px; }}
.controls {{ margin: 12px 0; display: flex; flex-wrap: wrap; gap: 8px; align-items: center; }}
input, select {{ background: #111; color: #0f0; border: 1px solid #0f0; padding: 8px 12px; font-family: inherit; font-size: 14px; }}
input::placeholder {{ color: #060; }}
.chip {{ display: inline-block; padding: 4px 10px; border: 1px solid #333; border-radius: 12px; cursor: pointer; font-size: 12px; user-select: none; background: #111; color: #888; }}
.chip:hover {{ border-color: #0f0; color: #0f0; }}
.chip.active {{ background: #0f0; color: #000; border-color: #0f0; font-weight: bold; }}
.chip.active-src {{ background: #f0f; color: #000; border-color: #f0f; }}
.chip.active-img {{ background: #ff0; color: #000; border-color: #ff0; }}
table {{ width: 100%; border-collapse: collapse; margin-top: 10px; }}
th {{ background: #111; color: #0ff; padding: 10px; text-align: left; border: 1px solid #0f0; cursor: pointer; user-select: none; white-space: nowrap; }}
th:hover {{ background: #1a1a1a; }}
th .arrow {{ font-size: 10px; margin-left: 4px; }}
td {{ padding: 8px 10px; border: 1px solid #030; }}
tr:hover {{ background: #111; }}
a {{ color: #0ff; text-decoration: none; }}
a:hover {{ text-decoration: underline; }}
.aim {{ color: #f0f; }}
.password {{ color: #ff0; }}
.stats {{ color: #060; margin: 8px 0; font-size: 13px; }}
.dl {{ color: #0f0; }}
.badge {{ display: inline-block; padding: 1px 6px; border-radius: 3px; font-size: 11px; margin-left: 4px; }}
.badge-src {{ background: #303; color: #f0f; }}
.badge-img {{ background: #330; color: #ff0; }}
.badge-vb {{ background: #030; color: #0f0; }}
</style>
</head>
<body>
<div class="topbar">
<a href="index.html">&larr; Home</a>
<h1>AOL Underground Proggies</h1>
</div>
<div class="content">
<div class="controls">
<input type="text" id="search" placeholder="Search name, author, or file..." size="35">
<select id="platform-filter"><option value="">All Platforms</option><option value="AOL">AOL</option><option value="AIM">AIM</option></select>
<select id="version-filter"><option value="">All Versions</option></select>
<span class="chip" id="chip-src" onclick="toggleChip('src')">Has Source ({n_source})</span>
<span class="chip" id="chip-img" onclick="toggleChip('img')">Has Screenshots ({n_screenshots})</span>
</div>
<div class="stats">Showing <span id="showing">0</span> of {len(proggies)} proggies</div>
<table><thead><tr>
<th data-col="name">Name <span class="arrow"></span></th>
<th data-col="author">Author <span class="arrow"></span></th>
<th data-col="platform">Platform <span class="arrow"></span></th>
<th data-col="primary">Version <span class="arrow"></span></th>
<th data-col="vb_version">VB <span class="arrow"></span></th>
<th>Download</th>
<th data-col="password">Password <span class="arrow"></span></th>
</tr></thead><tbody id="results"></tbody></table>
</div>
<script>
const GITHUB_RAW = {json.dumps(GITHUB_RAW)};
const proggies = {data_json};
const versions = new Set();
proggies.forEach(p => versions.add(p.primary));
const vf = document.getElementById('version-filter');
Array.from(versions).sort().forEach(v => {{ const o = document.createElement('option'); o.value = v; o.textContent = v; vf.appendChild(o); }});

let sortCol = null, sortAsc = true;
let chipSrc = false, chipImg = false;

function toggleChip(which) {{
  if (which === 'src') {{ chipSrc = !chipSrc; document.getElementById('chip-src').classList.toggle('active-src'); }}
  if (which === 'img') {{ chipImg = !chipImg; document.getElementById('chip-img').classList.toggle('active-img'); }}
  doFilter();
}}

function render(list) {{
  const tb = document.getElementById('results');
  tb.innerHTML = '';
  list.forEach(p => {{
    const r = tb.insertRow();
    const nc = r.insertCell(0);
    if (p.html) {{ const na = document.createElement('a'); na.href = p.html; na.textContent = p.name; nc.appendChild(na); }}
    else {{ nc.textContent = p.name; }}
    if (p.has_source) {{ const b = document.createElement('span'); b.className='badge badge-src'; b.textContent='src'; nc.appendChild(b); }}
    if (p.has_screenshot) {{ const b = document.createElement('span'); b.className='badge badge-img'; b.textContent='img'; nc.appendChild(b); }}
    r.insertCell(1).textContent = p.author;
    const pc = r.insertCell(2); pc.textContent = p.platform; if(p.platform==='AIM') pc.className='aim';
    r.insertCell(3).textContent = p.primary;
    const vc = r.insertCell(4); vc.textContent = p.vb_version; if(p.vb_version && p.vb_version !== 'unknown') {{ vc.innerHTML = '<span class="badge badge-vb">' + p.vb_version + '</span>'; }}
    const fc = r.insertCell(5); const a = document.createElement('a'); a.href = GITHUB_RAW + p.file; a.textContent = p.file.split('/').pop(); a.className='dl'; fc.appendChild(a);
    const pw = r.insertCell(6); pw.textContent = p.password; if(p.password) pw.className='password';
  }});
  document.getElementById('showing').textContent = list.length;
}}

function doFilter() {{
  const s = document.getElementById('search').value.toLowerCase();
  const pf = document.getElementById('platform-filter').value;
  const vfv = document.getElementById('version-filter').value;
  let list = proggies.filter(p =>
    (!s || p.name.toLowerCase().includes(s) || p.author.toLowerCase().includes(s) || p.file.toLowerCase().includes(s)) &&
    (!pf || p.platform === pf) &&
    (!vfv || p.primary === vfv) &&
    (!chipSrc || p.has_source) &&
    (!chipImg || p.has_screenshot)
  );
  if (sortCol) {{
    list = list.slice().sort((a, b) => {{
      let va = (a[sortCol] || '').toString().toLowerCase();
      let vb = (b[sortCol] || '').toString().toLowerCase();
      if (va < vb) return sortAsc ? -1 : 1;
      if (va > vb) return sortAsc ? 1 : -1;
      return 0;
    }});
  }}
  render(list);
}}

document.querySelectorAll('th[data-col]').forEach(th => {{
  th.addEventListener('click', () => {{
    const col = th.dataset.col;
    if (sortCol === col) {{ sortAsc = !sortAsc; }} else {{ sortCol = col; sortAsc = true; }}
    document.querySelectorAll('th .arrow').forEach(a => a.textContent = '');
    th.querySelector('.arrow').textContent = sortAsc ? ' \\u25B2' : ' \\u25BC';
    doFilter();
  }});
}});

document.getElementById('search').addEventListener('input', doFilter);
document.getElementById('platform-filter').addEventListener('change', doFilter);
document.getElementById('version-filter').addEventListener('change', doFilter);
doFilter();
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
