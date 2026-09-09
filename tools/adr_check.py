#!/usr/bin/env python3
"""adr_check.py — Pre-commit ADR scope, relevance, and creation gate checker.

Called by git-ship.sh before committing. Three-layer check:

0. CREATION GATE (signal detection): If the diff shows signals of a new
   architectural decision (new thresholds, MANDATORY rules, detection functions)
   AND no ADR is staged, block until --adr-bypass "reason" is provided.
1. HARD GATE (scope match): If any staged file falls under an ADR's declared
   ## Scope paths, that ADR must be acknowledged via --adr-ack flag.
2. SOFT INFO (BM25): If BM25 finds related ADRs by content similarity,
   print them as informational (non-blocking).

Exit codes:
    0 = pass (no scope-matched ADRs, or all acknowledged)
    1 = blocked (scope-matched ADR not acknowledged, or creation gate triggered)
    2 = error (missing args, bad ADR format, etc.)

Usage:
    python3 tools/adr_check.py --staged-files file1.py file2.py \\
        --commit-msg "feat: compress shell output" \\
        --diff "$(git diff --cached --unified=0)" \\
        --new-files newfile1.py \\
        [--adr-ack "0001:no-change,0002:superseded"] \\
        [--adr-bypass "cosmetic: reformatted existing rules"]
"""
from __future__ import annotations

import argparse
import json
import logging
import re
import subprocess as sp
import sys
from datetime import datetime
from pathlib import Path

logger = logging.getLogger(__name__)

REPO_ROOT = Path(__file__).resolve().parent.parent
ADR_DIR = REPO_ROOT / "docs" / "adr"

# ANSI colors
RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[0;33m"
CYAN = "\033[0;36m"
NC = "\033[0m"


# --- Layer 0: ADR Creation Gate ---
# Signals that suggest a commit introduces a new architectural decision.
# Each signal has a weight. If total weight >= CREATION_THRESHOLD, the gate
# blocks unless --adr-bypass "reason" is provided.

CREATION_THRESHOLD = 4

# Patterns: (regex for filename, regex for added line content, weight, description)
CREATION_SIGNALS: list[tuple[re.Pattern, re.Pattern | None, int, str]] = [
    # New threshold/constant in validator or checker scripts
    (
        re.compile(r"(validat|check|gate)", re.IGNORECASE),
        re.compile(r"^\+.*(?:THRESHOLD|MAX_|MIN_|LIMIT|_WEIGHT|_SCORE)\w*\s*=\s*\d", re.MULTILINE),
        3,
        "New threshold/constant in validation logic",
    ),
    # New MANDATORY/FORBIDDEN/NEVER rule in steering
    (
        re.compile(r"\.kiro/steering/"),
        re.compile(r"^\+.*\b(MANDATORY|FORBIDDEN|NEVER|ALWAYS)\b", re.MULTILINE),
        3,
        "New mandatory/forbidden rule in steering",
    ),
    # New detection/classification function in any tool
    (
        re.compile(r"tools/.*\.py$"),
        re.compile(r"^\+\s*def\s+(?:detect|classify|score|check|validate|gate)_\w+", re.MULTILINE),
        2,
        "New detection/classification function",
    ),
    # New steering file created (not modification)
    (
        re.compile(r"\.kiro/steering/.*\.md$"),
        None,  # Only checks if file is NEW (handled separately)
        2,
        "New steering file created",
    ),
    # New validator/checker script created
    (
        re.compile(r"tools/.*(?:validat|check|gate).*\.py$"),
        None,  # Only checks if file is NEW
        2,
        "New validator/checker script created",
    ),
]


def detect_creation_signals(
    staged_files: list[str], diff_text: str, new_files: set[str]
) -> list[tuple[int, str]]:
    """Detect signals that suggest a new architectural decision.

    Returns list of (weight, description) for each triggered signal.
    """
    triggered: list[tuple[int, str]] = []
    seen_descriptions: set[str] = set()

    for file_pattern, line_pattern, weight, description in CREATION_SIGNALS:
        if description in seen_descriptions:
            continue

        for staged in staged_files:
            if not file_pattern.search(staged):
                continue

            # For signals that check new files only (line_pattern is None)
            if line_pattern is None:
                if staged in new_files:
                    triggered.append((weight, f"{description}: {staged}"))
                    seen_descriptions.add(description)
                    break
                continue

            # For signals that check diff content
            if line_pattern.search(diff_text):
                triggered.append((weight, f"{description}"))
                seen_descriptions.add(description)
                break

    return triggered


def parse_adr_file(path: Path) -> dict | None:
    """Parse an ADR file and extract number, title, status, scope, and decision."""
    try:
        content = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        logger.warning("Failed to read ADR file %s: %s", path, exc)
        return None

    # Extract ADR number from filename (NNNN-slug.md)
    match = re.match(r"(\d{4})-", path.name)
    if not match:
        return None
    number = match.group(1)

    # Extract title from first heading
    title_match = re.search(r"^#\s+ADR\s+\d+:\s*(.+)$", content, re.MULTILINE)
    title = title_match.group(1).strip() if title_match else path.stem

    # Extract status
    status = "unknown"
    status_match = re.search(
        r"^##\s+Status\s*\n+\s*(\w[\w\s]*?)(?:\n|$)", content, re.MULTILINE
    )
    if status_match:
        status = status_match.group(1).strip().lower()

    # Extract scope paths (lines under ## Scope that start with -)
    scope_paths: list[str] = []
    scope_match = re.search(
        r"^##\s+Scope\s*\n((?:.*\n)*?)(?=^##|\Z)", content, re.MULTILINE
    )
    if scope_match:
        for line in scope_match.group(1).splitlines():
            line = line.strip()
            if line.startswith("- "):
                # Strip backticks and leading/trailing whitespace
                scope_path = line[2:].strip().strip("`")
                if scope_path:
                    scope_paths.append(scope_path)

    # Extract decision (first paragraph under ## Decision)
    decision = ""
    dec_match = re.search(
        r"^##\s+Decision\s*\n+(.+?)(?:\n\n|\n##|\Z)", content, re.MULTILINE | re.DOTALL
    )
    if dec_match:
        decision = dec_match.group(1).strip()
        # Take first sentence or first 120 chars
        if len(decision) > 120:
            decision = decision[:120] + "..."

    return {
        "number": number,
        "title": title,
        "status": status,
        "scope_paths": scope_paths,
        "decision": decision,
        "path": str(path.relative_to(REPO_ROOT)) if path.is_relative_to(REPO_ROOT) else str(path),
    }


def load_all_adrs() -> list[dict]:
    """Load and parse all ADR files from docs/adr/."""
    if not ADR_DIR.exists():
        return []
    adrs = []
    for f in sorted(ADR_DIR.glob("*.md")):
        if f.name == "template.md":
            continue
        parsed = parse_adr_file(f)
        if parsed and parsed["status"] in ("accepted", "proposed"):
            adrs.append(parsed)
    return adrs


def check_scope_match(staged_files: list[str], adrs: list[dict]) -> list[dict]:
    """Return ADRs whose scope paths match any staged file."""
    matched = []
    for adr in adrs:
        if not adr["scope_paths"]:
            continue
        for staged in staged_files:
            for scope in adr["scope_paths"]:
                if staged.startswith(scope) or staged == scope:
                    if adr not in matched:
                        matched.append(adr)
                    break
    return matched


def validate_no_change(
    acks: dict[str, str],
    scope_matched: list[dict],
    staged_files: list[str],
    diff_text: str,
) -> list[str]:
    """Reject 'no-change' disposition when scope files were actually modified.

    If a file falls under an ADR's scope AND the diff shows that file was
    modified, then 'no-change' is a false claim. The committer must use:
      - 'extends' — file modified but decision unchanged (extending/implementing)
      - 'superseded' — decision is being replaced (new ADR required)
    Or include the ADR file in the commit (indicating initial creation).
    """
    errors: list[str] = []
    acked_no_change = {num for num, disp in acks.items() if disp == "no_change"}

    for adr in scope_matched:
        if adr["number"] not in acked_no_change:
            continue

        # Check if the ADR file itself is staged (initial creation = OK)
        adr_filename = f"docs/adr/{adr['number']}-"
        adr_staged = any(f.startswith(adr_filename) for f in staged_files)
        if adr_staged:
            # ADR is being created/modified in the same commit — allow no-change
            # (this handles the initial creation case where code + ADR ship together)
            continue

        # Find which staged files match this ADR's scope
        matched_files = []
        for staged in staged_files:
            for scope in adr["scope_paths"]:
                if staged.startswith(scope) or staged == scope:
                    matched_files.append(staged)
                    break

        # Check if any matched file appears in the diff as modified
        # (the diff contains lines like "--- a/tools/adr_check.py" or
        # "+++ b/tools/adr_check.py" for modified files)
        modified_in_scope = []
        for mf in matched_files:
            # Check for file header in unified diff
            if f"--- a/{mf}" in diff_text or f"+++ b/{mf}" in diff_text:
                modified_in_scope.append(mf)

        if modified_in_scope:
            files_str = ", ".join(modified_in_scope)
            errors.append(
                f"ADR {adr['number']} ({adr['title']}): disposition is 'no-change' "
                f"but diff shows modifications to scope files: {files_str}. "
                f"Use 'extends' if the decision is unchanged (just extending/implementing), "
                f"'superseded' if the decision changed (new ADR required), "
                f"or include the ADR file in staged files if this is initial creation."
            )

    return errors


def check_bm25_relevance(
    commit_msg: str, staged_files: list[str], adrs: list[dict]
) -> list[dict]:
    """Simple keyword overlap scoring (no external deps). Returns top 3 relevant ADRs."""
    if not adrs:
        return []

    # Build query terms from commit message + filenames
    query_terms = set()
    for word in re.split(r"[\s/._\-]+", commit_msg.lower()):
        if len(word) > 2:
            query_terms.add(word)
    for f in staged_files[:10]:  # Cap to avoid huge queries
        for word in re.split(r"[\s/._\-]+", f.lower()):
            if len(word) > 2:
                query_terms.add(word)

    # Remove common stop words
    stop_words = {"the", "and", "for", "that", "this", "with", "from", "are", "not"}
    query_terms -= stop_words

    # Score each ADR by term overlap with title + decision + scope
    scored = []
    for adr in adrs:
        adr_text = f"{adr['title']} {adr['decision']} {' '.join(adr['scope_paths'])}".lower()
        score = sum(1 for term in query_terms if term in adr_text)
        if score > 0:
            scored.append((score, adr))

    scored.sort(key=lambda x: x[0], reverse=True)
    return [adr for _score, adr in scored[:3]]


def parse_ack_flags(ack_str: str) -> dict[str, str]:
    """Parse --adr-ack '0001:no-change,0002:superseded' into {number: disposition}.

    Valid dispositions:
      no-change  — File in scope but the decision is not affected (unmodified file)
      extends    — File in scope AND modified, but the modification extends/implements
                   the existing decision without altering it
      superseded — The decision is being replaced (new ADR required in commit)
    """
    if not ack_str:
        return {}
    acks = {}
    for part in ack_str.split(","):
        part = part.strip()
        if ":" not in part:
            continue
        number, disposition = part.split(":", 1)
        number = number.strip().zfill(4)
        disposition = disposition.strip().lower().replace("-", "_")
        if disposition not in ("no_change", "superseded", "extends"):
            continue
        acks[number] = disposition
    return acks


def validate_supersede(
    acked_superseded: list[str], staged_files: list[str]
) -> list[str]:
    """If any ADR is marked superseded, verify a new ADR file is staged."""
    errors = []
    adr_files_staged = [f for f in staged_files if f.startswith("docs/adr/")]
    for number in acked_superseded:
        # Check that the old ADR's status was updated OR a new ADR references it
        old_adr_path = None
        for f in ADR_DIR.glob(f"{number}-*.md"):
            old_adr_path = f"docs/adr/{f.name}"
            break
        if old_adr_path and old_adr_path not in staged_files:
            errors.append(
                f"ADR {number} marked superseded but {old_adr_path} is not in staged files "
                f"(must update its Status line)"
            )
        # Must have at least one NEW adr file staged
        new_adrs = [f for f in adr_files_staged if f != old_adr_path and not f.endswith("template.md")]
        if not new_adrs:
            errors.append(
                f"ADR {number} marked superseded but no new ADR file is staged "
                f"(must include the superseding ADR)"
            )
    return errors


# --- Layer 3: Vendor Reference Validation ---

# File extensions considered "code" (require reference backing)
CODE_EXTENSIONS = {".py", ".sh", ".ps1", ".js", ".ts", ".tf", ".go", ".sql"}

# Maximum age in days for a vendor reference to be considered fresh
MAX_REF_AGE_DAYS = 180


def parse_ref_map(ref_map_str: str) -> list[dict]:
    """Parse --ref-map string into list of citation dicts.

    Accepted formats:
        file.md#Section-Header
        file.md:L45-L60
        file.md#Section-Header:L45-L60

    Returns list of dicts with keys: path, section, line_start, line_end.
    """
    if not ref_map_str.strip():
        return []

    refs = []
    for entry in ref_map_str.split(","):
        entry = entry.strip()
        if not entry:
            continue

        section = None
        line_start = None
        line_end = None
        path = entry

        # Extract line range (:L45-L60)
        line_match = re.search(r":L(\d+)-L(\d+)$", path)
        if line_match:
            line_start = int(line_match.group(1))
            line_end = int(line_match.group(2))
            path = path[: line_match.start()]

        # Extract section anchor (#Section-Name)
        if "#" in path:
            parts = path.split("#", 1)
            path = parts[0]
            section = parts[1]

        refs.append({
            "path": path,
            "section": section,
            "line_start": line_start,
            "line_end": line_end,
            "raw": entry,
        })

    return refs


def extract_ref_date(file_path: Path) -> datetime | None:
    """Extract the date from a vendor reference file.

    Checks in order:
    1. YAML frontmatter 'date:' field
    2. 'Date fetched: YYYY-MM-DD' or '**Date fetched:** YYYY-MM-DD' line
    3. Git commit date of the file (fallback)
    """
    import subprocess as sp

    if not file_path.exists():
        return None

    text = file_path.read_text(encoding="utf-8")
    lines = text.split("\n")

    # Check YAML frontmatter
    if lines and lines[0].strip() == "---":
        for line in lines[1:]:
            if line.strip() == "---":
                break
            m = re.match(r"date:\s*['\"]?(\d{4}-\d{2}-\d{2})", line)
            if m:
                return datetime.strptime(m.group(1), "%Y-%m-%d")

    # Check inline 'Date fetched:' pattern (handles bold, plain, etc.)
    for line in lines[:30]:  # Only check first 30 lines
        m = re.search(r"[Dd]ate\s+[Ff]etched.*?(\d{4}-\d{2}-\d{2})", line)
        if m:
            return datetime.strptime(m.group(1), "%Y-%m-%d")

    # Fallback: git log date
    try:
        result = sp.run(
            ["git", "log", "-1", "--format=%ci", "--", str(file_path)],
            capture_output=True,
            text=True,
            timeout=5,
        )
        if result.returncode == 0 and result.stdout.strip():
            date_str = result.stdout.strip()[:10]
            return datetime.strptime(date_str, "%Y-%m-%d")
    except (sp.TimeoutExpired, ValueError):
        pass

    return None


def validate_section_anchor(file_path: Path, section: str) -> tuple[bool, int, int]:
    """Check if a section header exists in the file.

    Returns (found, section_start_line, section_end_line).
    Section matching is case-insensitive and hyphen/space-normalized.
    """
    if not file_path.exists():
        return False, 0, 0

    lines = file_path.read_text(encoding="utf-8").split("\n")

    # Normalize the target section: lowercase, replace hyphens with spaces
    target = section.lower().replace("-", " ").strip()

    section_start = 0
    section_end = 0
    found = False

    for i, line in enumerate(lines, start=1):
        # Match markdown headers (## Section Name, ### Section Name, etc.)
        m = re.match(r"^#{1,6}\s+(.+)$", line)
        if m:
            header_text = m.group(1).lower().replace("-", " ").strip()
            if found and section_start > 0:
                # We found the NEXT section — previous section ends here
                section_end = i - 1
                break
            if header_text == target:
                found = True
                section_start = i
    else:
        # If we hit end of file while in a section, section goes to EOF
        if found and section_start > 0:
            section_end = len(lines)

    return found, section_start, section_end


def validate_line_range(file_path: Path, line_start: int, line_end: int) -> tuple[bool, str]:
    """Validate that a line range exists and has non-empty content.

    Returns (valid, error_message).
    """
    if not file_path.exists():
        return False, f"File does not exist: {file_path}"

    lines = file_path.read_text(encoding="utf-8").split("\n")
    total_lines = len(lines)

    if line_start < 1 or line_end < line_start:
        return False, f"Invalid line range: L{line_start}-L{line_end}"

    if line_end > total_lines:
        return False, (
            f"Line range L{line_start}-L{line_end} exceeds file length "
            f"({total_lines} lines)"
        )

    # Check that the range has non-empty content
    range_content = "\n".join(lines[line_start - 1 : line_end]).strip()
    if not range_content:
        return False, f"Lines L{line_start}-L{line_end} are empty/blank"

    return True, ""


def check_ref_citations(refs: list[dict], repo_root: Path) -> list[str]:
    """Validate all reference citations (existence, freshness, citation specificity).

    Returns list of error strings (empty = all pass).
    """
    errors = []
    today = datetime.now()

    for ref in refs:
        raw = ref["raw"]
        path_str = ref["path"]

        # Resolve path relative to repo root
        full_path = repo_root / path_str
        if not full_path.exists():
            errors.append(
                f"Reference file not found: {path_str}\n"
                f"    Cited as: {raw}\n"
                f"    Fix: run web research, save to docs/vendor-references/, update _index.md"
            )
            continue

        # Check freshness
        ref_date = extract_ref_date(full_path)
        if ref_date:
            age_days = (today - ref_date).days
            if age_days > MAX_REF_AGE_DAYS:
                errors.append(
                    f"Reference is stale ({age_days} days old, max {MAX_REF_AGE_DAYS}): "
                    f"{path_str}\n"
                    f"    Last updated: {ref_date.strftime('%Y-%m-%d')}\n"
                    f"    Fix: re-fetch authoritative source, update file, refresh date"
                )
                continue

        # Validate citation specificity (must have section or line range)
        if ref["section"] is None and ref["line_start"] is None:
            errors.append(
                f"Citation must include #Section-Header or :L-range: {raw}\n"
                f"    Fix: add section anchor (e.g., {path_str}#Recommendation) "
                f"or line range (e.g., {path_str}:L10-L25)"
            )
            continue

        # Validate section anchor exists
        if ref["section"]:
            found, sec_start, sec_end = validate_section_anchor(full_path, ref["section"])
            if not found:
                errors.append(
                    f"Section not found in {path_str}: #{ref['section']}\n"
                    f"    Fix: check the file for correct section header spelling"
                )
                continue

            # If both section and line range, validate lines are within section
            if ref["line_start"] and ref["line_end"]:
                if ref["line_start"] < sec_start or ref["line_end"] > sec_end:
                    errors.append(
                        f"Line range L{ref['line_start']}-L{ref['line_end']} "
                        f"is outside section #{ref['section']} "
                        f"(section spans L{sec_start}-L{sec_end}): {raw}"
                    )
                    continue

        # Validate line range bounds
        if ref["line_start"] and ref["line_end"]:
            valid, err_msg = validate_line_range(full_path, ref["line_start"], ref["line_end"])
            if not valid:
                errors.append(f"Line range invalid in {path_str}: {err_msg}")
                continue

    return errors


def has_code_files(staged_files: list[str]) -> bool:
    """Check if any staged files are code files (not pure docs/tests)."""
    for f in staged_files:
        ext = Path(f).suffix.lower()
        if ext in CODE_EXTENSIONS:
            return True
    return False


# --- Layer 4: Quality Attestation (Annie/Sauron/Boyscout) ---

# Required attestation keys for code commits
REQUIRED_ATTESTATIONS = {"sauron", "boyscout"}


def extract_new_public_functions(diff_text: str, staged_files: list[str]) -> list[dict]:
    """Extract new public function definitions from the diff.

    Only considers Python files. Skips private (_prefix), dunder (__prefix__),
    and functions in test files.

    Returns list of dicts: {name, file}.
    """
    new_funcs = []
    current_file = None

    for line in diff_text.split("\n"):
        # Track which file we're in
        if line.startswith("+++ b/"):
            current_file = line[6:]
            continue

        # Skip non-Python files
        if current_file and not current_file.endswith(".py"):
            continue

        # Skip test files
        if current_file and ("/test_" in current_file or "/tests/" in current_file
                            or current_file.startswith("tests/")):
            continue

        # Detect new function definitions (added lines containing def)
        if line.startswith("+") and not line.startswith("+++"):
            # Extract function name
            m = re.match(r"\+\s*def\s+(\w+)\s*\(", line)
            if m:
                func_name = m.group(1)
                # Skip private and dunder methods
                if func_name.startswith("__") or func_name.startswith("_"):
                    continue
                new_funcs.append({"name": func_name, "file": current_file})

    return new_funcs


def check_function_has_callers(func_name: str, defining_file: str) -> tuple[bool, str]:
    """Check if a function has at least one caller in the codebase.

    Uses code-graph.sh callers first, falls back to grep.
    Returns (has_callers, method_used).
    """
    code_graph = REPO_ROOT / "tools" / "code-graph" / "code-graph.sh"

    # Try code-graph first
    if code_graph.exists():
        try:
            result = sp.run(
                ["bash", str(code_graph), "callers", func_name],
                capture_output=True,
                text=True,
                timeout=10,
                cwd=str(REPO_ROOT),
            )
            if result.returncode == 0:
                # code-graph returns lines like:
                #   /full/path/file.py:123 in some_function
                # "No callers" message means none found
                output = result.stdout.strip()
                if "No callers" in output or not output:
                    return False, "code-graph"
                # Any non-empty output that isn't "No callers" = has callers
                callers = [
                    line for line in output.split("\n")
                    if line.strip() and "No callers" not in line
                ]
                return len(callers) > 0, "code-graph"
        except (sp.TimeoutExpired, OSError):
            pass  # Fall through to grep

    # Fallback: grep for the function name (excluding tests and __pycache__)
    try:
        result = sp.run(
            ["grep", "-r", "--include=*.py",
             "--exclude-dir=__pycache__", "--exclude-dir=tests",
             "-l", func_name, str(REPO_ROOT)],
            capture_output=True,
            text=True,
            timeout=10,
        )
        if result.returncode == 0:
            # Filter out the defining file itself
            files_with_refs = [
                f for f in result.stdout.strip().split("\n")
                if f.strip()
                and not f.endswith(defining_file)
                and not f.endswith("/" + defining_file)
            ]
            if files_with_refs:
                return True, "grep"
    except (sp.TimeoutExpired, OSError):
        pass

    return False, "grep-fallback"


def check_annie_violations(diff_text: str, staged_files: list[str]) -> list[str]:
    """Check for Annie violations: new public functions without callers.

    Returns list of error strings (empty = all pass).
    """
    new_funcs = extract_new_public_functions(diff_text, staged_files)
    if not new_funcs:
        return []

    errors = []
    for func in new_funcs:
        has_callers, method = check_function_has_callers(func["name"], func["file"] or "")
        if not has_callers:
            errors.append(
                f"Annie violation: new function '{func['name']}' in {func['file']} "
                f"has no callers in the codebase (checked via {method}).\n"
                f"    Fix: wire it into the application, or mark as _private if internal."
            )

    return errors


def parse_quality_check(quality_str: str) -> dict[str, str]:
    """Parse --quality-check string into dict.

    Format: 'sauron:pass,boyscout:pass'
    Returns dict like {'sauron': 'pass', 'boyscout': 'pass'}.
    """
    if not quality_str.strip():
        return {}

    result = {}
    for entry in quality_str.split(","):
        entry = entry.strip()
        if ":" in entry:
            key, val = entry.split(":", 1)
            result[key.strip().lower()] = val.strip().lower()

    return result


def check_quality_attestation(
    quality_str: str, staged_files: list[str]
) -> list[str]:
    """Validate quality attestation for code commits.

    Returns list of error strings (empty = all pass).
    """
    # Skip if no code files
    if not has_code_files(staged_files):
        return []

    attestations = parse_quality_check(quality_str)
    errors = []

    for key in REQUIRED_ATTESTATIONS:
        if key not in attestations or attestations[key] != "pass":
            errors.append(
                f"Missing attestation: '{key}:pass' required in --quality-check.\n"
                f"    This confirms you verified no {key} violations exist."
            )

    return errors


# Maximum changed lines for a "trivial" bypass claim
MAX_TRIVIAL_LINES = 20

# --- Layer 5: Test Co-Change Enforcement ---

# Paths exempt from test co-change requirement
TEST_EXEMPT_PREFIXES = (
    "tests/",
    "docs/",
    ".kiro/",
    "prompts/",
    "diagrams/",
    "projects/",
    "infra/",       # Terraform — tested via plan/apply, not pytest
)

# File extensions exempt from test requirement
TEST_EXEMPT_EXTENSIONS = {
    ".md", ".txt", ".json", ".yaml", ".yml", ".toml", ".cfg",
    ".html", ".css", ".svg", ".png", ".jpg",
}

# Filenames that are always exempt (scripts without unit test equivalents)
TEST_EXEMPT_FILENAMES = {
    "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt",
    "Makefile", "Dockerfile", ".gitignore", ".env.example",
}


def find_test_file(code_file: str) -> Path | None:
    """Find the corresponding test file for a code file.

    Uses convention-based discovery:
    1. tests/test_<stem>.py (flat)
    2. tests/<subdir>/test_<stem>.py (mirrored structure)
    3. tests/<parent>/test_<stem>.py (parent directory)

    Returns Path if found, None if no test file exists.
    """
    code_path = Path(code_file)
    stem = code_path.stem.replace("-", "_")

    # Strategy 1: tests/test_<stem>.py
    candidate = REPO_ROOT / "tests" / f"test_{stem}.py"
    if candidate.exists():
        return candidate

    # Strategy 2: tests/<subdir>/test_<stem>.py
    # e.g., vulncrafter/src/lib/foo.py → tests/vulncrafter/test_foo.py
    parts = code_path.parts
    for i, part in enumerate(parts):
        subdir_candidate = REPO_ROOT / "tests" / part / f"test_{stem}.py"
        if subdir_candidate.exists():
            return subdir_candidate

    # Strategy 3: tests/<parent>/test_<stem>.py
    # e.g., tools/mcp/foo.py → tests/mcp/test_foo.py
    parent = code_path.parent.name
    if parent:
        candidate = REPO_ROOT / "tests" / parent / f"test_{stem}.py"
        if candidate.exists():
            return candidate

    return None


def is_test_exempt(code_file: str) -> bool:
    """Check if a file is exempt from test co-change requirement."""
    # Check prefix exemptions
    for prefix in TEST_EXEMPT_PREFIXES:
        if code_file.startswith(prefix):
            return True

    # Check extension exemptions
    ext = Path(code_file).suffix.lower()
    if ext in TEST_EXEMPT_EXTENSIONS:
        return True

    # Check filename exemptions
    filename = Path(code_file).name
    if filename in TEST_EXEMPT_FILENAMES:
        return True

    # Shell scripts (.sh) are exempt — tested via bats or integration, not pytest
    if ext == ".sh":
        return True

    return False


def check_test_co_change(staged_files: list[str]) -> list[str]:
    """Check that code changes have accompanying test changes.

    Rules:
    1. If a code file has a corresponding test file AND that test file
       is NOT in the staged files → BLOCK
    2. If a code file has NO corresponding test file → WARNING (not blocking,
       since many files legitimately lack tests)
    3. Test file deletions in same commit as code changes → BLOCK

    Returns list of error strings (empty = all pass).
    """
    errors = []
    staged_set = set(staged_files)
    has_test_deletion = False

    # Check for test file deletions (anti-sabotage)
    for f in staged_files:
        if f.startswith("tests/") and f.endswith(".py"):
            # Check if this is a deletion (file no longer exists)
            full_path = REPO_ROOT / f
            if not full_path.exists():
                has_test_deletion = True

    code_files_without_test_update = []

    for f in staged_files:
        # Skip non-code and exempt files
        ext = Path(f).suffix.lower()
        if ext not in CODE_EXTENSIONS:
            continue
        if is_test_exempt(f):
            continue

        # Find corresponding test file
        test_file = find_test_file(f)
        if test_file is None:
            # No test file exists — this is a warning, not a block
            # (many files legitimately don't have tests yet)
            continue

        # Test file exists — is it in the commit?
        test_rel = str(test_file.relative_to(REPO_ROOT))
        if test_rel not in staged_set:
            code_files_without_test_update.append((f, test_rel))

    # Report code files whose test file exists but wasn't updated
    for code_file, test_file in code_files_without_test_update:
        errors.append(
            f"Code changed: {code_file}\n"
            f"    Test exists: {test_file} — but NOT in this commit.\n"
            f"    Fix: update the test to cover your changes, then stage it."
        )

    # Report test deletions alongside code changes
    if has_test_deletion and any(
        Path(f).suffix.lower() in CODE_EXTENSIONS and not is_test_exempt(f)
        for f in staged_files
    ):
        errors.append(
            "Test file DELETED in the same commit as code changes.\n"
            "    This is forbidden — tests may not be removed to make code pass.\n"
            "    Fix: restore the test file, fix the code to pass the tests."
        )

    return errors


def count_diff_changes(diff_text: str) -> int:
    """Count the number of added + deleted lines in a unified diff.

    Only counts actual content changes (lines starting with + or - that
    aren't file headers like +++ or ---).
    """
    count = 0
    for line in diff_text.split("\n"):
        if line.startswith("+") and not line.startswith("+++"):
            count += 1
        elif line.startswith("-") and not line.startswith("---"):
            count += 1
    return count


def validate_bypass_trivial(
    bypass_reason: str, diff_text: str, bypass_name: str
) -> str | None:
    """Check if a bypass claiming 'trivial' is actually trivial.

    Returns error string if the bypass is invalid, None if OK.
    A bypass is considered a trivial claim if it contains the word 'trivial'
    (case-insensitive). Trivial claims are BLOCKED when diff exceeds
    MAX_TRIVIAL_LINES.

    Non-trivial bypass reasons (e.g., 'bootstrapping: creating the system')
    are always accepted regardless of diff size.
    """
    if "trivial" not in bypass_reason.lower():
        return None  # Not claiming trivial — no size check

    changes = count_diff_changes(diff_text)
    if changes > MAX_TRIVIAL_LINES:
        return (
            f"{bypass_name} claims 'trivial' but diff has {changes} changed lines "
            f"(max {MAX_TRIVIAL_LINES} for trivial bypass).\n"
            f"    Either: provide a real {bypass_name.lower().replace('-bypass', '-map/-check')} "
            f"or use a non-trivial bypass reason."
        )

    return None


def main() -> int:
    parser = argparse.ArgumentParser(description="Pre-commit ADR scope checker")
    parser.add_argument(
        "--staged-files", nargs="*", default=[], help="List of staged file paths"
    )
    parser.add_argument("--commit-msg", default="", help="Commit message")
    parser.add_argument(
        "--adr-ack", default="", help="ADR acknowledgments: '0001:no-change,0002:superseded'"
    )
    parser.add_argument(
        "--adr-bypass", default="",
        help="Bypass ADR creation gate with a reason: 'cosmetic: no new constraints'"
    )
    parser.add_argument(
        "--diff", default="",
        help="Git diff text of staged changes (for Layer 0 signal detection)"
    )
    parser.add_argument(
        "--new-files", nargs="*", default=[],
        help="Files that are newly created (not modifications)"
    )
    parser.add_argument("--json", action="store_true", help="JSON output for programmatic use")
    parser.add_argument(
        "--ref-map", default="",
        help="Comma-separated vendor reference citations: 'file.md#Section,file2.md:L10-L20'"
    )
    parser.add_argument(
        "--ref-bypass", default="",
        help="Bypass vendor reference gate with a reason: 'trivial: typo fix only'"
    )
    parser.add_argument(
        "--quality-check", default="",
        help="Quality attestation: 'sauron:pass,boyscout:pass'"
    )
    parser.add_argument(
        "--quality-bypass", default="",
        help="Bypass quality attestation with a reason"
    )
    parser.add_argument(
        "--test-bypass", default="",
        help="Bypass test co-change requirement: 'pure refactor: existing tests cover this'"
    )
    args = parser.parse_args()

    adrs = load_all_adrs()

    # --- Layer 0: ADR Creation Gate (signal detection) ---
    # Runs even when no ADRs exist yet (that's the point — it detects when
    # the FIRST ADR should be created).
    diff_text = args.diff
    new_files = set(args.new_files)
    signals = detect_creation_signals(args.staged_files, diff_text, new_files)
    total_signal_weight = sum(w for w, _ in signals)

    # An ADR file in the staged set satisfies the creation gate (they wrote one)
    adr_staged = any(
        f.startswith("docs/adr/") and not f.endswith("template.md")
        for f in args.staged_files
    )
    creation_blocked = (
        total_signal_weight >= CREATION_THRESHOLD
        and not adr_staged
        and not args.adr_bypass
    )

    if not adrs and not creation_blocked:
        # No ADRs exist and no creation signals — pass clean
        if args.json:
            result = {
                "status": "pass",
                "reason": "no_adrs",
                "scope_matched": [],
                "unacknowledged": [],
                "supersede_errors": [],
                "no_change_errors": [],
                "bm25_related": [],
                "acknowledged": [],
                "creation_signals": [
                    {"weight": w, "description": d} for w, d in signals
                ],
                "creation_signal_weight": total_signal_weight,
                "creation_blocked": False,
                "adr_bypass": args.adr_bypass,
            }
            print(json.dumps(result, indent=2))
        return 0

    acks = parse_ack_flags(args.adr_ack)

    # --- Layer 1: Hard gate (scope match) ---
    scope_matched = check_scope_match(args.staged_files, adrs) if adrs else []

    # Filter out already-acknowledged ADRs
    unacked = [adr for adr in scope_matched if adr["number"] not in acks]

    # Validate no-change claims against actual diff
    no_change_errors: list[str] = []
    if diff_text:
        no_change_errors = validate_no_change(acks, scope_matched, args.staged_files, diff_text)

    # Validate supersede claims
    supersede_errors: list[str] = []
    acked_superseded = [num for num, disp in acks.items() if disp == "superseded"]
    if acked_superseded:
        supersede_errors = validate_supersede(acked_superseded, args.staged_files)

    # --- Layer 2: Soft info (keyword relevance) ---
    # Exclude scope-matched ADRs from BM25 results (already shown)
    scope_numbers = {adr["number"] for adr in scope_matched}
    remaining_adrs = [a for a in adrs if a["number"] not in scope_numbers]
    bm25_matches = check_bm25_relevance(args.commit_msg, args.staged_files, remaining_adrs)

    # --- Output ---
    blocked = bool(unacked or supersede_errors or no_change_errors or creation_blocked)

    if args.json:
        result = {
            "status": "blocked" if blocked else "pass",
            "scope_matched": scope_matched,
            "unacknowledged": unacked,
            "supersede_errors": supersede_errors,
            "no_change_errors": no_change_errors,
            "bm25_related": bm25_matches,
            "acknowledged": list(acks.keys()),
            "creation_signals": [
                {"weight": w, "description": d} for w, d in signals
            ],
            "creation_signal_weight": total_signal_weight,
            "creation_blocked": creation_blocked,
            "adr_bypass": args.adr_bypass,
        }
        print(json.dumps(result, indent=2))
        return 1 if blocked else 0

    # Human-readable output

    if creation_blocked:
        print(f"\n{RED}❌ BLOCKED: Commit shows signals of a new architectural decision:{NC}\n")
        for weight, desc in signals:
            print(f"  • {desc} (+{weight})")
        print(f"  Total signal weight: {total_signal_weight} (threshold: {CREATION_THRESHOLD})")
        print(f"\n{YELLOW}Decision classification questions:{NC}")
        print("    1. Does this commit introduce a threshold, constant, or limit that")
        print("       constrains future work?")
        print("    2. Does this commit add a MANDATORY/FORBIDDEN rule that all future")
        print("       code/content must follow?")
        print("    3. Could this decision reasonably be made differently, and would")
        print("       changing it later require touching multiple files?")
        print(f"\n{GREEN}If ANY answer is YES:{NC} write an ADR and include it in staged files.")
        print(f"{GREEN}If ALL answers are NO:{NC} pass --adr-bypass \"one-sentence reason\"")
        print(f"\n{YELLOW}Example:{NC}")
        print('  --adr-bypass "cosmetic: reformatted existing rules, no new constraints"')
        print()

    if unacked:
        print(f"\n{RED}❌ BLOCKED: Scope-matched ADRs require acknowledgment:{NC}\n")
        for adr in unacked:
            print(f"  {CYAN}ADR {adr['number']}{NC}: {adr['title']}")
            print(f"    Decision: \"{adr['decision']}\"")
            print(f"    Scope: {', '.join(adr['scope_paths'])}")
            print()
        print(f"{YELLOW}Re-run git-ship.sh with:{NC}")
        ack_examples = ",".join(f"{a['number']}:no-change" for a in unacked)
        print(f"  --adr-ack \"{ack_examples}\"     (files NOT modified, decision unaffected)")
        ack_extends = ",".join(f"{a['number']}:extends" for a in unacked)
        print(f"  --adr-ack \"{ack_extends}\"      (files modified but decision unchanged)")
        ack_supersede = ",".join(f"{a['number']}:superseded" for a in unacked)
        print(f"  --adr-ack \"{ack_supersede}\"  (decision replaced, new ADR required)\n")

    if supersede_errors:
        print(f"\n{RED}❌ BLOCKED: Supersede validation failed:{NC}\n")
        for err in supersede_errors:
            print(f"  • {err}")
        print()

    if no_change_errors:
        print(f"\n{RED}❌ BLOCKED: 'no-change' disposition contradicts diff:{NC}\n")
        for err in no_change_errors:
            print(f"  • {err}")
        print(f"\n{YELLOW}Valid dispositions when scope files are modified:{NC}")
        print(f"  • {CYAN}extends{NC}     — file modified but decision unchanged (extending/implementing)")
        print(f"  • {CYAN}superseded{NC}  — decision is being replaced (new ADR required in commit)")
        print()

    # Show bypass acceptance if it was used
    if args.adr_bypass and signals and not creation_blocked:
        print(f"\n{GREEN}✓ ADR creation gate bypassed:{NC} \"{args.adr_bypass}\"\n")

    if bm25_matches and not blocked:
        print(f"\n{YELLOW}ℹ Related ADRs (informational, not blocking):{NC}\n")
        for adr in bm25_matches:
            print(f"  {CYAN}ADR {adr['number']}{NC}: {adr['title']}")
            if adr["decision"]:
                print(f"    \"{adr['decision']}\"")
        print()

    # --- Layer 3: Vendor Reference Validation ---
    ref_blocked = False

    if args.ref_bypass:
        # Validate trivial claim size
        diff_text_l3 = args.diff if args.diff else ""
        trivial_err = validate_bypass_trivial(args.ref_bypass, diff_text_l3, "Ref-Bypass")
        if trivial_err:
            ref_blocked = True
            print(f"\n{RED}❌ BLOCKED: Trivial bypass rejected:{NC}\n")
            print(f"  • {trivial_err}")
            print()
    elif args.ref_map:
        # Validate provided references
        refs = parse_ref_map(args.ref_map)
        ref_errors = check_ref_citations(refs, REPO_ROOT)
        if ref_errors:
            ref_blocked = True
            print(f"\n{RED}❌ BLOCKED: Vendor reference validation failed:{NC}\n")
            for err in ref_errors:
                print(f"  • {err}")
            print(f"\n{YELLOW}Fix the references or pass --ref-bypass \"reason\"{NC}\n")
    elif has_code_files(args.staged_files):
        # Code files but no ref-map — emit warning (non-blocking)
        print(
            f"\n{YELLOW}⚠ No --ref-map provided for code change. Best practice: "
            f"cite authoritative vendor references.{NC}"
        )
        print(
            f"  {CYAN}Example:{NC} --ref-map "
            f"\"docs/vendor-references/thing-best-practices.md#Recommendation\""
        )
        print(
            f"  {CYAN}Bypass:{NC}  --ref-bypass \"trivial: typo fix\"\n"
        )

    if ref_blocked:
        blocked = True

    # --- Layer 4: Quality Attestation (Annie/Sauron/Boyscout) ---
    quality_blocked = False

    if args.quality_bypass:
        # Validate trivial claim size
        diff_text_l4 = args.diff if args.diff else ""
        trivial_err = validate_bypass_trivial(
            args.quality_bypass, diff_text_l4, "Quality-Bypass"
        )
        if trivial_err:
            quality_blocked = True
            print(f"\n{RED}❌ BLOCKED: Trivial bypass rejected:{NC}\n")
            print(f"  • {trivial_err}")
            print()
        # else: bypass accepted
    else:
        # Annie: automated orphan detection (on staged Python diffs)
        diff_text = args.diff if args.diff else ""
        annie_errors = check_annie_violations(diff_text, args.staged_files)
        if annie_errors:
            quality_blocked = True
            print(f"\n{RED}❌ BLOCKED: Annie violation (orphaned functions):{NC}\n")
            for err in annie_errors:
                print(f"  • {err}")
            print(
                f"\n{YELLOW}Fix: ensure every new public function has at least one caller.{NC}\n"
                f"  Or pass --quality-bypass \"reason\" to skip.\n"
            )

        # Sauron + Boyscout: attestation check
        attest_errors = check_quality_attestation(
            args.quality_check, args.staged_files
        )
        if attest_errors:
            quality_blocked = True
            print(f"\n{RED}❌ BLOCKED: Quality attestation missing:{NC}\n")
            for err in attest_errors:
                print(f"  • {err}")
            print(
                f"\n{YELLOW}Re-run with:{NC}\n"
                f"  --quality-check \"sauron:pass,boyscout:pass\"\n"
                f"  --quality-bypass \"reason\"  (to skip)\n"
            )

    if quality_blocked:
        blocked = True

    # --- Layer 5: Test Co-Change Enforcement ---
    test_blocked = False

    if args.test_bypass:
        # Validate trivial claim
        diff_text_l5 = args.diff if args.diff else ""
        trivial_err = validate_bypass_trivial(
            args.test_bypass, diff_text_l5, "Test-Bypass"
        )
        if trivial_err:
            test_blocked = True
            print(f"\n{RED}❌ BLOCKED: Trivial test bypass rejected:{NC}\n")
            print(f"  • {trivial_err}")
            print()
        # else: bypass accepted
    elif has_code_files(args.staged_files):
        test_errors = check_test_co_change(args.staged_files)
        if test_errors:
            test_blocked = True
            print(f"\n{RED}❌ BLOCKED: Test co-change requirement:{NC}\n")
            for err in test_errors:
                print(f"  • {err}")
            print(
                f"\n{YELLOW}Re-run with:{NC}\n"
                f"  Stage the test file alongside the code change, OR:\n"
                f"  --test-bypass \"reason\"  (e.g., \"pure refactor: existing tests cover this\")\n"
            )

    if test_blocked:
        blocked = True

    return 1 if blocked else 0


if __name__ == "__main__":
    sys.exit(main())
