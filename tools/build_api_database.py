#!/usr/bin/env python3
"""Extract AOL API signatures from BAS files to build version detection database."""
import re
from pathlib import Path
from collections import defaultdict

# Map directory names to AOL versions
DIR_VERSION_MAP = {
    "25": ["2.5"],
    "30": ["3.0"],
    "40": ["4.0"],
    "50": ["5.0"],
    "60": ["6.0"],
    "70": ["7.0"],
    "80": ["8.0"],
    "90": ["9.0"],
    "25-30": ["2.5", "3.0"],
    "40-50": ["4.0", "5.0"],
    "40-60": ["4.0", "5.0", "6.0"],
    "50-60": ["5.0", "6.0"],
    "60-70": ["6.0", "7.0"],
    "70-80": ["7.0", "8.0"],
    "80-90": ["8.0", "9.0"],
}

def extract_window_classes(bas_content):
    """Extract AOL window class names from FindWindow calls."""
    pattern = r'FindWindow\s*\(\s*"([^"]+)"'
    return re.findall(pattern, bas_content, re.IGNORECASE)

def extract_control_classes(bas_content):
    """Extract AOL control class names from FindWindowEx calls."""
    pattern = r'FindWindowEx\s*\([^,]+,\s*[^,]+,\s*"([^"]+)"'
    return re.findall(pattern, bas_content, re.IGNORECASE)

def extract_aol_paths(bas_content):
    """Extract AOL installation paths."""
    pattern = r'[Cc]:\\[Aa][Oo][Ll]\d+\\'
    return re.findall(pattern, bas_content)

def get_versions_from_path(file_path):
    """Determine AOL versions from BAS file directory structure."""
    path_str = str(file_path)
    for dir_pattern, versions in DIR_VERSION_MAP.items():
        if f"/aol/{dir_pattern}/" in path_str or f"\\aol\\{dir_pattern}\\" in path_str:
            return versions
    return []

def main():
    api_db = defaultdict(lambda: defaultdict(set))
    
    bas_files = list(Path("programming/vb/aol").rglob("*.bas"))
    print(f"Analyzing {len(bas_files)} BAS files...")
    
    for bas_file in bas_files:
        try:
            content = bas_file.read_text(encoding="latin-1", errors="ignore")
            versions = get_versions_from_path(bas_file)
            
            if not versions:
                continue
            
            # Extract API signatures
            window_classes = extract_window_classes(content)
            control_classes = extract_control_classes(content)
            aol_paths = extract_aol_paths(content)
            
            for version in versions:
                for wc in window_classes:
                    if "AOL" in wc or "aol" in wc:
                        api_db["window_classes"][wc].add(version)
                
                for cc in control_classes:
                    if "AOL" in cc or "_AOL_" in cc or "aol" in cc:
                        api_db["control_classes"][cc].add(version)
                
                for path in aol_paths:
                    api_db["install_paths"][path].add(version)
        
        except Exception as e:
            print(f"Error reading {bas_file}: {e}")
    
    # Convert sets to sorted lists
    output = {}
    for category, signatures in api_db.items():
        output[category] = {sig: sorted(list(versions)) for sig, versions in signatures.items()}
    
    # Print results
    print(f"\n=== Window Classes ===")
    for sig, versions in sorted(output.get("window_classes", {}).items()):
        print(f"{sig:30} -> {', '.join(versions)}")
    
    print(f"\n=== Control Classes ===")
    for sig, versions in sorted(output.get("control_classes", {}).items()):
        print(f"{sig:30} -> {', '.join(versions)}")
    
    print(f"\n=== Install Paths ===")
    for sig, versions in sorted(output.get("install_paths", {}).items()):
        print(f"{sig:30} -> {', '.join(versions)}")
    
    # Save to JSON
    import json
    with open("tools/aol_api_signatures.json", "w") as f:
        json.dump(output, f, indent=2)
    
    print(f"\nSaved API signature database to tools/aol_api_signatures.json")

if __name__ == "__main__":
    main()
