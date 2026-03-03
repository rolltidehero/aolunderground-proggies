#!/usr/bin/env python3
"""Main archive analysis engine - extracts metadata from proggie archives."""
from __future__ import annotations

import argparse
import hashlib
import json
import logging
import sys
import tempfile
import zipfile
from pathlib import Path

from pe_parser import parse_pe_metadata
from string_extractor import extract_strings
from version_detector import detect_aol_version

logger = logging.getLogger(__name__)


def compute_hash(filepath: Path) -> str:
    """Compute SHA256 hash of file."""
    sha256 = hashlib.sha256()
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            sha256.update(chunk)
    return sha256.hexdigest()


def extract_archive(archive_path: Path, temp_dir: str) -> list[str]:
    """Extract archive to temporary directory."""
    try:
        if archive_path.suffix.lower() == ".zip":
            with zipfile.ZipFile(archive_path, "r") as zf:
                for name in zf.namelist():
                    if name.startswith("/") or "/../" in name or name.startswith("../"):
                        logger.warning("Skipping suspicious path in %s: %s", archive_path.name, name)
                        continue
                # Try extractall first, fall back to per-file extraction
                try:
                    zf.extractall(temp_dir)
                except (zipfile.BadZipFile, RuntimeError) as e:
                    logger.debug("extractall failed for %s (%s), trying per-file", archive_path.name, e)
                    for info in zf.infolist():
                        if info.is_dir():
                            continue
                        try:
                            zf.extract(info, temp_dir)
                        except (zipfile.BadZipFile, RuntimeError, KeyError) as e2:
                            # Last resort: read raw data and write manually
                            try:
                                data = zf.read(info.filename)
                                safe_name = info.filename.encode("cp437", errors="replace").decode("ascii", errors="replace")
                                out = Path(temp_dir) / safe_name
                                out.parent.mkdir(parents=True, exist_ok=True)
                                out.write_bytes(data)
                            except (RuntimeError, KeyError, OSError) as e3:
                                logger.debug("Cannot extract %s from %s: %s", info.filename, archive_path.name, e3)
                return list(zf.namelist())
        return []
    except zipfile.BadZipFile:
        logger.error("%s is not a valid zip file", archive_path)
        return []
    except RuntimeError as e:
        logger.warning("Cannot extract %s (encrypted?): %s", archive_path, e)
        return []
    except OSError as e:
        logger.error("Error extracting %s: %s", archive_path, e)
        return []


def find_dependencies(temp_dir: str) -> dict[str, list[str]]:
    """Find dependency files (.dll, .ocx, .vbx, etc)."""
    deps: dict[str, list[str]] = {"dlls": [], "ocx": [], "vbx": [], "other": []}
    suffix_map = {".dll": "dlls", ".ocx": "ocx", ".vbx": "vbx"}
    notable_files = {"acidrop.txt", "readme.txt", "read.me"}

    for file in Path(temp_dir).rglob("*"):
        if not file.is_file():
            continue
        suffix = file.suffix.lower()
        if suffix in suffix_map:
            deps[suffix_map[suffix]].append(file.name)
        elif file.name.lower() in notable_files:
            deps["other"].append(file.name)

    return deps


def analyze_archive(archive_path: str | Path,
                    passwords_db: dict[str, list[str]] | None = None) -> dict[str, object]:
    """Analyze a single archive and extract metadata."""
    archive_path = Path(archive_path)
    logger.debug("Analyzing archive: %s", archive_path)

    metadata: dict[str, object] = {
        "archive_name": archive_path.name,
        "exe_name": None,
        "exe_hash": None,
        "program_name": None,
        "author": None,
        "timestamp": None,
        "versions": [],
        "version_confidence": {},
        "primary_version": None,
        "version_range": None,
        "category": archive_path.parent.name,
        "dependencies": {},
        "passwords": [],
        "has_password": False,
        "password_confidence": 0.0,
        "detection_evidence": {},
        "needs_review": True,
        "original_path": str(archive_path),
        "new_path": None,
    }

    with tempfile.TemporaryDirectory() as temp_dir:
        files = extract_archive(archive_path, temp_dir)
        if not files:
            return metadata

        exe_files = [f for f in Path(temp_dir).rglob("*") if f.suffix.lower() == ".exe"]
        if not exe_files:
            return metadata

        exe_file = exe_files[0]
        metadata["exe_name"] = exe_file.name
        metadata["exe_hash"] = f"sha256:{compute_hash(exe_file)}"

        strings = extract_strings(exe_file)
        pe_metadata = parse_pe_metadata(exe_file)
        metadata["timestamp"] = pe_metadata.get("timestamp")
        metadata["program_name"] = pe_metadata.get("file_description") or exe_file.stem
        metadata["author"] = pe_metadata.get("company_name")

        bas_content: list[str] = []
        for bas_file in Path(temp_dir).rglob("*.bas"):
            try:
                with open(bas_file, "r", encoding="latin-1", errors="ignore") as f:
                    bas_content.append(f.read())
            except OSError as e:
                logger.debug("Cannot read .bas file %s: %s", bas_file, e)

        version_result = detect_aol_version(archive_path.name, strings, pe_metadata, bas_content)
        metadata.update({
            "versions": version_result["versions"],
            "version_confidence": version_result["version_confidence"],
            "primary_version": version_result["primary_version"],
            "version_range": version_result["version_range"],
            "detection_evidence": version_result["evidence"],
            "needs_review": version_result["needs_review"],
        })

        metadata["dependencies"] = find_dependencies(temp_dir)

        if passwords_db:
            prog_name_lower = metadata["program_name"].lower() if metadata["program_name"] else ""
            for db_prog, db_passwords in passwords_db.items():
                if db_prog.lower() in archive_path.name.lower() or db_prog.lower() in prog_name_lower:
                    metadata["passwords"] = db_passwords
                    metadata["has_password"] = True
                    metadata["password_confidence"] = 0.9
                    break

    return metadata


def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    logging.basicConfig(level=level, format=fmt, datefmt="%Y-%m-%d %H:%M:%S")


def main() -> int:
    parser = argparse.ArgumentParser(description="Analyze proggie archive and extract metadata")
    parser.add_argument("archive", help="Path to archive file")
    parser.add_argument("passwords", nargs="?", help="Path to passwords.json")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose logging")
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Starting %s", Path(__file__).name)

    try:
        passwords_db = None
        if args.passwords:
            with open(args.passwords, "r") as f:
                passwords_db = json.load(f)

        result = analyze_archive(args.archive, passwords_db)
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
