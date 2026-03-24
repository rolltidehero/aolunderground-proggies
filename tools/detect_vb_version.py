#!/usr/bin/env python3
"""Detect VB compiler version and p-code/native for every exe in every archive.
Updates merge_report.json with vb_info field.

Detection method:
- NE exes: check imported module names for VBRUN300/200/100, VB40016
- PE exes: check for VB5! signature, then:
  - Version from runtime DLL import (VB40032/MSVBVM50/MSVBVM60)
  - P-code vs native from ProjectInfo.aNativeCode field (offset +0x20):
    0 = p-code, non-zero = native code
    (per Alex Ionescu's VB structure docs and RE Stack Exchange confirmation)
"""
import zipfile, struct, json, os, sys

REPORT = "data/merged/merge_report.json"

def detect_vb(data):
    if len(data) < 64 or data[:2] != b'MZ':
        return None
    try:
        new_hdr_off = struct.unpack_from('<I', data, 0x3C)[0]
    except:
        return None
    if new_hdr_off >= len(data) - 2:
        return None
    sig = data[new_hdr_off:new_hdr_off+2]
    if sig == b'NE':
        return _detect_ne(data, new_hdr_off)
    elif sig == b'PE':
        return _detect_pe(data, new_hdr_off)
    return None

def _detect_ne(data, ne_off):
    try:
        num_mod_refs = struct.unpack_from('<H', data, ne_off + 0x1E)[0]
        mod_ref_table = struct.unpack_from('<H', data, ne_off + 0x28)[0]
        imp_names_table = struct.unpack_from('<H', data, ne_off + 0x2A)[0]
    except:
        return None
    dll_map = {
        'VBRUN300': ('VB3', 'VBRUN300.DLL'),
        'VBRUN200': ('VB2', 'VBRUN200.DLL'),
        'VBRUN100': ('VB1', 'VBRUN100.DLL'),
        'VB40016':  ('VB4-16', 'VB40016.DLL'),
    }
    for i in range(num_mod_refs):
        try:
            ref_off = ne_off + mod_ref_table + (i * 2)
            name_off = struct.unpack_from('<H', data, ref_off)[0]
            abs_off = ne_off + imp_names_table + name_off
            name_len = data[abs_off]
            name = data[abs_off+1:abs_off+1+name_len].decode('ascii', errors='replace').upper()
        except:
            continue
        for prefix, (ver, dll) in dll_map.items():
            if name.startswith(prefix):
                return {'version': ver, 'compile_type': 'p-code', 'runtime_dll': dll, 'exe_type': 'NE/16-bit'}
    return None

def _detect_pe(data, pe_off):
    # Determine VB version from runtime DLL
    data_upper = data.upper()
    dll_map = {
        b'MSVBVM60.DLL': ('VB6', 'MSVBVM60.DLL'),
        b'MSVBVM50.DLL': ('VB5', 'MSVBVM50.DLL'),
        b'VB40032.DLL':  ('VB4-32', 'VB40032.DLL'),
    }
    version = runtime = None
    for dll_bytes, (ver, dll_name) in dll_map.items():
        if dll_bytes in data_upper:
            version, runtime = ver, dll_name
            break
    if not version:
        return None

    # Detect p-code vs native via ProjectInfo.aNativeCode
    # Chain: VB5! header +0x30 -> ProjectInfo VA -> +0x20 = aNativeCode
    # If aNativeCode == 0, it's p-code. Otherwise native.
    compile_type = 'unknown'
    vb5_pos = data.find(b'VB5!')
    if vb5_pos >= 0:
        try:
            image_base = struct.unpack_from('<I', data, pe_off + 0x34)[0]
            num_sections = struct.unpack_from('<H', data, pe_off + 6)[0]
            opt_hdr_size = struct.unpack_from('<H', data, pe_off + 20)[0]
            section_off = pe_off + 24 + opt_hdr_size

            def va_to_raw(va):
                rva = va - image_base
                for s in range(num_sections):
                    so = section_off + s * 40
                    sec_va = struct.unpack_from('<I', data, so + 12)[0]
                    sec_vsize = struct.unpack_from('<I', data, so + 8)[0]
                    sec_rawsize = struct.unpack_from('<I', data, so + 16)[0]
                    sec_rawptr = struct.unpack_from('<I', data, so + 20)[0]
                    if sec_va <= rva < sec_va + max(sec_vsize, sec_rawsize):
                        return sec_rawptr + (rva - sec_va)
                return None

            proj_info_va = struct.unpack_from('<I', data, vb5_pos + 0x30)[0]
            proj_info_raw = va_to_raw(proj_info_va)
            if proj_info_raw is not None and proj_info_raw + 0x24 <= len(data):
                native_code_ptr = struct.unpack_from('<I', data, proj_info_raw + 0x20)[0]
                compile_type = 'p-code' if native_code_ptr == 0 else 'native'
        except:
            pass

    return {'version': version, 'compile_type': compile_type, 'runtime_dll': runtime, 'exe_type': 'PE/32-bit'}

def main():
    with open(REPORT) as f:
        report = json.load(f)

    stats = {}
    total = len(report['merges'])

    for i, merge in enumerate(report['merges']):
        zip_path = merge['merged_archive']
        if not os.path.exists(zip_path):
            continue

        # Scan all exes in archive
        results = []
        try:
            with zipfile.ZipFile(zip_path) as z:
                for name in z.namelist():
                    if name.lower().endswith('.exe'):
                        try:
                            info = detect_vb(z.read(name))
                            if info:
                                info['exe_name'] = name
                                results.append(info)
                        except:
                            pass
        except:
            pass

        # Match primary exe
        meta_exe = merge['metadata'].get('exe_name', '')
        primary = None
        for r in results:
            if r['exe_name'].lower() == meta_exe.lower():
                primary = r
                break
        if not primary and results:
            primary = results[0]

        if primary:
            merge['metadata']['vb_info'] = {
                'version': primary['version'],
                'compile_type': primary['compile_type'],
                'runtime_dll': primary['runtime_dll'],
                'exe_type': primary['exe_type'],
            }
            key = f"{primary['version']} ({primary['compile_type']})"
        else:
            merge['metadata']['vb_info'] = {
                'version': 'non-VB',
                'compile_type': 'n/a',
                'runtime_dll': 'n/a',
                'exe_type': 'unknown',
            }
            key = 'non-VB'

        stats[key] = stats.get(key, 0) + 1
        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{total} scanned", file=sys.stderr)

    with open(REPORT, 'w') as f:
        json.dump(report, f, indent=2)

    print(f"\nVB Version Detection Complete ({total} archives):")
    for k in sorted(stats.keys()):
        print(f"  {k}: {stats[k]}")
    print(f"  Total: {sum(stats.values())}")

if __name__ == '__main__':
    main()
