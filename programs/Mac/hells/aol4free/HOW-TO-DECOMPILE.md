# How to Extract and Decompile Classic Mac Binaries from StuffIt Archives on Linux

This documents the exact steps used to extract and disassemble AOL4Free v4 from its original 1995 StuffIt archive on an Ubuntu Linux system. No Mac hardware or emulator was needed.

## What You're Working With

Classic Mac applications from the mid-1990s store their executable code in **resource forks**, not data forks. On a modern filesystem (ext4, NTFS, APFS), the resource fork is either lost entirely or preserved as an extended attribute or sidecar file. The tools below handle this.

The file formats involved:
- **MacBinary II** (`.bin`) — a wrapper that encodes both forks + Finder metadata into a single file for transfer
- **StuffIt** (`.sit`) — a Mac compression format, often wrapped in MacBinary
- **Resource fork** — contains typed resources (CODE, DLOG, STR#, etc.) in a structured binary format
- **AppleDouble** (`._` prefix or `.rsrc` suffix) — how macOS/unar preserves resource forks on non-HFS filesystems

## Step 1: Install unar

```bash
sudo apt-get install -y unar
```

unar (The Unarchiver's command-line tool) handles MacBinary + StuffIt in one step. It preserves resource forks by saving them as `.rsrc` sidecar files in AppleDouble format.

## Step 2: Extract the StuffIt Archive

```bash
mkdir extracted
unar -o extracted AOL4FREE2.6v4.sit
```

Output:
```
AOL4FREE2.6v4.sit: StuffIt in MacBinary
  AOL4Free2.6 v4/Install AOL4Free2.6 v4  (31385 B, rsrc)... OK.
  AOL4Free2.6 v4/Remove AOL4Free2.6 v4  (29308 B, rsrc)... OK.
  AOL4Free2.6 v4/AOL4Free2.6 v4 Docs  (76142 B, rsrc)... OK.
  ...
```

Note the `(rsrc)` marker — unar detected these files have resource forks and saved them as `.rsrc` files. The data fork files will be 0 bytes (the code is entirely in the resource fork).

The `.rsrc` files are in **AppleDouble format**. They are NOT raw resource forks — they have a header you must parse first.

## Step 3: Parse the AppleDouble Header

Each `.rsrc` file starts with the AppleDouble magic number `0x00051607`. You need to skip the AppleDouble header to reach the actual Mac resource fork data.

```python
import struct

def extract_resource_fork(rsrc_path):
    with open(rsrc_path, 'rb') as f:
        data = f.read()
    
    magic = struct.unpack('>I', data[:4])[0]
    assert magic == 0x00051607, f"Not AppleDouble: {magic:#x}"
    
    # AppleDouble header: magic(4) + version(4) + filler(16) + num_entries(2)
    num_entries = struct.unpack('>H', data[24:26])[0]
    
    # Each entry: entry_id(4) + offset(4) + length(4)
    for i in range(num_entries):
        entry_id, offset, length = struct.unpack('>III', data[26 + i*12 : 26 + i*12 + 12])
        if entry_id == 2:  # Resource fork
            return data[offset : offset + length]
    
    raise ValueError("No resource fork entry found")
```

## Step 4: Parse the Mac Resource Fork

The resource fork has a fixed structure:
- Bytes 0-3: offset to resource data section
- Bytes 4-7: offset to resource map
- Bytes 8-11: length of resource data
- Bytes 12-15: length of resource map

The resource map contains a type list and reference list that index all resources by 4-character type code and numeric ID.

```python
def parse_resource_fork(rsrc_data):
    """Returns dict of {type_code: [(id, name, data), ...]}"""
    data_offset, map_offset = struct.unpack('>II', rsrc_data[:8])
    
    # Resource map starts at map_offset
    m = rsrc_data[map_offset:]
    type_list_off = struct.unpack('>H', m[24:26])[0]  # offset from map start
    name_list_off = struct.unpack('>H', m[26:28])[0]
    
    tl = m[type_list_off:]
    num_types = struct.unpack('>H', tl[:2])[0] + 1  # stored as count-1
    
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
            
            # Data offset: 3 bytes at ref[5:8], relative to data section
            d_off = struct.unpack('>I', b'\x00' + ref[5:8])[0]
            abs_off = data_offset + d_off
            
            # First 4 bytes at the data location = length of this resource's data
            res_len = struct.unpack('>I', rsrc_data[abs_off:abs_off+4])[0]
            res_data = rsrc_data[abs_off+4 : abs_off+4+res_len]
            
            # Get name if present
            name = ''
            if name_off != 0xFFFF:
                nl = m[name_list_off + name_off:]
                nlen = nl[0]
                name = nl[1:1+nlen].decode('mac_roman', errors='replace')
            
            resources.append((res_id, name, res_data))
        
        result[rtype] = resources
    
    return result
```

Usage:
```python
rsrc_data = extract_resource_fork("Install AOL4Free2.6 v4.rsrc")
resources = parse_resource_fork(rsrc_data)

for rtype, res_list in sorted(resources.items()):
    print(f"  '{rtype}': {len(res_list)} resource(s)")
    for res_id, name, data in res_list:
        print(f"    ID {res_id} '{name}': {len(data)} bytes")
```

## Step 5: Understand What You're Looking At

For a classic Mac application, the key resource types are:

| Type | Contains |
|------|----------|
| `CODE` | 68k machine code segments. CODE 0 is the jump table. CODE 1+ are named segments. |
| `DLOG` | Dialog box definitions |
| `DITL` | Dialog item lists |
| `MENU` | Menu bar definitions |
| `STR#` | String lists |
| `STR ` | Individual strings |
| `vers` | Version info |
| `PICT` | Pictures |
| `cicn` | Color icons |
| `SIZE` | Memory/launch configuration |

For the AOL4Free patcher specifically, the interesting types are:

| Type | Contains |
|------|----------|
| `ZAP ` | Patch data — raw 68k machine code to inject into the AOL binary |
| `ZAP#` | Target file descriptors — identifies which files and CODE resources to patch |
| `ZIS#` | Patch site index — byte offsets within target CODE segments where patches go |
| `ZVER` | Version checks — file type/creator codes for locating the target files |

## Step 6: Extract CODE Resources

Save each CODE segment to a separate `.bin` file:

```python
for res_id, name, data in resources.get('CODE', []):
    with open(f"CODE_{res_id:04d}.bin", 'wb') as f:
        f.write(data)
    print(f"CODE {res_id} '{name}': {len(data)} bytes")
```

For the AOL4Free patcher, there are only 5 CODE resources (the patcher is small). For the full AOL 2.6 client (v6 in this project), there are 54 CODE resources totaling ~800KB.

## Step 7: Disassemble with Capstone

Install capstone in a venv:
```bash
python3 -m venv venv
venv/bin/pip install capstone
```

Disassemble a CODE resource:
```python
from capstone import Cs, CS_ARCH_M68K, CS_MODE_M68K_040

md = Cs(CS_ARCH_M68K, CS_MODE_M68K_040)
md.detail = True

with open("CODE_0009.bin", "rb") as f:  # e.g. TokenHandler
    code = f.read()

# CODE segments have a 4-byte header: 2 bytes jump table offset + 2 bytes entry count
# Skip header for segments > 0. CODE 0 is the jump table (different format).
header_size = 4  # for CODE 1+; CODE 0 has a different header
base_address = 0  # or the actual CODE offset if known

for insn in md.disasm(code[header_size:], base_address):
    print(f"0x{insn.address:04x}: {code[insn.address:insn.address+insn.size].hex():<16s} {insn.mnemonic} {insn.op_str}")
```

### Important: Classic Mac 68k calling conventions

- **A5** = application globals pointer. Subroutines at A5+offset are AOL internal routines.
- **A6** = frame pointer (LINK/UNLK for stack frames)
- **A7** = stack pointer
- **A-traps** (`$Axxx` instructions like `$A9BF`, `$A945`) are Mac Toolbox calls
- **JSR d16(A5)** = call to an AOL internal routine at a fixed offset from the globals base
- **JSR d16(PC)** = PC-relative call (common in segmented code)

### Reconstructing actual addresses from patch data

For patcher binaries (like AOL4Free), the `ZAP ` resources contain code fragments and the `ZIS#` resources tell you WHERE each fragment goes in the target CODE segment. The format:

```python
# ZIS# structure:
# Bytes 0-1: number of patch sites
# Bytes 2-5: header (typically 0000 + size)
# Then per site:
#   2 bytes: offset in target CODE resource
#   2 bytes: flags | size (bit 15 = flag, bits 14-0 = size in bytes)
# Last entry may have a different format with explicit size

zis_data = resources['ZIS#'][matching_id]
num_sites = struct.unpack('>H', zis_data[0:2])[0]
```

The ZAP data bytes are consumed sequentially — the first N bytes go to the first patch site, the next M bytes to the second, etc. Reconstruct addresses by adding the patch site offset to each instruction's local offset.

## Step 8: For the Full AOL Client (if you have it)

If you have the actual AOL 2.6 Mac client (from a disk image, WhackedMac CD, etc.), the same extraction process works. The CODE resources will be much larger:

- CODE 5 'P3' (22,972 bytes) — the protocol handler where AOL4Free injects
- CODE 9 'TokenHandler' (4,218 bytes) — token processing
- CODE 4 'Events' (27,148 bytes) — event loop

You can diff the patched vs unpatched CODE resources to see exactly what changed, or apply the ZAP patches programmatically and compare.

## Step 9: Alternative — Ghidra

For deeper analysis, Ghidra (free, from NSA) supports 68k Mac binaries. The workflow:

1. Export a CODE resource to a `.bin` file (as above)
2. In Ghidra, create a new project, import the .bin as "Raw Binary"
3. Set language to "68000:BE:32:Mac" (if available) or "68000:BE:32:default"
4. Set base address to the CODE offset from ZIS# (e.g., 0x57FC for the P3 patch block)
5. Ghidra will auto-analyze and identify functions, branches, and A-trap calls

Ghidra's 68k support includes Macintosh Toolbox call recognition for A-traps.

## Tool Summary

| Tool | Package | Purpose |
|------|---------|---------|
| `unar` | `apt install unar` | Extract MacBinary + StuffIt preserving resource forks |
| Python `struct` | stdlib | Parse AppleDouble, resource fork, ZAP/ZIS# structures |
| `capstone` | `pip install capstone` | 68k disassembly |
| Ghidra | ghidra.re | Full reverse engineering (optional) |

## What Was NOT Needed

- No Mac hardware
- No Mac emulator (Basilisk II, SheepShaver)
- No macOS
- No ResEdit
- No HFS disk image mounting
- No xattr support on the filesystem

Everything was done with standard Linux tools + Python + capstone. The key insight is that `unar` preserves resource forks as AppleDouble `.rsrc` sidecar files, and the resource fork binary format is simple enough to parse with Python's `struct` module.

---

*Written 2026-04-02. Tested on Ubuntu 24.04, Python 3.12, unar 1.10.1, capstone 5.0.7.*
