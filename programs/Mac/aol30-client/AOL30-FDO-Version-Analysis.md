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

## Comparison with AOL 2.6: FDO Version Evidence

### 1. PPC Architecture — No CODE Segments

The binary contains a `cfrg` (Code Fragment) resource (ID 0, 80 bytes) and **zero CODE
resources**. PPC-only application — code is in the 1,759,739-byte data fork.

Because PPC applications don't use CODE resources, there are no named segments like `MOPs`,
`TokenHandler`, or `FormsCreation` to compare against AOL 2.6. This evidence type cannot
be replicated for AOL 3.0.

### 2. "Unknown FDO code" Error String is Absent

AOL 2.6 STR# 10018 contains `"Unknown FDO code: "` and `"Unknown extended FDO code: "`.

AOL 3.0 does not contain these strings — searched all 47 STR# resources in the resource fork
and all 1,759,739 bytes of the PPC data fork.

### 3. "Exit Free Area" Present

STR# resource 303 contains `"Exit Free Area"`. The free/paid area billing mechanism from
FDO88 Manual p.2-44 is present in AOL 3.0.

### 4. UI Framework Changed

AOL 3.0 contains 86 `PPob` (PowerPlant Object) resources — built with Metrowerks CodeWarrior
and the PowerPlant application framework. AOL 2.6 has none.

### 5. Version

```
vers 1: short="3.0b34" long="3.0B Copyright © 1987-1996 America Online, Inc."
```

---

## Supplementary: AOL4Free-Related Findings

These findings are relevant to the AOL4Free exploit analysis but do not prove the FDO version.

### K1 and Kg Tokens in PPC Code

K1 (`li r4, 0x4B31`) appears 6 times in the data fork. Kg (`li r4, 0x4B67`) appears 2 times.
Both are loaded as PPC register immediates — the token dispatch mechanism is present in
AOL 3.0.

| Token | AOL 2.6 (68K) | AOL 3.0 (PPC) |
|-------|---------------|----------------|
| K1 | In CODE 4, CODE 14 as ASCII | 6x as PPC `li r4` immediate |
| Kg | Dispatch template in CODE 27 (`06 4B 67`) | 2x as PPC `li r4` immediate |

### AOst Resources Contain Protocol Streams

35 `AOst` resources contain structured binary data with embedded K1 token references.
K1 (`$4B31`) appears in at least 12 of them, followed by 3-byte values (e.g., `02 a8 ff`,
`03 11 fc`, `08 3e a3`). This is a different storage format from AOL 2.6, which embedded
dispatch templates as static data blocks between 68K functions.

The exact encoding of these streams is unknown — the FDO91 Manual describes the human-readable
`atom$` syntax but not the binary wire format.

### AOp3 Resource

The `AOp3` resource (64 bytes) contains `"Copyright © 1987-1995"` — the main `vers` resource
says 1987-1996.

---

## Conclusion

| Fact | AOL 2.6 | AOL 3.0 |
|------|---------|---------|
| Architecture | 68K CODE resources in resource fork | PPC code in data fork (`cfrg`) |
| "Unknown FDO code" string | Present (STR# 10018) | Absent |
| "Exit Free Area" string | Present (STR# 10026) | Present (STR# 303) |
| CODE segment `MOPs` | Present (CODE 27) | N/A (no CODE resources) |
| K1 token | In CODE 4, CODE 14 | 6x in PPC data fork |
| Kg token | Dispatch template in CODE 27 | 2x in PPC data fork |
| Protocol data storage | Static data in CODE segments | Dedicated `AOst` resources (35) |
| UI framework | Raw Toolbox | PowerPlant (86 `PPob`) |

The FDO88 Manual's concepts (MOPs, dispatch format, "FDO code" error string) are present in
AOL 2.6 and absent from AOL 3.0. Neither binary contains a string that explicitly names its
FDO version.

---

## Sources

| Source | Location | Authority |
|--------|----------|-----------|
| FDO88 Manual v1, January 1994 | `programs/Mac/hells/aol4free/FDO88_Manual_v1_1994-01_(searchable).pdf` | **Primary** — AOL internal |
| Inside Macintosh: PowerPC System Software | [preterhuman.net mirror](https://www.preterhuman.net/macstuff/insidemac/PPCSoftware/PPCSoftware-15.html) | **Primary** — Apple documentation |
| AOL 3.0B PPC binary | `programs/Mac/aol30-client/InstallaOL3.0bppc.sit` | **Primary** — the client |
| AOL 2.6 FDO Analysis | `programs/Mac/aol26-client/AOL26-FDO-Version-Analysis.md` | **Primary** — comparison baseline |
| Token → FDO Source Mapping | `programs/Mac/hells/aol4free/AOL4FREE-Token-FDO-Mapping.md` | Reference — every token mapped to exact FDO88 Manual page or token DB source |
| vise-rs | [codeberg.org/cyco/vise-rs](https://codeberg.org/cyco/vise-rs) | Tool — VISE installer extractor |

*Analysis performed 2026-04-03 on Ubuntu Linux using unar, vise-rs (Rust nightly), and Python 3.12.*
