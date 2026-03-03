#!/usr/bin/env python3
"""Extract printable strings from binary files."""

import sys

def extract_strings(filepath, min_length=4):
    """Extract printable ASCII and Unicode strings from binary file."""
    strings = []
    
    with open(filepath, 'rb') as f:
        data = f.read()
    
    # ASCII strings
    current = []
    for byte in data:
        if 32 <= byte <= 126:  # Printable ASCII
            current.append(chr(byte))
        else:
            if len(current) >= min_length:
                strings.append(''.join(current))
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
                strings.append(''.join(current))
            current = []
            i += 1
    
    return list(set(strings))  # Remove duplicates

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: string_extractor.py <file>")
        sys.exit(1)
    
    strings = extract_strings(sys.argv[1])
    for s in sorted(strings):
        print(s)
