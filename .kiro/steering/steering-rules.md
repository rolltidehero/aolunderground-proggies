---
inclusion: always
description: Mandatory execution rules — nohup, AFV, and process management. ALWAYS enforced.
---

# Mandatory Execution Rules

## ABSOLUTE PROHIBITIONS

1. **NEVER guess at runtime behavior. ALWAYS VERIFY.** If you don't know what a function does, READ THE SOURCE CODE. If you don't know why something failed, READ THE LOG OUTPUT. No speculation, no "it probably does X", no "the script likely never started". If you don't have evidence, say "I don't know" and go get evidence. NEVER state a root cause without citing the specific log line, code line, or file content that proves it.

2. **NEVER kill all wineuser processes.** `sudo kill -9 $(pgrep -u wineuser)`, `sudo kill $(pgrep -u wineuser -f ...)`, and any variant that pattern-matches wineuser processes are BANNED. They kill wineserver, which kills ALL Wine apps. To kill a specific Wine app, find its exact PID with `pgrep -u wineuser -a`, then `sudo kill <that_exact_pid>`. Wine infrastructure (wineserver32, services.exe, winedevice.exe, explorer.exe, plugplay.exe, svchost.exe, dbus-launch) must NEVER be killed unless doing a full restart from scratch after confirming everything is already dead.

3. **NEVER do a full Xvfb/Wine restart unless everything is confirmed dead.** Always check `pgrep -a Xvfb; pgrep -a metacity; pgrep -u wineuser -a` FIRST. If VB Decompiler is still running, DO NOT restart Xvfb.

## MANDATORY METHODOLOGY

### Always Verify (AFV)

**THE #1 RULE: NEVER MAKE ASSUMPTIONS. ALWAYS VERIFY WITH EVIDENCE.**

- You do NOT know why something failed until you have read the log, the code path, and the actual state.
- "Probably", "likely", "presumably", "I think" are BANNED words when diagnosing failures. Replace them with "I don't know yet, let me check."
- When you see unexpected behavior, enumerate ALL possible causes. Do NOT pick one and run with it. Verify each one systematically.
- If you cannot verify (e.g., can't connect to the target), SAY SO. Do not fill the gap with speculation.

Specific verification requirements:
- Before claiming code works: `py_compile` it.
- Before claiming a function exists: `search_symbols` or `grep` for it.
- Before claiming a fix is correct: trace the FULL code path from entry to the failure point.
- Before modifying code: read the CURRENT state of the file, not what you remember from earlier.
- After modifying code: re-read the modified lines to confirm the edit landed correctly.
- When debugging: read ACTUAL log output, never infer what "probably happened".
- Before stating a root cause: cite the EXACT evidence (log line number, code line number, file content) that proves it. If you can't cite evidence, you don't have a root cause — you have a guess.

### Nohup Rule (MANDATORY — enforced by preToolUse hook)

Any command expected to run longer than 2 seconds MUST use nohup:
```bash
nohup command < /dev/null > /tmp/somename.log 2>&1 &
```

Examples of commands that need nohup (>2s):
- `apt install`, `apt update`, `pip install`
- `wine`, `wineboot`, `winetricks`
- `Xvfb`, any GUI/display server
- `find` over large trees, `grep -r` over large repos
- Any network operation, download, or build

Examples of commands that do NOT need nohup (<2s):
- `ls`, `cat`, `head`, `tail` (non-follow), `wc`
- `file`, `which`, `whoami`, `pwd`, `echo`
- `ps`, `pgrep`, `pkill`, `kill`
- `mkdir`, `chmod`, `mv`, `cp`, `rm` (small targets)
- `git status`, `git branch`, `dpkg --print-foreign-architectures`
- `wine --version`, `tesseract --version` (version checks)

**CRITICAL: The nohup launch and any subsequent log check MUST be separate tool calls.** Never chain `nohup ... & sleep && tail` in one command. Always:
1. First tool call: `nohup command < /dev/null > /tmp/output.log 2>&1 &` (and nothing else)
2. Second tool call: `cat /tmp/output.log` or `tail /tmp/output.log`

**A preToolUse hook (`.kiro/hooks/enforce-nohup.sh`) blocks any `execute_bash` call that backgrounds a process with `&` without `nohup`.** This is a mechanical guardrail — the command will be rejected before execution.

### Command Execution Order
1. **ALWAYS verify logical order before executing commands**
2. **Create dependencies BEFORE using them** (directories before files, processes before logs)
3. **Never check output of commands that haven't run yet**

### Background Process Management
1. Create log directories first
2. Start nohup/background process second
3. Wait/sleep third
4. Check logs/output fourth

### Chain of Thought + DeCRiM

For any non-trivial change, explicitly state:
1. **What is broken** (cite specific log lines or code lines)
2. **Why it's broken** (trace the code path that produces the wrong behavior)
3. **What the fix is** (minimal change, cite the exact lines being modified)
4. **Verify the fix** (compile check, re-read modified code, trace the path again)

DeCRiM: after implementing, audit for Duplication, edge Cases, Resource leaks, improper Masking.

## Error Prevention
- Verify file/directory exists before reading
- Check process started before tailing logs
- Validate paths before operations

## Verbose Tracing (Python)

Every function that touches I/O or execution MUST have `logger.debug()` calls at:
- Each decision branch (which path taken and why)
- Exit (with sanitized result summary)
