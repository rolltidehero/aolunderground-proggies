#!/usr/bin/env python3
"""Extract printable strings from binary files."""
from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path

logger = logging.getLogger(__name__)

MAX_FILE_SIZE = 50 * 1024 * 1024
MIN_STRING_LENGTH = 4


def extract_strings(filepath: Path, min_length: int = MIN_STRING_LENGTH,
                    max_file_size: int = MAX_FILE_SIZE) -> list[str]:
    """Extract printable ASCII and Unicode strings from binary file."""
    filepath = Path(filepath)
    try:
        file_size = filepath.stat().st_size
    except OSError as e:
        logger.error("Cannot stat %s: %s", filepath, e)
        return []

    if file_size > max_file_size:
        logger.warning("File %s is %d bytes, skipping (max: %d)", filepath, file_size, max_file_size)
        return []

    try:
        with open(filepath, "rb") as f:
            data = f.read()
    except OSError as e:
        logger.error("Cannot read %s: %s", filepath, e)
        return []

    strings: set[str] = set()

    # ASCII strings
    current: list[str] = []
    for byte in data:
        if 32 <= byte <= 126:
            current.append(chr(byte))
        else:
            if len(current) >= min_length:
                strings.add("".join(current))
            current = []

    # Unicode strings (UTF-16LE)
    current = []
    i = 0
    while i < len(data) - 1:
        if data[i + 1] == 0 and 32 <= data[i] <= 126:
            current.append(chr(data[i]))
            i += 2
        else:
            if len(current) >= min_length:
                strings.add("".join(current))
            current = []
            i += 1

    return list(strings)


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Extract strings from binary file")
    parser.add_argument("file", help="Path to binary file")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)

    try:
        result = extract_strings(Path(args.file))
        for s in sorted(result):
            print(s)
        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
