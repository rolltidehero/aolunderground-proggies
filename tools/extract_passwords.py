#!/usr/bin/env python3
"""Extract passwords from archive filenames and create password database."""
from __future__ import annotations

import argparse
import json
import logging
import re
import sys
from difflib import SequenceMatcher
from pathlib import Path

logger = logging.getLogger(__name__)


def extract_passwords_from_filenames(repo_path: Path) -> dict[str, list[str]]:
    """Extract passwords embedded in filenames."""
    passwords: dict[str, list[str]] = {}
    pattern = re.compile(r"password[=\s]+([^\s\]\.]+)", re.IGNORECASE)

    for archive in list(repo_path.rglob("*.zip")) + list(repo_path.rglob("*.rar")):
        match = pattern.search(archive.name)
        if match:
            password = match.group(1)
            prog_name = archive.stem.split("password")[0].strip(" -_")
            if prog_name:
                if prog_name not in passwords:
                    passwords[prog_name] = []
                if password not in passwords[prog_name]:
                    passwords[prog_name].append(password)

    return passwords


def fuzzy_match(query: str, candidates: list[str],
                threshold: float = 0.6) -> list[tuple[str, float]]:
    """Fuzzy match query against candidate program names."""
    matches: list[tuple[str, float]] = []
    query_lower = query.lower()

    for candidate in candidates:
        ratio = SequenceMatcher(None, query_lower, candidate.lower()).ratio()
        if ratio >= threshold:
            matches.append((candidate, ratio))

    return sorted(matches, key=lambda x: x[1], reverse=True)


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Extract passwords from archive filenames")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Starting %s", Path(__file__).name)

    try:
        repo_path = Path(__file__).parent.parent

        logger.info("Extracting passwords from filenames...")
        passwords = extract_passwords_from_filenames(repo_path)
        logger.info("Found %d programs with passwords", len(passwords))

        output_file = repo_path / "tools" / "passwords.json"
        with open(output_file, "w") as f:
            json.dump(passwords, f, indent=2)
        logger.info("Saved to %s", output_file)

        logger.info("Test: Fuzzy matching 'aohell'")
        matches = fuzzy_match("aohell", list(passwords.keys()))
        for prog, score in matches[:5]:
            logger.info("  %s: %s (score: %.2f)", prog, passwords[prog], score)

        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
