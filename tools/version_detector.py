#!/usr/bin/env python3
"""Detect AOL version compatibility from various sources."""

import re
from pathlib import Path

# Version detection patterns
VERSION_PATTERNS = {
    "2.5": [
        r'aol\s*2\.5', r'aol25', r'aol\s*95', r'C:\\aol25\\',
        r'for\s+aol\s+2\.5', r'\[aol\s*2\.5\]'
    ],
    "3.0": [
        r'aol\s*3\.0', r'aol30', r'C:\\aol30\\', r'aol\s*3\b',
        r'for\s+aol\s+3', r'\[aol\s*3\.0\]', r'aohell.*3'
    ],
    "4.0": [
        r'aol\s*4\.0', r'aol40', r'C:\\aol40\\', r'aol\s*4\b',
        r'for\s+aol\s+4', r'\[aol\s*4\.0\]', r"What's New in AOL 4\.0",
        r'_AOL_Glyph'
    ],
    "5.0": [
        r'aol\s*5\.0', r'aol50', r'America Online 5', r'aol\s*5\b',
        r'for\s+aol\s+5', r'\[aol\s*5\.0\]', r"What's New in AOL 5\.0"
    ],
    "6.0": [
        r'aol\s*6\.0', r'aol60', r'America Online 6', r'aol\s*6\b',
        r'for\s+aol\s+6', r'\[aol\s*6\.0\]', r"What's New in AOL 6\.0",
        r'C:\\America Online 6'
    ],
    "7.0": [
        r'aol\s*7\.0', r'aol70', r'America Online 7', r'aol\s*7\b',
        r'for\s+aol\s+7', r'\[aol\s*7\.0\]', r"What's New in AOL 7\.0"
    ],
    "8.0": [
        r'aol\s*8\.0', r'aol80', r'America Online 8', r'aol\s*8\b',
        r'for\s+aol\s+8', r'\[aol\s*8\.0\]'
    ],
    "9.0": [
        r'aol\s*9\.0', r'aol90', r'America Online 9', r'aol\s*9\b',
        r'for\s+aol\s+9', r'\[aol\s*9\.0\]'
    ]
}

def detect_version_from_filename(filename):
    """Detect version from archive filename."""
    versions = {}
    filename_lower = filename.lower()
    
    for version, patterns in VERSION_PATTERNS.items():
        for pattern in patterns:
            if re.search(pattern, filename_lower, re.IGNORECASE):
                versions[version] = versions.get(version, 0) + 0.3
    
    return versions

def detect_version_from_strings(strings):
    """Detect version from extracted strings."""
    versions = {}
    combined = ' '.join(strings).lower()
    
    for version, patterns in VERSION_PATTERNS.items():
        for pattern in patterns:
            matches = len(re.findall(pattern, combined, re.IGNORECASE))
            if matches > 0:
                versions[version] = versions.get(version, 0) + (0.2 * min(matches, 3))
    
    # Special indicators
    has_glyph = '_AOL_Glyph' in combined or '_aol_glyph' in combined
    has_frame25 = 'AOL Frame25' in combined or 'aol frame25' in combined
    has_waol = 'waol.exe' in combined
    has_aol_exe = 'aol.exe' in combined and 'America Online 6' in combined
    
    if has_glyph:
        # Glyph only in 4.0+
        for v in ["4.0", "5.0"]:
            versions[v] = versions.get(v, 0) + 0.4
    
    if has_frame25 and not has_glyph:
        # Frame25 without Glyph suggests 2.5 or 3.0
        for v in ["2.5", "3.0"]:
            versions[v] = versions.get(v, 0) + 0.2
    
    if has_waol:
        # waol.exe used in 2.5-5.0
        for v in ["2.5", "3.0", "4.0", "5.0"]:
            versions[v] = versions.get(v, 0) + 0.1
    
    if has_aol_exe:
        # aol.exe in 6.0+
        for v in ["6.0", "7.0", "8.0", "9.0"]:
            versions[v] = versions.get(v, 0) + 0.2
    
    return versions

def detect_version_from_pe_metadata(metadata):
    """Detect version from PE metadata."""
    versions = {}
    
    if not metadata:
        return versions
    
    # Combine all metadata fields
    text = ' '.join(str(v) for v in metadata.values() if v)
    text_lower = text.lower()
    
    for version, patterns in VERSION_PATTERNS.items():
        for pattern in patterns:
            if re.search(pattern, text_lower, re.IGNORECASE):
                versions[version] = versions.get(version, 0) + 0.5
    
    return versions

def detect_version_from_bas_files(bas_content):
    """Detect version from .bas source files."""
    versions = {}
    content_lower = bas_content.lower()
    
    for version, patterns in VERSION_PATTERNS.items():
        for pattern in patterns:
            matches = len(re.findall(pattern, content_lower, re.IGNORECASE))
            if matches > 0:
                versions[version] = versions.get(version, 0) + (0.4 * min(matches, 3))
    
    return versions

def combine_detections(filename_versions, string_versions, pe_versions, bas_versions):
    """Combine all version detections with confidence scores."""
    all_versions = {}
    
    # Combine scores
    for versions in [filename_versions, string_versions, pe_versions, bas_versions]:
        for version, score in versions.items():
            all_versions[version] = all_versions.get(version, 0) + score
    
    # Normalize to 0-1 range
    if all_versions:
        max_score = max(all_versions.values())
        if max_score > 0:
            all_versions = {v: min(s / max_score, 1.0) for v, s in all_versions.items()}
    
    # Filter by threshold (0.5 = 50% confidence)
    filtered = {v: s for v, s in all_versions.items() if s >= 0.5}
    
    return filtered

def detect_aol_version(filename, strings, pe_metadata, bas_files_content):
    """Main version detection function."""
    filename_v = detect_version_from_filename(filename)
    string_v = detect_version_from_strings(strings)
    pe_v = detect_version_from_pe_metadata(pe_metadata)
    
    bas_v = {}
    for content in bas_files_content:
        bas_detected = detect_version_from_bas_files(content)
        for v, score in bas_detected.items():
            bas_v[v] = max(bas_v.get(v, 0), score)
    
    versions = combine_detections(filename_v, string_v, pe_v, bas_v)
    
    # Determine primary version (highest confidence)
    primary = max(versions.items(), key=lambda x: x[1])[0] if versions else None
    
    # Create version range
    if versions:
        sorted_versions = sorted(versions.keys(), key=lambda x: float(x))
        if len(sorted_versions) > 1:
            version_range = f"{sorted_versions[0]}-{sorted_versions[-1]}"
        else:
            version_range = sorted_versions[0]
    else:
        version_range = None
    
    evidence = {
        "filename": filename_v,
        "strings": string_v,
        "pe_metadata": pe_v,
        "bas_files": bas_v
    }
    
    return {
        "versions": sorted(versions.keys(), key=lambda x: float(x)),
        "version_confidence": versions,
        "primary_version": primary,
        "version_range": version_range,
        "evidence": evidence,
        "needs_review": not versions or max(versions.values()) < 0.9
    }

if __name__ == '__main__':
    # Test
    result = detect_aol_version(
        "aohell3.zip",
        ["C:\\aol30\\waol.exe", "AOL Frame25", "For AOL 3.0"],
        {"file_description": "AOHell for AOL 3.0"},
        ["'This is for AOL 3.0 and 4.0"]
    )
    
    import json
    print(json.dumps(result, indent=2))
