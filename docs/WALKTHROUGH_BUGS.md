# Smart Walkthrough — Known Bugs & Required Fixes

Reference: bodini (known working) vs darkwater (broken)

## Known Good State: bodini

**Manifest** (`4.0/bodini/walkthrough.json`):
- `form.width=323, form.height=129` — matches `main_form.png` exactly (323x129)
- `form.nc_x=0, form.nc_y=0` — image IS the client area, no title bar
- `labels`: 5 entries with pixel positions relative to client area origin
- `categories`: 4 categories (Main, Chat, IM, Mail), each with items
- Every item has `child_h` (matches image height), `child_title`, `image`

**Screenshots**:
- `main_form.png`: 323x129 — client area only, no title bar (BorderStyle=0)
- Child screenshots: tightly cropped to just the child form content (e.g. 205x135, 148x65)
- No black space, no overlap, no title bars in child crops

**Interactive widget** (`generate_analysis.py` lines 524-652):
- Form image displayed at exact size
- Labels overlaid as invisible clickable hotspots
- Click label → popup menu appears over form image
- Click menu item → child form screenshot appears to the right
- `child_h` controls the display height of the child image

---

## Bug 1: main_form.png includes title bar and border

**Symptom**: darkwater `main_form.png` is 212x199 but client area is only 206x150. The extra 6px width and 49px height is the window chrome (title bar + border).

**Root cause**: `smart_walkthrough.py` line ~575 calls `capture_cropped(main_win, ...)` where `main_win` is the GetWindowRect (includes chrome). Should crop to client area.

**Expected**: `main_form.png` should be 206x150 (client area only). Manifest should have `nc_x=0, nc_y=0`.

**Fix**: Crop main_form.png to `(x + nc_x, y + nc_y, x + w - nc_x, y + nc_y + client_h)`. Set manifest `nc_x=0, nc_y=0`.

**Validation**: `main_form.png` dimensions must equal `form.width × form.height` in manifest. Both must equal client area size from .frm `ClientWidth/ClientHeight` (÷15 for twips→px).

---

## Bug 2: Child form screenshots include chrome and black space

**Symptom**: `screen_about_darkwater.png` is 422x315 — includes title bar, border, and possibly black padding. Should be just the form content.

**Root cause**: `smart_walkthrough.py` Phase 1 menu loop captures with `capture_cropped(new_win, ...)` using GetWindowRect. Same problem as Bug 1.

**Expected**: Child screenshots should be client area only, like bodini's (e.g. 205x135 for About).

**Fix**: After getting child window rect, compute client area: `(x + nc_x, y + nc_y, client_w, client_h)`. Use that rect for capture. Set `child_h` to the client height.

**Validation**: Every `screen_*.png` must be > 50x50px, not all-black, not all-single-color. `child_h` in manifest must match image height.

---

## Bug 3: No interactive widget for menu-bar apps

**Symptom**: darkwater has no labels (uses VB6 Menu bar, not clickable Label controls). The interactive `app-sim` widget requires labels. Falls back to tab explorer or broken fake menu bar.

**Root cause**: `generate_analysis.py` line 524: `if form_info and (label_info or categories)` — enters the widget path, but without labels, no clickable hotspots are rendered on the form image.

**Known good**: bodini has 5 Label controls that act as menu category triggers. Their positions are in the manifest `labels` dict. The widget overlays them on the form image.

**Expected for menu-bar apps**: Either:
1. Use the tab-based explorer (`walkthrough-explorer` at line 655) which already works — shows category tabs with expandable items
2. OR render the VB6 menu bar items as clickable hotspots at the top of the form image (y ≈ 0, since menu bar is at top of client area)

**Fix (option 1 — simplest)**: When `labels` is empty, skip `app-sim` widget entirely, fall through to `elif categories:` tab explorer. Revert the condition on line 524 back to `if form_info and label_info and ...`.

---

## Bug 4: Frame player shows smashed/black screenshots

**Symptom**: Clicking "Play" in the frame player shows tiny smashed images with black borders.

**Root cause**: Frame captures use viewport crop (`crop_to_proggies`) which captures a fixed-size region. When the main form is small (212x199) but the viewport is large (862x404), the frame is mostly black. The frame player canvas is sized to the viewport, not the form.

**Expected**: Frame player should show clean screenshots at readable size.

**Fix**: Frame captures should crop to just the relevant window (main form or child form), not the viewport. Or size the canvas to the form dimensions.

**Validation**: Every frame PNG must have < 30% black pixels.

---

## Bug 5: generate_analysis.py broken by today's changes

**Symptom**: Today's changes to `generate_analysis.py` added `has_labels`, `app-menubar`, `app-form-wrap` that broke the widget for BOTH label-based and menu-bar apps.

**Root cause**: Multiple edits to the widget rendering code without testing against bodini.

**Fix**: Restore `generate_analysis.py` from the last known-good commit (`29db636f`), then make ONLY the minimal change needed: when `labels` is empty, fall through to tab explorer.

**Validation**: After any change to `generate_analysis.py`, regenerate BOTH `bodini.html` and `darkwater.html`, verify bodini's interactive widget still works identically to the known-good version.

---

## Quality Gates (must pass before any commit)

1. `main_form.png` dimensions == manifest `form.width × form.height`
2. Every `screen_*.png` is > 50×50 pixels
3. Every `screen_*.png` has < 30% black pixels
4. Every `screen_*.png` is not single-color
5. Every item with `image` in manifest → file exists on disk
6. Every item with `child_h` → matches actual image height
7. bodini.html interactive widget unchanged after any generate_analysis.py edit
8. `python3 -c "import ast; ast.parse(open(f).read())"` passes for all modified .py files
