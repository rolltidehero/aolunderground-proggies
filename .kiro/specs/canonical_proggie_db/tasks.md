# Canonical Proggie Database — Tasks

## Task 1: Build extraction + DB script ✅ DONE
- [x] Created `tools/build_proggie_db.py`
- [x] Extracts all 2,138 deduped zips (zero failures)
- [x] VB version detection, SHA256 hashes, dependency detection
- [x] DB: 2,138 proggies, 1,706 exes, 8,475 deps, 9,395 files

## Task 2: Import existing metadata ✅ DONE
- [x] Imported 2,169 from proggie-index.txt, 865 from metadata.json, 43 passwords
- [x] Result: 2,138 named, 1,198 with author, 36 with password

## Task 3: Fix deduped zips ✅ DONE
- [x] 1,402 zips repacked, 12 DLLs recovered, 368 false positives reclassified
- [x] 274 string-scan deps still missing (zero PE import deps missing)
- [x] bubble.dll (86 refs) genuinely lost — not in archive or LensHell

## Task 4: Regenerate index files ✅ DONE
- [x] proggie-index.txt (2,138 entries, all FILE paths valid)
- [x] proggie-index.md (grouped by AOL version)

## Task 5: Query tool ✅ DONE
- [x] --stats, --search, --vb, --deps, --missing-deps, --format json/tsv all working

## Task 6: Commit ✅ DONE
- [x] Committed DB + 3 scripts + 1,397 repacked zips + updated indexes

## Task 7: Batch decompilation pipeline (Phase 7)

### T7.1: Build VB Decompiler plugin DLL ✅ DONE
- [x] C plugin, cross-compiled with i686-w64-mingw32-gcc
- [x] Correct API: exports are void __stdcall (HWND, HWND, char*, void*)
      NOT wchar_t* __stdcall (callback) — VBD passes (mainWnd, richEditWnd, buffer, engine)
- [x] Engine pointer is 4th param of PluginLoad, not 1st (1st is main window HWND)
- [x] Poll thread starts in DllMain (runs immediately on DLL load)
- [x] Engine set when plugin activated from Plugins menu (WM_COMMAND ID 60)
- [x] API ID 57 (GetModuleFunctionCode) for real decompiled output — ID 44 returns stubs
- [x] Validated on native code (anexbust.exe): 25 funcs, 61KB code, 9 string ref files
- [x] Validated on p-code (noted1.exe): 20 funcs, near-original VB source
- [x] Output per exe: project.vbp, info.txt, forms/*.frm, modules/*_funcs/*.vb + *.strings
- [x] Known gaps: .asm (ID 70) and .declarations (ID 32) return empty — acceptable
- [x] API reference: https://www.vb-decompiler.org/plugins_sdk.htm

### T7.2: Deploy plugin + configure VM
- [x] Plugin DLL deployed to C:\Tools\VBDecompiler\Plugins\vbd_extract.dll
- [x] Dual C2 agents working (SYSTEM + GUI session 1)
- [x] Plugin activation: WM_COMMAND ID 60 to TfrmMain after file loaded
- [ ] Set remaining VB Decompiler options (most set by plugin via cb_set)
- [ ] Take new production-clean snapshot with fixed plugin + dual agents

### T7.3: Build batch_decompile.py orchestrator
- [ ] Query DB for pending VB5/VB6 exes (1,141 total)
- [ ] Per exe: push exe + deps to VM, open in VB Decompiler (GUI automation)
- [ ] Wait for full decompile (poll tree view count)
- [ ] Trigger plugin → dumps all API data to files
- [ ] GUI saves: project (ID 10), procedures TXT+MAP (ID 8), all-in-one (ID 9), database (ID 7)
- [ ] Pull output to host, update DB decompile_status

### T7.4: Snapshot rotation
- [ ] Restore production-clean snapshot every 50 exes

### T7.5: Progress tracking
- [ ] Resume-on-crash via DB decompile_status field

### T7.6: Build metadata parser (host-side, no VM)
- [ ] Parse .vbp: Title, Description, Company, Version, Startup, IconForm, References
- [ ] Parse .frm: form dimensions, controls (type/name/caption/position/size/tabindex/
      enabled/visible/events), menus (hierarchy with captions/shortcuts), timers
- [ ] Parse decompiled code: navigation graph (Form.Show/Load/Unload/MsgBox/InputBox/Shell)
- [ ] Extract passwords from source:
      - Plaintext comparisons: If txtPass.Text = "secret" Then
      - Chr() concatenation: Chr(83) & Chr(117) → resolve to string
      - XOR cipher patterns: flag with key if visible
      - Registry/INI stored: GetSetting/GetPrivateProfileString
      - Variable tracing: follow assignment chain to literal
- [ ] Extract AOL version signals: window classes, API imports, protocol strings
- [ ] Extract author info: About form labels, module header comments, greet lists
- [ ] Extract identity verification: greet lists (author SNs), enemy lists,
      crew/group tags, greet messages, registration systems, lockout behavior
- [ ] Build metadata.json per exe
- [ ] Update DB: proggies.name, proggies.author, proggies.password

### T7.7: VB3/VB4-32 decompilation
- [ ] ~470 exes (partial results — VB Decompiler has limited VB3/VB4 support)

### Downstream (after decompile)
- [ ] Website: browsable proggie catalog with metadata, screenshots, animated GIFs
- [ ] Screenshot automation: use form dimensions + navigation graph + password data
- [ ] Animated GIF generation: step through navigation graph, capture each state

### Expected End State Per Exe (after full pipeline)
After decompilation + metadata parsing, each proggie should have:

```
programs/AOL/proggies-sorted-deduped/proggies-by-version/<ver>/<zip_stem>.zip   # original
programs/AOL/proggies-sorted-deduped/<ver>/<zip_stem>.html                      # analysis page

decompiled/<zip_stem>/<exe_name>/          # decompiled output (gitignored, local only)
  info.txt                                 # native/compiler/packed flags
  project.vbp                              # VB project structure
  extract.log                              # extraction summary
  forms/<FormName>.frm                     # form properties + controls + menus
  modules/<ModName>_funcs/<addr>_<name>.vb # decompiled function code
  modules/<ModName>_funcs/<addr>_<name>.strings  # per-function string refs
  frx_info.txt                             # FRX resource metadata (if present)
  metadata.json                            # parsed metadata (see schema below)

metadata.json schema:
{
  "exe_name": "anexbust.exe",
  "zip_stem": "anexbust",
  "vb_version": "VB6",
  "compile_type": "native",
  "is_packed": false,
  "project": { "startup": "Form1", "icon_form": "Form1", "company": "?", "version": "1.0.0" },
  "forms": [
    { "name": "Form1", "controls": [...], "menus": [...], "timers": [...] }
  ],
  "modules": [ { "name": "modAnexBust", "functions": [...] } ],
  "strings": { "interesting": [...], "api_refs": [...], "greets": [...] },
  "passwords": [],
  "aol_version_signals": [],
  "author_evidence": []
}
```

DB fields updated: exes.decompile_status, exes.decompile_output, exes.decompile_file_count
HTML file updated: enriched with forms, controls, menus, code snippets from decompile
