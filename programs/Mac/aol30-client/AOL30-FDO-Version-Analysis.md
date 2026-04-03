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

## Finding 2: "Unknown FDO code" Error String is Gone

### AOL 2.6 (68K) — STR# 10018:
```
"Unknown FDO code: "
"Unknown extended FDO code: "
```

### AOL 3.0 (PPC) — Not present

The strings "Unknown FDO code" and "Unknown extended FDO code" do not appear in any STR#
resource in the AOL 3.0 PPC resource fork, nor in the PPC data fork (searched all 1.76MB).

The string "atom" also does not appear as an error message. The FDO error handler was either
removed, rewritten, or moved into a shared library (the Online Tools are now separate PPC
shared libraries, not embedded CODE segments).

**This is consistent with but does not prove a FDO88→FDO91 transition.** The error strings
could have been removed for other reasons (e.g., moved to a shared library, or the error
handler was rewritten to use numeric codes instead of text).

---

## Finding 3: "Exit Free Area" Persists

STR# resource 303 contains:
```
"Exit Free Area"
```

The free/paid area billing mechanism documented in FDO88 Manual p.2-44 (PDF p.52) is still
present in AOL 3.0. This is expected — the billing architecture is server-side and would
persist across client protocol versions.

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
convention is the second parameter to a function call. This confirms the K1 and Kg token
dispatch mechanism survived the 68K→PPC port.

### Comparison with AOL 2.6

| Token | AOL 2.6 (68K) | AOL 3.0 (PPC) |
|-------|---------------|----------------|
| K1 | In CODE 4 'Events', CODE 14 'Dbase' as ASCII | 6 occurrences as PPC `li r4` immediate |
| Kg | In CODE 27 'MOPs' as dispatch template `06 4B 67` | 2 occurrences as PPC `li r4` immediate |

The dispatch template format changed — AOL 2.6 stored Kg as a static 8-byte data block
between functions (`06 4B 67 40 40 40 40 00`), while AOL 3.0 loads the token value directly
into a register as a function parameter. This is consistent with the architectural shift from
68K (data-driven dispatch tables) to PPC (register-based function calls).

---

## Finding 5: New Resource Types Indicate PowerPlant Framework

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
and the PowerPlant application framework — a complete rewrite from AOL 2.6's Think C / MPW
codebase. This is the kind of ground-up rewrite where a protocol transition (FDO88→FDO91)
would naturally occur.

---

## Finding 6: Version Confirmation

```
vers 1: short="3.0b34" long="3.0B Copyright © 1987-1996 America Online, Inc."
vers 2: short="3.0b34" long="America Online v3.0B"
```

Build 34 of AOL 3.0B, copyright 1987-1996.

---

## Conclusion

The AOL 3.0B PPC binary shows clear architectural differences from AOL 2.6 (68K):

1. **PPC-only** (`cfrg` present, no CODE resources) — code in data fork, not resource fork
2. **"Unknown FDO code" error strings are gone** — the FDO88-specific terminology is absent
3. **K1 and Kg tokens persist** — loaded as PPC register immediates, confirming the token
   protocol survived the port
4. **PowerPlant framework** (86 PPob resources) — complete UI rewrite from Think C to CodeWarrior
5. **Free area billing persists** — "Exit Free Area" still in STR# 303

The evidence is **consistent with** a FDO88→FDO91 transition at AOL 3.0 but does not
definitively prove it from the binary alone. The FDO88-specific error strings are gone and
the architecture was completely rewritten, but no FDO91-specific strings (like "atom") were
found either. The definitive proof would require:
- Finding FDO91 atom stream data in the PPC data fork or shared libraries
- Analyzing the Online Tool shared libraries (Chat PPC, Browser PPC, etc.)
- Comparing the dispatch mechanism in the PPC code against FDO91 atom format

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
