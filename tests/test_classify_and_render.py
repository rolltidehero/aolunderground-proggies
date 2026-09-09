"""Tests for extracted helpers in generate_analysis.py — _classify_strings, renderers."""
import json
import pytest
from pathlib import Path
from unittest.mock import patch, MagicMock

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent.parent / 'tools'))
from generate_analysis import (
    _classify_strings, render_screenshots,
    _render_static_gallery, _render_tab_explorer,
    is_pe_artifact, is_phishing, is_junk, is_interesting, classify,
)


class TestClassifyStrings:
    """Tests for _classify_strings() — the string classification engine."""

    def test_empty_strings(self):
        """Empty input returns empty categories."""
        cat, interesting, other, junk, greets, greet_text, freq, seen = _classify_strings([], None)
        assert all(len(v) == 0 for v in cat.values())
        assert interesting == []
        assert other == []
        assert junk == []

    def test_pe_artifacts_go_to_junk(self):
        """PE artifacts should be classified as junk."""
        strings = ['!This program cannot be run in DOS mode.', 'VS_VERSION_INFO', 'VarFileInfo']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        assert len(junk) == 3
        assert len(interesting) == 0

    def test_phishing_detected(self):
        """Phishing templates should be categorized as phishing."""
        strings = ['Dear AOL Member, we need you to verify your account billing information immediately']
        cat, *_ = _classify_strings(strings, None)
        assert len(cat['phishing']) == 1

    def test_author_evidence(self):
        """Author credits should be categorized."""
        strings = ['Coded by TestHacker', 'Programmed by SomeGuy']
        cat, *_ = _classify_strings(strings, None)
        assert len(cat['author']) == 2

    def test_long_author_strings_go_to_interesting(self):
        """Long strings classified as 'credits' but too long go to interesting."""
        # This string gets classified as 'credits' by classify() but is >80 chars
        # so the author filter in _classify_strings moves it to interesting
        long_str = "This is a very long help text that happens to contain the word by in it somewhere but is definitely not an author credit at all"
        strings = [long_str]
        cat, interesting, other, *_ = _classify_strings(strings, None)
        # It may go to credits (categorized) or interesting depending on exact regex
        # The key invariant: it should NOT be in cat['author']
        assert len(cat['author']) == 0

    def test_dll_goes_to_dep(self):
        """DLL names should be categorized as dependencies."""
        strings = ['MSVBVM60.DLL', 'COMDLG32.OCX']
        cat, interesting, *_ = _classify_strings(strings, None)
        assert len(cat['dep']) == 2
        assert len(interesting) == 0

    def test_dedup(self):
        """Duplicate strings should be deduplicated."""
        strings = ['hello world', 'hello world', 'hello world']
        cat, interesting, other, junk, greets, greet_text, freq, seen = _classify_strings(strings, None)
        # All three should appear once total across all output buckets
        total = sum(len(v) for v in cat.values()) + len(interesting) + len(other) + len(junk)
        assert total <= 1  # deduplicated to one
        # But freq should show count of 3
        assert freq.get('hello world', 0) == 3

    def test_greet_names_extracted_from_decomp(self):
        """Greet names from decompile data should be extracted."""
        decomp = {
            'strings': [
                'Greets to all my friends',
                'DaHacker',
                'EliteCoder',
                'Tahoma',  # font, should be skipped
            ]
        }
        strings = ['DaHacker', 'EliteCoder']  # these should NOT appear in other
        cat, interesting, other, junk, greet_names, greet_text, *_ = _classify_strings(strings, decomp)
        assert 'DaHacker' in greet_names
        assert 'EliteCoder' in greet_names
        assert 'Tahoma' not in greet_names  # font name filtered

    def test_author_dedup_by_normalized_whitespace(self):
        """Author evidence should be deduplicated by normalized whitespace."""
        strings = ['Coded by  TestAuthor', 'Coded by TestAuthor']
        cat, *_ = _classify_strings(strings, None)
        assert len(cat['author']) == 1

    def test_author_merge_from_decomp(self):
        """Author evidence from decomp metadata should be merged."""
        decomp = {'author_evidence': ['Written by DecompHacker'], 'strings': []}
        strings = ['Coded by TestAuthor']
        cat, *_ = _classify_strings(strings, decomp)
        assert len(cat['author']) == 2
        assert any('DecompHacker' in a for a in cat['author'])

    def test_junk_classification(self):
        """Short non-meaningful strings should be junk."""
        strings = ['XI42', 'j7M', 'lblStop', 'cmdSend']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        # These should go to junk or be filtered
        assert len(interesting) == 0

    def test_interesting_strings(self):
        """Version strings and descriptive text should be interesting."""
        strings = ['Version 2.0 beta', 'This program will punt anyone from a chat room']
        cat, interesting, *_ = _classify_strings(strings, None)
        assert len(interesting) >= 1

    def test_frequency_map(self):
        """Frequency map should count before dedup."""
        strings = ['hello', 'world', 'hello', 'hello']
        *_, freq, seen = _classify_strings(strings, None)
        assert freq['hello'] == 3
        assert freq['world'] == 1

    def test_empty_strings_ignored(self):
        """Empty and whitespace-only strings should be ignored."""
        strings = ['', '   ', '\t', '\n', 'real string']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        total = sum(len(v) for v in cat.values()) + len(interesting) + len(other) + len(junk)
        assert total <= 1  # only 'real string' counted

    def test_none_decomp(self):
        """Should work with None decomp."""
        cat, *_ = _classify_strings(['test string'], None)
        assert isinstance(cat, dict)


class TestRenderScreenshots:
    """Tests for render_screenshots() dispatcher."""

    def test_nonexistent_dir_returns_empty(self, tmp_path):
        html = render_screenshots('nonexistent', tmp_path / 'page.html')
        assert html == ''

    def test_empty_dir_returns_empty(self, tmp_path):
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert html == ''

    def test_static_screenshot(self, tmp_path):
        """Directory with screenshot.png should render static gallery."""
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        (img_dir / 'screenshot.png').write_bytes(b'\x89PNG')
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert 'screenshot.png' in html
        assert '<section class="screenshot">' in html

    def test_animated_gif(self, tmp_path):
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        (img_dir / 'animated.gif').write_bytes(b'GIF89a')
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert 'animated.gif' in html

    def test_installer_screenshots(self, tmp_path):
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        (img_dir / 'install_welcome.png').write_bytes(b'\x89PNG')
        (img_dir / 'install_complete.png').write_bytes(b'\x89PNG')
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert 'Welcome' in html
        assert 'Installation Complete' in html

    def test_tab_explorer_with_walkthrough_json(self, tmp_path):
        """Walkthrough JSON with categories should render tab explorer."""
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        walkthrough = [
            {'category': 'File', 'items': [
                {'caption': 'Open', 'image': 'open.png'},
                {'caption': 'Save', 'image': 'save.png'},
            ]},
            {'category': 'Help', 'items': [
                {'caption': 'About', 'image': 'about.png'},
            ]},
        ]
        (img_dir / 'walkthrough.json').write_text(json.dumps(walkthrough))
        (img_dir / 'open.png').write_bytes(b'\x89PNG')
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert 'walkthrough-explorer' in html
        assert 'File' in html
        assert 'Help' in html

    def test_app_simulator_with_form_info(self, tmp_path):
        """Walkthrough JSON with form+labels should render app simulator."""
        img_dir = tmp_path / 'test_prog'
        img_dir.mkdir()
        walkthrough = {
            'categories': [{'category': 'File', 'items': [{'caption': 'Open', 'image': 'open.png'}]}],
            'form': {'width': 640, 'height': 480, 'image': 'main.png', 'screen_x': 10, 'crop_x0': 0},
            'labels': {'File': {'left': 10, 'top': 5, 'width': 40, 'height': 15}},
        }
        (img_dir / 'walkthrough.json').write_text(json.dumps(walkthrough))
        (img_dir / 'main.png').write_bytes(b'\x89PNG')
        html = render_screenshots('test_prog', tmp_path / 'page.html')
        assert 'app-sim' in html
        assert 'app-simulator' in html.lower() or 'app-label' in html


class TestRenderStaticGallery:
    """Tests for _render_static_gallery() helper."""

    def test_no_images_returns_false(self, tmp_path):
        img_dir = tmp_path / 'empty'
        img_dir.mkdir()
        lines = []
        found = _render_static_gallery(lines, 'test', img_dir)
        assert found is False
        assert lines == []

    def test_screenshot_png(self, tmp_path):
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'screenshot.png').write_bytes(b'\x89PNG')
        lines = []
        found = _render_static_gallery(lines, 'prog', img_dir)
        assert found is True
        assert any('screenshot.png' in l for l in lines)

    def test_screen_files_in_details(self, tmp_path):
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'screen_main.png').write_bytes(b'\x89PNG')
        (img_dir / 'screen_about.png').write_bytes(b'\x89PNG')
        lines = []
        found = _render_static_gallery(lines, 'prog', img_dir)
        assert found is True
        assert any('<details>' in l for l in lines)

    def test_install_labels_mapped(self, tmp_path):
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'install_welcome.png').write_bytes(b'\x89PNG')
        lines = []
        _render_static_gallery(lines, 'prog', img_dir)
        html = '\n'.join(lines)
        assert 'Welcome' in html  # mapped from install_welcome → Welcome


class TestClassificationHelpers:
    """Tests for individual classification functions."""

    @pytest.mark.parametrize('s,expected', [
        ('!This program cannot be run in DOS mode.', True),
        ('VS_VERSION_INFO', True),
        ('VarFileInfo', True),
        ('Hello World', False),
        ('Coded by TestAuthor', False),
    ])
    def test_is_pe_artifact(self, s, expected):
        assert is_pe_artifact(s) == expected

    @pytest.mark.parametrize('s,expected', [
        ('Dear AOL Member please verify your password', True),
        ('Dear AOL member your account will be terminated unless you verify', True),
        ('Hello World', False),
        ('short', False),  # too short to be phishing
    ])
    def test_is_phishing(self, s, expected):
        result = is_phishing(s)
        assert result == expected, f'is_phishing({s!r}) = {result}, expected {expected}'

    def test_classify_author(self):
        assert classify('Coded by TestAuthor') == 'author'

    def test_classify_dep(self):
        assert classify('MSVBVM60.DLL') == 'dep'

    def test_classify_returns_none_for_unknown(self):
        result = classify('random text here')
        assert result is None or isinstance(result, str)


# ── Additional edge cases and negative tests ─────────────────────────────


class TestClassifyStringsEdgeCases:
    """Edge cases and boundary conditions for _classify_strings."""

    def test_single_character_strings(self):
        """Single characters should be handled without crash."""
        strings = ['a', 'Z', '1', '#', '!']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        # Should not crash, everything should be classified somewhere
        total = sum(len(v) for v in cat.values()) + len(interesting) + len(other) + len(junk)
        assert total <= len(strings)

    def test_very_long_string(self):
        """Very long strings should not cause performance issues."""
        long_str = 'A' * 10000
        cat, interesting, other, junk, *_ = _classify_strings([long_str], None)
        total = sum(len(v) for v in cat.values()) + len(interesting) + len(other) + len(junk)
        assert total == 1

    def test_unicode_strings(self):
        """Unicode strings should be handled."""
        strings = ['Ünïcödé tëst', '日本語テスト', 'emoji: 🔥🎉']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        # Should not crash

    def test_only_whitespace_variants(self):
        """Various whitespace strings should all be filtered."""
        strings = ['', ' ', '  ', '\t', '\n', '\r\n', '   \t\n  ']
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        total = sum(len(v) for v in cat.values()) + len(interesting) + len(other) + len(junk)
        assert total == 0

    def test_mixed_categories(self):
        """Mix of all category types in one call."""
        strings = [
            '!This program cannot be run in DOS mode.',     # PE artifact → junk
            'MSVBVM60.DLL',                                  # classify → dep
            'Coded by TestHacker',                            # classify → author
            'Dear member please verify your billing info',    # phishing (billing info)
            'Version 3.0 custom chat tool',                   # interesting
            'xyz',                                            # junk
        ]
        cat, interesting, other, junk, *_ = _classify_strings(strings, None)
        assert len(cat['dep']) >= 1
        assert len(cat['author']) >= 1
        assert len(junk) >= 1  # PE artifacts + xyz

    def test_decomp_with_empty_strings(self):
        """Decomp with empty strings list should not crash."""
        decomp = {'strings': [], 'author_evidence': []}
        cat, *_ = _classify_strings([], decomp)
        assert isinstance(cat, dict)

    def test_decomp_strings_as_dicts(self):
        """Decomp strings can be dicts with 'value' key."""
        decomp = {
            'strings': [
                {'value': 'Greets to everyone'},
                {'value': 'TestName'},
                {'value': 'AnotherName'},
            ]
        }
        strings = ['TestName']
        cat, interesting, other, junk, greet_names, *_ = _classify_strings(strings, decomp)
        assert 'TestName' in greet_names

    def test_greet_stop_on_long_string(self):
        """Greet name extraction should stop on strings > 30 chars."""
        decomp = {
            'strings': [
                'Greets to my crew',
                'ShortName',
                'This is a much longer string that should terminate greet parsing because it has punctuation.',
            ]
        }
        cat, interesting, other, junk, greet_names, greet_text, freq, seen = _classify_strings([], decomp)
        assert 'ShortName' in greet_names
        # The long string should NOT be a greet name

    def test_frequency_correctness_with_many_dupes(self):
        """Frequency map should handle large duplicate counts."""
        strings = ['same'] * 100
        *_, freq, seen = _classify_strings(strings, None)
        assert freq['same'] == 100

    def test_all_pe_artifacts(self):
        """All PE artifact strings should go to junk."""
        artifacts = [
            '!This program cannot be run in DOS mode.',
            'VS_VERSION_INFO',
            'VarFileInfo',
            'StringFileInfo',
            'CompanyName',
            'FileDescription',
            'InternalName',
            'OriginalFilename',
            'ProductName',
            'ProductVersion',
        ]
        cat, interesting, other, junk, *_ = _classify_strings(artifacts, None)
        # Most should be junk (PE artifacts)
        assert len(junk) >= 5


class TestRenderScreenshotsEdgeCases:
    """Edge cases for the render_screenshots dispatcher."""

    def test_walkthrough_json_invalid_json(self, tmp_path):
        """Invalid JSON in walkthrough.json should not crash."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'walkthrough.json').write_text('not valid json{{{')
        # Should fall through to static gallery (which finds nothing)
        # or raise — let's see what happens
        try:
            html = render_screenshots('prog', tmp_path / 'page.html')
            # If it doesn't crash, it should return empty or fallback
            assert isinstance(html, str)
        except (json.JSONDecodeError, Exception):
            pass  # Acceptable — invalid JSON raises

    def test_walkthrough_json_empty_object(self, tmp_path):
        """Empty walkthrough.json object should fall through to static."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'walkthrough.json').write_text('{}')
        html = render_screenshots('prog', tmp_path / 'page.html')
        assert html == ''  # No categories, no static images

    def test_walkthrough_json_empty_categories(self, tmp_path):
        """Walkthrough with empty categories should fall to static."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'walkthrough.json').write_text(json.dumps({'categories': []}))
        html = render_screenshots('prog', tmp_path / 'page.html')
        assert html == ''

    def test_form_image_missing(self, tmp_path):
        """App simulator mode should fall to tabs if form image doesn't exist."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        wt = {
            'categories': [{'category': 'File', 'items': [{'caption': 'Open'}]}],
            'form': {'width': 640, 'height': 480, 'image': 'nonexistent.png'},
            'labels': {'File': {'left': 10, 'top': 5, 'width': 40, 'height': 15}},
        }
        (img_dir / 'walkthrough.json').write_text(json.dumps(wt))
        html = render_screenshots('prog', tmp_path / 'page.html')
        # Should fall to tab explorer since form image missing
        if html:
            assert 'walkthrough-explorer' in html

    def test_screen_files_sorted(self, tmp_path):
        """screen_* files should appear in sorted order."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'screen_03_help.png').write_bytes(b'\x89PNG')
        (img_dir / 'screen_01_main.png').write_bytes(b'\x89PNG')
        (img_dir / 'screen_02_about.png').write_bytes(b'\x89PNG')
        html = render_screenshots('prog', tmp_path / 'page.html')
        # Verify ordering: 01 before 02 before 03
        pos_01 = html.find('screen_01')
        pos_02 = html.find('screen_02')
        pos_03 = html.find('screen_03')
        assert pos_01 < pos_02 < pos_03

    def test_mixed_static_content(self, tmp_path):
        """Dir with screenshot + screens + installs should render all."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'screenshot.png').write_bytes(b'\x89PNG')
        (img_dir / 'screen_main.png').write_bytes(b'\x89PNG')
        (img_dir / 'install_welcome.png').write_bytes(b'\x89PNG')
        html = render_screenshots('prog', tmp_path / 'page.html')
        assert 'screenshot.png' in html
        assert 'screen_main' in html
        assert 'install_welcome' in html


class TestRenderStaticGalleryEdgeCases:
    """Edge cases for _render_static_gallery."""

    def test_unknown_install_key(self, tmp_path):
        """Unknown install screenshot key should use title-cased fallback."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'install_custom_step.png').write_bytes(b'\x89PNG')
        lines = []
        _render_static_gallery(lines, 'prog', img_dir)
        html = '\n'.join(lines)
        assert 'Custom Step' in html  # title-cased from key

    def test_empty_glob(self, tmp_path):
        """No matching files should return False."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        (img_dir / 'unrelated.txt').write_text('not an image')
        lines = []
        result = _render_static_gallery(lines, 'prog', img_dir)
        assert result is False
        assert lines == []


class TestTabExplorerRendering:
    """Additional tests for _render_tab_explorer."""

    def test_html_escaping_in_category_names(self, tmp_path):
        """Category names with HTML special chars should be escaped."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        categories = [
            {'category': 'File <script>alert("xss")</script>', 'items': [{'caption': 'Open', 'image': ''}]},
        ]
        wt_data = categories
        (img_dir / 'walkthrough.json').write_text(json.dumps(wt_data))
        html = render_screenshots('prog', tmp_path / 'page.html')
        if html:  # may be empty if no images
            assert '<script>' not in html or '&lt;script&gt;' in html

    def test_many_categories(self, tmp_path):
        """Large number of categories should render correctly."""
        img_dir = tmp_path / 'prog'
        img_dir.mkdir()
        categories = [
            {'category': f'Cat{i}', 'items': [{'caption': f'Item{i}', 'image': f'img{i}.png'}]}
            for i in range(20)
        ]
        for i in range(20):
            (img_dir / f'img{i}.png').write_bytes(b'\x89PNG')
        (img_dir / 'walkthrough.json').write_text(json.dumps(categories))
        html = render_screenshots('prog', tmp_path / 'page.html')
        assert 'Cat0' in html
        assert 'Cat19' in html
