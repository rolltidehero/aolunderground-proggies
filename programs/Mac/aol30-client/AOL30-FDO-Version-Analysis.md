# AOL 3.0B (PPC) Binary Analysis: FDO Version Identification

## Reproducible Method

### Prerequisites

```bash
sudo apt-get install -y unar
# Build vise-rs (requires Rust nightly):
rustup install nightly
git clone https://codeberg.org/cyco/vise-rs.git
cd vise-rs && cargo +nightly build --release
```

### Step 1: Extract the StuffIt archive

```bash
unar -o /tmp/aol30ppc InstallaOL3.0bppc.sit
```

Output:
```
InstallaOL3.0bppc.sit: StuffIt 5
  Install AOL 3.0B (PPC)  (217295 B, rsrc)... OK.
  Install AOL 3.0B (PPC)  (3530316 B)... OK.
```

### Step 2: Extract the VISE installer

The data fork is a MindVision Installer VISE archive (`SVCT` format). Unlike StuffIt, VISE
requires a specialized extractor:

```bash
unvise extract "Install AOL 3.0B (PPC)" -o /tmp/aol30ppc/extracted
```

This extracts the full AOL 3.0 application folder including the main binary, Online Tools
(shared libraries), and support files.

### Step 3: Analyze the resource fork

**Critical difference from AOL 2.6 (68K):** PowerPC Mac applications store executable code
in the **data fork**, not in CODE resources in the resource fork. PPC apps use a `cfrg` (Code
Fragment) resource to tell the Code Fragment Manager where the executable code is located.
The resource fork still contains STR#, vers, MENU, DLOG, and other non-code resources.

Reference: Inside Macintosh: PowerPC System Software, Chapter 1 — "The fragment containing
an application's executable code is stored in the application's data fork, which is a file
of type 'APPL'."

```python
# Parse resource fork (same method as AOL 2.6, see HOW-TO-DECOMPILE.md)
# But read the .rsrc file directly — vise-rs outputs raw resource forks,
# not AppleDouble format
with open("America Online PPC.rsrc", "rb") as f:
    rsrc_data = f.read()
resources = parse_resource_fork(rsrc_data)  # same parser as AOL 2.6
```

---

## Finding 1: PPC Architecture Confirmed

### `cfrg` resource present, no CODE resources

The binary contains a `cfrg` (Code Fragment) resource (ID 0, 80 bytes) and **zero CODE
resources**. This confirms it is a PPC-only application — not a fat binary, not 68K.

The data fork is 1,759,739 bytes of PPC executable code in PEF (Preferred Executable Format).

For comparison:
- **AOL 2.6 (68K):** 54 CODE resources in resource fork, no `cfrg`, no data fork code
- **AOL 3.0 (PPC):** `cfrg` resource, zero CODE resources, code in data fork

### No named CODE segments to compare

Because PPC applications don't use CODE resources, there are no named segments like `MOPs`,
`TokenHandler`, or `FormsCreation` to compare against AOL 2.6. The PPC code is a single
monolithic fragment in the data fork. This means the CODE segment name evidence from the
AOL 2.6 analysis **cannot be replicated** for AOL 3.0 — it's an architectural impossibility,
not a finding about FDO version.

---

## Finding 2: "Unknown FDO code" Error String is Absent

### AOL 2.6 (68K) — STR# 10018:
```
"Unknown FDO code: "
"Unknown extended FDO code: "
```

### AOL 3.0 (PPC) — Not present

The strings "Unknown FDO code" and "Unknown extended FDO code" do not appear in any STR#
resource in the AOL 3.0 PPC resource fork (47 STR# resources searched), nor anywhere in the
PPC data fork (1,759,739 bytes searched).

**Fact:** AOL 2.6 has this error handler. AOL 3.0 does not. The FDO stream parser was either
removed, rewritten, or moved into a shared library.

---

## Finding 3: "Exit Free Area" Present

STR# resource 303 contains:
```
"Exit Free Area"
```

The free/paid area billing mechanism documented in FDO88 Manual p.2-44 (PDF p.52) is present
in AOL 3.0.

---

## Finding 4: K1 and Kg Tokens Still Used

### K1 in PPC data fork — 6 occurrences

The PPC instruction `li r4, 0x4B31` (load immediate, value = ASCII "K1") appears 6 times
in the data fork. Example at offset 0x0004AE86:

```
38 80 4B 31    li r4, 0x4B31    ; r4 = "K1" (token parameter)
```

### Kg in PPC data fork — 2 occurrences

The PPC instruction `li r4, 0x4B67` (load immediate, value = ASCII "Kg") appears 2 times.
Example at offset 0x00065C1E:

```
38 80 4B 67    li r4, 0x4B67    ; r4 = "Kg" (token parameter)
```

Both tokens are loaded as immediate values into register r4, which in the PPC calling
convention is the second parameter to a function call. K1 and Kg token dispatch is present
in AOL 3.0 PPC.

### Comparison with AOL 2.6

| Token | AOL 2.6 (68K) | AOL 3.0 (PPC) |
|-------|---------------|----------------|
| K1 | In CODE 4 'Events', CODE 14 'Dbase' as ASCII | 6 occurrences as PPC `li r4` immediate |
| Kg | In CODE 27 'MOPs' as dispatch template `06 4B 67` | 2 occurrences as PPC `li r4` immediate |

The dispatch template format changed — AOL 2.6 stored Kg as a static 8-byte data block
between functions (`06 4B 67 40 40 40 40 00`), while AOL 3.0 loads the token value directly
into a register as a function parameter.

---

## Finding 5: AOst Resources Contain Structured Protocol Data

The resource fork contains 35 `AOst` (AOL Stream) resources. These contain structured binary
data with embedded K1 token references — a format not present in AOL 2.6.

### Examples (hex dumps):

**AOst 137** (19 bytes):
```
00 01 20 11 24 20 9f 86 02 4B 31 24 62 08 3e a3 68 20 02
                              ^^^^
                              "K1" token embedded in stream
```

**AOst 141** (34 bytes):
```
00 01 20 11 e2 2e 01 21 a5 4B 31 02 a8 ff 2f 34
                         ^^^^
                         "K1"
01 24 20 9f 86 02 4B 31 24 62 02 a8 ff 68 40 27 20 02
                  ^^^^
                  "K1" again
```

**AOst 153** (29 bytes):
```
00 01 20 11 e2 2e 01 21 a5 4B 31 03 11 fc 24 20
                         ^^^^
9f 86 02 4B 31 24 62 03 11 fc 68 20 02
         ^^^^
```

### Observations

- K1 (`$4B31`) appears in at least 12 of the 35 AOst resources, always followed by
  3-byte values that resemble library record addresses (e.g., `02 a8 ff`, `03 11 fc`,
  `08 3e a3`)
- Streams consistently begin with `00 01` or `00 00` and end with `20 02` or `20 12`
- The byte `$24` (`$`) and `$62` (`b`) appear after K1 references — `$24 62` could encode
  a dispatch operation
- This is a **different storage format** from AOL 2.6, which embedded dispatch templates
  as static data blocks between 68K functions in CODE segments

### What this does NOT prove

The exact wire encoding of FDO91 atoms is not documented in the manual chapters we have
(the manual describes the human-readable `atom$` syntax, not the binary encoding). Without
the binary encoding specification, I cannot definitively identify these as FDO91 atom streams
vs. some other structured format. The K1 token references confirm the protocol layer is
consistent, but the container format requires further analysis.

### AOp3 Resource: P3 Protocol Copyright

The `AOp3` resource (64 bytes) contains:
```
"?Copyright © 1987-1995 America Online, Inc. All rights reserved."
```

Note the copyright ends at 1995, while the main `vers` resource says 1987-1996.

---

## Finding 6: New Resource Types Indicate PowerPlant Framework

AOL 3.0 PPC contains resource types not present in AOL 2.6:

| Resource Type | Count | Significance |
|---------------|-------|-------------|
| `PPob` | 86 | PowerPlant Object — Metrowerks PowerPlant UI framework |
| `RidL` | 86 | Resource ID List — PowerPlant companion resource |
| `Txtr` | 24 | Text traits — PowerPlant text formatting |
| `WSPC` | 5 | Workspace — PowerPlant layout |
| `LEvt` | 2 | Listener Event — PowerPlant event handling |
| `AOst` | 35 | AOL-specific string table (custom type) |
| `AOsf` | 4 | AOL-specific (custom type) |
| `AOp3` | 1 | AOL P3 protocol data (custom type) |

The presence of 86 `PPob` resources confirms AOL 3.0 was built with Metrowerks CodeWarrior
and the PowerPlant application framework.

---

## Finding 6: Version Confirmation

```
vers 1: short="3.0b34" long="3.0B Copyright © 1987-1996 America Online, Inc."
vers 2: short="3.0b34" long="America Online v3.0B"
```

Build 34 of AOL 3.0B, copyright 1987-1996.

---

## Conclusion

Verifiable differences between AOL 2.6 (68K) and AOL 3.0B (PPC):

| Fact | AOL 2.6 | AOL 3.0 |
|------|---------|---------|
| Architecture | 68K CODE resources in resource fork | PPC code in data fork (`cfrg`) |
| "Unknown FDO code" string | Present (STR# 10018) | Absent |
| "Exit Free Area" string | Present (STR# 10026) | Present (STR# 303) |
| K1 token | In CODE 4, CODE 14 | 6 occurrences in PPC data fork |
| Kg token | Dispatch template in CODE 27 | 2 occurrences in PPC data fork |
| Protocol data storage | Static data blocks between 68K functions | Dedicated `AOst` resources (35) |
| UI framework | None (raw Toolbox) | PowerPlant (86 `PPob` resources) |
| AOp3 copyright | N/A | "1987-1995" (vs vers "1987-1996") |

The binary does not contain any string or identifier that explicitly names its FDO version.
The FDO88 Manual's concepts (MOPs, dispatch format, "FDO code" error string) are present in
AOL 2.6 and absent from AOL 3.0. The token protocol (K1, Kg) is present in both.

---

## Sources

| Source | Location | Authority |
|--------|----------|-----------|
| FDO88 Manual v1, January 1994 | `programs/Mac/hells/aol4free/FDO88_Manual_v1_1994-01_(searchable).pdf` | **Primary** — AOL internal |
| Inside Macintosh: PowerPC System Software | [preterhuman.net mirror](https://www.preterhuman.net/macstuff/insidemac/PPCSoftware/PPCSoftware-15.html) | **Primary** — Apple documentation |
| AOL 3.0B PPC binary | `programs/Mac/aol30-client/InstallaOL3.0bppc.sit` | **Primary** — the client |
| AOL 2.6 FDO Analysis | `programs/Mac/aol26-client/AOL26-FDO-Version-Analysis.md` | **Primary** — comparison baseline |
| vise-rs | [codeberg.org/cyco/vise-rs](https://codeberg.org/cyco/vise-rs) | Tool — VISE installer extractor |

*Analysis performed 2026-04-03 on Ubuntu Linux using unar, vise-rs (Rust nightly), and Python 3.12.*
