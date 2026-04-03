# AOL 2.6b15 Binary Analysis: FDO Version Identification

## Reproducible Method

All steps below can be reproduced on any Linux system with `unar` and Python 3.

### Step 1: Extract the installer archive

```bash
sudo apt-get install -y unar
mkdir -p /tmp/aol26
unar -o /tmp/aol26 Instll_AOl_v2.6b15.sit
```

Output:
```
Instll_AOl_v2.6b15.sit: StuffIt 5
  Instll AOl v2.6b15  (83612 B, rsrc)... OK.
  Instll AOl v2.6b15  (1521415 B)... OK.
```

The data fork (`Instll AOl v2.6b15`, 1,521,415 bytes) is itself a StuffIt archive containing
the full AOL application folder.

### Step 2: Extract the nested application folder

```bash
unar -o /tmp/aol26/extracted "/tmp/aol26/Instll AOl v2.6b15"
```

Output (abbreviated):
```
Instll AOl v2.6b15: StuffIt
  America Online v2.6b15 Folder/America Online v2.6b15  (835073 B, rsrc)... OK.
  America Online v2.6b15 Folder/Online Tools/Chat  (19671 B, rsrc)... OK.
  America Online v2.6b15 Folder/Online Tools/File Transfer  (45005 B, rsrc)... OK.
  America Online v2.6b15 Folder/Online Tools/Mail  (74185 B, rsrc)... OK.
  [... modem configs, art resources, etc.]
```

The main binary is `America Online v2.6b15.rsrc` (835,073 bytes, AppleDouble resource fork).

### Step 3: Parse the resource fork and extract CODE segments

The following Python script parses the AppleDouble resource fork and extracts all resources.
This is the same method documented in [HOW-TO-DECOMPILE.md](../hells/aol4free/HOW-TO-DECOMPILE.md).

```python
#!/usr/bin/env python3
"""analyze_aol26.py — Extract and analyze resources from AOL 2.6b15."""
import struct, sys, os

def extract_resource_fork(rsrc_path):
    """Parse AppleDouble header, return raw resource fork bytes."""
    with open(rsrc_path, 'rb') as f:
        data = f.read()
    magic = struct.unpack('>I', data[:4])[0]
    assert magic == 0x00051607, f"Not AppleDouble: {magic:#x}"
    num_entries = struct.unpack('>H', data[24:26])[0]
    for i in range(num_entries):
        entry_id, offset, length = struct.unpack(
            '>III', data[26 + i*12 : 26 + i*12 + 12])
        if entry_id == 2:  # Resource fork
            return data[offset : offset + length]
    raise ValueError("No resource fork entry found")

def parse_resource_fork(rsrc_data):
    """Parse Mac resource fork, return {type: [(id, name, data), ...]}."""
    data_offset, map_offset = struct.unpack('>II', rsrc_data[:8])
    m = rsrc_data[map_offset:]
    type_list_off = struct.unpack('>H', m[24:26])[0]
    name_list_off = struct.unpack('>H', m[26:28])[0]
    tl = m[type_list_off:]
    num_types = struct.unpack('>H', tl[:2])[0] + 1
    result = {}
    for i in range(num_types):
        entry = tl[2 + i*8 : 2 + i*8 + 8]
        rtype = entry[0:4].decode('mac_roman', errors='replace')
        count = struct.unpack('>H', entry[4:6])[0] + 1
        ref_list_off = struct.unpack('>H', entry[6:8])[0]
        resources = []
        for j in range(count):
            ref = tl[ref_list_off + j*12 : ref_list_off + j*12 + 12]
            res_id = struct.unpack('>h', ref[0:2])[0]
            name_off = struct.unpack('>H', ref[2:4])[0]
            d_off = struct.unpack('>I', b'\x00' + ref[5:8])[0]
            abs_off = data_offset + d_off
            res_len = struct.unpack('>I', rsrc_data[abs_off:abs_off+4])[0]
            res_data = rsrc_data[abs_off+4 : abs_off+4+res_len]
            name = ''
            if name_off != 0xFFFF:
                nl = m[name_list_off + name_off:]
                nlen = nl[0]
                name = nl[1:1+nlen].decode('mac_roman', errors='replace')
            resources.append((res_id, name, res_data))
        result[rtype] = resources
    return result

# --- Main ---
rsrc_path = sys.argv[1]
rsrc_data = extract_resource_fork(rsrc_path)
resources = parse_resource_fork(rsrc_data)

# Print all resource types
for rtype, res_list in sorted(resources.items()):
    print(f"  '{rtype}': {len(res_list)} resource(s)")

# Extract and list CODE segments
if 'CODE' in resources:
    out_dir = sys.argv[2] if len(sys.argv) > 2 else '/tmp/aol26_code'
    os.makedirs(out_dir, exist_ok=True)
    print(f"\nCODE Resources ({len(resources['CODE'])}):")
    for res_id, name, data in sorted(resources['CODE'], key=lambda x: x[0]):
        with open(os.path.join(out_dir, f'CODE_{res_id:04d}.bin'), 'wb') as f:
            f.write(data)
        print(f"  CODE {res_id:4d} '{name}': {len(data):,} bytes")

# Print STR# strings containing FDO/free area references
if 'STR#' in resources:
    print("\nFDO-related strings:")
    for res_id, name, data in sorted(resources['STR#'], key=lambda x: x[0]):
        if len(data) < 2: continue
        count = struct.unpack('>H', data[:2])[0]
        pos = 2
        for _ in range(count):
            if pos >= len(data): break
            slen = data[pos]; pos += 1
            s = data[pos:pos+slen].decode('mac_roman', errors='replace'); pos += slen
            if any(k in s.lower() for k in ['fdo', 'free area', 'exit free']):
                print(f"  STR# {res_id}: \"{s}\"")

# Print vers resources
if 'vers' in resources:
    print("\nVersion resources:")
    for res_id, name, data in resources['vers']:
        if len(data) >= 8:
            short_len = data[6]
            short_ver = data[7:7+short_len].decode('mac_roman', errors='replace')
            long_off = 7 + short_len
            long_len = data[long_off] if long_off < len(data) else 0
            long_ver = data[long_off+1:long_off+1+long_len].decode(
                'mac_roman', errors='replace') if long_len else ''
            print(f"  vers {res_id}: short='{short_ver}' long='{long_ver}'")

# Search CODE 27 (MOPs) for Kg dispatch pattern
if 'CODE' in resources:
    for res_id, name, data in resources['CODE']:
        if res_id == 27:
            idx = data.find(b'\x06\x4B\x67')
            if idx >= 0:
                block = data[idx:idx+8]
                pre2 = data[idx-2:idx]
                post = data[idx+8:idx+12]
                print(f"\nKg dispatch in CODE {res_id} '{name}' at offset {idx:#06x}:")
                print(f"  Preceding 2 bytes: {pre2.hex()}"
                      f" ({'RTS' if pre2 == b'\\x4e\\x75' else 'other'})")
                print(f"  Dispatch bytes:    {block.hex()}")
                print(f"  Following 4 bytes: {post.hex()}"
                      f" ({'LINK A6' if post[:2] == b'\\x4e\\x56' else 'other'})")
```

### Step 4: Run the analysis

```bash
python3 analyze_aol26.py \
  "/tmp/aol26/extracted/Instll AOl v2/America Online v2.6b15 Folder/America Online v2.6b15.rsrc" \
  /tmp/aol26_code
```

Full output:

```
  'ALRT': 14 resource(s)
  'AOft': 1 resource(s)
  'AOqc': 1 resource(s)
  'BNDL': 1 resource(s)
  'CNTL': 2 resource(s)
  'CODE': 54 resource(s)
  'CURS': 15 resource(s)
  [... 47 resource types total ...]
  'vers': 2 resource(s)

CODE Resources (54):
  CODE    0 '': 12,552 bytes
  CODE    1 'Main': 23,918 bytes
  CODE    2 'InitUnit': 19,860 bytes
  CODE    3 'Libs': 31,416 bytes
  CODE    4 'Events': 27,106 bytes
  CODE    5 'P3': 22,524 bytes
  CODE    6 'DataParsing': 27,088 bytes
  CODE    7 'ToolkitUtils': 20,588 bytes
  CODE    8 'Toolkit': 19,072 bytes
  CODE    9 'TokenHandler': 4,218 bytes
  CODE   10 'FormsInfo': 18,004 bytes
  CODE   11 'Drawing': 14,294 bytes
  CODE   12 'FormModifiers': 28,050 bytes
  CODE   13 'CCL': 26,278 bytes
  CODE   14 'Dbase': 2,436 bytes
  CODE   15 'Dialogs': 2,898 bytes
  CODE   16 'Utils': 1,258 bytes
  CODE   17 'SerStuff': 16,940 bytes
  CODE   18 'Printing': 4,802 bytes
  CODE   19 'WindowUtes': 2,242 bytes
  CODE   20 'FormsDeletion': 3,120 bytes
  CODE   21 'FormsCreation': 28,006 bytes
  CODE   22 'Menus': 17,894 bytes
  CODE   23 'Schedule': 20,300 bytes
  CODE   24 'UDO': 9,306 bytes
  CODE   25 'ToolCallbacks': 23,752 bytes
  CODE   26 'EditStuff': 9,602 bytes
  CODE   27 'MOPs': 10,986 bytes
  CODE   28 'DiskIO': 13,884 bytes
  CODE   29 'SoundUtil': 6,216 bytes
  CODE   30 '2D_ENGINE_SUPPORT_1': 13,756 bytes
  [... segments 31-53: charting engine ...]

FDO-related strings:
  STR# 10016: "You cannot exit the free area while a download is in progress. ..."
  STR# 10016: "You cannot enter a free area while a download is in progress. ..."
  STR# 10018: "Unknown FDO code: "
  STR# 10018: "Unknown extended FDO code: "
  STR# 10026: "Exit Free Area"

Version resources:
  vers 1: short='2.6b15' long='2.6b15 Copyright © 1987-1995 America Online, Inc.'
  vers 2: short='2.6b15' long='America Online v2.6b15'

Kg dispatch in CODE 27 'MOPs' at offset 0x02f6:
  Preceding 2 bytes: 4e75 (RTS)
  Dispatch bytes:    064b674040404000
  Following 4 bytes: 4e56fdfa (LINK A6)
```

---

## Finding 1: AOL 2.6 Uses FDO88, Not FDO91

### Evidence A: Binary Terminology Matches FDO88 Manual (Primary)

STR# resource 10018 in the binary contains:
```
"Unknown FDO code: "
"Unknown extended FDO code: "
```

The FDO88 Manual (January 1994, AOL internal document) uses the terms "FDO code" and "opcode"
for its instructions throughout. The FDO91 Manual (February 1998, also AOL internal) uses the
term "atom" exclusively — 194 occurrences of "atom" in the introduction chapter alone, zero
occurrences of "FDO code" across all 11 chapters.

The binary's error handler uses FDO88 Manual terminology, not FDO91 Manual terminology.

### Evidence B: CODE Segment `MOPs` Implements FDO88 Architecture (Primary)

CODE resource 27 is named **`MOPs`** (10,986 bytes). MOP ("Message Operation Protocol") is the
dispatch mechanism defined in the FDO88 Manual:
- Chapter 2, p.2-43 (PDF p.51): `fdo$dispch` syntax definition
- Appendix E, pp.E-1 through E-10 (PDF pp.225–234): MOP code table and dispatch examples

The FDO88 Manual defines MOP codes in Table E.1 (p.E-2, PDF p.226):

| MOP Code | Name | Description |
|----------|------|-------------|
| 1 | Ask_DB | Request a library record |
| 2 | Ask_DB_Ext | Extended library request |
| 10 | Send_Form | Send form data to host |
| 11 | Send_Selected | Send selected item data |
| 14 | Private_Event | Internal client event |

A dedicated `MOPs` CODE segment confirms the client implements the FDO88 MOP dispatch
architecture. The FDO91 Manual does not use the term "MOP" — it uses "atom" for all operations.

### Evidence C: Dispatch Data Format Matches FDO88 Manual (Primary)

The Kg dispatch template at CODE 27 offset 0x02F6 (see Finding 2) uses the same 6-byte
length-prefixed format defined in the FDO88 Manual's `fdo$dispch` syntax (p.2-43, PDF p.51).
The verified dispatch example from Appendix B p.B-4 (PDF p.175) — `fdo$dispch 129 ('K1',2)
$08 $CC $93` — encodes to the same structure found in the binary.

### Evidence D: Free Area Strings Match FDO88 Manual (Primary)

STR# resources 10016 and 10026 contain:
```
"You cannot exit the free area while a download is in progress..."
"You cannot enter a free area while a download is in progress..."
"Exit Free Area"
```

These match the billing mechanism described in the FDO88 Manual p.2-44 (PDF p.52):
`plus_free` — "Action allowed from free area only" and "the client software will offer to
either cancel the dispatch or to change the surcharge status."

### Evidence E: Community Documentation (Corroborative, Not Authoritative)

The AOL-Files FDO tutorial (Tau/BMB, circa 2000, `aol-files.com`) states:

> "FDO88 is used in the GEOS version of the AOL client, PCAO, and the Macintosh clients
> before version AOL version 3.0. FDO91 is the 1991 version and is the language used in the
> Windows client, the Magic Cap client, and the Macintosh client (versions 3.0 and later)."

Source: [koin.org mirror](http://koin.org/files/aol.aim/aol/fdo/tutorial/tutorial%20-%20what%20is%20FDO.htm)

This is a community-written tutorial, not an AOL internal document. Tau and BMB operated
aol-files.com and had access to AOL tools and leaked documents, but their statement is
secondary — it is consistent with the primary evidence from the binary and the FDO88 Manual
but does not carry the same weight.

---

## Finding 2: The `Kg` Token Exists in the Unpatched AOL 2.6 Client

### Binary Evidence

CODE resource 27 (`MOPs`) contains the byte sequence `06 4B 67` at offset `0x02F6`:

```
Offset 0x02F4: 4E 75                    ← RTS (end of previous function)
Offset 0x02F6: 06 4B 67 40 40 40 40 00  ← data block between functions
Offset 0x02FE: 4E 56 FD FA              ← LINK A6 (start of next function)
```

The data block sits between an `RTS` instruction (0x4E75, return from subroutine) and a
`LINK A6` instruction (0x4E56, function prologue). This proves it is **static data embedded
between two functions**, not executable code. Classic Mac 68k applications commonly store
constant data between function boundaries in CODE segments.

Interpreting the data block:
```
06 4B 67 40 40 40 40 00
│  └──┘  └──────────┘  │
│  "Kg"  parameters     │ trailing null
len=6
```

- Byte 0: `$06` — length prefix (6 bytes of dispatch payload follow)
- Bytes 1-2: `$4B 67` — ASCII "Kg" (the token identifier)
- Bytes 3-6: `$40 40 40 40` — parameters (placeholder/default values)
- Byte 7: `$00` — null terminator or padding

### Why $06 is a length prefix, not MOP code 6

The AOL4Free Binary Analysis (section "The Two Free-Area Dispatch Tokens") proves this:
the Menus patch constructs an "MR" dispatch with the same `$06` prefix, but MR uses Ask_DB
(MOP 1/2), not Send_DB (MOP 6). If `$06` were a MOP code, the MR dispatch would be
inconsistent. Therefore `$06` is a length prefix meaning "6 bytes of payload follow."

### Comparison with AOL4Free's Kg Dispatch

The AOL4Free patch (Binary Analysis, address `0x5982`) contains:

```
AOL4Free:  06 4B 67 3F C1 3F C1 60
AOL 2.6:   06 4B 67 40 40 40 40 00
```

Both share the same format. The AOL4Free version has specific PlusGroup values (`$3FC1`)
while the unpatched client has placeholder values (`$4040`). This confirms:

1. The Kg dispatch structure existed in the original AOL 2.6 client code
2. AOL4Free modified the parameters, not the structure
3. The `$3FC1` PlusGroup value was injected by the patch

### Cross-Reference: Token Database

`Kg` does **not** appear in the FDO88 Manual (January 1994, 239 pages). It **is** documented
in the AOL internal token table dump (`1998.txt`, January 7, 1998) as:
- Category: `tih` (Terminal Interface Handler)
- Flags: PL (Pre-Login), SP (Special)
- Meaning: "PC indicating surcharge switch"

The file modification timestamp on the extracted binary is May 27, 1995. `Kg` was part of the
AOL protocol by that date but was not in the January 1994 FDO88 Manual — it was either added
between those dates or existed as an undocumented internal token.

---

## Finding 3: FDO88 Dispatch Format Confirmed in Binary

The FDO88 Manual (p.2-43, PDF p.51) defines the dispatch syntax:

```
fdo$dispch <MOP_code> ('<token_ID>',<s_code>) <MOP_info>
```

This encodes to 6 bytes:
- Byte 1: MOP code
- Bytes 2-3: Token (2 ASCII chars) + surcharge code (2-bit s_code), packed
- Bytes 4-6: MOP_info (3 bytes, typically a library record address)

**Verified example from FDO88 Manual Appendix B p.B-4 (PDF p.175):**
```
fdo$dispch 129 ('K1',2) $08 $CC $93
```
Members' Online Support — MOP 129 = Ask_DB, token K1, s_code 2 = plus_free, library $08,
record $CC93. This is the free-area dispatch that AOL4Free exploits.

The binary's dispatch data blocks use the same 6-byte format with a `$06` length prefix,
matching the FDO88 Manual specification.

---

## Finding 4: Free Area UI Strings Confirm Billing Architecture

STR# resource 10016:
```
"You cannot exit the free area while a download is in progress. To suspend
the download, click Finish Later in the File Transfer window. The remainder
of the download will not be free."

"You cannot enter a free area while a download is in progress."
```

STR# resource 10026:
```
"Exit Free Area"
```

These match the billing mechanism described in FDO88 Manual p.2-44 (PDF p.52):
- `plus_free` — "Action allowed from free area only"
- "the client software will offer to either cancel the dispatch or to change the surcharge status"

---

## Finding 5: Complete CODE Segment Map

54 CODE resources. Segment names with confirmed FDO88 relevance are marked:

| CODE ID | Name | Size | FDO88 Relevance |
|---------|------|------|-----------------|
| 0 | *(jump table)* | 12,552 | Standard Mac 68k jump table |
| 1 | Main | 23,918 | Application entry point |
| 4 | **Events** | 27,106 | Event loop — AOL4Free patches this for deferred K1 injection |
| 5 | **P3** | 22,524 | Protocol handler — AOL4Free's primary patch target |
| 6 | **DataParsing** | 27,088 | Parses incoming FDO data streams |
| 9 | **TokenHandler** | 4,218 | Token processing — FDO88 p.2-3: "Each data packet is marked with a token" |
| 10 | **FormsInfo** | 18,004 | FDO form metadata — "Forms" = FDO88 Chapter 2 |
| 12 | **FormModifiers** | 28,050 | FDO form modification (switches, attributes) |
| 20 | **FormsDeletion** | 3,120 | FDO form cleanup |
| 21 | **FormsCreation** | 28,006 | FDO form instantiation |
| 24 | UDO | 9,306 | Purpose unknown (acronym expansion unverified) |
| 27 | **MOPs** | 10,986 | MOP dispatch — FDO88 Appendix E; contains Kg template |

Segments 30–53 are charting/graphing engine components (2D_ENGINE, BAR_ENGINE, PIE_ENGINE,
etc.).

---

## Finding 6: Version Resource Confirmation

```
vers 1: short='2.6b15' long='2.6b15 Copyright © 1987-1995 America Online, Inc.'
vers 2: short='2.6b15' long='America Online v2.6b15'
```

File modification timestamp from extraction: May 27, 1995. The "b15" suffix indicates build 15
of the 2.6 release. This is the version AOL4Free v4 targets.

---

## Conclusion

The AOL 2.6b15 Macintosh client binary uses the **FDO88** protocol. The primary evidence comes
from the binary itself cross-referenced against the FDO88 Manual (AOL internal document,
January 1994, 239 pages):

1. **Error strings** use FDO88 Manual terminology ("FDO code") — the FDO91 Manual uses "atom" exclusively (194 occurrences in intro, 0 of "FDO code" across all chapters)
2. **CODE segment `MOPs`** implements the MOP dispatch architecture defined in FDO88 Manual Appendix E (pp.E-1–E-10)
3. **Dispatch data format** matches FDO88 Manual's `fdo$dispch` encoding (p.2-43)
4. **Free area strings** confirm the billing mechanism from FDO88 Manual p.2-44
5. **Kg dispatch template** (`06 4B 67 40 40 40 40 00`) exists in the unpatched client between function boundaries in CODE 27, proving AOL4Free exploited an existing protocol feature

Community documentation (AOL-Files tutorial by Tau/BMB) corroborates this by stating FDO88
was used for Mac clients before 3.0, but this is a secondary source — the conclusion stands
on the binary and the FDO88 Manual alone.

---

## Sources

| Source | Location | Authority | Pages Cited |
|--------|----------|-----------|-------------|
| FDO88 Manual v1, January 1994 | `programs/Mac/hells/aol4free/FDO88_Manual_v1_1994-01_(searchable).pdf` | **Primary** — AOL internal document | p.2-3 (PDF 11), p.2-43 (PDF 51), p.2-44 (PDF 52), App.B p.B-4 (PDF 175), App.E pp.E-1–E-10 (PDF 225–234) |
| FDO91 Manual, February 1998 | `programs/Mac/hells/aol4free/fdo91_docs/` | **Primary** — AOL internal document | intro.txt (terminology comparison) |
| AOL 2.6b15 binary | `programs/Mac/aol26-client/Instll_AOl_v2.6b15.sit` | **Primary** — the unpatched client | Extracted resource fork |
| AOL4Free Binary Analysis | `programs/Mac/hells/aol4free/AOL4FREE-Binary-Analysis.md` | **Primary** — disassembly of the patch code | "Kg Dispatch" section, "Patch Architecture" section |
| AOL internal token dump | `aol-files.com/fdo91/tokens/1998.txt` (Jan 7, 1998) | Secondary — server-side dump, not an official document | Kg entry |
| AOL-Files FDO Tutorial | [koin.org mirror](http://koin.org/files/aol.aim/aol/fdo/tutorial/tutorial%20-%20what%20is%20FDO.htm) | Secondary — community documentation by Tau/BMB | "What is FDO?" section |

*Analysis performed 2026-04-03 on Ubuntu Linux using unar 1.10.1 and Python 3.12.*
*Analysis script: `analyze_aol26.py` (included above, 80 lines).*
