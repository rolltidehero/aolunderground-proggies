#!/usr/bin/env python3
"""Merge duplicate archives into single archives with conflict handling."""
from __future__ import annotations

import argparse
import hashlib
import json
import logging
import sys
import zipfile
from collections import defaultdict
from pathlib import Path

logger = logging.getLogger(__name__)


def hash_file(data: bytes) -> str:
    """Calculate SHA256 hash of file data."""
    return hashlib.sha256(data).hexdigest()


def select_primary(group: list[dict[str, object]]) -> dict[str, object]:
    """Select primary archive (most complete metadata)."""
    scored: list[tuple[int, dict[str, object]]] = []
    for item in group:
        meta = item["metadata"]
        score = 0
        score += len(meta.get("versions", [])) * 10
        score += 5 if meta.get("program_name") else 0
        score += 5 if meta.get("author") else 0
        score += len(meta.get("passwords", [])) * 3
        score += len(meta.get("dependencies", {}).get("dlls", [])) * 2
        scored.append((score, item))

    return max(scored, key=lambda x: x[0])[1]


def merge_group(group: list[dict[str, object]], output_dir: str | Path) -> dict[str, object]:
    """Merge duplicate archives into single archive."""
    primary = select_primary(group)
    primary_archive = primary["archive"]
    primary_meta = primary["metadata"]

    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    merged_name = Path(primary_archive).name
    merged_path = output_dir / merged_name

    files_by_name: dict[str, list[tuple[str, bytes, str]]] = defaultdict(list)
    file_data_lookup: dict[tuple[str, str], bytes] = {}

    for item in group:
        archive_path = item["archive"]

        if not Path(archive_path).exists():
            logger.warning("Archive not found: %s", archive_path)
            continue

        try:
            with zipfile.ZipFile(archive_path, "r") as zf:
                for info in zf.infolist():
                    if info.is_dir():
                        continue
                    try:
                        data = zf.read(info.filename)
                        file_hash = hash_file(data)
                        files_by_name[info.filename].append((file_hash, data, archive_path))
                        file_data_lookup[(info.filename, file_hash)] = data
                    except RuntimeError as e:
                        if "encrypted" in str(e):
                            logger.warning("Skipping encrypted file %s in %s", info.filename, archive_path)
                        else:
                            raise
        except (OSError, zipfile.BadZipFile) as e:
            logger.error("Error reading %s: %s", archive_path, e)

    conflicts: list[dict[str, object]] = []
    unique_files: dict[str, tuple[str, bytes]] = {}

    for filename, versions in files_by_name.items():
        if len(set(v[0] for v in versions)) > 1:
            conflicts.append({
                "filename": filename,
                "versions": [(v[0], v[2]) for v in versions],
            })
            primary_version = next((v for v in versions if v[2] == primary_archive), versions[0])
            unique_files[filename] = (primary_version[0], primary_version[1])
        else:
            unique_files[filename] = (versions[0][0], versions[0][1])

    with zipfile.ZipFile(merged_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for filename, (file_hash, data) in unique_files.items():
            zf.writestr(filename, data)

        if conflicts:
            conflict_txt = "MERGE CONFLICTS\n" + "=" * 50 + "\n\n"
            conflict_txt += f"Primary archive: {Path(primary_archive).name}\n\n"

            for conflict in conflicts:
                conflict_txt += f"\nFile: {conflict['filename']}\n"
                conflict_txt += "Different versions found in:\n"
                for file_hash, source in conflict["versions"]:
                    conflict_txt += f"  - {Path(source).name} (hash: {file_hash[:8]}...)\n"
                conflict_txt += "Using version from primary archive.\n"

            zf.writestr("_conflicts/conflict.txt", conflict_txt)

            for conflict in conflicts:
                for file_hash, source in conflict["versions"]:
                    if source != primary_archive:
                        key = (conflict["filename"], file_hash)
                        if key in file_data_lookup:
                            alt_name = f"_conflicts/{conflict['filename']}.from_{Path(source).stem}_{file_hash[:8]}"
                            zf.writestr(alt_name, file_data_lookup[key])

    merged_meta = primary_meta.copy()

    all_passwords: set[str] = set(primary_meta.get("passwords", []))
    for item in group:
        all_passwords.update(item["metadata"].get("passwords", []))
    merged_meta["passwords"] = sorted(all_passwords)

    all_versions: set[str] = set(primary_meta.get("versions", []))
    for item in group:
        all_versions.update(item["metadata"].get("versions", []))
    merged_meta["versions"] = sorted(all_versions)

    merged_meta["merged_from"] = [item["archive"] for item in group]
    merged_meta["merge_conflicts"] = len(conflicts)

    return {
        "merged_archive": str(merged_path),
        "primary_source": primary_archive,
        "merged_from": [item["archive"] for item in group],
        "total_files": len(unique_files),
        "conflicts": conflicts,
        "metadata": merged_meta,
    }


def merge_duplicates(duplicates_report: str | Path, output_dir: str | Path) -> dict[str, object]:
    """Merge all duplicate groups."""
    with open(duplicates_report) as f:
        report = json.load(f)

    results: list[dict[str, object]] = []

    for i, group_data in enumerate(report["groups"], 1):
        logger.info("Merging group %d/%d...", i, len(report["groups"]))

        group = []
        for j, archive in enumerate(group_data["archives"]):
            group.append({"archive": archive, "metadata": group_data["metadata"][j]})

        try:
            result = merge_group(group, output_dir)
            results.append(result)
            logger.info("  Created: %s", Path(result["merged_archive"]).name)
            if result["conflicts"]:
                logger.info("  Conflicts: %d", len(result["conflicts"]))
        except (OSError, zipfile.BadZipFile) as e:
            logger.error("  Error merging group %d: %s", i, e)

    merge_report: dict[str, object] = {
        "total_groups_merged": len(results),
        "merges": results,
    }

    report_path = Path(output_dir) / "merge_report.json"
    with open(report_path, "w") as f:
        json.dump(merge_report, f, indent=2)

    logger.info("Merge complete: %d groups merged", len(results))
    logger.info("Report saved to: %s", report_path)

    return merge_report


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Merge duplicate archives")
    parser.add_argument("duplicates_report", help="Path to duplicates_report.json")
    parser.add_argument("output_dir", help="Output directory for merged archives")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Starting %s", Path(__file__).name)

    try:
        merge_duplicates(args.duplicates_report, args.output_dir)
        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
