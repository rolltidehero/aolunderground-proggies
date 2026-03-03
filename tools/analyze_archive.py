#!/usr/bin/env python3
"""Main archive analysis engine - extracts metadata from proggie archives."""

import sys
import json
import hashlib
import zipfile
import tempfile
import shutil
from pathlib import Path

# Import our modules
sys.path.insert(0, str(Path(__file__).parent))
from pe_parser import parse_pe_metadata
from string_extractor import extract_strings
from version_detector import detect_aol_version

def compute_hash(filepath):
    """Compute SHA256 hash of file."""
    sha256 = hashlib.sha256()
    with open(filepath, 'rb') as f:
        for chunk in iter(lambda: f.read(8192), b''):
            sha256.update(chunk)
    return sha256.hexdigest()

def extract_archive(archive_path, temp_dir):
    """Extract archive to temporary directory."""
    try:
        if archive_path.suffix.lower() == '.zip':
            with zipfile.ZipFile(archive_path, 'r') as zf:
                # Security: Check for path traversal
                for name in zf.namelist():
                    if name.startswith('/') or '..' in name:
                        print(f"Warning: Skipping suspicious path: {name}")
                        continue
                zf.extractall(temp_dir)
                return list(zf.namelist())
        # TODO: Add rarfile support
        return []
    except zipfile.BadZipFile:
        print(f"Error: {archive_path} is not a valid zip file")
        return []
    except Exception as e:
        print(f"Error extracting {archive_path}: {e}")
        return []

def find_dependencies(temp_dir):
    """Find dependency files (.dll, .ocx, .vbx, .wav, etc)."""
    deps = {"dlls": [], "ocx": [], "vbx": [], "other": []}
    
    for file in Path(temp_dir).rglob('*'):
        if file.is_file():
            suffix = file.suffix.lower()
            if suffix == '.dll':
                deps["dlls"].append(file.name)
            elif suffix == '.ocx':
                deps["ocx"].append(file.name)
            elif suffix == '.vbx':
                deps["vbx"].append(file.name)
            elif suffix in ['.wav', '.mid', '.mp3', '.txt']:
                if file.name.lower() in ['acidrop.txt', 'readme.txt', 'read.me']:
                    deps["other"].append(file.name)
    
    return deps

def analyze_archive(archive_path, passwords_db=None):
    """Analyze a single archive and extract metadata."""
    archive_path = Path(archive_path)
    
    metadata = {
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
        "new_path": None
    }
    
    # Create temp directory
    with tempfile.TemporaryDirectory() as temp_dir:
        # Extract archive
        files = extract_archive(archive_path, temp_dir)
        if not files:
            return metadata
        
        # Find .exe files (case-insensitive)
        exe_files = [f for f in Path(temp_dir).rglob('*') if f.suffix.lower() == '.exe']
        if not exe_files:
            return metadata
        
        # Analyze first .exe
        exe_file = exe_files[0]
        metadata["exe_name"] = exe_file.name
        metadata["exe_hash"] = f"sha256:{compute_hash(exe_file)}"
        
        # Extract strings
        strings = extract_strings(exe_file)
        
        # Parse PE metadata
        pe_metadata = parse_pe_metadata(exe_file)
        metadata["timestamp"] = pe_metadata.get("timestamp")
        metadata["program_name"] = pe_metadata.get("file_description") or exe_file.stem
        metadata["author"] = pe_metadata.get("company_name")
        
        # Find .bas files
        bas_files = list(Path(temp_dir).rglob('*.bas'))
        bas_content = []
        for bas_file in bas_files:
            try:
                with open(bas_file, 'r', encoding='latin-1', errors='ignore') as f:
                    bas_content.append(f.read())
            except:
                pass
        
        # Detect AOL version
        version_result = detect_aol_version(
            archive_path.name,
            strings,
            pe_metadata,
            bas_content
        )
        
        metadata.update({
            "versions": version_result["versions"],
            "version_confidence": version_result["version_confidence"],
            "primary_version": version_result["primary_version"],
            "version_range": version_result["version_range"],
            "detection_evidence": version_result["evidence"],
            "needs_review": version_result["needs_review"]
        })
        
        # Find dependencies
        metadata["dependencies"] = find_dependencies(temp_dir)
        
        # Check for passwords
        if passwords_db:
            prog_name_lower = metadata["program_name"].lower() if metadata["program_name"] else ""
            for db_prog, db_passwords in passwords_db.items():
                if db_prog.lower() in archive_path.name.lower() or db_prog.lower() in prog_name_lower:
                    metadata["passwords"] = db_passwords
                    metadata["has_password"] = True
                    metadata["password_confidence"] = 0.9
                    break
        
        # Password detection stub (Task 8)
        # TODO: Implement password detection from strings
    
    return metadata

def main():
    if len(sys.argv) < 2:
        print("Usage: analyze_archive.py <archive_path> [passwords.json]")
        sys.exit(1)
    
    archive_path = sys.argv[1]
    passwords_db = None
    
    if len(sys.argv) > 2:
        with open(sys.argv[2], 'r') as f:
            passwords_db = json.load(f)
    
    metadata = analyze_archive(archive_path, passwords_db)
    print(json.dumps(metadata, indent=2))

if __name__ == '__main__':
    main()
