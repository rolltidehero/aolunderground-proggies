#!/usr/bin/env python3
"""Test that every clickable item in the walkthrough actually works in the HTML page.

Reads walkthrough.json to get all items, then uses Playwright to click each one
and verify the child content appears with a valid image.

Usage:
    /tmp/test-venv/bin/python tests/test_every_click.py [url]
"""
import sys, json
sys.path.insert(0, '/tmp/test-venv/lib/python3.12/site-packages')

from playwright.sync_api import sync_playwright
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
URL = sys.argv[1] if len(sys.argv) > 1 else 'http://linux:8088/programs/AOL/proggies-sorted-deduped/tools/mav-spy.html'
STEM = URL.split('/')[-1].replace('.html', '')
PASS = FAIL = 0


def check(name, condition, detail=''):
    global PASS, FAIL
    if condition:
        PASS += 1
        print(f'  PASS: {name}')
    else:
        FAIL += 1
        print(f'  FAIL: {name} — {detail}')


def main():
    global PASS, FAIL

    # Load walkthrough.json
    # Try multiple locations
    wt = None
    for base in [REPO / 'programs' / 'AOL' / 'proggies-sorted-deduped']:
        for ver_dir in base.iterdir():
            wt_path = ver_dir / STEM / 'walkthrough.json'
            if wt_path.exists():
                wt = json.loads(wt_path.read_text())
                break
        if wt:
            break

    if not wt:
        print(f'ERROR: No walkthrough.json found for {STEM}')
        sys.exit(1)

    categories = wt.get('categories', [])
    all_items = []
    for cat in categories:
        for item in cat.get('items', []):
            all_items.append(item)

    # Also load discover_targets to know what SHOULD be clickable
    sys.path.insert(0, str(REPO / 'tools'))
    from discover_targets import discover_targets
    decomp_dir = REPO / 'decompiled' / STEM
    targets = []
    if decomp_dir.exists():
        for exe_dir in decomp_dir.iterdir():
            if exe_dir.is_dir() and not exe_dir.name.startswith('.') and exe_dir.name != 'cleaned':
                targets = discover_targets(exe_dir)
                break

    safe_targets = [t for t in targets if not t['dangerous']]
    startup_form = None
    for t in safe_targets:
        if t['is_startup_form']:
            startup_form = t['form']
            break
    if not startup_form and safe_targets:
        startup_form = safe_targets[0]['form']

    visible_targets = [t for t in safe_targets
                       if t['form'] == startup_form
                       and t['left_px'] >= 0 and t['top_px'] >= 0
                       and t['name'] != 'Form' and t['type'] != 'Form'
                       and t['action'] not in ('shell', 'file_dialog')]

    # Count SSTab tabs as visible targets too
    has_sstab = any(t['type'] == 'SSTab' for t in safe_targets)
    sstab_count = sum(1 for t in safe_targets if t['type'] == 'SSTab' and t['form'] == startup_form)

    print(f'\nSource analysis: {len(visible_targets)} visible clickable targets on {startup_form}')
    if has_sstab:
        print(f'  ({sstab_count} SSTab tabs detected)')
    print(f'Walkthrough captured: {len(all_items)} items')
    if has_sstab:
        tab_items = [i for i in all_items if i.get('type') == 'tab']
        print(f'  ({len(tab_items)} tab states captured)')
        check('SSTab tabs captured', len(tab_items) >= sstab_count - 1,
              f'expected at least {sstab_count - 1} tab changes, got {len(tab_items)}')

    print(f'\nSource analysis: {len(visible_targets)} visible clickable targets on {startup_form}')
    print(f'Walkthrough captured: {len(all_items)} items')
    print()

    check('Walkthrough has items', len(all_items) > 0, f'got {len(all_items)}')
    check('At least 50% of visible targets captured',
          len(all_items) >= len(visible_targets) * 0.5 or len(visible_targets) == 0,
          f'{len(all_items)}/{len(visible_targets)} = {len(all_items)/max(len(visible_targets),1)*100:.0f}%')

    # Now test every item in the HTML page
    js_errors = []
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.on('pageerror', lambda err: js_errors.append(str(err)))
        page.goto(URL, wait_until='networkidle', timeout=15000)

        print(f'\nTesting every click in: {URL}\n')

        # Get all labels
        labels = page.query_selector_all('.app-label')
        check('Page has clickable labels', len(labels) > 0, f'found {len(labels)}')

        for li, label_el in enumerate(labels):
            # Click label to open popup
            label_el.click()
            page.wait_for_timeout(300)

            popup = page.query_selector('#app-popup')
            if not popup or not popup.is_visible():
                check(f'Label {li}: popup opens', False, 'popup not visible')
                continue

            items = popup.query_selector_all('.app-mi')
            num_items = len(items)
            check(f'Label {li}: popup has items', num_items > 0, f'found {num_items}')

            # Click each item — re-open popup and re-query each time (DOM changes after click)
            for ii in range(num_items):
                # Close any open popup/child first
                page.click('body', position={'x': 5, 'y': 5})
                page.wait_for_timeout(200)
                # Re-open popup
                label_el.click()
                page.wait_for_timeout(300)
                popup = page.query_selector('#app-popup')
                if not popup or not popup.is_visible():
                    check(f'  Item {ii}: re-open popup', False, 'popup not visible')
                    continue
                items = popup.query_selector_all('.app-mi')
                if ii >= len(items):
                    check(f'  Item {ii}: exists in popup', False, f'only {len(items)} items')
                    continue

                item_el = items[ii]
                item_text = item_el.text_content().strip()

                item_el.click()
                page.wait_for_timeout(300)

                child = page.query_selector('#app-child')
                child_html = child.inner_html() if child else ''

                has_content = len(child_html) > 10
                check(f'  Item "{item_text}": shows content', has_content,
                      f'html length={len(child_html)}')

                if has_content:
                    child_img = child.query_selector('img')
                    if child_img:
                        src = child_img.get_attribute('src') or ''
                        # Check image actually loads
                        img_ok = page.evaluate(f'''() => {{
                            var img = document.querySelector("#app-child img");
                            return img && img.naturalWidth > 0;
                        }}''')
                        check(f'  Item "{item_text}": image loads', img_ok,
                              f'src="{src}" naturalWidth check')
                    else:
                        # Might be a "no screenshot" message — that's ok if noted
                        has_noshot = 'app-noshot' in child_html
                        check(f'  Item "{item_text}": has image or noshot message',
                              has_noshot, 'no img and no noshot message')

            # Close popup
            page.click('body')
            page.wait_for_timeout(200)

        # Check for JS errors during all clicks
        check('No JS errors during clicks', len(js_errors) == 0,
              f'{len(js_errors)} errors: {js_errors[:3]}')

        # Report uncaptured targets
        captured_captions = {item['caption'].lower() for item in all_items}
        uncaptured = [t for t in visible_targets
                      if (t['caption'] or t['name']).lower() not in captured_captions
                      and t['name'].lower() not in captured_captions]
        if uncaptured:
            print(f'\nUncaptured visible targets ({len(uncaptured)}):')
            for t in uncaptured:
                print(f'  {t["name"]} ({t["caption"] or "no caption"}) type={t["type"]} action={t["action"]} pos=({t["left_px"]},{t["top_px"]})')

        browser.close()

    print(f'\n{"="*50}')
    print(f'Results: {PASS} passed, {FAIL} failed')
    if FAIL > 0:
        print('SOME TESTS FAILED')
        sys.exit(1)
    else:
        print('ALL TESTS PASSED')


if __name__ == '__main__':
    main()
