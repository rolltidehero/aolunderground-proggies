# America Online v3.0.1 — Mac Client (68K)

The AOL 3.0.1 Macintosh client installer (68K version). AOL 3.0 is significant because it is
the first Mac version expected to use the **FDO91** protocol, based on the FDO88 Manual's own
introduction which states FDO91 was designed for "Windows and Macintosh platforms" while FDO88
was "the original online service forms display language developed for the Apple II platform"
(FDO91 Manual, Introduction, `fdo91_docs/intro.txt`).

The AOL-Files community tutorial (secondary source) corroborates this, stating FDO91 was used
in "the Macintosh client (versions 3.0 and later)."

## Download

[InstallaOL3-0.1.sit](InstallaOL3-0.1.sit) — StuffIt 5 archive containing the VISE installer (3.7MB)

## Status: Binary Analysis Not Yet Possible

The installer uses **MindVision Installer VISE** format (`SVCT` header in data fork). Unlike
StuffIt archives, VISE installers cannot be extracted with `unar` — the payload is compressed
in a proprietary format.

```bash
# Extraction attempt:
unar -o /tmp/aol30 InstallaOL3-0.1.sit
# Produces: Install AOL 3.0.1 (68K) — data fork is SVCT, not extractable

unar "/tmp/aol30/Install AOL 3.0.1 (68K)"
# Result: "Couldn't recognize the archive format."
```

### What's needed to extract

One of:
- **[vise-rs](https://codeberg.org/cyco/vise-rs)** — Rust tool for extracting VISE installers (requires `cargo`)
- **Basilisk II or SheepShaver** — Mac emulator to run the installer natively
- **A pre-extracted copy** of the AOL 3.0 Mac application

### What we expect to find

If AOL 3.0 uses FDO91 as documented, the binary should show:
- Error strings using "atom" terminology instead of "FDO code"
- No `MOPs` CODE segment (FDO91 uses atoms, not MOPs)
- Different dispatch data format (FDO91 atom streams vs FDO88 `fdo$dispch`)
- Possibly `atom$hfs_attr_plus_group_type` references for billing

This would confirm the FDO88→FDO91 transition boundary at AOL Mac 3.0 and validate the
AOL 2.6 analysis by contrast.

## Installer Details

| Property | Value |
|----------|-------|
| Archive | StuffIt 5 |
| Installer | MindVision Installer VISE (`SVCT` format) |
| Platform | 68K Macintosh |
| Installer resource fork | 214,775 bytes (13 CODE segments — installer code, not AOL app) |
| Installer data fork | 3,600,761 bytes (compressed AOL application + components) |
| Files listed in installer | America Online v3.0, America Online 68K, America Online v3.0 Guide, AOL Scheduler, TCPack |
