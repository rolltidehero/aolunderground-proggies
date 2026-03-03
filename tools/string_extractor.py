#!/usr/bin/env python3
"""Extract printable strings from binary files."""

import sys
from pathlib import Path

def extract_strings(filepath, min_length=4, max_file_size=50*1024*1024):
    """Extract printable ASCII and Unicode strings from binary file.
    
    Args:
        filepath: Path to binary file
        min_length: Minimum string length to extract
        max_file_size: Maximum file size to process (default 50MB)
    
    Returns:
        List of unique strings found
    """
    file_size = Path(filepath).stat().st_size
    if file_size > max_file_size:
        print(f"Warning: File {filepath} is {file_size} bytes, skipping (max: {max_file_size})")
        return []
    
    strings = set()  # Use set for deduplication
    
    with open(filepath, 'rb') as f:
        data = f.read()
    
    # ASCII strings
    current = []
    for byte in data:
        if 32 <= byte <= 126:  # Printable ASCII
            current.append(chr(byte))
        else:
            if len(current) >= min_length:
                strings.add(''.join(current))
            current = []
    
    # Unicode strings (UTF-16LE)
    current = []
    i = 0
    while i < len(data) - 1:
        if data[i+1] == 0 and 32 <= data[i] <= 126:
            current.append(chr(data[i]))
            i += 2
        else:
            if len(current) >= min_length:
                strings.add(''.join(current))
            current = []
            i += 1
    
    return list(strings)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: string_extractor.py <file>")
        sys.exit(1)
    
    strings = extract_strings(sys.argv[1])
    for s in sorted(strings):
        print(s)
