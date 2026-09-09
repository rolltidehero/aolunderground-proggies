#!/usr/bin/env python3
"""Playwright tests for mav-spy walkthrough page.

Tests:
1. Page loads without JS errors
2. Frame player canvas exists at fixed dimensions
3. Play button works and loops
4. Slider scrubs frames
5. Interactive widget: clicking label shows popup
6. Interactive widget: clicking popup item shows child screenshot
7. Keyboard controls work (space, arrows)

Usage:
    /tmp/test-venv/bin/python tests/test_walkthrough_page.py
"""
import sys
sys.path.insert(0, '/tmp/test-venv/lib/python3.12/site-packages')

from playwright.sync_api import sync_playwright

URL = 'http://linux:8088/programs/AOL/proggies-sorted-deduped/tools/mav-spy.html'
PASS = 0
FAIL = 0

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
    js_errors = []

    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        page.on('pageerror', lambda err: js_errors.append(str(err)))
        page.goto(URL, wait_until='networkidle', timeout=15000)

        print(f'\nTesting: {URL}\n')

        # 1. No JS errors
        check('No JS errors on load', len(js_errors) == 0,
              f'{len(js_errors)} errors: {js_errors[:3]}')

        # 2. Canvas exists with fixed dimensions
        canvas = page.query_selector('#fp-canvas')
        check('Canvas element exists', canvas is not None)
        if canvas:
            w = canvas.get_attribute('width')
            h = canvas.get_attribute('height')
            check(f'Canvas has fixed dimensions ({w}x{h})',
                  w and h and int(w) > 100 and int(h) > 100,
                  f'width={w} height={h}')

        # 3. Frame counter shows "1 / N"
        counter = page.text_content('#fp-counter')
        check('Frame counter shows "1 / N"',
              counter and '1 / ' in counter and int(counter.split('/')[-1].strip()) > 1,
              f'counter="{counter}"')

        # 4. Frame label shows text
        label = page.text_content('#fp-label')
        check('Frame label has text', label and len(label.strip()) > 0,
              f'label="{label}"')

        # 5. Play button exists and has text
        play_btn = page.query_selector('#fp-play')
        check('Play button exists', play_btn is not None)
        if play_btn:
            check('Play button text is "Play"', play_btn.text_content().strip() == 'Play',
                  f'text="{play_btn.text_content()}"')

        # 6. Click play → counter advances after 2s
        if play_btn:
            play_btn.click()
            page.wait_for_timeout(2000)
            counter2 = page.text_content('#fp-counter')
            check('Play advances frames',
                  counter2 and counter2 != counter,
                  f'before="{counter}" after="{counter2}"')
            # Pause
            play_btn.click()
            btn_text = play_btn.text_content().strip()
            check('Pause button toggles back to "Play"', btn_text == 'Play',
                  f'text="{btn_text}"')

        # 7. Slider scrub works
        slider = page.query_selector('#fp-slider')
        if slider:
            slider.fill('0')
            slider.dispatch_event('input')
            page.wait_for_timeout(300)
            counter3 = page.text_content('#fp-counter')
            check('Slider scrub to 0 shows "1 / N"',
                  counter3 and counter3.startswith('1 /'),
                  f'counter="{counter3}"')

        # 8. Arrow keys work — click pause button, then reset slider
        play_btn.click()  # ensure paused (toggle)
        page.wait_for_timeout(200)
        play_btn.click()  # if it started playing, pause again
        page.wait_for_timeout(200)
        # Force pause state
        btn_state = play_btn.text_content().strip()
        if btn_state == 'Pause':
            play_btn.click()
            page.wait_for_timeout(200)
        page.evaluate('document.getElementById("fp-slider").value=0;document.getElementById("fp-slider").dispatchEvent(new Event("input"))')
        page.wait_for_timeout(500)

        page.keyboard.press('ArrowRight')
        page.wait_for_timeout(500)
        counter4 = page.text_content('#fp-counter')
        check('ArrowRight advances frame',
              counter4 and '2 / ' in counter4,
              f'counter="{counter4}"')

        page.keyboard.press('ArrowLeft')
        page.wait_for_timeout(500)
        counter5 = page.text_content('#fp-counter')
        check('ArrowLeft goes back',
              counter5 and '1 / ' in counter5,
              f'counter="{counter5}"')

        # 9. Interactive widget: app-label exists
        labels = page.query_selector_all('.app-label')
        check('Interactive widget has labels', len(labels) > 0,
              f'found {len(labels)} labels')

        # 10. Click label → popup appears
        if labels:
            labels[0].click()
            page.wait_for_timeout(300)
            popup = page.query_selector('#app-popup')
            popup_visible = popup and popup.is_visible() if popup else False
            check('Clicking label shows popup', popup_visible,
                  f'popup exists={popup is not None} visible={popup_visible}')

            # 11. Popup has menu items
            if popup_visible:
                items = popup.query_selector_all('.app-mi')
                check('Popup has menu items', len(items) > 0,
                      f'found {len(items)} items')

                # 12. Click menu item → child area shows content
                if items:
                    items[0].click()
                    page.wait_for_timeout(300)
                    child = page.query_selector('#app-child')
                    child_html = child.inner_html() if child else ''
                    check('Clicking menu item shows child content',
                          len(child_html) > 10,
                          f'child html length={len(child_html)}')

                    # 13. Child has an image
                    child_img = child.query_selector('img') if child else None
                    check('Child content has image', child_img is not None)

        # 14. Donate button (only on main branch builds)
        donate = page.query_selector('a[href*="buymeacoffee"]')
        if donate:
            check('Donate button exists', True)
        else:
            print('  SKIP: Donate button (not on this branch)')

        # 15. Download Source button (only on main branch builds)
        dl_src = page.query_selector('a:has-text("Download Source")')
        if dl_src:
            check('Download Source button exists', True)
        else:
            print('  SKIP: Download Source button (not on this branch)')

        browser.close()

    print(f'\n{"="*40}')
    print(f'Results: {PASS} passed, {FAIL} failed')
    if FAIL > 0:
        print('SOME TESTS FAILED')
        sys.exit(1)
    else:
        print('ALL TESTS PASSED')


if __name__ == '__main__':
    main()
