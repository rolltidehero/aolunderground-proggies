---
trigger: manual
description: Cross-check a spec's tasks against what was actually implemented. Run at task boundaries or before committing.
---

Verify alignment between the spec and the implementation. Read:

- The spec the user specifies (typically in `.kiro/specs/`)
- `README.md` (repo structure and tool documentation)
- All files referenced in the spec's design and tasks
- Recent git log (`git log --oneline -20`)

Perform these checks:

1. **Coverage** — every task in the spec has corresponding code committed.
   Check for functions, scripts, config entries, and directories that the
   spec says should exist.
2. **Scope creep** — code was changed that isn't in the spec. Flag anything
   modified in the codebase that has no corresponding spec task.
3. **Code standards compliance** — spot-check that implemented code follows:
   - Bash: `set -euo pipefail`, proper quoting, no unguarded variable
     expansion, `shellcheck`-clean where possible
   - Python: PEP 8, type hints, argparse with help text
   - PowerShell: param blocks, comment-based help, error handling
4. **Script consistency** — new or modified scripts have usage/help output,
   error handling, input validation, and match the patterns of existing
   scripts in the same directory.
5. **README accuracy** — if a new tool was added or an existing tool's
   interface changed, verify README.md reflects the current state.

For each finding:

- State the specific spec task and what's misaligned
- Severity: Critical (blocks correctness), Important (quality gap), Minor (cleanup)
- Concrete fix: what to add, remove, or change
- Always state your recommendation and why before presenting options
- Present ONE finding at a time, wait for user response before the next

After all findings are resolved, summarize what's aligned and confirm
the work is complete.
