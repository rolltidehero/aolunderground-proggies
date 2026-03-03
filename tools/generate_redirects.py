#!/usr/bin/env python3
"""Generate REDIRECTS.md mapping old paths to new merged locations."""
import json
from pathlib import Path

MERGE_REPORT = Path("data/merged/merge_report.json")
OUTPUT = Path(".github/REDIRECTS.md")

def main():
    with open(MERGE_REPORT) as f:
        data = json.load(f)
    
    OUTPUT.parent.mkdir(exist_ok=True)
    
    with open(OUTPUT, 'w') as f:
        f.write("# File Redirects\n\n")
        f.write("This file maps old archive locations to their new merged locations.\n\n")
        f.write("**Why files moved:**\n")
        f.write("- Duplicate detection merged archives containing identical .exe files\n")
        f.write("- Version-based organization moved files to version-specific directories\n\n")
        f.write("## How to Find Your File\n\n")
        f.write("1. Search this page (Ctrl+F) for the old filename\n")
        f.write("2. Use the [proggie-index.html](../proggie-index.html) search interface\n")
        f.write("3. Browse [proggie-index.md](../proggie-index.md) by version\n\n")
        f.write("---\n\n")
        
        # Group by merged archive
        for merge in sorted(data['merges'], key=lambda x: x['merged_archive']):
            merged_path = merge['merged_archive']
            sources = merge['merged_from']
            
            if len(sources) > 1:  # Only show if there were duplicates
                f.write(f"### {Path(merged_path).name}\n\n")
                f.write(f"**New location:** `{merged_path}`\n\n")
                f.write("**Old locations:**\n")
                for src in sorted(sources):
                    f.write(f"- `{src}`\n")
                f.write("\n")
    
    print(f"Created: {OUTPUT}")
    print(f"Total redirects: {sum(len(m['merged_from']) for m in data['merges'] if len(m['merged_from']) > 1)}")

if __name__ == '__main__':
    main()
