#!/usr/bin/env python3
"""Parse PE (Portable Executable) metadata from Windows executables."""
from __future__ import annotations

import argparse
import json
import logging
import struct
import sys
from datetime import datetime
from pathlib import Path

logger = logging.getLogger(__name__)


def parse_pe_metadata(filepath: Path) -> dict[str, str | None]:
    """Extract metadata from PE file."""
    metadata: dict[str, str | None] = {
        "timestamp": None,
        "file_description": None,
        "product_version": None,
        "company_name": None,
        "original_filename": None,
        "comments": None,
    }

    try:
        with open(filepath, "rb") as f:
            dos_header = f.read(64)
            if len(dos_header) < 64 or dos_header[:2] != b"MZ":
                return metadata

            pe_offset = struct.unpack("<I", dos_header[60:64])[0]
            f.seek(pe_offset)

            if f.read(4) != b"PE\x00\x00":
                return metadata

            coff_header = f.read(20)
            if len(coff_header) < 20:
                return metadata

            timestamp = struct.unpack("<I", coff_header[4:8])[0]
            if timestamp > 0:
                try:
                    metadata["timestamp"] = datetime.fromtimestamp(timestamp).isoformat()
                except (OSError, ValueError, OverflowError):
                    logger.debug("Invalid PE timestamp %d in %s", timestamp, filepath)

            f.seek(0)
            data = f.read()

            version_strings = {
                b"FileDescription\x00": "file_description",
                b"ProductVersion\x00": "product_version",
                b"CompanyName\x00": "company_name",
                b"OriginalFilename\x00": "original_filename",
                b"Comments\x00": "comments",
            }

            for marker, key in version_strings.items():
                idx = data.find(marker)
                if idx == -1:
                    continue
                start = idx + len(marker)
                while start < len(data) and data[start] == 0:
                    start += 1

                end = start
                value: list[str] = []
                while end < len(data) - 1:
                    if data[end] != 0:
                        value.append(chr(data[end]))
                        end += 1
                    elif data[end + 1] == 0:
                        break
                    else:
                        end += 1

                if value:
                    metadata[key] = "".join(value).strip()

    except OSError as e:
        logger.error("Cannot read PE file %s: %s", filepath, e)

    return metadata


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Parse PE metadata from executable")
    parser.add_argument("exe_file", help="Path to executable")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Parsing %s", args.exe_file)

    try:
        metadata = parse_pe_metadata(Path(args.exe_file))
        print(json.dumps(metadata, indent=2))
        return 0
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1


if __name__ == "__main__":
    sys.exit(main())
