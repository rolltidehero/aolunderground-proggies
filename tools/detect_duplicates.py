#!/usr/bin/env python3
import json
import sys
from pathlib import Path
from collections import defaultdict
from analyze_archive import analyze_archive

def detect_duplicates(archives_dir, passwords_file, output_file):
    """Group archives by exe hash and detect duplicates."""
    archives_dir = Path(archives_dir)
    hash_groups = defaultdict(list)
    
    # Load passwords database
    passwords_db = {}
    if passwords_file:
        with open(passwords_file) as f:
            passwords_db = json.load(f)
    
    # Find all archives
    archives = list(archives_dir.rglob("*.zip")) + list(archives_dir.rglob("*.rar"))
    print(f"Found {len(archives)} archives")
    
    # Analyze each archive
    for i, archive in enumerate(archives, 1):
        if i % 100 == 0:
            print(f"Processed {i}/{len(archives)}...")
        
        try:
            metadata = analyze_archive(str(archive), passwords_db)
            if metadata and metadata.get("exe_hash"):
                hash_groups[metadata["exe_hash"]].append({
                    "archive": str(archive),
                    "metadata": metadata
                })
        except Exception as e:
            print(f"Error analyzing {archive}: {e}", file=sys.stderr)
    
    # Find duplicates (groups with >1 archive)
    duplicates = {h: g for h, g in hash_groups.items() if len(g) > 1}
    
    # Analyze each duplicate group
    report = {
        "total_archives": len(archives),
        "unique_exes": len(hash_groups),
        "duplicate_groups": len(duplicates),
        "groups": []
    }
    
    for exe_hash, group in duplicates.items():
        # Collect all files from all archives
        all_files = defaultdict(list)  # filename -> [(archive, hash)]
        
        for item in group:
            metadata = item["metadata"]
            archive = item["archive"]
            
            # Track exe
            if metadata.get("exe_name"):
                all_files[metadata["exe_name"]].append((archive, exe_hash))
            
            # Track dependencies
            for dep_type, deps in metadata.get("dependencies", {}).items():
                for dep in deps:
                    all_files[dep].append((archive, None))
        
        # Find conflicts (same filename, different content)
        conflicts = []
        unique_files = []
        
        for filename, sources in all_files.items():
            if len(sources) > 1:
                # Check if hashes differ (for non-exe files, we don't have hashes yet)
                conflicts.append({
                    "filename": filename,
                    "sources": [s[0] for s in sources]
                })
            else:
                unique_files.append(filename)
        
        report["groups"].append({
            "exe_hash": exe_hash,
            "exe_name": group[0]["metadata"].get("exe_name"),
            "count": len(group),
            "archives": [item["archive"] for item in group],
            "metadata": [item["metadata"] for item in group],
            "potential_conflicts": conflicts,
            "unique_files": unique_files
        })
    
    # Save report
    with open(output_file, "w") as f:
        json.dump(report, f, indent=2)
    
    print(f"\nDuplicate Detection Complete:")
    print(f"  Total archives: {report['total_archives']}")
    print(f"  Unique .exe files: {report['unique_exes']}")
    print(f"  Duplicate groups: {report['duplicate_groups']}")
    print(f"  Report saved to: {output_file}")
    
    return report

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: detect_duplicates.py <archives_dir> <passwords_file> <output_file>")
        sys.exit(1)
    
    detect_duplicates(sys.argv[1], sys.argv[2], sys.argv[3])
