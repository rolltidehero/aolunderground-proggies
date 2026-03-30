#!/usr/bin/env python3
"""Organize merged archives by AOL version."""
import json
import shutil
from pathlib import Path

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

def main():
    merge_report = Path("data/merged/merge_report.json")
    output_base = Path("programs/AOL/proggies-by-version")

    with open(merge_report) as f:
        report = json.load(f)

    # Clean old organization
    if output_base.exists():
        shutil.rmtree(output_base)

    for merge in report["merges"]:
        archive_path = Path(merge["merged_archive"])
        if not archive_path.exists():
            continue

        meta = merge["metadata"]
        primary = meta.get("primary_version")
        target_dir = output_base / (primary or "unknown")
        target_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(archive_path, target_dir / archive_path.name)

    # Summary
    for d in sorted(output_base.iterdir()):
        count = len(list(d.glob("*")))
        if count:
            print(f"  {d.name}: {count}")

if __name__ == "__main__":
    main()
