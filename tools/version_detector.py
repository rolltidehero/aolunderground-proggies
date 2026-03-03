#!/usr/bin/env python3
"""Detect AOL version compatibility from various sources."""
from __future__ import annotations

import argparse
import json
import logging
import re
import sys

logger = logging.getLogger(__name__)

CONFIDENCE_THRESHOLD = 0.5
REVIEW_THRESHOLD = 0.9

VERSION_PATTERN_STRINGS: dict[str, list[str]] = {
    "2.5": [r'aol\s*2\.5', r'aol25', r'aol\s*95', r'C:\\aol25\\',
            r'for\s+aol\s+2\.5', r'\[aol\s*2\.5\]'],
    "3.0": [r'aol\s*3\.0', r'aol30', r'C:\\aol30\\', r'aol\s*3\b',
            r'for\s+aol\s+3', r'\[aol\s*3\.0\]', r'aohell.*3'],
    "4.0": [r'aol\s*4\.0', r'aol40', r'C:\\aol40\\', r'aol\s*4\b',
            r'for\s+aol\s+4', r'\[aol\s*4\.0\]', r"What's New in AOL 4\.0", r'_AOL_Glyph'],
    "5.0": [r'aol\s*5\.0', r'aol50', r'America Online 5', r'aol\s*5\b',
            r'for\s+aol\s+5', r'\[aol\s*5\.0\]', r"What's New in AOL 5\.0"],
    "6.0": [r'aol\s*6\.0', r'aol60', r'America Online 6', r'aol\s*6\b',
            r'for\s+aol\s+6', r'\[aol\s*6\.0\]', r"What's New in AOL 6\.0", r'C:\\America Online 6'],
    "7.0": [r'aol\s*7\.0', r'aol70', r'America Online 7', r'aol\s*7\b',
            r'for\s+aol\s+7', r'\[aol\s*7\.0\]', r"What's New in AOL 7\.0"],
    "8.0": [r'aol\s*8\.0', r'aol80', r'America Online 8', r'aol\s*8\b',
            r'for\s+aol\s+8', r'\[aol\s*8\.0\]'],
    "9.0": [r'aol\s*9\.0', r'aol90', r'America Online 9', r'aol\s*9\b',
            r'for\s+aol\s+9', r'\[aol\s*9\.0\]'],
}

# Pre-compile all patterns at module load
COMPILED_PATTERNS: dict[str, list[re.Pattern[str]]] = {
    version: [re.compile(p, re.IGNORECASE) for p in patterns]
    for version, patterns in VERSION_PATTERN_STRINGS.items()
}


def detect_version_from_filename(filename: str) -> dict[str, float]:
    """Detect version from archive filename."""
    versions: dict[str, float] = {}
    filename_lower = filename.lower()

    for version, patterns in COMPILED_PATTERNS.items():
        for pattern in patterns:
            if pattern.search(filename_lower):
                versions[version] = versions.get(version, 0) + 0.3

    return versions


def detect_version_from_strings(strings: list[str]) -> dict[str, float]:
    """Detect version from extracted binary strings."""
    versions: dict[str, float] = {}
    combined = " ".join(strings).lower()

    for version, patterns in COMPILED_PATTERNS.items():
        for pattern in patterns:
            matches = len(pattern.findall(combined))
            if matches > 0:
                versions[version] = versions.get(version, 0) + (0.2 * min(matches, 3))

    has_glyph = "_aol_glyph" in combined
    has_frame25 = "aol frame25" in combined
    has_waol = "waol.exe" in combined
    has_aol_exe = "aol.exe" in combined and "america online 6" in combined

    if has_glyph:
        for v in ["4.0", "5.0"]:
            versions[v] = versions.get(v, 0) + 0.4

    if has_frame25 and not has_glyph:
        for v in ["2.5", "3.0"]:
            versions[v] = versions.get(v, 0) + 0.2

    if has_waol:
        for v in ["2.5", "3.0", "4.0", "5.0"]:
            versions[v] = versions.get(v, 0) + 0.1

    if has_aol_exe:
        for v in ["6.0", "7.0", "8.0", "9.0"]:
            versions[v] = versions.get(v, 0) + 0.2

    return versions


def detect_version_from_pe_metadata(metadata: dict[str, str | None]) -> dict[str, float]:
    """Detect version from PE metadata fields."""
    versions: dict[str, float] = {}
    if not metadata:
        return versions

    text = " ".join(str(v) for v in metadata.values() if v).lower()

    for version, patterns in COMPILED_PATTERNS.items():
        for pattern in patterns:
            if pattern.search(text):
                versions[version] = versions.get(version, 0) + 0.5

    return versions


def detect_version_from_bas_files(bas_content: str) -> dict[str, float]:
    """Detect version from .bas source file content."""
    versions: dict[str, float] = {}
    content_lower = bas_content.lower()

    for version, patterns in COMPILED_PATTERNS.items():
        for pattern in patterns:
            matches = len(pattern.findall(content_lower))
            if matches > 0:
                versions[version] = versions.get(version, 0) + (0.4 * min(matches, 3))

    return versions


def combine_detections(filename_versions: dict[str, float], string_versions: dict[str, float],
                       pe_versions: dict[str, float], bas_versions: dict[str, float]) -> dict[str, float]:
    """Combine all version detections with confidence scores."""
    all_versions: dict[str, float] = {}

    for versions in [filename_versions, string_versions, pe_versions, bas_versions]:
        for version, score in versions.items():
            all_versions[version] = all_versions.get(version, 0) + score

    if all_versions:
        max_score = max(all_versions.values())
        if max_score > 0:
            all_versions = {v: min(s / max_score, 1.0) for v, s in all_versions.items()}

    return {v: s for v, s in all_versions.items() if s >= CONFIDENCE_THRESHOLD}


def detect_aol_version(filename: str, strings: list[str],
                       pe_metadata: dict[str, str | None],
                       bas_files_content: list[str]) -> dict[str, object]:
    """Main version detection function."""
    filename_v = detect_version_from_filename(filename)
    string_v = detect_version_from_strings(strings)
    pe_v = detect_version_from_pe_metadata(pe_metadata)

    bas_v: dict[str, float] = {}
    for content in bas_files_content:
        bas_detected = detect_version_from_bas_files(content)
        for v, score in bas_detected.items():
            bas_v[v] = max(bas_v.get(v, 0), score)

    versions = combine_detections(filename_v, string_v, pe_v, bas_v)

    primary = max(versions.items(), key=lambda x: x[1])[0] if versions else None

    if versions:
        sorted_v = sorted(versions.keys(), key=float)
        version_range = f"{sorted_v[0]}-{sorted_v[-1]}" if len(sorted_v) > 1 else sorted_v[0]
    else:
        version_range = None

    return {
        "versions": sorted(versions.keys(), key=float),
        "version_confidence": versions,
        "primary_version": primary,
        "version_range": version_range,
        "evidence": {"filename": filename_v, "strings": string_v,
                     "pe_metadata": pe_v, "bas_files": bas_v},
        "needs_review": not versions or max(versions.values()) < REVIEW_THRESHOLD,
    }


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Test AOL version detection")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)

    try:
        result = detect_aol_version(
            "aohell3.zip",
            ["C:\\aol30\\waol.exe", "AOL Frame25", "For AOL 3.0"],
            {"file_description": "AOHell for AOL 3.0"},
            ["'This is for AOL 3.0 and 4.0"],
        )
        print(json.dumps(result, indent=2))
        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
