#!/usr/bin/env python3
"""Main archive analysis engine - extracts metadata from proggie archives."""
from __future__ import annotations

import argparse
import hashlib
import json
import logging
import subprocess
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


def extract_archive(archive_path: Path, temp_dir: str, passwords: list[str] | None = None) -> list[str]:
    """Extract archive to temporary directory.

    Strategy: try Python zipfile first, fall back to 7z for
    corrupt zips, encoding mismatches, RAR files, and encrypted archives.
    """
    # Try Python zipfile first (fastest)
    if archive_path.suffix.lower() == ".zip":
        try:
            with zipfile.ZipFile(archive_path, "r") as zf:
                for name in zf.namelist():
                    if name.startswith("/") or "/../" in name or name.startswith("../"):
                        logger.warning("Skipping suspicious path in %s: %s", archive_path.name, name)
                        continue
                zf.extractall(temp_dir)
                return list(zf.namelist())
        except (zipfile.BadZipFile, RuntimeError, OSError) as e:
            logger.debug("Python zipfile failed on %s (%s), trying 7z", archive_path.name, e)

    # Fall back to 7z for everything Python can't handle
    return _extract_with_7z(archive_path, temp_dir, passwords)


def _extract_with_7z(archive_path: Path, temp_dir: str, passwords: list[str] | None = None) -> list[str]:
    """Extract any archive using 7z, with unrar fallback for RAR files."""
    try:
        # First attempt without password
        result = subprocess.run(
            ["7z", "x", f"-o{temp_dir}", "-y", str(archive_path)],
            capture_output=True, timeout=60,
        )
        files = [str(p.relative_to(temp_dir)) for p in Path(temp_dir).rglob("*") if p.is_file()]
        
        # Check if EXE files are valid (not 0 bytes) - this is what matters
        exe_files = [f for f in Path(temp_dir).rglob("*.exe") if f.is_file()]
        valid_exes = [f for f in exe_files if f.stat().st_size > 0]
        
        # If RAR file and no valid EXE (either 0 bytes or not extracted), try unrar
        if archive_path.suffix.lower() == ".rar" and not valid_exes:
            logger.debug("RAR file with no valid EXE, trying unrar...")
            # Clean temp dir
            for f in Path(temp_dir).rglob("*"):
                if f.is_file():
                    f.unlink()
            return _extract_with_unrar(archive_path, temp_dir, passwords)
        
        # Check if any files are valid
        valid_files = [f for f in Path(temp_dir).rglob("*") if f.is_file() and f.stat().st_size > 0]
        
        if valid_files:
            logger.debug("7z extracted %d files from %s (exit %d)",
                         len(files), archive_path.name, result.returncode)
            return files
        
        # Check for unsupported RAR method in stderr
        stderr = result.stderr.decode(errors="replace")
        if "Unsupported Method" in stderr and archive_path.suffix.lower() == ".rar":
            logger.debug("7z reports unsupported RAR method, trying unrar...")
            return _extract_with_unrar(archive_path, temp_dir, passwords)
        
        # Try with passwords if extraction failed or files are 0 bytes
        if passwords:
            logger.debug("Initial extraction failed or produced empty files, trying passwords...")
            # Clean temp dir for retry
            for f in Path(temp_dir).rglob("*"):
                if f.is_file():
                    f.unlink()
            
            for pwd in passwords:
                logger.debug("Trying password for %s: %s", archive_path.name, pwd)
                result = subprocess.run(
                    ["7z", "x", f"-o{temp_dir}", "-y", f"-p{pwd}", str(archive_path)],
                    capture_output=True, timeout=60,
                )
                files = [str(p.relative_to(temp_dir)) for p in Path(temp_dir).rglob("*") if p.is_file()]
                valid_files = [f for f in Path(temp_dir).rglob("*") if f.is_file() and f.stat().st_size > 0]
                
                if valid_files:
                    logger.info("Successfully extracted %s with password: %s", archive_path.name, pwd)
                    return files
                
                # Check for unsupported RAR method with password
                stderr = result.stderr.decode(errors="replace")
                if "Unsupported Method" in stderr and archive_path.suffix.lower() == ".rar":
                    logger.debug("7z reports unsupported RAR method with password, trying unrar...")
                    return _extract_with_unrar(archive_path, temp_dir, passwords)
        
        if result.returncode > 0 and not files:
            logger.warning("7z could not extract %s (exit %d): %s",
                           archive_path.name, result.returncode,
                           stderr.strip()[:200])
        return files
    except FileNotFoundError:
        logger.error("7z not found - install with: brew install p7zip")
        return []
    except subprocess.TimeoutExpired:
        logger.error("7z timed out on %s", archive_path.name)
        return []


def _extract_with_unrar(archive_path: Path, temp_dir: str, passwords: list[str] | None = None) -> list[str]:
    """Extract RAR archive using compiled unrar (supports old RAR formats)."""
    unrar_bin = Path(__file__).parent / "unrar" / "unrar"
    if not unrar_bin.exists():
        unrar_bin = Path("tools/unrar/unrar")
    
    try:
        # Try without password first
        result = subprocess.run(
            [str(unrar_bin), "x", "-o+", "-y", str(archive_path), temp_dir + "/"],
            capture_output=True, timeout=60,
        )
        files = [str(p.relative_to(temp_dir)) for p in Path(temp_dir).rglob("*") if p.is_file()]
        valid_files = [f for f in Path(temp_dir).rglob("*") if f.is_file() and f.stat().st_size > 0]
        
        if valid_files:
            logger.debug("unrar extracted %d files from %s", len(files), archive_path.name)
            return files
        
        # Try with passwords
        if passwords:
            for f in Path(temp_dir).rglob("*"):
                if f.is_file():
                    f.unlink()
            
            for pwd in passwords:
                logger.debug("Trying unrar with password: %s", pwd)
                result = subprocess.run(
                    [str(unrar_bin), "x", "-o+", "-y", f"-p{pwd}", str(archive_path), temp_dir + "/"],
                    capture_output=True, timeout=60,
                )
                files = [str(p.relative_to(temp_dir)) for p in Path(temp_dir).rglob("*") if p.is_file()]
                valid_files = [f for f in Path(temp_dir).rglob("*") if f.is_file() and f.stat().st_size > 0]
                
                if valid_files:
                    logger.info("Successfully extracted %s with unrar using password: %s", archive_path.name, pwd)
                    return files
        
        logger.warning("unrar could not extract %s", archive_path.name)
        return files
    except FileNotFoundError:
        logger.warning("unrar not found at %s", unrar_bin)
        return []
    except subprocess.TimeoutExpired:
        logger.error("unrar timed out on %s", archive_path.name)
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

    # Collect all passwords to try
    all_passwords = []
    if passwords_db:
        for db_passwords in passwords_db.values():
            all_passwords.extend(db_passwords)

    with tempfile.TemporaryDirectory() as temp_dir:
        files = extract_archive(archive_path, temp_dir, all_passwords if all_passwords else None)
        if not files:
            return metadata

        exe_files = [f for f in Path(temp_dir).rglob("*") if f.suffix.lower() == ".exe"]
        if not exe_files:
            return metadata

        exe_file = exe_files[0]
        if exe_file.stat().st_size == 0:
            logger.warning("Exe %s in %s is 0 bytes (encrypted/corrupt archive?)", exe_file.name, archive_path.name)
            metadata["exe_name"] = exe_file.name
            return metadata
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
