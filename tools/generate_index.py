#!/usr/bin/env python3
"""Generate proggie-index.html from proggie_db.sqlite."""
import json
import sqlite3
from pathlib import Path

from static_loader import load_css, load_js

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
<style>{load_css("index.css")}</style>
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
{load_js("index.js")}
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
