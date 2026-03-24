---
trigger: manual
description: Analyze a spec or plan for omissions, ambiguities, contradictions, and security issues. Run after writing or updating any spec.
---

The user has just written or updated a spec document. Analyze it for:

1. **Omissions** — missing steps, unhandled error paths, edge cases not
   covered (e.g. what happens when target is unreachable, file doesn't
   exist, permissions are wrong, user interrupts with Ctrl-C)
2. **Ambiguities** — vague language, undefined terms, steps that could be
   interpreted multiple ways
3. **Contradictions** — internal conflicts within the spec, or conflicts
   with existing scripts in the same directory
4. **Security concerns** — command injection via unsanitized input,
   hardcoded credentials, overly permissive file permissions, missing
   input validation on IPs/hostnames/paths, unsafe temp file usage
5. **Platform compatibility** — bash scripts assuming GNU coreutils on
   systems that might have BSD utils, PowerShell version requirements
   not documented, Python version assumptions
6. **Operational safety** — scripts that could cause damage if run against
   wrong targets, missing confirmation prompts for destructive operations,
   no dry-run option for risky actions

Process:

- Read the spec doc the user specifies (typically in `.kiro/specs/`)
- Cross-reference against `README.md` and existing scripts in the same directory
- Ask the user ONE question at a time
- Present specific options ranked best-to-worst with a short explanation for each
- Always state your recommendation and why before presenting options
- Wait for their answer before asking the next question
- After all questions are answered, update the spec doc with clarifications

If no issues are found, say so and move on.
