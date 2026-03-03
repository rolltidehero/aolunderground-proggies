#!/usr/bin/env python3
"""Extract passwords from archive filenames and create password database."""

import json
import re
from pathlib import Path
from difflib import SequenceMatcher

def extract_passwords_from_filenames(repo_path):
    """Extract passwords embedded in filenames."""
    passwords = {}
    
    # Pattern: "password=xxx" or "pass=xxx" in filename
    pattern = re.compile(r'password[=\s]+([^\s\]\.]+)', re.IGNORECASE)
    
    for archive in Path(repo_path).rglob('*.zip'):
        match = pattern.search(archive.name)
        if match:
            password = match.group(1)
            # Extract program name (before "password=")
            prog_name = archive.stem.split('password')[0].strip(' -_')
            if prog_name:
                if prog_name not in passwords:
                    passwords[prog_name] = []
                if password not in passwords[prog_name]:
                    passwords[prog_name].append(password)
    
    for archive in Path(repo_path).rglob('*.rar'):
        match = pattern.search(archive.name)
        if match:
            password = match.group(1)
            prog_name = archive.stem.split('password')[0].strip(' -_')
            if prog_name:
                if prog_name not in passwords:
                    passwords[prog_name] = []
                if password not in passwords[prog_name]:
                    passwords[prog_name].append(password)
    
    return passwords

def fuzzy_match(query, candidates, threshold=0.6):
    """Fuzzy match query against candidate program names."""
    matches = []
    query_lower = query.lower()
    
    for candidate in candidates:
        ratio = SequenceMatcher(None, query_lower, candidate.lower()).ratio()
        if ratio >= threshold:
            matches.append((candidate, ratio))
    
    return sorted(matches, key=lambda x: x[1], reverse=True)

def main():
    repo_path = Path(__file__).parent.parent
    
    print("Extracting passwords from filenames...")
    passwords = extract_passwords_from_filenames(repo_path)
    
    print(f"Found {len(passwords)} programs with passwords")
    
    # Save to JSON
    output_file = repo_path / 'tools' / 'passwords.json'
    with open(output_file, 'w') as f:
        json.dump(passwords, f, indent=2)
    
    print(f"Saved to {output_file}")
    
    # Test fuzzy matching
    print("\nTest: Fuzzy matching 'aohell'")
    matches = fuzzy_match('aohell', passwords.keys())
    for prog, score in matches[:5]:
        print(f"  {prog}: {passwords[prog]} (score: {score:.2f})")

if __name__ == '__main__':
    main()
