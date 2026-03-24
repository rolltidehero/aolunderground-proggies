"""Match decompiled functions against canonical .bas module source code.

Fingerprints functions by their API calls, window class strings, and message
constants, then matches decompiled proc bodies against known .bas functions.
"""
import re, json, logging
from pathlib import Path

logger = logging.getLogger(__name__)

REPO = Path(__file__).resolve().parent.parent

# Canonical .bas file locations (first match wins)
_BAS_PATHS = {
    'dos32':    ['programming/vb/aol/40-50/modules/dos32/dos32.bas'],
    'jaguar32': ['programming/vb/aol/40-50/modules/jaguar32/Jaguar32.bas',
                 'programming/vb/aol/25-30/modules/jaguar32/jaguar32.bas'],
    'livid32':  ['programming/vb/aol/40-50/modules/livid32/LiviD32.bas'],
    'skybox':   ['programming/vb/aol/40-50/modules/skybox/Skybox.bas'],
    'kin2000':  ['programming/vb/aol/40-50/modules/kin2000/KiN2000.bas'],
    'bas32':    ['programming/vb/aol/unsorted/_extracted/bas32/bas32.bas'],
    'arc3':     ['programming/vb/aol/unsorted/_extracted/arc/arc3.bas'],
    'arc5':     ['programming/vb/aol/unsorted/_extracted/arc/arc5.bas'],
}

# Patterns to extract from function bodies for fingerprinting
_API_RE = re.compile(
    r'\b(FindWindow|FindWindowEx|SendMessage(?:ByString|Long)?|PostMessage|'
    r'GetWindowText(?:Length)?|SetWindowPos|ShowWindow|GetMenu|GetSubMenu|'
    r'GetPrivateProfileString|WritePrivateProfileString|'
    r'GetClassName|EnumChildWindows|SetWindowText|'
    r'Shell|Dir\$?|InStr|Left\$?|Right\$?|Mid\$?|'
    r'WM_SETTEXT|WM_GETTEXT|WM_GETTEXTLENGTH|WM_CHAR|WM_CLOSE|'
    r'WM_KEYDOWN|WM_KEYUP|WM_LBUTTONDOWN|WM_LBUTTONUP|'
    r'VK_SPACE|VK_RETURN|ENTER_KEY)\b', re.I)

_WINCLASS_RE = re.compile(
    r'"(AOL Frame25|AOL Frame|AOL Child|AOL Toolbar|MDIClient|'
    r'RICHCNTL|_AOL_\w+|Edit|Buddy List Window|'
    r'AOL Instant Message|WndAte32Class)"')

_MSG_CONST_RE = re.compile(r'(?:SendMessage\w*|PostMessage)\(.+?,\s*(\d+)')

# Map numeric message IDs to symbolic names (decompiled code uses numbers)
_MSG_ID_MAP = {
    '12': 'WM_SETTEXT', '13': 'WM_GETTEXT', '14': 'WM_GETTEXTLENGTH',
    '16': 'WM_CLOSE', '258': 'WM_CHAR', '256': 'WM_KEYDOWN', '257': 'WM_KEYUP',
    '513': 'WM_LBUTTONDOWN', '514': 'WM_LBUTTONUP', '273': 'WM_COMMAND',
}


def _fingerprint(code):
    """Extract a fingerprint from function code: frozenset of API/class/msg tokens."""
    tokens = set()
    for m in _API_RE.finditer(code):
        tok = m.group(1).lower()
        # Normalize SendMessage variants
        if tok in ('sendmessagebystring', 'sendmessagelong'):
            tok = 'sendmessage'
        tokens.add(('api', tok))
    for m in _WINCLASS_RE.finditer(code):
        tokens.add(('cls', m.group(1)))
    for m in _MSG_CONST_RE.finditer(code):
        num = m.group(1)
        if num == '0':
            continue  # skip zero (usually wparam/lparam, not message ID)
        sym = _MSG_ID_MAP.get(num, num)
        tokens.add(('api', sym.lower()))
    # Also catch named constants used in source
    for const in ('WM_SETTEXT', 'WM_GETTEXT', 'WM_GETTEXTLENGTH', 'WM_CHAR',
                  'WM_CLOSE', 'WM_KEYDOWN', 'WM_KEYUP', 'WM_LBUTTONDOWN',
                  'WM_LBUTTONUP', 'WM_COMMAND', 'VK_SPACE', 'VK_RETURN',
                  'ENTER_KEY'):
        if const in code:
            tokens.add(('api', const.lower()))
    return frozenset(tokens)


def _parse_bas_functions(text):
    """Parse a .bas file into {name: body_text} dict."""
    funcs = {}
    func_re = re.compile(
        r'^(?:Public\s+|Private\s+)?(?:Sub|Function)\s+(\w+)',
        re.MULTILINE)
    ends = [m.start() for m in re.finditer(r'^End\s+(?:Sub|Function)', text, re.MULTILINE)]
    for m in func_re.finditer(text):
        name = m.group(1)
        start = m.start()
        # Find the next End Sub/Function after this start
        body_end = next((e for e in ends if e > start), len(text))
        body = text[start:body_end].strip()
        if name not in funcs:  # first definition wins
            funcs[name] = body
    return funcs


# Cache: module_name -> {func_name: (fingerprint, source_code)}
_ref_cache = {}


def _load_reference(module_name):
    """Load and fingerprint all functions from a canonical .bas file."""
    if module_name in _ref_cache:
        return _ref_cache[module_name]
    paths = _BAS_PATHS.get(module_name, [])
    for rel in paths:
        p = REPO / rel
        if p.exists():
            text = p.read_text(errors='replace')
            funcs = _parse_bas_functions(text)
            ref = {}
            for name, body in funcs.items():
                fp = _fingerprint(body)
                if fp:  # any tokens at all
                    ref[name] = (fp, body)
            _ref_cache[module_name] = ref
            logger.debug('Loaded %s: %d fingerprinted functions', module_name, len(ref))
            return ref
    _ref_cache[module_name] = {}
    return {}


def match_decompiled_functions(decompiled_funcs, exclude_modules=None):
    """Match decompiled functions against all known .bas modules.

    Args:
        decompiled_funcs: list of {'name': str, 'code': str, ...}
        exclude_modules: set of module names already identified as base (skip those)

    Returns:
        list of dicts, one per input func, with added fields:
            'matched_module': str or None
            'matched_func': str or None
            'matched_source': str or None (clean .bas source)
            'match_score': float 0-1
    """
    exclude = set(exclude_modules or [])
    # Load all references
    refs = {}
    for mod in _BAS_PATHS:
        if mod not in exclude:
            r = _load_reference(mod)
            if r:
                refs[mod] = r

    results = []
    for func in decompiled_funcs:
        code = func.get('code', '')
        fp = _fingerprint(code)
        best = None
        best_score = 0.0

        if fp:
            for mod, mod_funcs in refs.items():
                for fname, (ref_fp, ref_src) in mod_funcs.items():
                    if not ref_fp:
                        continue
                    # Jaccard similarity
                    inter = len(fp & ref_fp)
                    union = len(fp | ref_fp)
                    score = inter / union if union else 0
                    # Require at least 50% overlap, or exact match for tiny fps
                    threshold = 0.4 if len(fp) <= 2 else 0.5
                    if score > best_score and score >= threshold:
                        best_score = score
                        best = (mod, fname, ref_src)

        entry = dict(func)  # copy
        if best:
            entry['matched_module'] = best[0]
            entry['matched_func'] = best[1]
            entry['matched_source'] = best[2]
            entry['match_score'] = round(best_score, 3)
        else:
            entry['matched_module'] = None
            entry['matched_func'] = None
            entry['matched_source'] = None
            entry['match_score'] = 0.0
        results.append(entry)

    # Second pass: for ambiguous matches, prefer the module with most other matches
    mod_counts = {}
    for entry in results:
        m = entry.get('matched_module')
        if m:
            mod_counts[m] = mod_counts.get(m, 0) + 1
    dominant = max(mod_counts, key=mod_counts.get) if mod_counts else None

    # Re-check entries that matched a non-dominant module — see if dominant has a close match
    if dominant:
        for entry in results:
            if entry['matched_module'] and entry['matched_module'] != dominant:
                fp = _fingerprint(entry.get('code', ''))
                if not fp or dominant not in refs:
                    continue
                for fname, (ref_fp, ref_src) in refs[dominant].items():
                    inter = len(fp & ref_fp)
                    union = len(fp | ref_fp)
                    score = inter / union if union else 0
                    # Accept if within 20% of current best
                    if score >= entry['match_score'] * 0.7 and score >= 0.4:
                        entry['matched_module'] = dominant
                        entry['matched_func'] = fname
                        entry['matched_source'] = ref_src
                        entry['match_score'] = round(score, 3)
                        break

    return results
