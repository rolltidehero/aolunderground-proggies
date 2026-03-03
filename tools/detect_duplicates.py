#!/usr/bin/env python3
"""Detect duplicate archives by exe hash."""
from __future__ import annotations

import argparse
import json
import logging
import sys
from collections import defaultdict
from pathlib import Path

from analyze_archive import analyze_archive

logger = logging.getLogger(__name__)


def detect_duplicates(archives_dir: str | Path, passwords_file: str | Path,
                      output_file: str | Path) -> dict[str, object] | None:
    """Group archives by exe hash and detect duplicates."""
    archives_dir = Path(archives_dir)
    hash_groups: dict[str, list[dict[str, object]]] = defaultdict(list)

    passwords_db: dict[str, list[str]] = {}
    if passwords_file and Path(passwords_file).exists():
        with open(passwords_file) as f:
            passwords_db = json.load(f)

    archives = list(archives_dir.rglob("*.zip")) + list(archives_dir.rglob("*.rar"))
    logger.info("Found %d archives", len(archives))

    if not archives:
        logger.warning("No archives found!")
        return None

    for i, archive in enumerate(archives, 1):
        if i % 100 == 0:
            logger.info("Processed %d/%d...", i, len(archives))

        try:
            metadata = analyze_archive(str(archive), passwords_db)
            if metadata and metadata.get("exe_hash"):
                hash_groups[metadata["exe_hash"]].append({
                    "archive": str(archive),
                    "metadata": metadata,
                })
        except OSError as e:
            logger.error("Error analyzing %s: %s", archive, e)

    duplicates = {h: g for h, g in hash_groups.items() if len(g) > 1}

    report: dict[str, object] = {
        "total_archives": len(archives),
        "unique_exes": len(hash_groups),
        "duplicate_groups": len(duplicates),
        "groups": [],
    }

    for exe_hash, group in duplicates.items():
        all_files: dict[str, list[tuple[str, str | None]]] = defaultdict(list)

        for item in group:
            metadata = item["metadata"]
            archive = item["archive"]

            if metadata.get("exe_name"):
                all_files[metadata["exe_name"]].append((archive, exe_hash))

            for dep_type, deps in metadata.get("dependencies", {}).items():
                for dep in deps:
                    all_files[dep].append((archive, None))

        conflicts = []
        unique_files = []

        for filename, sources in all_files.items():
            if len(sources) > 1:
                conflicts.append({"filename": filename, "sources": [s[0] for s in sources]})
            else:
                unique_files.append(filename)

        report["groups"].append({
            "exe_hash": exe_hash,
            "exe_name": group[0]["metadata"].get("exe_name"),
            "count": len(group),
            "archives": [item["archive"] for item in group],
            "metadata": [item["metadata"] for item in group],
            "potential_conflicts": conflicts,
            "unique_files": unique_files,
        })

    Path(output_file).parent.mkdir(parents=True, exist_ok=True)
    with open(output_file, "w") as f:
        json.dump(report, f, indent=2)

    logger.info("Duplicate Detection Complete:")
    logger.info("  Total archives: %d", report["total_archives"])
    logger.info("  Unique .exe files: %d", report["unique_exes"])
    logger.info("  Duplicate groups: %d", report["duplicate_groups"])
    logger.info("  Report saved to: %s", output_file)

    return report


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Detect duplicate archives by exe hash")
    parser.add_argument("archives_dir", help="Directory containing archives")
    parser.add_argument("passwords_file", help="Path to passwords.json")
    parser.add_argument("output_file", help="Output JSON file")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Starting %s", Path(__file__).name)

    try:
        detect_duplicates(args.archives_dir, args.passwords_file, args.output_file)
        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
