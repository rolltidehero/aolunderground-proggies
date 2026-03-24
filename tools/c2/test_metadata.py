#!/usr/bin/env python3
"""Tests for extract_metadata.py"""
import sys, os, tempfile, json

sys.path.insert(0, os.path.dirname(__file__))
from extract_metadata import extract_metadata, AUTHOR_RE, VERSION_RE, ABOUT_FORM_RE

PASS = 0
FAIL = 0

def check(name, got, expected):
    global PASS, FAIL
    if got == expected:
        PASS += 1
    else:
        FAIL += 1
        print(f'FAIL: {name}\n  expected: {expected}\n  got:      {got}')

def check_in(name, needle, haystack):
    global PASS, FAIL
    if needle in haystack:
        PASS += 1
    else:
        FAIL += 1
        print(f'FAIL: {name}\n  expected {needle!r} in {haystack!r}')

def check_true(name, val):
    global PASS, FAIL
    if val:
        PASS += 1
    else:
        FAIL += 1
        print(f'FAIL: {name}\n  expected truthy, got {val!r}')

# ── Test AUTHOR_RE ──

def test_author_patterns():
    cases = [
        ('By Coolryguy', 'Coolryguy'),
        ('coded by DarkKnight', 'DarkKnight'),
        ('Created by Anphanax@Hotmail.com', 'Anphanax@Hotmail.com'),
        ('by pdm', 'pdm'),
        ('Programmed by xSEDo and BaNdO', 'xSEDo and BaNdO'),
        ('Written by L33t_H4x0r', 'L33t_H4x0r'),
        ('Made by SkRiBe', 'SkRiBe'),
    ]
    for text, expected in cases:
        m = AUTHOR_RE.search(text)
        check(f'author: "{text}"', m.group(1).strip() if m else None, expected)

# ── Test VERSION_RE ──

def test_version_patterns():
    cases = [
        ('Version 2.0', '2.0'),
        ('v1.5b', '1.5b'),
        ('V3.2.1', '3.2.1'),
        ('version 10', '10'),
    ]
    for text, expected in cases:
        m = VERSION_RE.search(text)
        check(f'version: "{text}"', m.group(1) if m else None, expected)

# ── Test ABOUT_FORM_RE ──

def test_about_form_patterns():
    should_match = ['frmAbout', 'frmCredits', 'frmabout', 'About', 'credits',
                    'frmInfo', 'frmSplash', 'Greetz', 'frmGreets']
    should_not = ['frmMain', 'Module1', 'Form1', 'frmLogin', 'Packets']
    for name in should_match:
        check_true(f'about_form match: {name}', ABOUT_FORM_RE.match(name))
    for name in should_not:
        check(f'about_form no match: {name}', ABOUT_FORM_RE.match(name), None)

# ── Test extract_metadata on synthetic source ──

def test_extract_buddymax_style():
    src = """\
' Listing created by VB Decompiler v9.8.64863
' Application: C:\\vbdec_input.exe
' Compiled to: Native Code
' Compiler version: 8988

'Object: frmMain

Private Sub Aboutsdsa_Click() '408A80
  loc_00408B03: var_24 = "Buddy Max Version 1.0"
End Sub

Private Sub cmdLogin_Click() '408B90
  Dim var_18 As Variant
  Dim var_44 As Winsock
End Sub

'Object: FLAPSock
'Object: Packets
'Object: Module1
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.bas', delete=False) as f:
        f.write(src)
        f.flush()
        meta = extract_metadata(f.name)
    os.unlink(f.name)

    check('buddymax forms', meta['forms'], ['frmMain', 'FLAPSock', 'Packets', 'Module1'])
    check('buddymax name', meta['name'], 'Buddy Max Version 1.0')
    check('buddymax version', meta['version'], '1.0')
    check_in('buddymax feature winsock', 'winsock', meta['features'])
    check_in('buddymax ui button', 'Aboutsdsa',
             [e['name'] for e in meta['ui_elements'] if e['type'] == 'button'])
    check_in('buddymax ui button login', 'cmdLogin',
             [e['name'] for e in meta['ui_elements'] if e['type'] == 'button'])

def test_extract_with_author():
    src = """\
' Application: C:\\test.exe

'Object: frmMain
'Object: frmAbout
'Object: modUtils

Private Sub Form_Load()
  loc_1: var_1 = "AIM Destroyer v2.5 by xSEDo"
  loc_2: var_2 = "Coded by xSEDo and BaNdO"
End Sub

Private Sub cmdPunt_Click()
  loc_3: Winsock.SendData "punt"
End Sub
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.bas', delete=False) as f:
        f.write(src)
        f.flush()
        meta = extract_metadata(f.name)
    os.unlink(f.name)

    check('author name', meta['author'], 'xSEDo')
    check('about form', meta['about_form'], 'frmAbout')
    check('name has version', meta['version'], '2.5')
    check_in('feature punt', 'punt', meta['features'])
    check_in('feature winsock', 'winsock', meta['features'])

def test_extract_with_deps():
    src = """\
' Application: C:\\cracker.exe

'Object: Form1

Private Declare Function GetWindowText Lib "user32.dll" (ByVal hwnd As Long) As Long
Private Sub cmdCrack_Click()
  loc_1: var_1 = "Cracking password..."
End Sub
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.bas', delete=False) as f:
        f.write(src)
        f.flush()
        meta = extract_metadata(f.name)
    os.unlink(f.name)

    check_in('dep user32', 'user32.dll', meta['dependencies'])
    check_in('feature crack', 'crack', meta['features'])

def test_extract_with_captions():
    src = """\
' Application: C:\\toolz.exe

'Object: frmMain
'Object: frmCredits

Private Sub Form_Load()
  lblTitle.Caption = "Elite Punter v3.0"
  cmdPunt.Caption = "Punt!"
  cmdFlood.Caption = "Flood Chat"
End Sub
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.bas', delete=False) as f:
        f.write(src)
        f.flush()
        meta = extract_metadata(f.name)
    os.unlink(f.name)

    check('about form credits', meta['about_form'], 'frmCredits')
    check_in('feature punt', 'punt', meta['features'])
    check_in('feature flood', 'flood', meta['features'])
    check_in('feature chat', 'chat', meta['features'])
    captions = [e for e in meta['ui_elements'] if e['type'] == 'caption']
    check_true('has captions', len(captions) >= 2)
    texts = [c['text'] for c in captions]
    check_in('caption punt', 'Punt!', texts)

def test_no_about_form():
    src = """\
' Application: C:\\simple.exe

'Object: Form1
'Object: Module1

Private Sub cmdGo_Click()
  loc_1: var_1 = "Hello"
End Sub
"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.bas', delete=False) as f:
        f.write(src)
        f.flush()
        meta = extract_metadata(f.name)
    os.unlink(f.name)

    check('no about form', meta['about_form'], None)
    check('forms', meta['forms'], ['Form1', 'Module1'])

# ── Test on real files ──

def test_real_files():
    """Test on actual decompiled files if they exist."""
    test_cases = [
        ('/home/braker/git/aolunderground-proggies/programs/AIM/_extracted/chatrush/Chat Rush/Chat Rush.decompiled.bas',
         {'about_form': 'frmabout', 'has_forms': True}),
        ('/home/braker/git/aolunderground-proggies/programs/AIM/_extracted/customaway/Custom Away.decompiled.bas',
         {'about_form': 'frmAbout', 'has_forms': True}),
        ('/home/braker/git/aolunderground-proggies/programs/AIM/_extracted/autobot/Auto-Bot.decompiled.bas',
         {'has_author': True, 'has_forms': True}),
    ]
    for path, expected in test_cases:
        if not os.path.isfile(path):
            continue
        meta = extract_metadata(path)
        if expected.get('about_form'):
            check(f'real {os.path.basename(path)} about_form',
                  meta['about_form'], expected['about_form'])
        if expected.get('has_author'):
            check_true(f'real {os.path.basename(path)} has author', meta.get('author'))
        if expected.get('has_forms'):
            check_true(f'real {os.path.basename(path)} has forms', len(meta['forms']) > 0)


if __name__ == '__main__':
    test_author_patterns()
    test_version_patterns()
    test_about_form_patterns()
    test_extract_buddymax_style()
    test_extract_with_author()
    test_extract_with_deps()
    test_extract_with_captions()
    test_no_about_form()
    test_real_files()

    print(f'\n{PASS} passed, {FAIL} failed')
    sys.exit(1 if FAIL else 0)
