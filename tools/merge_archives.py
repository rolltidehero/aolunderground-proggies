#!/usr/bin/env python3
import json
import sys
import zipfile
import hashlib
from pathlib import Path
from collections import defaultdict

def hash_file(data):
    """Calculate SHA256 hash of file data."""
    return hashlib.sha256(data).hexdigest()

def select_primary(group):
    """Select primary archive (most complete metadata)."""
    scored = []
    for item in group:
        meta = item["metadata"]
        score = 0
        score += len(meta.get("versions", [])) * 10
        score += 5 if meta.get("program_name") else 0
        score += 5 if meta.get("author") else 0
        score += len(meta.get("passwords", [])) * 3
        score += len(meta.get("dependencies", {}).get("dlls", [])) * 2
        scored.append((score, item))
    
    return max(scored, key=lambda x: x[0])[1]

def merge_group(group, output_dir):
    """Merge duplicate archives into single archive."""
    primary = select_primary(group)
    primary_archive = primary["archive"]
    primary_meta = primary["metadata"]
    
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Create merged archive name
    merged_name = Path(primary_archive).name
    merged_path = output_dir / merged_name
    
    # Track all files by hash
    files_by_hash = {}  # hash -> (filename, data, source_archive)
    files_by_name = defaultdict(list)  # filename -> [(hash, data, source)]
    
    # Extract all files from all archives
    for item in group:
        archive_path = item["archive"]
        try:
            with zipfile.ZipFile(archive_path, 'r') as zf:
                for info in zf.infolist():
                    if info.is_dir():
                        continue
                    
                    data = zf.read(info.filename)
                    file_hash = hash_file(data)
                    
                    files_by_hash[file_hash] = (info.filename, data, archive_path)
                    files_by_name[info.filename].append((file_hash, data, archive_path))
        except Exception as e:
            print(f"Error reading {archive_path}: {e}", file=sys.stderr)
    
    # Identify conflicts (same name, different hash)
    conflicts = []
    unique_files = {}  # filename -> (hash, data)
    
    for filename, versions in files_by_name.items():
        if len(set(v[0] for v in versions)) > 1:
            # Conflict: same name, different content
            conflicts.append({
                "filename": filename,
                "versions": [(v[0], v[2]) for v in versions]
            })
            # Use version from primary archive
            primary_version = next((v for v in versions if v[2] == primary_archive), versions[0])
            unique_files[filename] = (primary_version[0], primary_version[1])
        else:
            # No conflict, use any version
            unique_files[filename] = (versions[0][0], versions[0][1])
    
    # Create merged archive
    with zipfile.ZipFile(merged_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        for filename, (file_hash, data) in unique_files.items():
            zf.writestr(filename, data)
        
        # Add conflicts folder if conflicts exist
        if conflicts:
            conflict_txt = "MERGE CONFLICTS\n" + "="*50 + "\n\n"
            conflict_txt += f"Primary archive: {Path(primary_archive).name}\n\n"
            
            for conflict in conflicts:
                conflict_txt += f"\nFile: {conflict['filename']}\n"
                conflict_txt += "Different versions found in:\n"
                for file_hash, source in conflict['versions']:
                    conflict_txt += f"  - {Path(source).name} (hash: {file_hash[:8]}...)\n"
                conflict_txt += f"Using version from primary archive.\n"
            
            zf.writestr("_conflicts/conflict.txt", conflict_txt)
            
            # Store alternate versions
            for conflict in conflicts:
                for i, (file_hash, source) in enumerate(conflict['versions']):
                    if source != primary_archive:
                        # Find the data for this version
                        for versions in files_by_name[conflict['filename']]:
                            if versions[0] == file_hash:
                                alt_name = f"_conflicts/{conflict['filename']}.from_{Path(source).stem}"
                                zf.writestr(alt_name, versions[1])
                                break
    
    # Merge metadata
    merged_meta = primary_meta.copy()
    
    # Combine passwords from all sources
    all_passwords = set(primary_meta.get("passwords", []))
    for item in group:
        all_passwords.update(item["metadata"].get("passwords", []))
    merged_meta["passwords"] = sorted(all_passwords)
    
    # Combine versions
    all_versions = set(primary_meta.get("versions", []))
    for item in group:
        all_versions.update(item["metadata"].get("versions", []))
    merged_meta["versions"] = sorted(all_versions)
    
    # Track merge sources
    merged_meta["merged_from"] = [item["archive"] for item in group]
    merged_meta["merge_conflicts"] = len(conflicts)
    
    return {
        "merged_archive": str(merged_path),
        "primary_source": primary_archive,
        "merged_from": [item["archive"] for item in group],
        "total_files": len(unique_files),
        "conflicts": conflicts,
        "metadata": merged_meta
    }

def merge_duplicates(duplicates_report, output_dir):
    """Merge all duplicate groups."""
    with open(duplicates_report) as f:
        report = json.load(f)
    
    results = []
    
    for i, group_data in enumerate(report["groups"], 1):
        print(f"Merging group {i}/{len(report['groups'])}...")
        
        # Reconstruct group format for merge_group
        group = []
        for j, archive in enumerate(group_data["archives"]):
            group.append({
                "archive": archive,
                "metadata": group_data["metadata"][j]
            })
        
        try:
            result = merge_group(group, output_dir)
            results.append(result)
            print(f"  Created: {Path(result['merged_archive']).name}")
            if result["conflicts"]:
                print(f"  Conflicts: {len(result['conflicts'])}")
        except Exception as e:
            print(f"  Error: {e}", file=sys.stderr)
    
    # Save merge report
    merge_report = {
        "total_groups_merged": len(results),
        "merges": results
    }
    
    report_path = Path(output_dir) / "merge_report.json"
    with open(report_path, "w") as f:
        json.dump(merge_report, f, indent=2)
    
    print(f"\nMerge complete: {len(results)} groups merged")
    print(f"Report saved to: {report_path}")
    
    return merge_report

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: merge_archives.py <duplicates_report.json> <output_dir>")
        sys.exit(1)
    
    merge_duplicates(sys.argv[1], sys.argv[2])
