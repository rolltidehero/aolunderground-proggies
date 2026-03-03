#!/usr/bin/env python3
"""Generate NEEDS_REVIEW.md for proggies needing version verification."""
import json
from pathlib import Path

MERGE_REPORT = Path("data/merged/merge_report.json")
OUTPUT = Path("NEEDS_REVIEW.md")

def main():
    with open(MERGE_REPORT) as f:
        data = json.load(f)
    
    needs_review = []
    for merge in data['merges']:
        meta = merge['metadata']
        detection = meta.get('detection_evidence', {})
        
        # Flag for review if:
        # 1. Marked as needs_review
        # 2. No version detected (Unknown)
        # 3. Low confidence detection
        if (detection.get('needs_review') or 
            meta.get('aol_versions') == ['Unknown'] or
            (detection.get('confidence', 1.0) < 0.8 and meta.get('aol_versions') != ['Unknown'])):
            needs_review.append(merge)
    
    with open(OUTPUT, 'w') as f:
        f.write("# Proggies Needing Version Review\n\n")
        f.write(f"**Total needing review:** {len(needs_review)} of {len(data['merges'])} proggies\n\n")
        f.write("These proggies need manual version verification:\n")
        f.write("- No AOL API signatures detected\n")
        f.write("- Low confidence version detection\n")
        f.write("- Conflicting version evidence\n\n")
        f.write("## How to Help\n\n")
        f.write("1. Extract and test the proggie on different AOL versions\n")
        f.write("2. Check README files or documentation for version info\n")
        f.write("3. Submit corrections via issues or pull requests\n\n")
        f.write("---\n\n")
        
        # Group by detected version
        by_version = {}
        for merge in needs_review:
            versions = merge['metadata'].get('aol_versions', ['Unknown'])
            key = ', '.join(versions)
            if key not in by_version:
                by_version[key] = []
            by_version[key].append(merge)
        
        for version_key in sorted(by_version.keys()):
            f.write(f"## {version_key}\n\n")
            f.write("| Name | File | Reason | Evidence |\n")
            f.write("|------|------|--------|----------|\n")
            
            for merge in sorted(by_version[version_key], key=lambda x: x['metadata'].get('program_name', 'Unknown').lower()):
                meta = merge['metadata']
                detection = meta.get('detection_evidence', {})
                
                name = meta.get('program_name', 'Unknown')
                file = Path(merge['merged_archive']).name
                
                # Determine reason
                if meta.get('aol_versions') == ['Unknown']:
                    reason = "No signatures"
                elif detection.get('confidence', 1.0) < 0.8:
                    reason = f"Low confidence ({detection.get('confidence', 0):.2f})"
                else:
                    reason = "Needs review"
                
                # Evidence summary
                evidence_parts = []
                if detection.get('window_classes'):
                    evidence_parts.append(f"{len(detection['window_classes'])} window classes")
                if detection.get('control_classes'):
                    evidence_parts.append(f"{len(detection['control_classes'])} controls")
                evidence = ', '.join(evidence_parts) if evidence_parts else "None"
                
                f.write(f"| {name} | `{file}` | {reason} | {evidence} |\n")
            
            f.write("\n")
    
    print(f"Created: {OUTPUT}")
    print(f"Proggies needing review: {len(needs_review)}")

if __name__ == '__main__':
    main()
