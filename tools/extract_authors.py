#!/usr/bin/env python3
"""Extract author info from archives by deep-scanning text files and exe strings."""
import zipfile, os, re, json, sys
from collections import Counter

MERGED_DIR = "data/merged"
REPORT = "data/merged/merge_report.json"

NOISE = {'visual basic','vb6','vb5','vb4','aol','aim','n/a','none','unknown','me','myself',
         'america online','the','you','your','a','an','and','or','for','all','this','that',
         'installshield','microsoft','setup','install','windows','error','default','adobe',
         'photoshop','file','ctrl','version','label','form','about','credit','billing',
         'hello','dear','welcome','sorry','please','online','department','system','user',
         'member','service','information','password','account','internet','computer',
         'loaded','enabled','disabled','active','status','option','detected','start','stop'}

def clean(s):
    if isinstance(s, bytes):
        s = s.decode('latin-1', errors='replace')
    s = s.strip().strip('.:;,!-*"\'()[]{}/<>\\|~`^= \t')
    s = re.sub(r'\s+', ' ', s).strip()
    if not s or len(s) < 3 or len(s) > 50:
        return None
    if s.lower() in NOISE:
        return None
    # Must have at least one letter
    if not re.search(r'[a-zA-Z]', s):
        return None
    # Skip paths, URLs, sentences (more than 5 words usually not an author)
    if '/' in s or '\\' in s or 'http' in s.lower() or '.com' in s.lower():
        return None
    if '.exe' in s.lower() or '.dll' in s.lower() or '.ocx' in s.lower():
        return None
    if len(s.split()) > 5:
        return None
    # Skip if mostly non-ASCII
    if sum(1 for c in s if ord(c) < 128) < len(s) * 0.7:
        return None
    if any(ord(c) < 32 for c in s):
        return None
    return s

def extract_authors_from_strings(strings):
    """Given a list of decoded strings, find all author candidates with scores."""
    candidates = Counter()
    
    for s in strings:
        s = s.strip()
        if len(s) < 4 or len(s) > 200:
            continue
        
        # High confidence: "coded/programmed/made/created by X"
        m = re.search(r'(?:coded|programmed|programming|written|designed|developed|produced|created|made)\s+by\s*:?\s*(.+?)(?:\s*[,\-\|]|$)', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 10
        
        # High confidence: "X presents"
        m = re.match(r'^[*\-=\s]*([A-Za-z][\w\s&\-]{1,25}?)\s+presents', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 10
        
        # High confidence: "X productions"
        m = re.search(r'([A-Za-z][\w\s&\-]{1,25}?)\s+productions?\b', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 8
        
        # Medium: "By: X" or "By X" (with colon)
        m = re.search(r'\bby\s*:\s*(.+?)(?:\s*[\-\|,\]]|$)', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 5
        
        # Medium: "By X" (capitalized name after By)
        m = re.search(r'\bBy\s+([A-Z][\w\-]+(?:\s*[&+]\s*[A-Z][\w\-]+)*)', s)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 5
        
        # Medium: "author/coder/programmer: X"
        m = re.search(r'(?:author|coder|programmer|creator|developer)\s*:?\s*(.+?)(?:\s*[\-\|,]|$)', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 5
        
        # Lower: "by x" (lowercase, less reliable)
        m = re.search(r'\bby\s+([a-zA-Z][\w\-]+(?:\s*[&+]\s*[a-zA-Z][\w\-]+)*)', s, re.I)
        if m:
            a = clean(m.group(1))
            if a: candidates[a] += 2

    # Return highest scored candidate
    if candidates:
        return candidates.most_common(1)[0][0]
    return None

def process(path):
    try:
        with zipfile.ZipFile(path) as z:
            all_strings = []
            
            # Text files first (higher quality)
            for name in z.namelist():
                if name.lower().endswith(('.txt', '.nfo', '.diz')):
                    try:
                        content = z.read(name).decode('latin-1', errors='replace')[:3000]
                        all_strings.extend(content.split('\n'))
                    except:
                        pass
            
            # Check text files alone first
            author = extract_authors_from_strings(all_strings)
            if author:
                return author
            
            # Now scan exe strings (ASCII + UTF-16LE)
            exe_strings = []
            for name in z.namelist():
                if name.lower().endswith('.exe'):
                    try:
                        data = z.read(name)
                        # ASCII strings
                        for m in re.finditer(rb'[\x20-\x7e]{4,}', data):
                            exe_strings.append(m.group().decode('ascii'))
                        # UTF-16LE strings
                        for m in re.finditer(rb'(?:[\x20-\x7e]\x00){4,}', data):
                            try:
                                exe_strings.append(m.group().decode('utf-16-le'))
                            except:
                                pass
                    except:
                        pass
            
            return extract_authors_from_strings(exe_strings)
    except:
        pass
    return None

# Known authors that can't be auto-detected
KNOWN = {
    'aohell': 'Da Chronic',
    'fatex25': 'MaGuS & FuNGii',
    'fatex42': 'MaGuS & FuNGii',
}

def main():
    with open(REPORT) as f:
        report = json.load(f)

    # Clear all authors first for clean re-extraction
    for merge in report['merges']:
        merge['metadata']['author'] = None

    updated = 0
    total = len(report['merges'])
    for i, merge in enumerate(report['merges']):
        path = merge['merged_archive']
        if not os.path.exists(path):
            continue
        author = process(path)
        if author:
            merge['metadata']['author'] = author
            updated += 1
        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{total} processed, {updated} authors found", file=sys.stderr)

    # Apply known authors last (override)
    for merge in report['merges']:
        name = merge['metadata'].get('archive_name', '').lower().rsplit('.', 1)[0]
        for key, author in KNOWN.items():
            if name == key or name.startswith(key + ' '):
                merge['metadata']['author'] = author
                break

    with open(REPORT, 'w') as f:
        json.dump(report, f, indent=2)

    has = sum(1 for m in report['merges'] if m['metadata'].get('author') and m['metadata']['author'] not in (None, 'None'))
    print(f"Done: {has}/{total} authors found")

if __name__ == '__main__':
    main()
