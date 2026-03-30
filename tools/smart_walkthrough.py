#!/usr/bin/env python3
"""Smart walkthrough: state-diff driven screenshot capture for VB proggies.

Uses decompiled source as navigation map, runtime window diffing for
verification and cropping, Bezier mouse movement for natural animation.

Usage:
    python3 tools/smart_walkthrough.py <zip_stem> [--screenshot-only]
"""
import argparse, json, logging, os, re, shutil, sqlite3, subprocess, sys, time
from pathlib import Path

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s.%(msecs)03d [%(levelname)-8s] %(name)s: %(message)s',
    datefmt='%H:%M:%S',
)
log = logging.getLogger(Path(__file__).stem)

REPO = Path(__file__).resolve().parent.parent
DB_PATH = REPO / 'proggie_db.sqlite'
DECOMPILED = REPO / 'decompiled'
SORTED = REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped'
SCREEN_W, SCREEN_H = 1280, 800
TWIPS_PER_PX = 15

sys.path.insert(0, str(REPO / 'tools'))
from window_diff import (WindowDiff, QMP, capture_cropped, capture_context,
                          capture_full_screen, dismiss_msgboxes, close_child_forms,
                          move_child_form, _c2gui_shell, PYTHON_GUEST, VB6_CLASSES)
from bezier_mouse import bezier_move
from discover_targets import discover_targets
from extract_passwords import extract_passwords


def _free(n=100):
    for _ in range(n):
        time.sleep(0.01)


def find_exe_info(zip_stem):
    """Get exe name, path, and AOL version from DB."""
    if not DB_PATH.exists():
        return None, None, 'unknown'
    conn = sqlite3.connect(str(DB_PATH))
    row = conn.execute('''
        SELECT e.exe_name, p.aol_version FROM exes e
        JOIN proggies p ON e.proggie_id=p.id
        WHERE p.zip_stem=? AND e.vb_version IN ('VB5','VB6')
        ORDER BY e.is_primary DESC LIMIT 1
    ''', (zip_stem,)).fetchone()
    conn.close()
    if not row:
        return None, None, 'unknown'
    exe_name = row[0]
    ver = row[1] or 'unknown'
    extract_dir = SORTED / '_extracted' / zip_stem
    exe_path = extract_dir / exe_name
    if not exe_path.exists():
        for f in extract_dir.iterdir() if extract_dir.exists() else []:
            if f.name.lower() == exe_name.lower():
                exe_path = f; break
    return exe_name, exe_path if exe_path.exists() else None, ver


def launch_proggie(zip_stem, exe_name):
    """Push exe + deps to VM and launch. Returns True on success."""
    _t0 = time.monotonic()
    log.info('launch_proggie: ENTER %s/%s', zip_stem, exe_name)
    extract_dir = SORTED / '_extracted' / zip_stem
    local_exe = extract_dir / exe_name
    if not local_exe.exists():
        log.error('launch_proggie: exe not found %s', local_exe)
        return False

    guest_exe = rf'C:\work\{exe_name}'
    _c2gui_shell(r'if not exist C:\work mkdir C:\work')

    sys.path.insert(0, str(REPO / 'tools' / 'vm' / 'host'))
    from push_file import push_file
    try:
        push_file(str(local_exe), guest_exe)
    except Exception as e:
        log.warning('launch_proggie: push failed (%s), exe may already be on VM', e)

    for f in extract_dir.iterdir():
        if f.suffix.lower() in ('.dll', '.ocx', '.vbx') and f.name.lower() != exe_name.lower():
            try:
                push_file(str(f), rf'C:\work\{f.name}')
            except Exception:
                pass

    _c2gui_shell(rf'start "" "{guest_exe}"')
    log.info('launch_proggie: EXIT elapsed=%.1fs', time.monotonic() - _t0)
    return True


def wait_for_main_form(wd, timeout=30):
    """Poll for a VB6 form to appear. Returns window dict or None."""
    _t0 = time.monotonic()
    log.debug('wait_for_main_form: ENTER timeout=%d', timeout)
    for attempt in range(timeout * 2):
        _free(50)
        windows = wd.snapshot()
        forms = wd.find_vb_forms(windows)
        if forms:
            log.info('wait_for_main_form: found "%s" at %d,%d %dx%d (attempt %d, %.1fs)',
                     forms[0]['title'], forms[0]['x'], forms[0]['y'],
                     forms[0]['w'], forms[0]['h'], attempt, time.monotonic() - _t0)
            return forms[0]
        if attempt % 10 == 0:
            log.debug('wait_for_main_form: waiting... attempt=%d', attempt)
    log.error('wait_for_main_form: TIMEOUT')
    return None


def run_walkthrough(zip_stem, exe_name, out_dir, passwords=None):
    """Main walkthrough loop. Returns walkthrough manifest dict."""
    _t0 = time.monotonic()
    log.info('run_walkthrough: ENTER zip_stem=%s exe_name=%s', zip_stem, exe_name)

    wd = WindowDiff()
    frames = []
    frame_dir = out_dir / 'frames'
    frame_dir.mkdir(parents=True, exist_ok=True)
    frame_idx = [0]
    passwords = passwords or []
    seen_forms = set()
    seen_msgboxes = set()
    IGNORE_CLASSES = frozenset({'ConsoleWindowClass', 'Progman', 'Shell_TrayWnd', 'tooltips_class32'})
    last_frame_path = [None]  # track last saved frame for dedup

    viewport = [None]  # mutable container, set after main form found

    def crop_to_proggies(path, extra_rect=None):
        """Capture cropped to the fixed viewport. Same size every frame."""
        if viewport[0] is None:
            return capture_cropped(main_win, str(path))
        return capture_cropped(viewport[0], str(path))

    def frames_are_identical(path_a, path_b):
        """Check if two images are visually identical (>97% similar)."""
        if not path_a or not path_b:
            return False
        try:
            from PIL import Image
            import numpy as np
            a = np.array(Image.open(str(path_a)).convert('RGB'))
            b = np.array(Image.open(str(path_b)).convert('RGB'))
            if a.shape != b.shape:
                return False
            diff = np.abs(a.astype(int) - b.astype(int))
            pct_same = (diff.max(axis=2) < 10).mean()
            return pct_same > 0.97
        except Exception:
            return False

    def next_frame(label, ftype='result', extra_rect=None):
        path = frame_dir / f'frame_{frame_idx[0]:03d}.png'
        QMP.park_cursor()
        _free(30)
        ok = crop_to_proggies(path, extra_rect)
        if not ok:
            frame_idx[0] += 1
            return False
        # Dedup: skip if identical to previous frame
        if frames_are_identical(last_frame_path[0], path):
            log.warning('frame %03d: DUPLICATE of previous, skipping: %s', frame_idx[0], label)
            path.unlink(missing_ok=True)
            frame_idx[0] += 1
            return False
        last_frame_path[0] = path
        frames.append({'file': f'frames/frame_{frame_idx[0]:03d}.png', 'label': label, 'type': ftype})
        log.debug('frame %03d: %s (%s)', frame_idx[0], label, ftype)
        frame_idx[0] += 1
        return True

    def wait_for_new_window(baseline_snap, max_retries=8):
        """Poll for a new VB6 form or MsgBox to appear. Returns diff or None."""
        for attempt in range(max_retries):
            _free(50 + attempt * 25)  # increasing wait: 0.5s, 0.75s, 1s...
            after = wd.snapshot()
            diff = wd.diff(baseline_snap, after)
            real_new = [w for w in diff['new'] if w['class'] not in IGNORE_CLASSES]
            if real_new:
                log.debug('wait_for_new_window: found %d new windows on attempt %d', len(real_new), attempt)
                return {'new': real_new, 'changed': diff['changed'], 'gone': diff['gone']}, after
        return None, wd.snapshot()

    # Launch
    if not launch_proggie(zip_stem, exe_name):
        return None

    # Wait for main form
    main_win = wait_for_main_form(wd)
    if not main_win:
        return None

    # Dismiss startup MsgBoxes
    dismiss_msgboxes()
    _free(50)

    # Re-snapshot after dismissals
    windows = wd.snapshot()
    forms = wd.find_vb_forms(windows)
    if forms:
        main_win = forms[0]

    # Capture main form
    QMP.park_cursor()
    _free(30)
    capture_cropped(main_win, str(out_dir / 'screenshot.png'))
    capture_cropped(main_win, str(out_dir / 'main_form.png'))
    next_frame('Main form', 'main')
    log.info('run_walkthrough: main form captured "%s" %dx%d', main_win['title'], main_win['w'], main_win['h'])

    # Compute fixed viewport — main form + space for child forms to the right
    # Child forms will be placed at main_win right edge + 10px
    child_x = main_win['x'] + main_win['w'] + 10
    child_y = main_win['y']
    max_child_w = max(main_win['w'], 400)  # assume child forms up to 400px wide
    max_child_h = max(main_win['h'], 400)
    vp_x = max(main_win['x'] - 2, 0)
    vp_y = max(main_win['y'] - 2, 0)
    vp_w = min(main_win['w'] + max_child_w + 20, SCREEN_W - vp_x)
    vp_h = min(max(main_win['h'], max_child_h) + 4, SCREEN_H - vp_y)
    viewport[0] = {'x': vp_x, 'y': vp_y, 'w': vp_w, 'h': vp_h}
    log.info('run_walkthrough: fixed viewport (%d,%d) %dx%d', vp_x, vp_y, vp_w, vp_h)

    # Discover click targets from source
    decomp_base = DECOMPILED / zip_stem / exe_name
    if not decomp_base.exists():
        # Try to find it
        for d in (DECOMPILED / zip_stem).iterdir() if (DECOMPILED / zip_stem).exists() else []:
            if d.is_dir() and not d.name.startswith('.') and d.name != 'cleaned':
                decomp_base = d; break

    targets = discover_targets(decomp_base) if decomp_base.exists() else []
    safe_targets = [t for t in targets if not t['dangerous']]
    log.info('run_walkthrough: %d targets (%d safe)', len(targets), len(safe_targets))

    # Build categories for walkthrough.json
    categories = {}  # form_name → list of items
    main_form_name = None

    # Get startup form
    for t in safe_targets:
        if t['is_startup_form']:
            main_form_name = t['form']
            break
    if not main_form_name and safe_targets:
        main_form_name = safe_targets[0]['form']

    # Click each safe target on the startup form
    for target in safe_targets:
        if target['form'] != main_form_name:
            continue  # Only click startup form targets for now

        # Skip if action is shell/file_dialog
        if target['action'] in ('shell', 'file_dialog'):
            log.debug('run_walkthrough: skip %s.%s action=%s', target['form'], target['name'], target['action'])
            continue

        # Skip Form-level click handlers (clicking form background rarely does anything)
        if target['type'] in ('Form', 'unknown') and target['name'] == 'Form':
            log.debug('run_walkthrough: skip Form-level handler %s.%s', target['form'], target['name'])
            continue

        ctrl_name = target['name']
        caption = target['caption'] or ctrl_name
        log.info('run_walkthrough: clicking %s (%s) action=%s', ctrl_name, caption, target['action'])

        # Compute screen coords from form position + control position + nc offset
        # GetWindowRect includes title bar, control positions are relative to client area
        nc_x_off = 3   # border width
        nc_y_off = 26  # title bar height (Win10 classic theme)
        sx = main_win['x'] + nc_x_off + target['left_px'] + target['width_px'] // 2
        sy = main_win['y'] + nc_y_off + target['top_px'] + target['height_px'] // 2
        log.debug('run_walkthrough: %s screen=(%d,%d) form=(%d,%d) ctrl=(%d,%d)',
                  ctrl_name, sx, sy, main_win['x'], main_win['y'], target['left_px'], target['top_px'])

        # Skip controls with negative positions (hidden SSTab pages)
        if target['left_px'] < 0 or target['top_px'] < 0:
            log.debug('run_walkthrough: skip off-screen %s left=%d top=%d', ctrl_name, target['left_px'], target['top_px'])
            continue

        # Skip if outside main form bounds
        if sx < main_win['x'] or sx > main_win['x'] + main_win['w'] or \
           sy < main_win['y'] or sy > main_win['y'] + main_win['h']:
            log.debug('run_walkthrough: skip out-of-bounds %s screen=(%d,%d)', ctrl_name, sx, sy)
            continue

        # Hover phase — only capture if control has hint text
        bezier_move(QMP.move, QMP._last_x, QMP._last_y, sx, sy)
        _free(30)
        if target['hint_text']:
            next_frame(f'Hover: {caption} — {target["hint_text"]}', 'hover')

        # Take baseline IMMEDIATELY before click (minimizes stale state)
        baseline = wd.snapshot()

        # Click phase
        QMP.click(sx, sy)
        _free(100)

        # Diff phase — poll with retries for show_form targets
        max_retries = 8 if target['action'] == 'show_form' else 3
        diff_result, after = wait_for_new_window(baseline, max_retries)

        # Capture phase
        item = {'caption': caption, 'type': target['action'], 'image': '', 'hint': target.get('hint_text', '')}

        if diff_result and diff_result['new']:
            real_new = diff_result['new']

            new_forms = [w for w in real_new if w['class'] in VB6_CLASSES]
            new_msgboxes = [w for w in real_new if w['class'] == '#32770']
            other_new = [w for w in real_new if w['class'] not in VB6_CLASSES and w['class'] != '#32770']

            if new_msgboxes:
                mb = new_msgboxes[0]
                mb_key = mb.get('title', '')
                if mb_key not in seen_msgboxes:
                    seen_msgboxes.add(mb_key)
                    fname = f'screen_{re.sub(r"[^a-z0-9]", "_", caption.lower())}.png'
                    QMP.park_cursor()
                    _free(30)
                    capture_cropped(mb, str(out_dir / fname))
                    next_frame(f'MsgBox: {mb.get("title", caption)}', 'result')
                    item['image'] = fname
                    item['type'] = 'msgbox'
                dismiss_msgboxes()

            elif new_forms:
                nf = new_forms[0]
                nf_key = (nf['class'], nf['title'])
                if nf_key not in seen_forms:
                    seen_forms.add(nf_key)
                    move_child_form(main_win['title'], child_x, child_y)
                    _free(50)
                    after2 = wd.snapshot()
                    moved = [w for w in wd.find_vb_forms(after2) if w['title'] != main_win['title']]
                    child_rect = moved[0] if moved else nf

                    fname = f'screen_{re.sub(r"[^a-z0-9]", "_", caption.lower())}.png'
                    QMP.park_cursor()
                    _free(30)
                    capture_cropped(child_rect, str(out_dir / fname))
                    next_frame(f'Form: {nf.get("title", caption)}', 'result')
                    item['image'] = fname
                    item['child_h'] = child_rect['h']
                    item['child_title'] = nf.get('title', '')

                close_child_forms(main_win['title'])
                _free(50)
                dismiss_msgboxes()

            else:
                # New window but not VB6 form or MsgBox — capture it anyway
                nw = other_new[0]
                log.info('run_walkthrough: new non-VB window class=%s title="%s"', nw['class'], nw.get('title', ''))
                fname = f'screen_{re.sub(r"[^a-z0-9]", "_", caption.lower())}.png'
                QMP.park_cursor()
                _free(30)
                capture_cropped(nw, str(out_dir / fname))
                next_frame(f'Window: {nw.get("title", caption)}', 'result', extra_rect=nw)
                item['image'] = fname
                dismiss_msgboxes()

        else:
            # No new window detected
            if target['action'] == 'show_form':
                log.warning('run_walkthrough: EXPECTED new form from %s but none appeared', ctrl_name)
            # Only capture if something visually changed (dedup will catch identical frames)
            fname = f'screen_{re.sub(r"[^a-z0-9]", "_", caption.lower())}.png'
            QMP.park_cursor()
            _free(30)
            ok = capture_cropped(main_win, str(out_dir / fname))
            if ok:
                # Check if this screenshot is different from main_form.png
                if not frames_are_identical(out_dir / 'main_form.png', out_dir / fname):
                    next_frame(f'{caption}', 'result')
                    item['image'] = fname
                else:
                    log.debug('run_walkthrough: %s produced no visual change, skipping', ctrl_name)
                    (out_dir / fname).unlink(missing_ok=True)

        # Add to categories
        cat_name = main_form_name or 'Main'
        if cat_name not in categories:
            categories[cat_name] = []
        if item.get('image'):
            categories[cat_name].append(item)

    # ── Post-walkthrough validation ──────────────────────────────────
    expected_forms = sum(1 for t in safe_targets if t['form'] == main_form_name and t['action'] == 'show_form' and not t['dangerous'])
    captured_forms = sum(1 for f in frames if f['type'] == 'result' and 'Form:' in f['label'])
    total_items = sum(len(items) for items in categories.values())

    if expected_forms > 0 and captured_forms == 0:
        log.error('VALIDATION: expected %d child forms but captured 0 — walkthrough may have failed', expected_forms)
    if len(frames) <= 1:
        log.error('VALIDATION: only %d frame(s) captured — walkthrough produced no useful content', len(frames))
    if total_items == 0 and len(safe_targets) > 0:
        log.warning('VALIDATION: 0 items captured from %d safe targets', len(safe_targets))

    log.info('VALIDATION: frames=%d unique_items=%d expected_forms=%d captured_forms=%d',
             len(frames), total_items, expected_forms, captured_forms)

    # Build animated GIF from frames — only if we have >1 distinct frame
    gif_path = out_dir / 'animated.gif'
    if len(frames) > 1:
        try:
            from PIL import Image
            imgs = [Image.open(str(out_dir / f['file'])) for f in frames if (out_dir / f['file']).exists()]
            if len(imgs) > 1:
                imgs[0].save(str(gif_path), save_all=True, append_images=imgs[1:],
                             duration=1000, loop=0, optimize=True)
                log.info('run_walkthrough: GIF %s (%d frames)', gif_path, len(imgs))
            else:
                log.warning('run_walkthrough: only 1 frame, skipping GIF')
        except Exception as exc:
            log.warning('run_walkthrough: GIF failed exc=%s', exc)
    elif len(frames) == 1:
        log.warning('run_walkthrough: only 1 frame, no GIF created')

    # Kill proggie
    _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')

    # Build manifest
    # Compute nc_offset from main form
    nc_x = 3  # default border width
    nc_y = 26  # default title bar height

    cat_list = []
    for cat_name, items in categories.items():
        cat_list.append({'category': cat_name, 'items': items})

    # Build label positions from targets
    labels = {}
    for t in safe_targets:
        if t['form'] == main_form_name and t['type'] in ('Label', 'Image', 'PictureBox') and t['left_px'] >= 0 and t['top_px'] >= 0:
            labels[t['name']] = {
                'left': t['left_px'], 'top': t['top_px'],
                'width': t['width_px'], 'height': t['height_px'],
            }

    # Collect files from extracted zip
    extract_dir = SORTED / '_extracted' / zip_stem
    files = sorted(f.name for f in extract_dir.iterdir()) if extract_dir.exists() else []

    manifest = {
        'form': {
            'width': main_win['w'], 'height': main_win['h'],
            'image': 'main_form.png', 'nc_x': nc_x, 'nc_y': nc_y,
        },
        'labels': labels,
        'categories': cat_list,
        'passwords': passwords,
        'frames': frames,
        'files': files,
    }

    manifest_path = out_dir / 'walkthrough.json'
    manifest_path.write_text(json.dumps(manifest, indent=2))
    log.info('run_walkthrough: EXIT %d categories, %d items, %d frames, elapsed=%.1fs',
             len(cat_list), sum(len(c['items']) for c in cat_list), len(frames),
             time.monotonic() - _t0)
    return manifest


def screenshot_only(zip_stem, exe_name, out_dir):
    """Just launch, screenshot main form, kill."""
    _t0 = time.monotonic()
    log.info('screenshot_only: ENTER %s/%s', zip_stem, exe_name)
    wd = WindowDiff()

    if not launch_proggie(zip_stem, exe_name):
        return None

    main_win = wait_for_main_form(wd)
    if not main_win:
        _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')
        return None

    dismiss_msgboxes()
    _free(50)

    # Re-snapshot
    windows = wd.snapshot()
    forms = wd.find_vb_forms(windows)
    if forms:
        main_win = forms[0]

    QMP.park_cursor()
    _free(30)
    out_dir.mkdir(parents=True, exist_ok=True)
    capture_cropped(main_win, str(out_dir / 'screenshot.png'))
    log.info('screenshot_only: saved %s (%dx%d)', out_dir / 'screenshot.png', main_win['w'], main_win['h'])

    _c2gui_shell(f'taskkill /f /im "{exe_name}" 2>nul')
    log.info('screenshot_only: EXIT elapsed=%.1fs', time.monotonic() - _t0)
    return main_win


def main():
    parser = argparse.ArgumentParser(description='Smart walkthrough for VB proggies')
    parser.add_argument('zip_stem', help='Proggie zip stem')
    parser.add_argument('--screenshot-only', action='store_true')
    parser.add_argument('-q', '--quiet', action='store_true')
    args = parser.parse_args()

    if args.quiet:
        logging.getLogger().setLevel(logging.WARNING)

    log.info('smart_walkthrough: pid=%d zip_stem=%s', os.getpid(), args.zip_stem)

    exe_name, exe_path, ver = find_exe_info(args.zip_stem)
    if not exe_name:
        log.error('No VB5/VB6 exe found for %s', args.zip_stem)
        sys.exit(1)

    out_dir = SORTED / ver / args.zip_stem
    out_dir.mkdir(parents=True, exist_ok=True)

    if args.screenshot_only:
        result = screenshot_only(args.zip_stem, exe_name, out_dir)
        sys.exit(0 if result else 1)

    # Extract passwords first
    passwords = extract_passwords(args.zip_stem)
    log.info('Passwords found: %d', len(passwords))

    result = run_walkthrough(args.zip_stem, exe_name, out_dir, passwords)
    if not result:
        log.error('Walkthrough failed')
        sys.exit(1)

    log.info('Done: %s', out_dir)


if __name__ == '__main__':
    main()
