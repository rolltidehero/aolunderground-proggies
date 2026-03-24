#!/usr/bin/env python3
"""
AOL Version Detector - Accurate version detection using API signatures

Analyzes Windows executables to determine AOL version compatibility by
identifying specific window classes and control types used by the proggie.

Usage:
    python3 detect_aol_version.py proggie.exe
    python3 detect_aol_version.py --json proggie.exe
    python3 detect_aol_version.py --batch directory/
"""
import argparse
import json
import subprocess
import sys
from pathlib import Path
from collections import defaultdict

# Load API signature database
API_DB_PATH = Path(__file__).parent / "aol_api_signatures.json"

def load_api_database():
    """Load the AOL API signature database."""
    if not API_DB_PATH.exists():
        print(f"Error: API database not found at {API_DB_PATH}", file=sys.stderr)
        print("Run: python3 tools/build_api_database.py", file=sys.stderr)
        sys.exit(1)
    
    with open(API_DB_PATH) as f:
        return json.load(f)

def extract_strings(exe_path):
    """Extract printable strings from executable (ASCII and Unicode)."""
    with open(exe_path, 'rb') as f:
        data = f.read()
    
    strings = []
    
    # Extract ASCII strings
    current = []
    for byte in data:
        if 32 <= byte <= 126:
            current.append(chr(byte))
        elif len(current) >= 8:
            strings.append(''.join(current))
            current = []
        else:
            current = []
    if len(current) >= 8:
        strings.append(''.join(current))
    
    # Extract Unicode (UTF-16LE) strings
    i = 0
    while i < len(data) - 1:
        if data[i] != 0 and 32 <= data[i] <= 126 and data[i+1] == 0:
            # Potential UTF-16LE string
            current = [chr(data[i])]
            i += 2
            while i < len(data) - 1:
                if data[i] != 0 and 32 <= data[i] <= 126 and data[i+1] == 0:
                    current.append(chr(data[i]))
                    i += 2
                else:
                    break
            if len(current) >= 8:
                strings.append(''.join(current))
        else:
            i += 1
    
    return strings

def detect_version(exe_path, api_db, verbose=False):
    """Detect AOL version from executable using API signatures."""
    strings = extract_strings(exe_path)
    strings_lower = {s.lower() for s in strings}
    
    # Track evidence (deduplicated by lowercase)
    evidence = defaultdict(set)
    version_scores = defaultdict(float)
    seen_signatures = set()  # Track by lowercase to avoid duplicate scoring
    
    # Check window classes (high confidence)
    for sig, versions in api_db.get("window_classes", {}).items():
        sig_lower = sig.lower()
        if sig_lower in strings_lower and sig_lower not in seen_signatures:
            seen_signatures.add(sig_lower)
            evidence["window_classes"].add(sig)
            # Score based on specificity
            specificity = 1.0 / len(versions)  # Fewer versions = more specific
            for v in versions:
                version_scores[v] += specificity * 0.4
            
            if verbose:
                print(f"  Found window class: {sig} -> {versions}")
    
    # Check control classes (medium confidence)
    seen_signatures.clear()
    for sig, versions in api_db.get("control_classes", {}).items():
        sig_lower = sig.lower()
        if sig_lower in strings_lower and sig_lower not in seen_signatures:
            seen_signatures.add(sig_lower)
            evidence["control_classes"].add(sig)
            specificity = 1.0 / len(versions)
            for v in versions:
                version_scores[v] += specificity * 0.3
            
            if verbose:
                print(f"  Found control class: {sig} -> {versions}")
    
    # Check install paths (low confidence)
    seen_signatures.clear()
    for sig, versions in api_db.get("install_paths", {}).items():
        sig_lower = sig.lower()
        if sig_lower in strings_lower and sig_lower not in seen_signatures:
            seen_signatures.add(sig_lower)
            evidence["install_paths"].add(sig)
            for v in versions:
                version_scores[v] += 0.2
            
            if verbose:
                print(f"  Found install path: {sig} -> {versions}")
    
    # Normalize scores to 0-1 range
    if version_scores:
        max_score = max(version_scores.values())
        if max_score > 0:
            version_scores = {v: min(s / max_score, 1.0) for v, s in version_scores.items()}
    
    # Filter by confidence threshold
    confident_versions = {v: s for v, s in version_scores.items() if s >= 0.5}
    
    # Determine primary version (highest score)
    primary = max(confident_versions.items(), key=lambda x: x[1])[0] if confident_versions else None
    
    # Determine if needs review
    needs_review = not confident_versions or (primary and confident_versions[primary] < 0.7)
    
    return {
        "file": Path(exe_path).name,
        "versions": sorted(confident_versions.keys(), key=float),
        "primary_version": primary,
        "confidence": dict(confident_versions),
        "evidence": {k: sorted(list(v)) for k, v in evidence.items()},
        "needs_review": needs_review
    }

def main():
    parser = argparse.ArgumentParser(
        description="Detect AOL version compatibility from proggie executables",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s aohell3.exe
  %(prog)s --json punter.exe
  %(prog)s --batch programs/AOL/proggies/
  %(prog)s --verbose proggie.exe

For more information, see: docs/AOL_VERSION_DETECTION.md
        """
    )
    parser.add_argument("path", help="Path to .exe file or directory")
    parser.add_argument("--json", action="store_true", help="Output JSON format")
    parser.add_argument("--batch", action="store_true", help="Process directory of .exe files")
    parser.add_argument("--verbose", "-v", action="store_true", help="Show detailed evidence")
    
    args = parser.parse_args()
    
    # Load API database
    api_db = load_api_database()
    
    # Process files
    if args.batch or Path(args.path).is_dir():
        exe_files = list(Path(args.path).rglob("*.exe"))
        results = []
        
        for exe_file in exe_files:
            if args.verbose:
                print(f"\nAnalyzing: {exe_file}")
            
            result = detect_version(exe_file, api_db, args.verbose)
            results.append(result)
            
            if not args.json and not args.verbose:
                versions_str = ", ".join(result["versions"]) if result["versions"] else "Unknown"
                print(f"{exe_file.name:40} -> {versions_str}")
        
        if args.json:
            print(json.dumps(results, indent=2))
    
    else:
        # Single file
        exe_file = Path(args.path)
        if not exe_file.exists():
            print(f"Error: File not found: {exe_file}", file=sys.stderr)
            return 1
        
        if args.verbose:
            print(f"Analyzing: {exe_file}\n")
        
        result = detect_version(exe_file, api_db, args.verbose)
        
        if args.json:
            print(json.dumps(result, indent=2))
        else:
            print(f"\nFile: {result['file']}")
            print(f"Versions: {', '.join(result['versions']) if result['versions'] else 'Unknown'}")
            if result['primary_version']:
                print(f"Primary: {result['primary_version']} (confidence: {result['confidence'][result['primary_version']]:.2f})")
            print(f"Needs Review: {result['needs_review']}")
            
            if result['evidence']:
                print("\nEvidence:")
                for category, items in result['evidence'].items():
                    if items:
                        print(f"  {category}: {', '.join(items[:5])}")
                        if len(items) > 5:
                            print(f"    ... and {len(items) - 5} more")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
