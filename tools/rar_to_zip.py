#!/usr/bin/env python3
"""Convert all .rar files in data/merged/ to Win3.1-compatible .zip files.

ZIP compatibility: ZIP 2.0 (Deflate, no ZIP64, no UTF-8 flag).
Updates merge_report.json paths accordingly.
"""
import os, sys, json, tempfile, shutil, zipfile, subprocess

MERGED_DIR = "data/merged"
REPORT = "data/merged/merge_report.json"

def rar_to_zip(rar_path):
    """Extract RAR, repack as Win3.1-compatible ZIP. Returns new zip path or None."""
    zip_path = rar_path.rsplit('.', 1)[0] + '.zip'
    if os.path.exists(zip_path):
        # ZIP already exists with same base name — append _from_rar
        zip_path = rar_path.rsplit('.', 1)[0] + '_from_rar.zip'

    tmpdir = tempfile.mkdtemp()
    try:
        # Extract with 7z (handles all RAR versions)
        r = subprocess.run(['7z', 'x', '-y', f'-o{tmpdir}', rar_path],
                           capture_output=True, timeout=60)
        if r.returncode != 0:
            return None

        # Repack as ZIP 2.0 (Deflate, no ZIP64, no UTF-8 names flag)
        with zipfile.ZipFile(zip_path, 'w', compression=zipfile.ZIP_DEFLATED,
                             allowZip64=False) as zf:
            for root, dirs, files in os.walk(tmpdir):
                for f in files:
                    full = os.path.join(root, f)
                    arcname = os.path.relpath(full, tmpdir)
                    # Encode name as CP437 for Win3.1 compat
                    try:
                        arcname.encode('cp437')
                    except UnicodeEncodeError:
                        # Replace non-CP437 chars
                        arcname = arcname.encode('cp437', errors='replace').decode('cp437')
                    zf.write(full, arcname)

        # Remove original RAR
        os.remove(rar_path)
        return zip_path
    except Exception as e:
        print(f"  FAIL {rar_path}: {e}", file=sys.stderr)
        # Clean up partial zip
        if os.path.exists(zip_path) and not os.path.exists(rar_path):
            pass  # keep it if rar already deleted
        elif os.path.exists(zip_path):
            os.remove(zip_path)
        return None
    finally:
        shutil.rmtree(tmpdir, ignore_errors=True)

def main():
    rars = sorted(f for f in os.listdir(MERGED_DIR) if f.lower().endswith('.rar'))
    print(f"Converting {len(rars)} RAR files to Win3.1-compatible ZIP...", file=sys.stderr)

    # Build rename map: old path -> new path
    rename_map = {}
    converted = 0
    failed = 0

    for i, name in enumerate(rars):
        rar_path = os.path.join(MERGED_DIR, name)
        new_path = rar_to_zip(rar_path)
        if new_path:
            rename_map[rar_path] = new_path
            converted += 1
        else:
            failed += 1
        if (i + 1) % 50 == 0:
            print(f"  {i+1}/{len(rars)} done, {converted} converted, {failed} failed", file=sys.stderr)

    print(f"\nConverted: {converted}, Failed: {failed}", file=sys.stderr)

    # Update merge_report.json
    if rename_map:
        with open(REPORT) as f:
            report = json.load(f)

        updated = 0
        for merge in report['merges']:
            old = merge['merged_archive']
            if old in rename_map:
                merge['merged_archive'] = rename_map[old]
                updated += 1

        with open(REPORT, 'w') as f:
            json.dump(report, f, indent=2)
        print(f"Updated {updated} paths in merge_report.json")

    # Also convert any RARs in proggies-by-version
    byver_dir = "programs/AOL/proggies-by-version"
    if os.path.isdir(byver_dir):
        ver_rars = []
        for root, dirs, files in os.walk(byver_dir):
            for f in files:
                if f.lower().endswith('.rar'):
                    ver_rars.append(os.path.join(root, f))
        if ver_rars:
            print(f"\nConverting {len(ver_rars)} RARs in proggies-by-version...", file=sys.stderr)
            vc = 0
            for rp in ver_rars:
                if rar_to_zip(rp):
                    vc += 1
            print(f"  Converted {vc}/{len(ver_rars)}")

if __name__ == '__main__':
    main()
