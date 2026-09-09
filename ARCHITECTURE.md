# Architecture — AOL Underground Proggies

## Overview

This repo is a digital preservation and reverse-engineering project for
~2,800 AOL/AIM underground tools ("proggies") from the late 1990s and
early 2000s. The architecture has three layers: an **archive layer** (the
raw zip/rar collection), a **data layer** (SQLite databases with metadata
and extracted strings), and a **tooling layer** (Python scripts for
cataloging, decompiling, and generating browsable HTML).

There is also a **VM automation layer** — a Windows 10 QEMU/KVM guest
controlled from the Linux host via virtio-serial and QMP — used to
decompile Visual Basic executables and capture screenshots.

## Directory Map

```
aolunderground-proggies/
│
├── programs/                       # THE ARCHIVE (read-only data)
│   ├── AOL/
│   │   └── proggies-sorted-deduped/
│   │       ├── proggies-by-version/ # 2,138 zips sorted by AOL version
│   │       │   ├── 2.5/ 3.0/ 4.0/ 5.0/ 6.0/ 7.0/ 8.0/ 9.0/ unknown/
│   │       │   └── <name>.zip
│   │       ├── <name>.html          # Per-proggie analysis pages (1,821)
│   │       └── <name>/              # Per-proggie assets (screenshots, source)
│   └── AIM/                         # 649 AIM proggies (unsorted)
│
├── decompiled/                      # Decompiled VB source (local-only, gitignored)
│   └── <proggie-name>/
│       └── <exe-name>/
│           ├── modules/             # .bas/.frm/.cls files
│           ├── forms/               # .frm form files
│           ├── cleaned/             # Post-processed source
│           ├── metadata.json        # Parsed metadata
│           └── project.vbp          # VB project file
│
├── scene/                           # Scene artifacts
│   ├── nfos/                        # 154 NFO files from release groups
│   └── wav/                         # WAV files from the era
│
├── programming/                     # VB source code & tutorials from the era
│   ├── vb/                          # Visual Basic code samples and tools
│   ├── misc/                        # Other programming resources
│   └── mirrors/                     # Mirrored download sites
│
├── tools/                           # TOOLING LAYER (Python scripts)
│   ├── (see Tooling Layer below)
│   ├── c2/                          # VM command & control pipeline
│   ├── vm/                          # VM infrastructure
│   │   ├── guest/                   # Runs inside Windows VM
│   │   ├── host/                    # Runs on Linux host
│   │   └── scripts/                 # VM lifecycle (launch, snapshot, share)
│   ├── templates/                   # Jinja2 HTML templates
│   └── vb_decompile_ref/            # Third-party VB PE parsers (reference)
│
├── proggie_db.sqlite                # Metadata DB (names, authors, VB versions, deps)
├── exe_strings.db[.zip]             # 11.6M extracted strings from 2,452 exes (LFS)
├── proggie-index.html               # Interactive search page (generated)
├── proggie-index.md                 # Markdown index (generated)
├── proggie-index.txt                # Tab-delimited greppable index (generated)
├── index.html                       # Landing page
│
├── tests/                           # Test suite
│   ├── test_every_click.py          # Walkthrough click-target coverage
│   ├── test_walkthrough_page.py     # HTML page generation tests
│   └── test_widget_layout.py        # VB form widget layout tests
│
├── docs/                            # Documentation
│   ├── PROJECT_STATUS.md            # Current state and roadmap
│   └── old-plans/                   # Historical planning docs
│
├── kagi-reviews/                    # Code review transcripts (fix/review pairs)
│
├── .github/workflows/
│   └── deploy-pages.yml             # GitHub Pages auto-deploy from main
│
├── .kiro/                           # Kiro agent configuration
├── .claude/                         # Claude Code configuration
└── oldscool_windows_tools/          # Windows utilities for VM setup
```

## Data Layer

### proggie_db.sqlite

The primary metadata database. Built by `tools/build_proggie_db.py` from
the archive contents. Schema includes:

- **proggies** — name, author, AOL version, VB version, compile type,
  zip path, exe SHA256, file size, detected dependencies
- **exe_metadata** — per-executable PE header data, timestamps, linked DLLs
- **api_refs** — AOL API references (window classes, control names) found
  in each executable's strings

Queried by `tools/query_proggies.py` (CLI search, stats, filters).

### exe_strings.db

11.6 million strings extracted from 2,452 executables using the `strings`
command. Distributed as `exe_strings.db.zip` (301MB) via Git LFS; unzips
to 2.4GB. Built by `tools/build_strings_db.py`.

Queried by `tools/query_strings.py` and `tools/search_strings.py`.

### metadata.json (per decompiled proggie)

JSON files in `decompiled/<name>/<exe>/metadata.json` containing parsed
form layouts, control inventories, API calls, and string references
extracted from decompiled VB source.

## Tooling Layer

### Standalone Tools (tools/)

| Script | Input | Output | Purpose |
|--------|-------|--------|---------|
| `build_proggie_db.py` | Archive zips | `proggie_db.sqlite` | Build metadata database |
| `build_strings_db.py` | Extracted strings | `exe_strings.db` | Build strings database |
| `build_api_database.py` | BAS source files | `aol_api_signatures.json` | Extract AOL API signatures |
| `query_proggies.py` | `proggie_db.sqlite` | stdout | CLI search and stats |
| `query_strings.py` | `exe_strings.db` | stdout | String search across exes |
| `search_strings.py` | `exe_strings.db` | stdout | Alternate string search |
| `detect_aol_version.py` | exe bytes | version tag | API-based AOL version detection |
| `detect_vb_version.py` | exe bytes | VB version | PE header VB version detection |
| `detect_duplicates.py` | Archive zips | duplicate groups | SHA256-based dedup |
| `merge_archives.py` | Duplicate groups | merged zips | Combine duplicate archives |
| `organize_by_version.py` | Merged zips | version dirs | Sort into version buckets |
| `analyze_archive.py` | Single zip | metadata dict | Extract and analyze one archive |
| `extract_passwords.py` | Archive names | `passwords.json` | Recover archive passwords |
| `extract_authors.py` | VB source | author names | Extract author attribution |
| `generate_analysis.py` | DB + decompiled | `.html` pages | Per-proggie analysis HTML |
| `generate_index.py` | DB | index files | Interactive search + indices |
| `generate_needs_review.py` | DB | `NEEDS_REVIEW.md` | Low-confidence detections |
| `generate_redirects.py` | Old paths | `REDIRECTS.md` | GitHub Pages redirects |
| `generate_aohell.py` | DB | AOHell page | Special AOHell analysis |
| `generate_slipstream.py` | DB | slipstream page | Slipstream-specific page gen |
| `build_slipstream_metadata.py` | Source | metadata | Slipstream metadata builder |
| `build_aohell_metadata.py` | Source | metadata | AOHell metadata builder |
| `clean_code.py` | Decompiled .frm | cleaned source | Strip decompiler noise |
| `match_functions.py` | Two VB sources | diff | Function-level source diff |
| `window_diff.py` | Two VB sources | visual diff | Window-aware VB source diff |
| `validate_decompile.py` | Decompiled dir | report | Check decompile completeness |
| `frm2tk.py` | .frm files | Tkinter code | Convert VB forms to Python/Tk |
| `repack_zips.py` | Old archives | clean zips | Normalize archive format |
| `rar_to_zip.py` | .rar files | .zip files | Convert RAR to ZIP |
| `peid_scan.py` | exe bytes | packer ID | PEiD signature scanning |
| `smart_walkthrough.py` | Metadata | walkthrough | Generate interactive walkthroughs |
| `capture_walkthrough.py` | VM + exe | screenshots | Automated screenshot capture |
| `capture_aohell.py` | VM + AOHell | screenshots | AOHell-specific capture |
| `single_decompile.py` | exe | decompiled/ | End-to-end single proggie pipeline |
| `discover_targets.py` | DB | target list | Find decompilation candidates |
| `bezier_mouse.py` | coords | movement | Bezier curve mouse automation |

### VM Command & Control (tools/c2/)

The decompilation and screenshot pipeline uses a host/guest architecture:

```
Linux Host                              Windows 10 VM (QEMU/KVM)
─────────────────────                   ──────────────────────────
batch_decompile.py ──┐                  agent.py (virtio-serial listener)
screenshot_proggies.py──┤                  │
poc_walkthrough.py ──┤                  ├─ vbd_helper.py (VB Decompiler GUI automation)
                     │                  └─ vbd_extract.dll (native VB Decompiler plugin)
                     ▼
              orchestrator.py
              ├── qmp_client.py         QMP socket ──→ QEMU monitor
              ├── virtio_serial_client  virtio-serial ──→ guest agent
              ├── input_controller.py   QMP input events (keyboard/mouse)
              ├── screen_recorder.py    QMP screendump → ffmpeg → video
              └── push_file.py          QEMU Guest Agent file push
```

**Host-side** (`tools/vm/host/`):
- `orchestrator.py` — top-level VM management (push exe, trigger decompile, pull results)
- `qmp_client.py` — QEMU Machine Protocol for screendumps, input, power control
- `virtio_serial_client.py` — JSON messaging over virtio-serial to the guest agent
- `input_controller.py` — high-level UI automation (click, type, key combos)
- `screen_recorder.py` — continuous screenshot capture → GIF/video
- `push_file.py` — push files into VM via QEMU Guest Agent
- `config.py` — VM socket paths and constants

**Guest-side** (`tools/vm/guest/`):
- `agent.py` — C2 agent running inside the VM, listens on virtio-serial
- `vbd_helper.py` — VB Decompiler Pro GUI automation (menus, dialogs, export)
- `vbd_extract.dll` / `vbd_plugin.c` — native VB Decompiler plugin for direct extraction

**C2 pipeline scripts** (`tools/c2/`):
- `batch_decompile.py` — batch orchestrator with resume-on-crash (checkpoint JSON)
- `screenshot_proggies.py` — batch screenshot capture (main form, menus, about, GIF)
- `poc_walkthrough.py` — proof-of-concept walkthrough using nav graph
- `vbdecompile.py` — single exe decompile via VB Decompiler Pro + C2 DLL
- `extract_metadata.py` — parse metadata from decompiled .bas/.frm source
- `enumerate_controls.py` — extract control inventory from VB6 apps
- `extract_frx.py` — extract binary data from .frx resource files
- `parse_nav_graph.py` — parse window navigation graphs for walkthrough

### VM Infrastructure (tools/vm/scripts/)

Shell scripts for VM lifecycle:
- `launch-vm.sh` — start the Windows 10 QEMU/KVM instance
- `stop-vm.sh` — graceful shutdown
- `snapshot-vm.sh` — create/restore QCOW2 snapshots
- `vm-share.sh` — mount shared directory
- `build-unattended-iso.sh` — create unattended Windows install ISO
- `create-vm-disk.sh` — create QCOW2 disk image

## Generated Output (GitHub Pages)

The `deploy-pages.yml` workflow collects static files on push to `main`:
- `index.html` — landing page
- `proggie-index.html` — interactive search
- `programs/AOL/proggies-sorted-deduped/**/*.html` — analysis pages
- `programs/AOL/proggies-sorted-deduped/**/*.{png,gif,jpg}` — screenshots

Deployed to: https://ssstonebraker.github.io/aolunderground-proggies/

## Data Flow

```
Archive Zips (programs/)
    │
    ├──→ build_proggie_db.py ──→ proggie_db.sqlite
    │
    ├──→ build_strings_db.py ──→ exe_strings.db
    │
    ├──→ single_decompile.py ──→ decompiled/<name>/
    │    (via VM pipeline)          │
    │                               ├──→ extract_metadata.py ──→ metadata.json
    │                               └──→ clean_code.py ──→ cleaned/
    │
    └──→ generate_analysis.py ──→ <name>.html (per-proggie pages)
         (reads: DB, decompiled, strings)
              │
              └──→ generate_index.py ──→ proggie-index.{html,md,txt}
                                              │
                                              └──→ GitHub Pages deploy
```

## Key Design Decisions

1. **SQLite for everything.** Both the metadata DB and the strings DB are
   SQLite. No external database server. The strings DB is 2.4GB but SQLite
   handles it fine with WAL mode and FTS if needed.

2. **Jinja2 templates, not inline HTML.** All HTML generation uses templates
   in `tools/templates/`. No hardcoded HTML strings in Python.

3. **Virtio-serial for VM C2, not SSH/RDP.** The guest agent communicates
   over a virtio-serial device. This works even when Windows networking is
   disabled (network isolation is a security requirement for running
   untrusted 1990s malware).

4. **Checkpoint-based batch processing.** Long-running batch operations
   (decompile, screenshot) write checkpoint JSON files so they can resume
   after crashes or VM resets. Each checkpoint maps proggie name → status.

5. **Git LFS for large files.** `exe_strings.db.zip` (301MB) is tracked
   via Git LFS. The uncompressed DB (2.4GB) is gitignored.

6. **GitHub Pages from main.** Every push to `main` triggers a pages
   deploy. The workflow copies only static assets (HTML, images) — no
   Python, no databases, no executables.

7. **Decompiled output is local-only.** The `decompiled/` directory is
   gitignored. It contains the raw output of VB Decompiler Pro and is
   too large and legally ambiguous to distribute.

## Stack

| Component | Technology |
|-----------|-----------|
| Language | Python 3.8+ |
| Databases | SQLite (WAL mode) |
| HTML generation | Jinja2 templates |
| VM hypervisor | QEMU/KVM |
| VM control | QMP (monitor) + virtio-serial (C2) + QGA (file push) |
| Guest OS | Windows 10 (network-isolated) |
| Decompiler | VB Decompiler Pro (GUI + native DLL plugin) |
| GUI automation | QMP input events (keyboard/mouse) + AHK |
| CI/CD | GitHub Actions → GitHub Pages |
| Large files | Git LFS |
| Screenshots | QMP screendump → PIL/ffmpeg → PNG/GIF |
