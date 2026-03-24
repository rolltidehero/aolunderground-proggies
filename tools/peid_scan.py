#!/usr/bin/env python3
"""Identify compiler/packer for all exes using PEiD signatures (5,500+).
Updates merge_report.json vb_info with peid_match field."""
import json, zipfile, tempfile, os, sys
from peid import identify_packer

REPORT = "data/merged/merge_report.json"

def scan_exe(raw_bytes):
    """Write exe to temp file, run peid, return best match string."""
    with tempfile.NamedTemporaryFile(suffix='.exe', delete=False) as f:
        f.write(raw_bytes)
        tmpf = f.name
    try:
        matches = identify_packer(tmpf)
        if matches and matches[0][1]:
            return matches[0][1]  # all matches, most specific last
        return []
    except:
        return []
    finally:
        os.unlink(tmpf)

def main():
    with open(REPORT) as f:
        report = json.load(f)

    stats = {}
    total = len(report['merges'])

    for i, merge in enumerate(report['merges']):
        zip_path = merge['merged_archive']
        exe_name = merge['metadata'].get('exe_name', '')
        if not exe_name or not os.path.exists(zip_path):
            continue

        try:
            with zipfile.ZipFile(zip_path) as z:
                raw = z.read(exe_name)
        except:
            continue

        matches = scan_exe(raw)
        vb_info = merge['metadata'].setdefault('vb_info', {})

        if matches:
            best = matches[-1]  # most specific
            vb_info['peid_match'] = best
            vb_info['peid_all'] = matches

            # If we tagged it non-VB but peid says VB, fix it
            if vb_info.get('version') == 'non-VB':
                bl = best.lower()
                if 'visual basic' in bl or 'vb 5' in bl or 'vb 6' in bl or 'vb5' in bl or 'vb6' in bl:
                    vb_info['version'] = 'VB-peid'
                    vb_info['compile_type'] = 'native'
        else:
            vb_info['peid_match'] = '(unknown)'
            vb_info['peid_all'] = []

        key = vb_info.get('peid_match', '(unknown)')
        stats[key] = stats.get(key, 0) + 1

        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{total} scanned", file=sys.stderr)

    with open(REPORT, 'w') as f:
        json.dump(report, f, indent=2)

    print(f"\nPEiD Scan Complete ({total} archives):")
    for k, v in sorted(stats.items(), key=lambda x: -x[1])[:40]:
        print(f"  {v:4d}  {k}")
    remaining = sum(v for k, v in stats.items()) - sum(v for _, v in sorted(stats.items(), key=lambda x: -x[1])[:40])
    if remaining > 0:
        print(f"  ... and {len(stats)-40} more categories ({remaining} files)")

if __name__ == '__main__':
    main()
