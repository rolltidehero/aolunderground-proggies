"""Tests for tools/generate_analysis.py.

Covers: string classification, HTML rendering, metadata parsing,
edge cases, and negative tests.
"""
from __future__ import annotations

import html as H
import re
import sqlite3
from pathlib import Path
from unittest.mock import patch

import pytest

# tools/ is on pythonpath via pyproject.toml
from generate_analysis import (
    AOL_API_VERSIONS,
    classify,
    generate_html,
    get_meta_from_db,
    get_strings_from_db,
    is_interesting,
    is_junk,
    is_pe_artifact,
    is_phishing,
    render_about_text,
    render_api_refs,
    render_code_breakdown,
    render_deps_from_db,
    render_forms,
    render_greets,
    render_hero,
    render_screenshots,
    _render_menu_tree,
    _extract_program_name,
    _read_pe_timestamp,
    load_decompile_data,
)


# ── String Classification ─────────────────────────────────────────


class TestIsPeArtifact:
    def test_exact_match(self):
        assert is_pe_artifact("!This program cannot be run in DOS mode.")
        assert is_pe_artifact("VS_VERSION_INFO")
        assert is_pe_artifact("VarFileInfo")
        assert is_pe_artifact("VB5!")

    def test_regex_match(self):
        assert is_pe_artifact("__vbaStrMove")
        assert is_pe_artifact("EVENT_SINK_Release")
        assert is_pe_artifact("DllFunctionCall")
        assert is_pe_artifact("_allmul")

    def test_not_artifact(self):
        assert not is_pe_artifact("Hello World")
        assert not is_pe_artifact("Coded by hacker")
        assert not is_pe_artifact("AOL Frame25")

    def test_empty_string(self):
        assert not is_pe_artifact("")

    def test_path_artifact(self):
        assert is_pe_artifact("C:\\Program Files\\Microsoft Visual Studio\\foo")


class TestIsPhishing:
    def test_billing_pattern(self):
        assert is_phishing(
            "Dear AOL Member, your billing department needs to verify your credit card number immediately"
        )

    def test_account_deletion_threat(self):
        assert is_phishing(
            "Your account will be terminated unless you verify your billing information immediately"
        )

    def test_screen_name_and_password(self):
        assert is_phishing(
            "Please enter your screen name and password to continue with this AOL verification process"
        )

    def test_short_string_rejected(self):
        """Phishing requires >40 chars."""
        assert not is_phishing("billing dept info")

    def test_normal_string_not_phishing(self):
        assert not is_phishing("This is a normal program description that happens to be quite long indeed")

    def test_empty(self):
        assert not is_phishing("")


class TestIsJunk:
    def test_short_strings(self):
        assert is_junk("ab")
        assert is_junk("x")
        assert is_junk("")

    def test_vb_control_names(self):
        assert is_junk("lblStop")
        assert is_junk("cmdSend")
        assert is_junk("txtName")
        assert is_junk("picLogo")
        assert is_junk("tmrMain")

    def test_vb_object_names(self):
        assert is_junk("Picture1")
        assert is_junk("Command3")
        assert is_junk("Label2")
        assert is_junk("Project1")

    def test_menu_names(self):
        assert is_junk("options_greets")
        assert is_junk("menu_file")

    def test_module_names(self):
        assert is_junk("modUtils")
        assert is_junk("clsHelper")

    def test_font_names(self):
        assert is_junk("Tahoma")
        assert is_junk("Arial")
        # "Comic Sans MS" has spaces + >8 chars — passes the sentence heuristic
        # but the font regex only matches single-word names. This is expected.
        assert not is_junk("Comic Sans MS")

    def test_bare_exe(self):
        assert is_junk("test.exe")

    def test_not_junk(self):
        assert not is_junk("This program was coded by someone")
        assert not is_junk("Version 2.0 beta release")
        assert not is_junk("AOL Frame25")

    def test_asm_like(self):
        assert is_junk("Qj h")
        assert is_junk("jPh R@")

    def test_repeated_chars(self):
        assert is_junk("aaaaaaa")

    def test_binary_art(self):
        assert is_junk("///oOO@@__  ??PP")

    def test_path_fragments(self):
        assert is_junk("foo\\\\")


class TestClassify:
    def test_author_coded_by(self):
        assert classify("Coded by SomeHacker") == "author"

    def test_author_programmed_by(self):
        assert classify("Programmed by Someone") == "author"

    def test_credits(self):
        assert classify("Credits go to...") == "credits"
        assert classify("Greetz to the crew") == "credits"

    def test_api(self):
        assert classify("AOL Frame25") == "api"
        assert classify("FindWindowExA") == "api"
        assert classify("SendMessageA to target") == "api"

    def test_form(self):
        assert classify("frmMain.FRM") == "form"

    def test_dep(self):
        assert classify("MSVBVM60.DLL") == "dep"
        assert classify("COMDLG32.OCX") == "dep"

    def test_no_match(self):
        assert classify("Hello World") is None
        assert classify("") is None


class TestIsInteresting:
    def test_version_string(self):
        assert is_interesting("Version 2.0 beta")
        assert is_interesting("v3.1 release")

    def test_file_extension(self):
        assert is_interesting("config.ini")

    def test_sentence(self):
        assert is_interesting("This program will punt anyone from a chat room instantly")

    def test_bracketed_label(self):
        assert is_interesting("[Loaded]")
        assert is_interesting("[Connected to server]")

    def test_short_no_alpha(self):
        assert not is_interesting("123")
        assert not is_interesting("!@#")

    def test_empty(self):
        assert not is_interesting("")

    def test_no_alpha_run(self):
        assert not is_interesting("a1 b2")


# ── Metadata ──────────────────────────────────────────────────────


class TestGetMetaFromDb:
    def test_returns_meta(self, in_memory_proggie_db):
        meta = get_meta_from_db("test", in_memory_proggie_db)
        assert meta is not None
        assert meta["program"] == "TestProggie"
        assert meta["author"] == "TestAuthor"
        assert meta["aol_version"] == "4.0"
        assert meta["vb"] == "VB6"

    def test_not_found(self, in_memory_proggie_db):
        meta = get_meta_from_db("nonexistent", in_memory_proggie_db)
        assert meta is None


class TestGetStringsFromDb:
    def test_returns_strings(self, in_memory_strings_db):
        strings = get_strings_from_db(in_memory_strings_db, "test_archive/test.exe")
        assert len(strings) == 7
        assert "Coded by TestAuthor" in strings

    def test_missing_exe(self, in_memory_strings_db):
        strings = get_strings_from_db(in_memory_strings_db, "nonexistent.exe")
        assert strings == []


class TestExtractProgramName:
    def test_about_pattern(self):
        decomp = {"strings": ["About SuperPunter"], "code_breakdown": {}}
        assert _extract_program_name(decomp) == "SuperPunter"

    def test_no_match(self):
        decomp = {"strings": ["random text"], "code_breakdown": {}}
        assert _extract_program_name(decomp) is None

    def test_empty(self):
        decomp = {"strings": [], "code_breakdown": {}}
        assert _extract_program_name(decomp) is None

    def test_too_short(self):
        decomp = {"strings": ["About XY"], "code_breakdown": {}}
        assert _extract_program_name(decomp) is None


class TestReadPeTimestamp:
    def test_invalid_path(self, tmp_path):
        assert _read_pe_timestamp(tmp_path / "nonexistent.exe") is None

    def test_truncated_file(self, tmp_path):
        f = tmp_path / "tiny.exe"
        f.write_bytes(b"\x00" * 10)
        assert _read_pe_timestamp(f) is None

    def test_out_of_range_timestamp(self, tmp_path):
        """Timestamps outside 1990-2030 are rejected."""
        import struct

        f = tmp_path / "test.exe"
        # Build minimal PE: DOS header at 0x3C points to PE sig, then timestamp at offset +8
        data = bytearray(256)
        # PE offset at 0x3C
        struct.pack_into("<I", data, 0x3C, 0x80)
        # PE signature at 0x80
        data[0x80:0x84] = b"PE\x00\x00"
        # Timestamp at 0x88 — set to 0 (out of range)
        struct.pack_into("<I", data, 0x88, 0)
        f.write_bytes(bytes(data))
        assert _read_pe_timestamp(f) is None


# ── Rendering ─────────────────────────────────────────────────────


class TestRenderHero:
    def test_basic_hero(self, sample_meta):
        html = render_hero(sample_meta, "test.zip", None)
        assert "TestProggie" in html
        assert "TestAuthor" in html
        assert "AOL 4.0" in html
        assert "VB6" in html

    def test_with_decomp(self, sample_meta, sample_decomp):
        html = render_hero(sample_meta, "test.zip", sample_decomp)
        # decomp project name overrides meta
        assert "SuperPunter" in html

    def test_unknown_author_fallback(self, sample_meta, sample_decomp):
        sample_meta["author"] = "Unknown"
        html = render_hero(sample_meta, "test.zip", sample_decomp)
        assert "TestAuthor" in html  # falls back to decomp author_evidence

    def test_html_escaping(self, sample_meta):
        sample_meta["program"] = 'Test<script>alert("xss")</script>'
        html = render_hero(sample_meta, "test.zip", None)
        assert "<script>" not in html
        assert "&lt;script&gt;" in html

    def test_badges_present(self, sample_meta):
        html = render_hero(sample_meta, "test.zip", None)
        assert "badge-ver" in html
        assert "badge-vb" in html


class TestRenderScreenshots:
    def test_no_images(self, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        result = render_screenshots("test", html_path)
        assert result == ""

    def test_static_screenshot(self, tmp_path):
        img_dir = tmp_path / "test"
        img_dir.mkdir()
        (img_dir / "screenshot.png").write_bytes(b"\x89PNG")
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        result = render_screenshots("test", html_path)
        assert "screenshot.png" in result
        assert "Main window" in result

    def test_animated_gif(self, tmp_path):
        img_dir = tmp_path / "test"
        img_dir.mkdir()
        (img_dir / "animated.gif").write_bytes(b"GIF89a")
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        result = render_screenshots("test", html_path)
        assert "animated.gif" in result

    def test_individual_screens(self, tmp_path):
        img_dir = tmp_path / "test"
        img_dir.mkdir()
        (img_dir / "screen_main.png").write_bytes(b"\x89PNG")
        (img_dir / "screen_about.png").write_bytes(b"\x89PNG")
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        result = render_screenshots("test", html_path)
        assert "screen_main.png" in result
        assert "screen_about.png" in result


class TestRenderForms:
    def test_with_forms(self, sample_decomp):
        html = render_forms(sample_decomp)
        assert "frmMain" in html
        assert "cmdPunt" in html
        assert "Punt!" in html
        assert "ctrl-table" in html

    def test_no_forms(self):
        assert render_forms(None) == ""
        assert render_forms({}) == ""
        assert render_forms({"forms": []}) == ""

    def test_menu_rendering(self, sample_decomp):
        html = render_forms(sample_decomp)
        assert "File" in html
        assert "Exit" in html
        assert "menu-tree" in html

    def test_timer_display(self, sample_decomp):
        html = render_forms(sample_decomp)
        assert "tmrPunt" in html


class TestRenderMenuTree:
    def test_simple_tree(self):
        menus = [
            {"name": "mnuFile", "caption": "File"},
            {"name": "mnuFile_Open", "caption": "Open"},
            {"name": "mnuFile_Exit", "caption": "Exit"},
        ]
        html = _render_menu_tree(menus)
        assert "File" in html
        assert "Open" in html
        assert "Exit" in html
        assert "submenu" in html

    def test_separator(self):
        menus = [
            {"name": "mnuFile", "caption": "File"},
            {"name": "mnuFile_Sep", "caption": "-"},
        ]
        html = _render_menu_tree(menus)
        assert "File" in html
        # Separator caption '-' is filtered out (build returns '' for '-')
        # but hyphens exist in CSS class names like "menu-tree"
        assert '<li>-</li>' not in html

    def test_empty_menus(self):
        html = _render_menu_tree([])
        assert "<ul" in html


class TestRenderApiRefs:
    def test_with_aol_classes(self):
        html = render_api_refs(["AOL Frame25", "_AOL_Button"])
        assert "AOL Window Classes" in html
        assert "AOL Frame25" in html
        assert "2.5–3.0" in html

    def test_with_win32(self):
        html = render_api_refs(["FindWindowA", "SendMessageA"])
        assert "Win32 API" in html

    def test_empty(self):
        assert render_api_refs([]) == ""
        assert render_api_refs(None) == ""

    def test_mixed(self):
        html = render_api_refs(["AOL Frame25", "FindWindowA", "UnknownApi"])
        assert "AOL Window Classes" in html
        assert "Win32 API" in html
        assert "Other" in html


class TestRenderGreets:
    def test_with_names(self):
        html = render_greets(["HackerX", "CoolDude"], [])
        assert "HackerX" in html
        assert "CoolDude" in html
        assert "greet-tag" in html

    def test_with_text(self):
        html = render_greets([], ["Thanks to everyone who helped!"])
        assert "Thanks to everyone" in html

    def test_empty(self):
        assert render_greets([], []) == ""

    def test_filters_greet_headers(self):
        """'Greets to...' headers should not appear as closing text."""
        html = render_greets(["SomeGuy"], ["Greets to..."])
        assert "Greets to..." not in html


class TestRenderCodeBreakdown:
    def test_with_breakdown(self, sample_decomp):
        html = render_code_breakdown(sample_decomp)
        assert "breakdown-bar" in html
        assert "Application Code" in html
        assert "60" in html  # app_pct

    def test_no_decomp(self):
        assert render_code_breakdown(None) == ""
        assert render_code_breakdown({}) == ""
        assert render_code_breakdown({"code_breakdown": None}) == ""


class TestRenderAboutText:
    def test_with_about_function(self):
        decomp = {
            "_funcs_by_module": {
                "frmMain": [
                    {
                        "name": "mnuAbout_Click",
                        "code": 'MsgBox "SuperPunter v2.0 by HackerX - The ultimate AOL tool for all your punting needs"',
                        "size": 100,
                        "file": "test.vb",
                    }
                ]
            }
        }
        html = render_about_text(decomp)
        assert "SuperPunter" in html
        assert "HackerX" in html

    def test_no_about(self):
        decomp = {
            "_funcs_by_module": {
                "frmMain": [
                    {"name": "cmdPunt_Click", "code": "punt()", "size": 10, "file": "test.vb"}
                ]
            }
        }
        html = render_about_text(decomp)
        assert html == ""

    def test_none_decomp(self):
        assert render_about_text(None) == ""


class TestRenderDepsFromDb:
    def test_with_deps(self, in_memory_proggie_db):
        html = render_deps_from_db("test", in_memory_proggie_db)
        assert "MSVBVM60.DLL" in html
        assert "VB Runtime" in html

    def test_no_deps(self, in_memory_proggie_db):
        html = render_deps_from_db("nonexistent", in_memory_proggie_db)
        assert html == ""


# ── Full Page Generation ──────────────────────────────────────────


class TestGenerateHtml:
    def test_basic_page(self, sample_meta, sample_strings, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        html = generate_html(sample_meta, sample_strings, "test.zip", html_path)
        assert "<!DOCTYPE html>" in html
        assert "TestProggie" in html
        assert "TestAuthor" in html

    def test_phishing_section(self, sample_meta, sample_strings, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        html = generate_html(sample_meta, sample_strings, "test.zip", html_path)
        assert "Phishing" in html

    def test_html_escaping_in_strings(self, sample_meta, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        evil_strings = ['<script>alert("xss")</script>', "normal string here"]
        html = generate_html(sample_meta, evil_strings, "test.zip", html_path)
        assert "<script>alert" not in html

    def test_empty_strings(self, sample_meta, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        html = generate_html(sample_meta, [], "test.zip", html_path)
        assert "<!DOCTYPE html>" in html

    def test_duplicate_strings_deduped(self, sample_meta, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        dupes = ["Version 2.0 beta"] * 5
        html = generate_html(sample_meta, dupes, "test.zip", html_path)
        # Should show frequency badge
        assert "×5" in html

    def test_nav_links(self, sample_meta, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        html = generate_html(sample_meta, [], "test.zip", html_path)
        assert "All Proggies" in html
        assert "Download" in html

    def test_with_decomp_data(self, sample_meta, sample_decomp, tmp_path):
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        # Patch load_decompile_data to return our fixture
        with patch("generate_analysis.load_decompile_data", return_value=sample_decomp):
            html = generate_html(sample_meta, [], "test.zip", html_path)
        assert "SuperPunter" in html
        assert "Code Breakdown" in html


# ── Edge Cases & Negative Tests ───────────────────────────────────


class TestEdgeCases:
    def test_unicode_strings(self):
        """Non-ASCII strings should not crash classification."""
        assert not is_pe_artifact("Ünïcödé tëst")
        assert not is_phishing("Short ünïcödé")
        assert not is_junk("Ünïcödé prögram nämé")

    def test_very_long_string(self):
        """Very long strings should not cause regex catastrophic backtracking."""
        long_s = "A" * 10000
        # Should complete without hanging
        is_junk(long_s)
        is_phishing(long_s)
        is_interesting(long_s)
        classify(long_s)

    def test_null_bytes_in_string(self):
        """Strings with null bytes (from binary extraction)."""
        assert is_junk("\x00\x00")
        # Longer string with embedded null
        result = is_pe_artifact("normal\x00text")
        # Should not crash

    def test_all_api_versions_have_values(self):
        """Every key in AOL_API_VERSIONS should map to a non-empty string."""
        for key, val in AOL_API_VERSIONS.items():
            assert val, f"AOL_API_VERSIONS[{key!r}] is empty"

    def test_classify_returns_valid_category(self):
        """classify() should only return known categories or None."""
        valid = {"author", "credits", "api", "form", "dep", None}
        test_strings = [
            "coded by someone", "greets", "AOL Frame25",
            "frmMain.FRM", "MSVBVM60.DLL", "normal text",
        ]
        for s in test_strings:
            result = classify(s)
            assert result in valid, f"classify({s!r}) returned {result!r}"

    def test_render_hero_minimal_meta(self):
        """Hero should render even with minimal/empty metadata."""
        html = render_hero({}, "unknown.zip", None)
        assert "hero" in html
        assert "Unknown" in html  # default author

    def test_generate_html_no_zip_path(self, tmp_path):
        """Page should render without download link when no zip_path."""
        meta = {"program": "Test", "author": "X", "aol_version": "?", "exe": "?"}
        html_path = tmp_path / "test.html"
        html_path.write_text("<html></html>")
        html = generate_html(meta, [], "test.zip", html_path)
        assert "<!DOCTYPE html>" in html
        # No download anchor when no zip_path (dl-btn still in CSS, but no <a class="dl-btn">)
        assert 'class="dl-btn"' not in html.split("</style>")[-1]
