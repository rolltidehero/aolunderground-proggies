#!/usr/bin/env python3
"""Playwright test: verify EVERY clickable item in the app-sim widget.

For each item with a screenshot:
- Screenshots the child frame, auto-crops non-black, scales 3x, thresholds, OCRs
- Verifies OCR returns meaningful text (broken screenshots are all-black → empty OCR)
- If child_title (ct) is in JS data, also verifies that text appears
- Checks layout geometry (flex, clipping, overflow)

Usage: python3 tests/test_widget_layout.py [--headed]
"""
import sys, io
from playwright.sync_api import sync_playwright
from PIL import Image
import pytesseract
import numpy as np

URL = "http://linux:8088/programs/AOL/proggies-sorted-deduped/4.0/bodini.html"
HEADED = "--headed" in sys.argv
failures = []
MIN_OCR_LEN = 4  # broken (black) frames return 0-2 chars; good frames return 10+


def fail(msg):
    print(f"  FAIL: {msg}")
    failures.append(msg)


def ocr_cc(el):
    """Screenshot element, auto-crop non-black, scale 3x, threshold, OCR."""
    png = el.screenshot()
    img = Image.open(io.BytesIO(png))
    arr = np.array(img)
    mask = arr.max(axis=2) > 25
    rows = mask.any(axis=1)
    cols = mask.any(axis=0)
    if not rows.any():
        return ''
    y0, y1 = int(np.where(rows)[0][0]), int(np.where(rows)[0][-1])
    x0, x1 = int(np.where(cols)[0][0]), int(np.where(cols)[0][-1])
    cropped = img.crop((x0, y0, x1 + 1, y1 + 1))
    if cropped.width < 10 or cropped.height < 10:
        return ''
    big = cropped.resize((cropped.width * 3, cropped.height * 3), Image.LANCZOS)
    gray = big.convert('L')
    bw = gray.point(lambda x: 0 if x < 128 else 255)
    return pytesseract.image_to_string(bw, config='--psm 6').lower().strip()


def test_viewport(browser, vw):
    print(f"\n{'=' * 50}\n  Viewport {vw}px\n{'=' * 50}")
    page = browser.new_page(viewport={"width": vw, "height": 900})
    page.goto(URL, wait_until="networkidle")

    if page.locator(".app-stage").evaluate("el => getComputedStyle(el).display") != "flex":
        fail(f"[vw={vw}] Stage not flex")

    form_el = page.locator(".app-form")
    labels = page.locator(".app-label")
    cat_data = page.evaluate("appCats")

    for ci, cat in enumerate(cat_data):
        for ii, item in enumerate(cat["items"]):
            if item["type"] == "secret":
                continue

            name = f"{cat['name']}>{item['caption']}"
            has_image = bool(item.get("image"))

            labels.nth(ci).click()
            page.locator(".app-popup").wait_for(state="visible")
            mis = page.locator(".app-mi")
            clicked = False
            for mi_idx in range(mis.count()):
                if mis.nth(mi_idx).inner_text() == item["caption"]:
                    mis.nth(mi_idx).click()
                    clicked = True
                    break
            if not clicked:
                fail(f"[vw={vw}][{name}] Menu item not found")
                continue

            ok = True

            if has_image:
                page.wait_for_selector(".app-child .app-cc", timeout=3000)
                page.evaluate('''() => {
                    var img = document.querySelector(".app-cc img");
                    if (!img) return false;
                    if (img.complete && img.naturalWidth > 0) return true;
                    return new Promise(r => { img.onload = () => r(true); setTimeout(() => r(false), 3000); });
                }''')

                fb = form_el.bounding_box()
                cb = page.locator(".app-child").bounding_box()
                cc_el = page.locator(".app-cc")
                ccb = cc_el.bounding_box()
                form_right = fb["x"] + fb["width"]

                if cb["x"] < form_right - 1:
                    fail(f"[vw={vw}][{name}] Overlaps form"); ok = False
                if cb["x"] + cb["width"] > vw + 2:
                    fail(f"[vw={vw}][{name}] Overflows viewport"); ok = False
                if ccb["width"] > 500:
                    fail(f"[vw={vw}][{name}] CC too wide: {ccb['width']:.0f}px"); ok = False
                if ccb["height"] > 355:
                    fail(f"[vw={vw}][{name}] CC too tall: {ccb['height']:.0f}px"); ok = False
                if ccb["height"] < 20:
                    fail(f"[vw={vw}][{name}] CC collapsed"); ok = False

                # OCR the child frame — must have readable content
                ocr_text = ocr_cc(cc_el)

                # Check child_title if available (from walkthrough manifest)
                ct = item.get("ct", "")
                if ct:
                    ct_word = ct.lower()[:6]
                    if ct_word not in ocr_text:
                        fail(f"[vw={vw}][{name}] OCR missing child_title '{ct}'")
                        ok = False
                else:
                    # Fallback: OCR must return SOMETHING — black frames return empty
                    if len(ocr_text) < MIN_OCR_LEN:
                        fail(f"[vw={vw}][{name}] OCR too short ({len(ocr_text)} chars) — broken screenshot")
                        ok = False

                status = "✓" if ok else "✗"
                ocr_short = ocr_text.replace('\n', ' ')[:50]
                print(f"    {name}: cc={ccb['width']:.0f}x{ccb['height']:.0f} ocr({len(ocr_text)})='{ocr_short}' {status}")

            else:
                page.wait_for_selector(".app-child .app-noshot", timeout=2000)
                placeholder = page.locator(".app-noshot")
                if placeholder.count() == 0:
                    fail(f"[vw={vw}][{name}] No image AND no placeholder"); ok = False
                status = "✓" if ok else "✗"
                print(f"    {name}: [no screenshot — placeholder] {status}")

            page.evaluate("hideChild()")

    if vw >= 1280:
        labels.nth(0).click()
        page.locator(".app-popup").wait_for(state="visible")
        gmi = page.locator(".app-mi", has_text="Greets")
        if gmi.count():
            gmi.first.click()
            page.wait_for_selector(".greets-track", timeout=3000)
            spans = page.locator(".greets-track span").count()
            if spans < 2:
                fail("Greets: insufficient spans")
            else:
                print(f"    Greets marquee: {spans} spans ✓")

    page.close()


def main():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=not HEADED)
        for vw in [800, 1024, 1280]:
            test_viewport(browser, vw)
        browser.close()

    print(f"\n{'=' * 50}")
    if failures:
        print(f"FAILED: {len(failures)} failures:")
        for f in failures:
            print(f"  - {f}")
        sys.exit(1)
    else:
        print("ALL TESTS PASSED")


if __name__ == "__main__":
    main()
