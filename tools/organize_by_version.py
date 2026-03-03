#!/usr/bin/env python3
"""Organize merged archives by AOL version."""
import json
import shutil
from pathlib import Path

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
