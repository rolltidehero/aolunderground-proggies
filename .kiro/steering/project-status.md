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
  build_proggie_db.py                  # TODO: canonical DB builder
  query_proggies.py                    # TODO: DB query tool

docs/
  old-plans/REORGANIZATION.md          # Original 8-task reorg plan (Tasks 1-3 done)
  old-plans/COMPILER_BREAKDOWN.md      # VB version stats for all 2,144 AOL proggies
  2026-03-07-pla.md                    # VM decompiler pipeline plan

.kiro/
  specs/canonical_proggie_db/          # Spec: single-source-of-truth DB
  specs/vb_decompiler_wine/            # Spec: old Wine-based decompiler (superseded)
  steering/                            # Always-loaded rules (qemu, win32, ahk, etc.)

proggie_db.sqlite                      # TODO: THE database (all metadata)
proggie-index.txt                      # ⚠ BROKEN: FILE column points to nonexistent paths
proggie-index.md                       # Browsable version of index
```

## Key Data

| What | Count |
|------|-------|
| Total zip archives | 6,061 (with dupes) |
| Deduped AOL zips | 2,138 |
| AIM proggies | 649 |
| VB6 exes | ~1,177 |
| VB5 exes | ~319 |
| VB4-32 exes | ~286 |
| VB3 exes | ~119 |
| non-VB exes | ~208 |
| Decompilable (VB5+VB6) | ~1,496 |

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

### Active: Batch Decompilation (Phase 7)
DB is built. Next: batch decompile 1,141 VB5/VB6 exes via the VM pipeline.
- [ ] T7.1: Build batch_decompile.py orchestrator
- [ ] T7.2: Push exe + deps to VM, decompile via C2, pull output
- [ ] T7.3: Restore production-clean snapshot every 50 exes
- [ ] T7.4: Progress tracking via DB (resume-on-crash)
- [ ] T7.5: Extract real names/authors from decompiled VBP/FRM/BAS output
- [ ] Then: 470 VB3/VB4-32 exes (partial results)
- Time estimate: ~47 hours for VB5/VB6 at 147s/exe

### Done
- [x] Reorganization Tasks 1-3 (git infra, passwords, analysis engine)
- [x] Duplicate detection + merge → 2,138 deduped zips
- [x] VB version detection for all exes
- [x] VM setup: Win10 x86 + QGA + C2 agent + VB Decompiler Pro
- [x] Single-exe decompile proven (anexbust.exe → 6 files)
- [x] Gold image + production-clean snapshot
- [x] Canonical DB built: 2,138 proggies, 1,706 exes, 8,475 deps, 9,395 files
- [x] Metadata imported: 2,138 named, 1,198 with author, 36 with password
- [x] Zips repacked: 1,402 zips updated with missing DLLs/OCXs
- [x] Index regenerated: proggie-index.txt + proggie-index.md with real paths
- [x] Query tool tested: --stats, --search, --vb, --deps, --missing-deps all working

## Quick Commands

```bash
# Launch decompiler VM
tools/vm/scripts/launch-decompiler.sh run

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

# Build/rebuild the proggie DB (once script exists)
python3 tools/build_proggie_db.py --extract --import-metadata --index
```
