#!/usr/bin/env python3
"""Generate combined proggie index including AOL and AIM."""
import json
from pathlib import Path
from collections import defaultdict

def load_aol():
    with open("data/merged/merge_report.json") as f:
        data = json.load(f)
    proggies = []
    for m in data['merges']:
        meta = m['metadata']
        proggies.append({
            'name': meta.get('program_name', 'Unknown'),
            'author': meta.get('author', 'Unknown'),
            'versions': meta.get('aol_versions', ['Unknown']),
            'primary': meta.get('primary_version', 'Unknown'),
            'file': m['merged_archive'],
            'dupes': len(m['merged_from']),
            'password': meta.get('password', ''),
            'platform': 'AOL'
        })
    return proggies

def load_aim():
    with open("data/aim/merged/merge_report.json") as f:
        data = json.load(f)
    proggies = []
    for m in data['merges']:
        meta = m['metadata']
        proggies.append({
            'name': meta.get('program_name', 'Unknown'),
            'author': meta.get('author', 'Unknown'),
            'versions': ['AIM'],
            'primary': 'AIM',
            'file': m['merged_archive'],
            'dupes': len(m['merged_from']),
            'password': meta.get('password', ''),
            'platform': 'AIM'
        })
    # Also add non-duplicate AIM archives
    merged_sources = set()
    for m in data['merges']:
        for src in m['merged_from']:
            merged_sources.add(Path(src).name)

    for f in sorted(Path("programs/AIM").glob("*.zip")) + sorted(Path("programs/AIM").glob("*.rar")):
        if f.name not in merged_sources:
            proggies.append({
                'name': f.stem,
                'author': 'Unknown',
                'versions': ['AIM'],
                'primary': 'AIM',
                'file': str(f),
                'dupes': 1,
                'password': '',
                'platform': 'AIM'
            })
    return proggies

def generate_txt(proggies):
    with open("proggie-index.txt", 'w') as f:
        f.write("NAME\tAUTHOR\tPLATFORM\tVERSIONS\tFILE\tDUPLICATES\tPASSWORD\n")
        for p in proggies:
            f.write(f"{p['name']}\t{p['author']}\t{p['platform']}\t{', '.join(p['versions'])}\t{p['file']}\t{p['dupes']}\t{p['password']}\n")
    print(f"Created: proggie-index.txt ({len(proggies)} entries)")

def generate_md(proggies):
    by_platform = defaultdict(lambda: defaultdict(list))
    for p in proggies:
        by_platform[p['platform']][p['primary'] or 'Unknown'].append(p)

    with open("proggie-index.md", 'w') as f:
        f.write("# AOL Underground Proggies Index\n\n")
        f.write(f"**Total Proggies:** {len(proggies)} ({sum(1 for p in proggies if p['platform']=='AOL')} AOL, {sum(1 for p in proggies if p['platform']=='AIM')} AIM)\n\n")

        for platform in ['AOL', 'AIM']:
            f.write(f"## {platform} Proggies\n\n")
            versions = by_platform[platform]
            for ver in sorted(versions.keys(), key=lambda x: (x == 'Unknown', x)):
                items = sorted(versions[ver], key=lambda x: x['name'].lower())
                anchor = f"{platform.lower()}-{ver.replace('.', '')}".lower()
                f.write(f"### {platform} {ver} ({len(items)} proggies)\n\n")
                f.write("| Name | Author | File | Password |\n")
                f.write("|------|--------|------|----------|\n")
                for p in items:
                    f.write(f"| {p['name']} | {p['author']} | `{Path(p['file']).name}` | {p['password']} |\n")
                f.write("\n")
    print(f"Created: proggie-index.md")

def generate_html(proggies):
    html = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AOL Underground Proggies Index</title>
<style>
body { font-family: 'Courier New', monospace; background: #000; color: #0f0; padding: 20px; }
h1 { color: #0ff; text-shadow: 0 0 10px #0ff; }
.search-box { width: 100%%; padding: 10px; font-size: 16px; background: #111; color: #0f0; border: 2px solid #0f0; margin-bottom: 20px; box-sizing: border-box; }
.filters { margin-bottom: 20px; }
.filters select { padding: 5px; background: #111; color: #0f0; border: 1px solid #0f0; margin-right: 10px; }
table { width: 100%%; border-collapse: collapse; }
th { background: #111; color: #0ff; padding: 10px; text-align: left; border: 1px solid #0f0; cursor: pointer; }
td { padding: 8px; border: 1px solid #333; }
tr:hover { background: #111; }
.stats { color: #ff0; margin-bottom: 20px; }
.password { color: #f00; }
.aim { color: #ff0; }
</style>
</head>
<body>
<h1>AOL Underground Proggies Index</h1>
<div class="stats">
<strong>Total:</strong> <span id="total">TOTAL</span> |
<strong>Showing:</strong> <span id="showing">TOTAL</span>
</div>
<input type="text" class="search-box" id="search" placeholder="Search by name, author, or file..." />
<div class="filters">
<label>Platform: <select id="platform-filter"><option value="">All</option><option value="AOL">AOL</option><option value="AIM">AIM</option></select></label>
<label>Version: <select id="version-filter"><option value="">All Versions</option></select></label>
</div>
<table><thead><tr>
<th>Name</th><th>Author</th><th>Platform</th><th>Version</th><th>File</th><th>Password</th>
</tr></thead><tbody id="results"></tbody></table>
<script>
const proggies = PROGGIES_JSON;
document.getElementById('total').textContent = proggies.length;
const versions = new Set();
proggies.forEach(p => versions.add(p.primary));
const vf = document.getElementById('version-filter');
Array.from(versions).sort().forEach(v => { const o = document.createElement('option'); o.value = v; o.textContent = v; vf.appendChild(o); });
function render(list) {
  const tb = document.getElementById('results');
  tb.innerHTML = '';
  list.forEach(p => {
    const r = tb.insertRow();
    r.insertCell(0).textContent = p.name;
    r.insertCell(1).textContent = p.author;
    const pc = r.insertCell(2); pc.textContent = p.platform; if(p.platform==='AIM') pc.className='aim';
    r.insertCell(3).textContent = p.primary;
    r.insertCell(4).textContent = p.file.split('/').pop();
    const pw = r.insertCell(5); pw.textContent = p.password; if(p.password) pw.className='password';
  });
  document.getElementById('showing').textContent = list.length;
}
function filter() {
  const s = document.getElementById('search').value.toLowerCase();
  const pf = document.getElementById('platform-filter').value;
  const vf = document.getElementById('version-filter').value;
  render(proggies.filter(p =>
    (!s || p.name.toLowerCase().includes(s) || p.author.toLowerCase().includes(s) || p.file.toLowerCase().includes(s)) &&
    (!pf || p.platform === pf) &&
    (!vf || p.primary === vf)
  ));
}
document.getElementById('search').addEventListener('input', filter);
document.getElementById('platform-filter').addEventListener('change', filter);
document.getElementById('version-filter').addEventListener('change', filter);
render(proggies);
</script>
</body>
</html>"""

    json_data = json.dumps([{k: v for k, v in p.items() if k != 'dupes'} for p in proggies])
    html = html.replace('PROGGIES_JSON', json_data).replace('TOTAL', str(len(proggies)))

    with open("proggie-index.html", 'w') as f:
        f.write(html)
    print(f"Created: proggie-index.html")

def main():
    aol = load_aol()
    aim = load_aim()
    all_proggies = sorted(aol + aim, key=lambda x: x['name'].lower())
    generate_txt(all_proggies)
    generate_md(all_proggies)
    generate_html(all_proggies)

if __name__ == '__main__':
    main()
