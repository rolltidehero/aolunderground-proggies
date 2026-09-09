"""Shared test fixtures for aolunderground-proggies."""
from __future__ import annotations

import sqlite3
import json
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parent.parent


@pytest.fixture
def repo_root() -> Path:
    return REPO


@pytest.fixture
def sample_meta() -> dict:
    """Minimal proggie metadata dict."""
    return {
        "program": "TestProggie",
        "author": "TestAuthor",
        "aol_version": "4.0",
        "category": "Punter",
        "exe": "test.exe",
        "vb": "VB6",
        "compile": "p-code",
        "zip_path": "programs/AOL/proggies-sorted-deduped/4.0/test.zip",
    }


@pytest.fixture
def sample_strings() -> list[str]:
    """Representative string set for testing classification."""
    return [
        # PE artifacts (should be filtered)
        "!This program cannot be run in DOS mode.",
        "VS_VERSION_INFO",
        "VarFileInfo",
        # Author evidence
        "Coded by TestAuthor",
        "Programmed by SomeHacker",
        # Phishing template (>40 chars with phishing pattern)
        "Dear AOL Member, we need you to verify your account billing information immediately",
        # API references
        "AOL Frame25",
        "FindWindowA",
        "SendMessageA",
        "_AOL_Button",
        # Dependencies
        "MSVBVM60.DLL",
        "COMDLG32.OCX",
        # Form references
        "frmMain.FRM",
        # Credits/greets
        "Greets to all my friends",
        # Interesting strings
        "Version 2.0 beta",
        "This program will punt anyone from a chat room",
        # Junk (short, non-alpha)
        "XI42",
        "j7M",
        "!@#",
        # VB control names (should be filtered as junk)
        "lblStop",
        "cmdSend",
        "txtPassword",
    ]


@pytest.fixture
def sample_decomp() -> dict:
    """Minimal decompile metadata for testing."""
    return {
        "project": {"name": "SuperPunter", "Startup": '"frmMain"'},
        "vb_version": "VB6",
        "compile_type": "p-code",
        "forms": [
            {
                "name": "frmMain",
                "controls": [
                    {"type": "CommandButton", "name": "cmdPunt", "caption": "Punt!"},
                    {"type": "TextBox", "name": "txtTarget", "text": ""},
                    {"type": "Label", "name": "lblStatus", "caption": "Ready"},
                    {"type": "Timer", "name": "tmrPunt"},
                ],
                "menus": [
                    {"name": "mnuFile", "caption": "File"},
                    {"name": "mnuFile_Exit", "caption": "Exit"},
                    {"name": "mnuHelp", "caption": "Help"},
                    {"name": "mnuHelp_About", "caption": "About"},
                ],
                "timers": [{"name": "tmrPunt"}],
            }
        ],
        "bas_modules": ["modBase"],
        "strings": [],
        "author_evidence": ["Coded by TestAuthor"],
        "has_original_source": False,
        "code_breakdown": {
            "app_pct": 60.0,
            "reachable_pct": 25.0,
            "dead_pct": 15.0,
            "app_funcs_count": 8,
            "total_base_funcs": 20,
            "reachable_base_funcs": 5,
            "dead_base_funcs": 3,
            "total_size": 10000,
            "app_functions": [
                {
                    "name": "cmdPunt_Click()",
                    "size": 200,
                    "code": "Private Sub cmdPunt_Click()\n  SendMessageA hWnd, WM_CLOSE, 0, 0\nEnd Sub",
                    "control_caption": "Punt!",
                    "control_type": "CommandButton",
                    "code_hint": "",
                    "calls_base_names": [],
                },
            ],
            "reachable_functions": [],
            "cherry_picked": [],
            "proc_names": {},
        },
        "addr_to_name": {},
        "_funcs_by_module": {
            "frmMain": [
                {
                    "name": "cmdPunt_Click",
                    "code": "Private Sub cmdPunt_Click()\n  SendMessageA hWnd, WM_CLOSE, 0, 0\nEnd Sub",
                    "size": 80,
                    "file": "cmdPunt_Click.vb",
                },
            ],
        },
    }


@pytest.fixture
def in_memory_strings_db():
    """In-memory SQLite database mimicking exe_strings.db."""
    conn = sqlite3.connect(":memory:")
    conn.execute("CREATE TABLE strings (id INTEGER PRIMARY KEY, exe_path TEXT, value TEXT)")
    test_strings = [
        ("test_archive/test.exe", "Coded by TestAuthor"),
        ("test_archive/test.exe", "AOL Frame25"),
        ("test_archive/test.exe", "FindWindowA"),
        ("test_archive/test.exe", "Version 1.0"),
        ("test_archive/test.exe", "MSVBVM60.DLL"),
        ("test_archive/test.exe", "!This program cannot be run in DOS mode."),
        ("test_archive/test.exe", "VS_VERSION_INFO"),
    ]
    conn.executemany("INSERT INTO strings (exe_path, value) VALUES (?, ?)", test_strings)
    conn.commit()
    yield conn
    conn.close()


@pytest.fixture
def in_memory_proggie_db():
    """In-memory SQLite database mimicking proggie_db.sqlite."""
    conn = sqlite3.connect(":memory:")
    conn.execute("""CREATE TABLE proggies (
        id INTEGER PRIMARY KEY, name TEXT, author TEXT, aol_version TEXT,
        category TEXT, zip_stem TEXT, zip_path TEXT
    )""")
    conn.execute("""CREATE TABLE exes (
        id INTEGER PRIMARY KEY, proggie_id INTEGER, exe_name TEXT,
        vb_version TEXT, compile_type TEXT, exe_path TEXT,
        decompile_status TEXT
    )""")
    conn.execute("""CREATE TABLE deps (
        id INTEGER PRIMARY KEY, exe_id INTEGER, dep_name TEXT,
        dep_type TEXT, source TEXT, in_zip INTEGER, system_dll INTEGER,
        vb_runtime INTEGER
    )""")
    conn.execute(
        "INSERT INTO proggies VALUES (1, 'TestProggie', 'TestAuthor', '4.0', 'Punter', 'test', 'programs/AOL/proggies-sorted-deduped/4.0/test.zip')"
    )
    conn.execute(
        "INSERT INTO exes VALUES (1, 1, 'test.exe', 'VB6', 'p-code', 'test/test.exe', 'done')"
    )
    conn.execute(
        "INSERT INTO deps VALUES (1, 1, 'MSVBVM60.DLL', 'dll', 'import', 0, 1, 1)"
    )
    conn.commit()
    yield conn
    conn.close()
