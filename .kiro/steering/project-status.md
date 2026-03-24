---
inclusion: always
description: Complete project overview — read this when user types 'r' to get fully up to speed on the project, where everything is, current tasks, and overall goals. If the user types 'r', confirm you have this context loaded and summarize current tasks and goals. If for any reason this file is missing or not loaded, tell the user you don't have project context and ask them to check .kiro/steering/project-status.md.
---

# AOL Underground Proggies — Project Status

**Last Updated:** 2026-03-08
**Branch:** `reorganize`

## What This Is

Historic vault of ~6,000 AOL/AIM proggie archives (3.1GB). We're building
tooling to catalog, decompile, and preserve these VB3-VB6 executables.

## Repository Layout

```
programs/
  AOL/
    proggies/                          # OLD: category dirs (punters/, idlers/, etc.)
      unsorted-zip-[A-O]/             #   6,061 zips, heavy duplication
      unsorted-zip-[P-Z]/             #   26 _extracted/ dirs, 2,109 exes
      ...                             #   ⚠ NO LONGER SOURCE OF TRUTH
    proggies-sorted-deduped/
      proggies-by-version/             # CANONICAL: 2,138 deduped zips by AOL version
        2.5/ 3.0/ 4.0/ 5.0/ 6.0/ 7.0/ 8.0/ 9.0/ unknown/
      _extracted/                      # LOCAL ONLY (gitignored): extracted exes
  AIM/                                 # 649 AIM proggies (separate pass later)

tools/
  vm/
    guest/agent.py                     # C2 agent running inside Windows VM
    host/virtio_serial_client.py       # Host-side C2 client
    scripts/launch-vm.sh               # VM launcher (QMP + QGA + C2 channels)
    scripts/launch-decompiler.sh       # Decompiler VM wrapper
  detect_vb_version.py                 # VB version detection (PE/NE analysis)
  build_proggie_db.py                  # Canonical DB builder (--extract --import-metadata --index)
  repack_zips.py                       # Repack zips with missing DLLs/OCXs
  query_proggies.py                    # DB query tool (--stats --search --vb --deps etc.)

docs/
  old-plans/REORGANIZATION.md          # Original 8-task reorg plan (Tasks 1-3 done)
  old-plans/COMPILER_BREAKDOWN.md      # VB version stats for all 2,144 AOL proggies
  2026-03-07-pla.md                    # VM decompiler pipeline plan

.kiro/
  specs/canonical_proggie_db/          # Spec: single-source-of-truth DB
  specs/vb_decompiler_wine/            # Spec: old Wine-based decompiler (superseded)
  steering/                            # Always-loaded rules (qemu, win32, ahk, etc.)

proggie_db.sqlite                      # THE database (2,138 proggies, 1,941 exes, 8,475 deps)
proggie-index.txt                      # Tab-delimited index (2,138 entries, all paths valid)
proggie-index.md                       # Browsable version of index
```

## Key Data

| What | Count |
|------|-------|
| Total zip archives | 6,061 (with dupes) |
| Deduped AOL zips | 2,138 |
| AIM proggies | 649 |
| VB6 exes | 805 |
| VB5 exes | 349 |
| VB4-32 exes | 458 |
| VB4-16 exes | 6 |
| VB3 exes | 211 |
| non-VB exes | 112 |
| Decompilable (all VB) | 1,829 |

## VM Infrastructure

Network-isolated Windows 10 x86 QEMU/KVM VM for batch decompilation.

| Disk Image | Contents |
|------------|----------|
| `~/malware-lab/win10-x86-qga-c2-gold-image-with-decompiler-and-crack.qcow2` | Working copy: Win10 + QGA + C2 agent + VB Decompiler Pro |
| `~/malware-lab/win10-x86-qga-c2-gold-image-before-decompiler.qcow2` | Restore point: no decompiler |
| `~/malware-lab/win10-analysis.qcow2` | Original backup |

Snapshots in working copy: `pre-decompiler-setup`, `gold-qga-c2-before-decompiler`, `production-clean`

Communication channels (all via Unix sockets):
- **QMP** (`/tmp/vm-qmp.sock`): screendump, power, input events
- **QGA** (`/tmp/vm-qga.sock`): guest-exec as SYSTEM, file ops
- **C2** (`/tmp/vm-c2.sock`): custom agent.py — decompile commands, shell, etc.

VB Decompiler Pro 9.8 at `C:\Tools\VBDecompiler\VB Decompiler.exe` (7.3MB cracked Pro).
Decompile proven working: sends exe via C2 → GUI automation → saves .frm/.bas/.vbp output.
~147s per exe.

## Current Tasks

### Active: Batch Decompilation Pipeline (Phase 7)
DB is built. Next: batch process ~1,496 VB5/VB6 exes.
- [x] T7.1: Build VB Decompiler plugin DLL (C, cross-compiled with mingw-w64)
      - Correct API: void __stdcall (HWND, HWND, char*, void*) — engine is 4th param
      - API ID 57 (GetModuleFunctionCode) for real decompiled output, not ID 44
      - Poll thread in DllMain, engine set on plugin activation (WM_COMMAND ID 60)
      - Validated: native (anexbust) + p-code (noted1) — real decompiled code
- [x] T7.2: Deploy plugin to VM, configure VB Decompiler settings
      - Plugin DLL deployed, dual C2 (SYSTEM + GUI session 1), plugin activation works
      - Still need: new production-clean snapshot
- [x] T7.E2E: End-to-end proven on anexbust.exe
      - VM extraction → host pull (62 files) → DB update → metadata.json → HTML enrichment
      - HTML: programs/AOL/proggies-sorted-deduped/4.0/anexbust.html
      - Decompiled: decompiled/anexbust/anexbust.exe/ (gitignored, local only)
- [ ] T7.3: Build batch_decompile.py orchestrator
      - Push exe + deps → open in VBD → activate plugin (ID 60) → trigger → pull output
      - Per-exe: open (ID 2) → wait decompile → plugin (ID 60) → cmd file → pull → metadata → HTML
- [ ] T7.4: Snapshot rotation (every 50 exes)
- [ ] T7.5: Progress tracking via DB (resume-on-crash)
- [ ] T7.6: Build metadata parser (host-side, no VM) — minimal version proven inline
- [ ] T7.7: Then decompile ~470 VB3/VB4-32 exes (partial results)
- [x] T7.8: HTML analysis page overhaul (HCI best practices)
      - Hero: program name + author inline, AOL version/VB/compile badges, PE compile date
      - API refs split: AOL Window Classes (version-annotated) vs Win32 API Calls
      - SVG form layouts from .frm control positions (twips→pixels)
      - Structured deps from DB: VB Runtime / System DLLs / Bundled
      - Progressive disclosure: functions collapsed, expand to show code
      - String frequency badges, PE artifact filtering, greet name tags
      - DB-based metadata, single-file mode, responsive dark theme
      - Nav bar: back-to-index + download zip link on every detail page
      - Landing page: index.html with auto-detected featured proggies (Jinja2)
      - Known issues (T7.8):
        - [ ] Code breakdown percentages may be off — computed from decompiled binary
              function sizes, not cleaned source sizes. bodini shows 50% custom but
              actual source files are ~80% custom code.
        - [x] Proc name resolution — addr_to_name map built in metadata.json from
              decompiled filenames + basmod_reference.json canonical names. Applied
              in both render_functions (Decompiled Functions section) and
              render_code_breakdown (Code Breakdown section). MonkEFade added to
              basmod_reference.json. bodini: 1,099/1,123 resolved (24 are intentional
              annotation references). Works for both plugin (.vb) and old (.bas) formats.
        - [ ] Author evidence classifier too broad — any string containing "by:" or
              "written by" gets classified as author evidence. Long help text paragraphs
              that mention "by" leak through. Fixed: removed bare "By + Name" pattern,
              added length filter (>80 chars without explicit credit phrase → interesting).
              Still imperfect — needs manual review per proggie.
        - [ ] Jinja2 migration incomplete — landing page uses Jinja2 templates, detail
              pages still use string concatenation in generate_analysis.py. Full migration
              to Jinja2 templates is a future task.
- Full design: see docs/2026-03-07-pla.md Phase 7
- Task breakdown: see .kiro/specs/canonical_proggie_db/tasks.md

### Done
- [x] Reorganization Tasks 1-3 (git infra, passwords, analysis engine)
- [x] Duplicate detection + merge → 2,138 deduped zips
- [x] VB version detection for all exes
- [x] VM setup: Win10 x86 + QGA + C2 agent + VB Decompiler Pro
- [x] End-to-end decompile proven (anexbust.exe → 62 files, metadata.json, HTML enriched)
- [x] Gold image + production-clean snapshot
- [x] Canonical DB built: 2,138 proggies, 1,941 exes, 8,475 deps, 9,395 files
- [x] Metadata imported: 2,138 named, 1,198 with author, 36 with password
- [x] Zips repacked: 1,402 zips updated with missing DLLs/OCXs
- [x] Index regenerated: proggie-index.txt + proggie-index.md with real paths
- [x] Fixed case-sensitive .exe glob: added 234 missing exes (was 1,707, now 1,941)
- [x] AOHell 95 v3.0 screenshots: 14 clean feature screenshots + animated.gif walkthrough
- [x] AOHell phishing phrases from PHISH.FRM source added to strings DB
- [x] FRM SVG parser fixed: skip non-visual controls, handle nested frame offsets
- [x] Author evidence dedup: normalize whitespace before comparing
- [x] Landing page: added decompilable count, fixed AOHell title + trimmed thumbnail
- [x] Query tool tested: --stats, --search, --vb, --deps, --missing-deps all working
- [x] GitHub Pages live: https://ssstonebraker.github.io/aolunderground-proggies/
- [x] GitHub Actions workflow for Pages deployment (HTML + images only)
- [x] exe_strings.db.zip tracked via Git LFS (2.4GB → 301MB compressed)
- [x] generate_index.py rewritten to use DB (was merge_report.json)
- [x] All download links point to GitHub raw/main (not Pages, not reorganize)
- [x] generate_analysis.py download URLs fixed: raw/main instead of raw/reorganize
- [x] Removed obsolete update-proggie-list.yml workflow
- [x] README + CONTRIBUTING updated: LFS instructions, unzip note, branch refs to main

## Quick Commands

```bash
# Launch decompiler VM
tools/vm/scripts/launch-decompiler.sh run

# Browse proggie HTML pages
# https://ssstonebraker.github.io/aolunderground-proggies/
# http://linux:8088/programs/AOL/proggies-sorted-deduped/4.0/anexbust.html

# Query proggies DB (metadata, VB versions, deps, decompile status)
python3 tools/query_proggies.py --stats
python3 tools/query_proggies.py --vb VB5,VB6
python3 tools/query_proggies.py --missing-deps
python3 tools/query_proggies.py --search "punter"
python3 tools/query_proggies.py --deps "anexbust"

# Query strings DB (2.4GB, 11.6M strings from 2,452 exes)
python3 tools/query_strings.py --stats
python3 tools/query_strings.py "AOL Frame25"
python3 tools/query_strings.py "FindWindow" --exe "anexbust"

# Build/rebuild the proggie DB
python3 tools/build_proggie_db.py --extract --import-metadata --index
```

## File Layout Per Proggie (after decompile)

```
programs/AOL/proggies-sorted-deduped/<ver>/<stem>.html     # analysis page (committed)
programs/AOL/proggies-sorted-deduped/<ver>/<stem>/         # assets dir (committed)
  screenshot.png                                            # main form screenshot
  animated.gif                                              # walkthrough GIF (menu→about→help→greets)
  screen_menu.png                                           # options menu screenshot
  screen_about.png                                          # about dialog screenshot
  screen_help.png                                           # help dialog screenshot
  source/raw/                                               # raw decompiled source (committed)
    project.vbp, info.txt
    forms/*.frm
    modules/*_funcs/*.vb
  source/cleaned/                                           # deobfuscated source (committed)
    forms/*.frm                                             #   decompiler noise stripped
    modules/*_funcs/*.vb                                    #   proc names resolved
    cherry_<module>.bas                                     #   matched known base module code

decompiled/<stem>/<exe>/                                    # working decompile output (gitignored)
  info.txt, project.vbp, extract.log, metadata.json
  forms/*.frm
  modules/*_funcs/*.vb, *.strings
  cleaned/                                                  # local cleaned copy
```

Nginx config: `/etc/nginx/sites-enabled/proggies.conf` → port 8088, root = repo
