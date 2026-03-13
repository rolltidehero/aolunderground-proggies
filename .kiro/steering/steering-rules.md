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

## MANDATORY: FreeProcess Polling — NO HARDCODED SLEEPS

**Write all wait/poll code like an AOL proggie.** Use the FreeProcess yield pattern
from the win32-api-automation steering doc. NEVER use hardcoded `time.sleep(N)`
to wait for a condition. Instead, poll for the condition in a tight loop with
`FreeProcess()` yields and a safety counter.

**BANNED in wait loops:**
- `time.sleep(1)`, `time.sleep(4)`, `time.sleep(5)` — arbitrary delays
- Any `time.sleep(N)` where N > 0.1 used to "wait for something to happen"

**REQUIRED pattern:**
```python
def free_process(n=100):
    """Yield CPU n times without arbitrary delay."""
    for _ in range(n):
        time.sleep(0)  # yield timeslice, no minimum delay

# Poll for a condition
for attempt in range(safety_max):
    free_process(100)
    result = check_condition()
    if result:
        break
else:
    log.error("Condition never met after %d attempts", safety_max)
```

**When is `time.sleep(N)` acceptable?**
- `time.sleep(0)` — always OK (yield timeslice)
- `time.sleep(0.05)` — OK for QMP socket round-trip (hardware latency)
- `time.sleep(0.1)` — OK after QMP screendump (file write latency)
- Animation frame capture (`time.sleep(0.2)`) — intentional frame timing, not waiting

**For QGA guest-exec:** Poll `guest-exec-status` with `exited=True` check in a
FreeProcess loop. Do NOT hardcode `time.sleep(5)` and hope the command finished.

**For window appearance:** Poll `EnumWindows` / `FindWindow` in a FreeProcess loop
with safety counter. Do NOT `time.sleep(1)` between checks.

This rule applies to ALL Python code in this project — host-side orchestration,
guest-side scripts, everything.

## MANDATORY: Post-Generate HTML Validation

After running `generate_analysis.py` on ANY HTML page, you MUST validate the
output before committing. Never eyeball grep counts and call it done.

**Required checks (run `validate_html.py` or equivalent):**
1. Every `appCats` menu item with `type: "show_form"` has a non-empty `image` value
2. Every referenced image file exists on disk at the expected path
3. No menu item renders as blank (image exists AND is non-zero bytes)
4. If `screen_greets.gif` is referenced, verify it exists and is > 0 bytes
5. If `animated.gif` is referenced, verify it exists and is > 0 bytes
6. The main screenshot (`main_form.png` or `screenshot.png`) exists

**If any check fails, DO NOT COMMIT. Fix the generation pipeline first.**

This rule exists because blank menu items were shipped to production on bodini
(greets rendered blank) due to skipping validation after HTML regeneration.

## Error Prevention
- Verify file/directory exists before reading
- Check process started before tailing logs
- Validate paths before operations

## Verbose Tracing (Python)

Every function that touches I/O or execution MUST have `logger.debug()` calls at:
- Each decision branch (which path taken and why)
- Exit (with sanitized result summary)
