"""Clean decompiler noise from VB Decompiler Pro native-code output.

Two levels:
  clean_for_display(code)  — aggressive, for HTML rendering
  clean_for_source(code, proc_names)  — writes readable .bas/.frm files
"""

import re

# --- helpers ----------------------------------------------------------------

_LOC_RE = re.compile(r'loc_[0-9A-Fa-f]+:\s*')
_ADDR_COMMENT_RE = re.compile(r"\s*'[0-9A-Fa-f]{4,}\s*$", re.M)
_DATA_TABLE_RE = re.compile(r"^\s*'Data Table:.*$\n?", re.M)
_REF_FROM_RE = re.compile(r"^\s*'Referenced from:.*$\n?", re.M)

# Type coercions the compiler inserts (safe to unwrap for single non-nested arg)
_COERCE_RE = [re.compile(rf'{fn}\(([^()]+)\)') for fn in
              ('CLng', 'CStr', 'CDbl', 'CVar', 'CBool')]

# var_eax = call X → call X  (return value discarded)
_VAREAX_CALL_RE = re.compile(r'(?:var_eax|eax|ecx|edx|esi|edi|ebx)\s*=\s*(?=call\b)')
# var_eax = Func(...) → Func(...)
_VAREAX_FUNC_RE = re.compile(r'(?:var_eax|eax|ecx|edx)\s*=\s*(?=[A-Z]\w+\()')
# Dead register-to-register: var_18 = esi
_DEAD_REG_RE = re.compile(r'^\s*var_\w+\s*=\s*(?:esi|edi|ebx|ecx|edx|eax)\s*$\n?', re.M)
# GoTo before Exit/End Sub
_GOTO_EXIT_RE = re.compile(
    r'^\s*GoTo loc_[0-9A-Fa-f]+\s*\n(\s*(?:Exit (?:Sub|Function)|End (?:Sub|Function)))', re.M)

# --- aggressive (display-only) patterns ------------------------------------

# Entire line: var_eax = Unknown_VTable_Call[...]
_VTABLE_ASSIGN_RE = re.compile(r'^\s*var_eax\s*=\s*Unknown_VTable_Call\[.*\]\s*$\n?', re.M)
# Entire line: call __vbaXXX  (bare internal runtime call)
_VBA_CALL_RE = re.compile(r'^\s*call __vba\w+\s*$\n?', re.M)
# Entire line: var_XX = __vbaXXX  (result of above)
_VBA_ASSIGN_RE = re.compile(r'^\s*var_\w+\s*=\s*__vba\w+\s*$\n?', re.M)
# FPU instructions: fcomp, fnstsw, fld, fild
_FPU_RE = re.compile(r'^\s*f(?:comp|nstsw|ld|ild|stp|iadd|isub|imul|idiv)\b.*$\n?', re.M)
# esi = (call ...) + 1  (boolean intermediate, next line has the If)
_REG_BOOL_RE = re.compile(r'^\s*(?:esi|edi)\s*=\s*\(.*\)\s*\+\s*1\s*$\n?', re.M)
# Duplicate call: "call X(...)" immediately followed by "var_YY = call X(...)"
# After var_eax strip, we get bare "call Func(...)" then "var_28 = call Func(...)"
_DUP_CALL_RE = re.compile(
    r'^\s*call (\w+\([^)]*\))\s*$\n(\s*var_\w+\s*=\s*call \1)', re.M)
# Standalone "call Func(...) + 1" (boolean test artifact, next line has If)
_CALL_PLUS1_RE = re.compile(r'^\s*call \w+\([^)]*\)\s*\+\s*1\s*$\n?', re.M)
# x86 instructions that leak through: setz, setne, movzx, cdq, etc.
_X86_INSN_RE = re.compile(r'^\s*(?:setz|setne|sete|movzx|cdq|nop)\b.*$\n?', re.M)
# Hex address literals used as args: 00404AECh → &hXXXXXXXX
_HEX_ADDR_RE = re.compile(r'\b(0{2}[0-9A-Fa-f]{6})h\b')
# var_XXXXXXXX (8-digit hex var from unresolved addresses)
_HEX_VAR_RE = re.compile(r'\bvar_[0-9A-Fa-f]{8}\b')
# Inline Unknown_VTable_Call[reg+offset] → (vtable call)
_VTABLE_INLINE_RE = re.compile(r'Unknown_VTable_Call\[\w+\+\S+?\]')
# Entire line: call _adj_fdiv_m32(...) — Pentium FDIV bug workaround
_ADJ_FDIV_RE = re.compile(r'^\s*call _adj_\w+\(.*$\n?', re.M)
# Entire line: XX = CheckObj(...) — runtime type check noise
_CHECKOBJ_RE = re.compile(r'^\s*\S+\s*=\s*CheckObj\(.*$\n?', re.M)
# If Unknown_VTable_Call[...] >= 0 Then GoTo — error handling boilerplate
_VTABLE_IF_RE = re.compile(r'^\s*If Unknown_VTable_Call\[.*\]\s*>=\s*0\s*Then GoTo\b.*$\n?', re.M)


def _base_clean(code: str) -> str:
    """Cleaning shared between display and source output."""
    c = code.replace('\r\n', '\n').replace('\r', '\n')
    c = _LOC_RE.sub('', c)
    c = _ADDR_COMMENT_RE.sub('', c)
    c = _DATA_TABLE_RE.sub('', c)
    c = _REF_FROM_RE.sub('', c)
    for rx in _COERCE_RE:
        c = rx.sub(r'\1', c)
    c = _VAREAX_CALL_RE.sub('', c)
    c = _VAREAX_FUNC_RE.sub('', c)
    c = _DEAD_REG_RE.sub('', c)
    c = _GOTO_EXIT_RE.sub(r'\1', c)
    return c


def clean_for_display(code: str) -> str:
    """Aggressive cleanup for HTML rendering. Strips everything that's pure noise."""
    c = _base_clean(code)
    c = _VTABLE_ASSIGN_RE.sub('', c)
    c = _VBA_CALL_RE.sub('', c)
    c = _VBA_ASSIGN_RE.sub('', c)
    c = _FPU_RE.sub('', c)
    c = _REG_BOOL_RE.sub('', c)
    c = _DUP_CALL_RE.sub(r'\2', c)
    c = _CALL_PLUS1_RE.sub('', c)
    c = _X86_INSN_RE.sub('', c)
    c = _ADJ_FDIV_RE.sub('', c)
    c = _CHECKOBJ_RE.sub('', c)
    c = _VTABLE_IF_RE.sub('', c)
    # Replace hex address literals with readable marker
    c = _HEX_ADDR_RE.sub(r'&h\1', c)
    # Simplify inline Unknown_VTable_Call to (vtable)
    c = _VTABLE_INLINE_RE.sub('(vtable)', c)
    # Collapse blanks
    c = re.sub(r'^\s*\n', '\n', c, flags=re.M)
    c = re.sub(r'\n{3,}', '\n\n', c)
    return c


def clean_for_source(code: str, proc_names: dict | None = None) -> str:
    """Clean a single function block and resolve proc names."""
    c = clean_for_display(code)
    if proc_names:
        def _sub(m):
            short = f'{m.group(1)}_{m.group(2)}'
            return proc_names.get(short, m.group(0))
        c = re.sub(r'(Proc_\d+)_(\d+)_[A-F0-9]+', _sub, c)
    return c


def clean_file(raw_text: str, proc_names: dict | None = None) -> str:
    """Clean an entire .frm/.bas file, preserving headers and structure.

    Only cleans code inside Sub/Function blocks. Preserves form headers,
    Attribute lines, Declare statements, and module-level code.
    Also strips 'VA: address comments from Declare sections.
    """
    lines_out = []
    raw_lines = raw_text.replace('\r\n', '\n').replace('\r', '\n').split('\n')
    i = 0
    while i < len(raw_lines):
        line = raw_lines[i]
        stripped = line.strip()
        # Detect start of Sub/Function body
        if re.match(r"(?:Public |Private )?(?:Sub|Function) ", stripped) and ' Lib "' not in stripped:
            # Collect entire block until End Sub/Function
            block = [line]
            i += 1
            while i < len(raw_lines):
                block.append(raw_lines[i])
                if raw_lines[i].strip().startswith(('End Sub', 'End Function')):
                    break
                i += 1
            # Clean the block
            cleaned = clean_for_source('\n'.join(block), proc_names)
            lines_out.append(cleaned)
        else:
            # Strip 'VA: XXXXXX comments (address annotations on Declares)
            if re.match(r"^\s*'VA:\s*[0-9A-Fa-f]+\s*$", stripped):
                i += 1
                continue
            lines_out.append(line)
        i += 1
    return '\n'.join(lines_out)
