#!/usr/bin/env python3
"""Discover clickable controls from decompiled VB source code.

Parses .frm files and _Click.vb handler files to build an ordered list of
click targets with positions, actions, and hint text.

Usage as module:
    from discover_targets import discover_targets
    targets = discover_targets('/path/to/decompiled/stem/exe')

Usage standalone:
    python3 tools/discover_targets.py <zip_stem>
"""
import json, logging, re, time
from pathlib import Path

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s.%(msecs)03d [%(levelname)-8s] %(name)s: %(message)s',
    datefmt='%H:%M:%S',
)
log = logging.getLogger(Path(__file__).stem)

REPO = Path(__file__).resolve().parent.parent
DECOMPILED = REPO / 'decompiled'
TWIPS_PER_PX = 15

DANGER_WORDS = frozenset({
    'exit', 'quit', 'close', 'send', 'punt', 'boot', 'kill', 'bomb',
    'flood', 'nuke', 'disconnect', 'terminate', 'shutdown', 'unload',
    'destroy', 'attack', 'scroll', 'mass', 'spam', 'kick',
    'end', 'cancel', 'start', 'stop', 'connect', 'crack',
    'run', 'go', 'begin',
})

# VB3 third-party control type mapping
CLICKABLE_TYPES = {
    'CommandButton', 'Command3D', 'SSCommand',
    'Label', 'Image', 'PictureBox',
    'CheckBox', 'Check3D', 'SSCheck',
    'OptionButton', 'Option3D', 'SSOption',
    'csPicture',
}
DISPLAY_ONLY = {'SSPanel', 'Panel3D', 'StatusBar', 'Timer', 'Line', 'Shape'}

# Handler event suffixes we care about
CLICK_EVENTS = re.compile(r'_Click\b|_DblClick\b|_MouseDown\b')
HINT_EVENT = re.compile(r'_MouseMove\b')


def parse_frm_controls(frm_path):
    """Parse .frm file for control definitions with positions.
    Returns dict {control_name: {type, caption, left, top, width, height}}."""
    _t0 = time.monotonic()
    text = frm_path.read_text(errors='replace')
    controls = {}
    stack = []  # (ctrl_dict, cum_left, cum_top)
    current = None
    cum_left = cum_top = 0

    for line in text.split('\n'):
        stripped = line.strip().rstrip('\r')
        m = re.match(r'Begin\s+(?:\w+\.)?(\w+)\s+(\w+)', stripped)
        if m:
            if current is not None:
                stack.append((current, cum_left, cum_top))
                bare = current.get('type', '')
                if bare not in ('Form', 'MDIForm'):
                    cum_left += current.get('left', 0)
                    cum_top += current.get('top', 0)
            current = {'type': m.group(1), 'name': m.group(2)}
            continue
        if stripped == 'End':
            if current is not None:
                if cum_left or cum_top:
                    current['left'] = current.get('left', 0) + cum_left
                    current['top'] = current.get('top', 0) + cum_top
                controls[current['name']] = current
                if stack:
                    current, cum_left, cum_top = stack.pop()
                else:
                    current = None
                    cum_left = cum_top = 0
            continue
        if current:
            kv = re.match(r'(\w+)\s*=\s*(.+)', stripped)
            if kv:
                key, val = kv.group(1), kv.group(2).strip()
                if key == 'Caption':
                    current['caption'] = val.strip('"')
                elif key in ('Left', 'Top', 'Width', 'Height'):
                    try:
                        current[key.lower()] = int(val)
                    except ValueError:
                        pass

    log.debug('parse_frm_controls: %s → %d controls (%.3fs)',
              frm_path.name, len(controls), time.monotonic() - _t0)
    return controls


def find_click_handlers(base, form_name):
    """Find all _Click/_DblClick/_MouseDown handlers for a form.
    Returns dict {control_name: {event, code, action, target_form}}."""
    handlers = {}

    # Layout 1: modules/<form>_funcs/*_Click.vb
    funcs_dir = base / 'modules' / f'{form_name}_funcs'
    if funcs_dir.exists():
        for vb in funcs_dir.iterdir():
            if not vb.suffix == '.vb':
                continue
            m = re.search(r'_(\w+)_(Click|DblClick|MouseDown)\.vb$', vb.name)
            if not m:
                continue
            ctrl_name = m.group(1)
            event = m.group(2)
            code = vb.read_text(errors='replace')
            action, target = classify_handler(code)
            handlers[ctrl_name] = {'event': event, 'code': code, 'action': action, 'target_form': target}

    # Layout 2: inline in .frm (flat layout)
    frm_path = base / f'{form_name}.frm'
    if not frm_path.exists():
        frm_path = base / 'forms' / f'{form_name}.frm'
    if frm_path.exists():
        text = frm_path.read_text(errors='replace')
        # VB6: Private Sub ControlName_Click()
        # VB3: Sub ControlName_Click ()
        for m in re.finditer(
            r'(?:Private\s+)?Sub\s+(\w+)_(Click|DblClick|MouseDown)\s*\(.*?\)\s*.*?End Sub',
            text, re.S | re.I
        ):
            ctrl_name = m.group(1)
            event = m.group(2)
            code = m.group(0)
            if ctrl_name not in handlers:
                action, target = classify_handler(code)
                handlers[ctrl_name] = {'event': event, 'code': code, 'action': action, 'target_form': target}

    return handlers


def find_hint_text(base, form_name):
    """Find _MouseMove handlers that set status bar hint text.
    Returns dict {control_name: hint_text}."""
    hints = {}

    # Layout 1: modules
    funcs_dir = base / 'modules' / f'{form_name}_funcs'
    if funcs_dir.exists():
        for vb in funcs_dir.iterdir():
            if '_MouseMove' not in vb.name:
                continue
            m = re.search(r'_(\w+)_MouseMove', vb.name)
            if not m:
                continue
            code = vb.read_text(errors='replace')
            hint = extract_hint(code)
            if hint:
                hints[m.group(1)] = hint

    # Layout 2: inline
    frm_path = base / f'{form_name}.frm'
    if not frm_path.exists():
        frm_path = base / 'forms' / f'{form_name}.frm'
    if frm_path.exists():
        text = frm_path.read_text(errors='replace')
        for m in re.finditer(
            r'(?:Private\s+)?Sub\s+(\w+)_MouseMove\s*\(.*?\)\s*.*?End Sub',
            text, re.S | re.I
        ):
            ctrl_name = m.group(1)
            if ctrl_name not in hints:
                hint = extract_hint(m.group(0))
                if hint:
                    hints[ctrl_name] = hint

    return hints


def extract_hint(code):
    """Extract hint text from a _MouseMove handler.
    Looks for patterns like: dd.Caption = "description" or lblStatus.Caption = "text"."""
    for m in re.finditer(r'\.Caption\s*=\s*"([^"]+)"', code):
        text = m.group(1)
        if len(text) > 5 and not re.match(r'^[\d.]+$', text):
            return text
    return None


def classify_handler(code):
    """Classify what a click handler does. Returns (action, target_form)."""
    # Check for danger patterns first
    if re.search(r'\bUnload\s+Me\b|\bMe\.Hide\b', code, re.I):
        return 'hide_self', None

    # .Show → opens another form
    m = re.search(r'(\w+)\.Show\b', code)
    if m:
        return 'show_form', m.group(1)

    # MsgBox
    if re.search(r'\bMsgBox\b', code, re.I):
        return 'msgbox', None

    # Shell → launches external program
    if re.search(r'\bShell\b', code, re.I):
        return 'shell', None

    # InputBox
    if re.search(r'\bInputBox\b', code, re.I):
        return 'input_dialog', None

    # CommonDialog
    if re.search(r'CommonDialog|\.Action\s*=\s*[12]|\.ShowOpen|\.ShowSave', code, re.I):
        return 'file_dialog', None

    # .Hide or Unload on another form
    if re.search(r'\w+\.Hide\b|\bUnload\s+\w+', code, re.I):
        return 'hide', None

    return 'action', None


def is_dangerous(caption, name):
    """Check if a control should be skipped based on danger words."""
    text = (caption or '').lower() + ' ' + (name or '').lower()
    # Remove & (VB accelerator key prefix)
    text = text.replace('&', '')
    return any(w in text.split() for w in DANGER_WORDS)


def discover_targets(base_path):
    """Discover all click targets for a decompiled exe.

    Args:
        base_path: Path to decompiled/<stem>/<exe>/ directory

    Returns:
        List of target dicts sorted by visual position (top-to-bottom, left-to-right),
        grouped by form. Each target has:
        {name, type, caption, form, left_px, top_px, width_px, height_px,
         action, hint_text, target_form, event, dangerous}
    """
    _t0 = time.monotonic()
    base = Path(base_path)
    log.debug('discover_targets: ENTER base=%s', base)

    # Find all .frm files (skip cleaned/)
    frm_files = []
    forms_dir = base / 'forms'
    if forms_dir.exists():
        frm_files = [f for f in forms_dir.glob('*.frm')]
    else:
        frm_files = [f for f in base.glob('*.frm') if '/cleaned/' not in str(f)]
    log.debug('discover_targets: found %d .frm files', len(frm_files))

    # Get startup form from .vbp
    startup_form = None
    for vbp in base.glob('*.vbp'):
        text = vbp.read_text(errors='replace')
        m = re.search(r'Startup\s*=\s*"?(\w+)"?', text)
        if m:
            startup_form = m.group(1)
            log.debug('discover_targets: startup form=%s', startup_form)
            break

    all_targets = []

    for frm_path in sorted(frm_files):
        form_name = frm_path.stem
        log.debug('discover_targets: processing form=%s', form_name)

        controls = parse_frm_controls(frm_path)
        click_handlers = find_click_handlers(base, form_name)
        hint_texts = find_hint_text(base, form_name)

        log.debug('discover_targets: form=%s controls=%d handlers=%d hints=%d',
                  form_name, len(controls), len(click_handlers), len(hint_texts))

        for ctrl_name, handler in click_handlers.items():
            ctrl = controls.get(ctrl_name, {})
            ctrl_type = ctrl.get('type', 'unknown')

            # Skip display-only controls
            if ctrl_type in DISPLAY_ONLY:
                log.debug('discover_targets: skip display-only %s.%s (%s)', form_name, ctrl_name, ctrl_type)
                continue

            # Skip hide_self actions
            if handler['action'] == 'hide_self':
                log.debug('discover_targets: skip hide_self %s.%s', form_name, ctrl_name)
                continue

            caption = ctrl.get('caption', '')
            dangerous = is_dangerous(caption, ctrl_name)

            target = {
                'name': ctrl_name,
                'type': ctrl_type,
                'caption': caption,
                'form': form_name,
                'left_px': ctrl.get('left', 0) // TWIPS_PER_PX,
                'top_px': ctrl.get('top', 0) // TWIPS_PER_PX,
                'width_px': max(ctrl.get('width', 0) // TWIPS_PER_PX, 10),
                'height_px': max(ctrl.get('height', 0) // TWIPS_PER_PX, 10),
                'action': handler['action'],
                'target_form': handler.get('target_form'),
                'event': handler['event'],
                'hint_text': hint_texts.get(ctrl_name, ''),
                'dangerous': dangerous,
                'is_startup_form': form_name.lower() == (startup_form or '').lower(),
            }

            if dangerous:
                log.debug('discover_targets: DANGER %s.%s caption="%s" action=%s',
                          form_name, ctrl_name, caption, handler['action'])
            else:
                log.debug('discover_targets: target %s.%s type=%s caption="%s" action=%s hint="%s"',
                          form_name, ctrl_name, ctrl_type, caption, handler['action'],
                          target['hint_text'][:40] if target['hint_text'] else '')

            all_targets.append(target)

    # Sort: startup form first, then by form name, then top-to-bottom left-to-right
    def sort_key(t):
        form_order = 0 if t['is_startup_form'] else 1
        return (form_order, t['form'], t['top_px'], t['left_px'])

    # Detect SSTab tabs from control Left offsets
    for frm_path in sorted(frm_files):
        form_name = frm_path.stem
        text = frm_path.read_text(errors='replace')
        if 'Begin SSTab' not in text:
            continue

        # Parse SSTab position
        m = re.search(r'Begin SSTab\s+(\w+).*?Left\s*=\s*(\d+).*?Top\s*=\s*(\d+).*?Width\s*=\s*(\d+).*?Height\s*=\s*(\d+)', text, re.S)
        if not m:
            continue
        sstab_name = m.group(1)
        sstab_left = int(m.group(2)) // TWIPS_PER_PX
        sstab_top = int(m.group(3)) // TWIPS_PER_PX
        sstab_w = int(m.group(4)) // TWIPS_PER_PX
        sstab_h = int(m.group(5)) // TWIPS_PER_PX

        # Count tabs by grouping child control Left values
        child_lefts = [int(lm.group(1)) for lm in re.finditer(r'Left\s*=\s*(-?\d+)', text)]
        tab_indices = set()
        for l in child_lefts:
            if l < -10000:
                tab_indices.add(round(-l / 75000))
        tab_indices.add(0)  # tab 0 always exists
        num_tabs = max(tab_indices) + 1

        tab_w = sstab_w // num_tabs
        log.info('discover_targets: SSTab %s on %s: %d tabs, tab_width=%dpx',
                 sstab_name, form_name, num_tabs, tab_w)

        for ti in range(num_tabs):
            all_targets.append({
                'name': f'{sstab_name}_Tab{ti}',
                'type': 'SSTab',
                'caption': f'Tab {ti}',
                'form': form_name,
                'left_px': sstab_left + ti * tab_w,
                'top_px': sstab_top,
                'width_px': tab_w,
                'height_px': 20,  # tab header height ~20px
                'action': 'tab',
                'target_form': None,
                'event': 'Click',
                'hint_text': '',
                'dangerous': False,
                'is_startup_form': form_name.lower() == (startup_form or '').lower(),
            })

    all_targets.sort(key=sort_key)

    safe = [t for t in all_targets if not t['dangerous']]
    log.info('discover_targets: EXIT total=%d safe=%d dangerous=%d forms=%d elapsed=%.3fs',
             len(all_targets), len(safe), len(all_targets) - len(safe),
             len(set(t['form'] for t in all_targets)), time.monotonic() - _t0)
    return all_targets


def main():
    import argparse, os
    parser = argparse.ArgumentParser(description='Discover click targets from decompiled VB source')
    parser.add_argument('zip_stem', help='Proggie zip stem')
    parser.add_argument('-q', '--quiet', action='store_true')
    args = parser.parse_args()

    if args.quiet:
        logging.getLogger().setLevel(logging.WARNING)

    log.info('discover_targets: pid=%d', os.getpid())

    decomp_dir = DECOMPILED / args.zip_stem
    if not decomp_dir.exists():
        log.error('No decompiled dir: %s', decomp_dir)
        return

    for exe_dir in sorted(decomp_dir.iterdir()):
        if not exe_dir.is_dir() or exe_dir.name.startswith('.'):
            continue
        targets = discover_targets(exe_dir)
        print(f'\n=== {args.zip_stem} / {exe_dir.name} ===')
        print(f'{"Form":<15} {"Control":<20} {"Type":<15} {"Caption":<25} {"Action":<12} {"Pos":<12} {"Hint"}')
        print('-' * 120)
        for t in targets:
            flag = '⚠' if t['dangerous'] else ' '
            pos = f'{t["left_px"]},{t["top_px"]}'
            hint = t['hint_text'][:30] if t['hint_text'] else ''
            print(f'{flag}{t["form"]:<14} {t["name"]:<20} {t["type"]:<15} {t["caption"]:<25} {t["action"]:<12} {pos:<12} {hint}')
        print(f'\nTotal: {len(targets)} targets ({len([t for t in targets if not t["dangerous"]])} safe, '
              f'{len([t for t in targets if t["dangerous"]])} dangerous)')


if __name__ == '__main__':
    main()
