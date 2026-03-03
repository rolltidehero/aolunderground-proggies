#!/usr/bin/env python3
"""Parse PE (Portable Executable) metadata from Windows executables."""

import struct
from datetime import datetime

def parse_pe_metadata(filepath):
    """Extract metadata from PE file."""
    metadata = {
        "timestamp": None,
        "file_description": None,
        "product_version": None,
        "company_name": None,
        "original_filename": None,
        "comments": None
    }
    
    try:
        with open(filepath, 'rb') as f:
            # Check DOS header
            dos_header = f.read(64)
            if dos_header[:2] != b'MZ':
                return metadata
            
            # Get PE header offset
            pe_offset = struct.unpack('<I', dos_header[60:64])[0]
            f.seek(pe_offset)
            
            # Check PE signature
            if f.read(4) != b'PE\x00\x00':
                return metadata
            
            # Read COFF header
            coff_header = f.read(20)
            timestamp = struct.unpack('<I', coff_header[4:8])[0]
            if timestamp > 0:
                try:
                    metadata["timestamp"] = datetime.fromtimestamp(timestamp).isoformat()
                except:
                    pass
            
            # Read entire file for version info strings
            f.seek(0)
            data = f.read()
            
            # Look for version info strings
            version_strings = {
                b'FileDescription\x00': 'file_description',
                b'ProductVersion\x00': 'product_version',
                b'CompanyName\x00': 'company_name',
                b'OriginalFilename\x00': 'original_filename',
                b'Comments\x00': 'comments'
            }
            
            for marker, key in version_strings.items():
                idx = data.find(marker)
                if idx != -1:
                    # Skip marker and null bytes
                    start = idx + len(marker)
                    # Find next string (skip padding)
                    while start < len(data) and data[start] == 0:
                        start += 1
                    
                    # Extract string
                    end = start
                    value = []
                    while end < len(data) - 1:
                        if data[end] != 0:
                            value.append(chr(data[end]))
                            end += 1
                        elif data[end+1] == 0:
                            break
                        else:
                            end += 1
                    
                    if value:
                        metadata[key] = ''.join(value).strip()
    
    except Exception as e:
        pass
    
    return metadata

if __name__ == '__main__':
    import sys
    if len(sys.argv) < 2:
        print("Usage: pe_parser.py <exe_file>")
        sys.exit(1)
    
    import json
    metadata = parse_pe_metadata(sys.argv[1])
    print(json.dumps(metadata, indent=2))
