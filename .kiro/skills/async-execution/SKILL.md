---
name: async-execution
description: Nohup pattern for long-running commands, safe command list, trace log conventions, venv rules for pip. Use when running shell commands, launching background processes, or installing Python packages.
---

# Async Execution — Nohup Mandatory (enforced by preToolUse hook)

A preToolUse hook blocks execute_bash calls that run long-running commands
without nohup. Violations are rejected before execution with feedback.

## RULE

**NEVER run `pip install` outside a virtual environment.** Always use
`.venv/bin/pip` or activate a venv first. No `--break-system-packages`.

**NEVER run a command directly that could take more than 2 seconds.** This includes:
- Script execution (python, bash, node, etc.)
- Package managers (apt, pip, npm)
- Git network ops (push, pull, fetch, clone, merge, rebase)
- Network tools (curl, wget)
- Test suites (pytest)
- Build tools (make)
- Code review submissions (code-review.py, model-grader.py)
- Walkthrough runs (smart_walkthrough.py, capture_walkthrough.py)
- Decompile pipeline (single_decompile.py)
- Any VM interaction that polls or waits

## MANDATORY PATTERN

```bash
nohup bash -c '<command>' > /tmp2/trace-<descriptive-name>.log 2>&1 &
echo "PID: $!"
```

Rules:
- Use a STATIC trace path (no `$(date ...)` or subshells in the redirect target)
- **STOP after launching.** Report the PID and trace path. Do NOT chain a log read.
- Check results in a SEPARATE tool call in the NEXT response:
  ```bash
  tail -50 /tmp2/trace-<name>.log
  ```

## WHY SEPARATE TOOL CALLS

- Tool call 1: launch + report PID/trace path
- Wait for user to respond
- Tool call 2: read the output

This ensures the user can ALWAYS talk to the agent between launch and read.
If the user hits Ctrl+C on a tail, the background process keeps running.

## SAFE COMMANDS (no nohup needed)

- `ls`, `cat`, `head`, `tail`, `wc`, `echo`, `pwd`, `file`, `which`
- `git status`, `git branch`, `git log`, `git diff`, `git stash list`
- `python3 -m py_compile` (instant syntax checks)
- `mkdir`, `chmod`, `mv`, `cp`, `rm`, `ln`, `touch`
- `sed`, `awk`, `cut`, `sort`, `uniq`, `tr`, `jq`
- `ps`, `pgrep`, `kill`
- `grep`, `find` (with `-maxdepth`)
- Any command that reads local files without network or heavy computation
