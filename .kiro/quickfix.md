---
trigger: manual
description: Quick-fix mode for small changes that don't warrant a full spec. Includes guardrails for pentest script quality.
---

You are in quick-fix mode. Announce "Quick-fix mode — let's go."

Rules:

- Before implementing, check if the functionality already exists in the
  codebase. Search existing scripts in the same directory before writing
  new code.
- If the task is unclear or has missing edge cases, ask for clarification
  before writing code. If it's clear, say "Clear, implementing now."
- If a conceptually simple task requires touching more than 3 files or
  50+ lines of new code, flag it: "This is bigger than a quick fix.
  Want to create a spec first?" Wait for the user's answer.
- If you spot code duplication while implementing, factor it out.

Quality checks for each language:

- **Bash**: `set -euo pipefail`, proper quoting (`"${var}"`), usage/help
  function, input validation, trap for cleanup, `bash -n` syntax check
- **Python**: argparse with help text, type hints, error handling,
  `if __name__ == "__main__"` guard
- **PowerShell**: param block, comment-based help, error handling with
  try/catch, `-WhatIf` support for destructive operations

After implementing:

- Run `bash -n` on any modified bash scripts
- Run `python3 -m py_compile` on any modified Python scripts
- Flag if a script has no usage/help output
- Flag if error handling is missing for network operations or file I/O
- Do NOT add tests unless the user asks

Match the style and patterns of existing scripts in the same directory.
