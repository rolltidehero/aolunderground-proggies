# Enforcing Nohup on Long-Running Commands in Kiro CLI

## The Problem

When a Kiro CLI agent runs a long-running command via `execute_bash` (e.g., `python3 script.py`, `pip install`, `apt update`), the command runs synchronously. The user's prompt is blocked until it finishes — or until they hit Ctrl+C, which kills the process entirely. There's no built-in timeout setting for `execute_bash`.

Steering rules alone don't solve this. The LLM reads them but drifts under task pressure, especially in long conversations. You need a mechanical guardrail.

## The Solution

Two layers working together:

1. **preToolUse hook** — a bash script that intercepts every `execute_bash` call before it runs. If the command matches a known long-running pattern and isn't wrapped in `nohup`, the hook exits with code 2, which blocks execution. Kiro feeds the STDERR back to the LLM so it self-corrects.

2. **Steering rule** — teaches the LLM to use nohup on the first attempt so the hook rarely fires.

## How preToolUse Hooks Work

Per [Kiro CLI Hooks docs](https://kiro.dev/docs/cli/hooks/):

- Hooks receive a JSON event on STDIN with `tool_name` and `tool_input` fields.
- Exit code 0 = allow the tool call.
- Exit code 2 = block the tool call. STDERR is returned to the LLM as feedback.
- Any other exit code = warning to user, tool call still proceeds.

The hook is wired to `execute_bash` via the `matcher` field in the agent config.

## Implementation

### Step 1: Create the Hook Script

Create `.kiro/hooks/enforce-nohup.sh`:

```bash
#!/usr/bin/env bash
# preToolUse hook: blocks execute_bash calls that run long-running commands
# without nohup. Exit 0 = allow, Exit 2 = block (STDERR returned to LLM).
set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

case "$TOOL" in
  execute_bash|shell) ;;
  *) exit 0 ;;
esac

CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$CMD" ] && exit 0

# Commands that are always safe (fast, read-only, local)
SAFE_PATTERNS=(
  '^ls\b' '^cat\b' '^head\b' '^tail\b' '^wc\b' '^echo\b' '^pwd$'
  '^file\b' '^which\b' '^whoami$' '^hostname$' '^uname\b' '^id$'
  '^ps\b' '^pgrep\b' '^pkill\b' '^kill\b' '^jobs$'
  '^mkdir\b' '^chmod\b' '^chown\b' '^mv\b' '^cp\b' '^rm\b' '^ln\b' '^touch\b'
  '^git (status|branch|log|diff|stash|show|rev-parse|config|remote -v)'
  '^git checkout\b' '^git switch\b' '^git stash\b'
  '^python3? -m py_compile\b' '^python3? -c\b' '^python3? --version'
  '^readlink\b' '^realpath\b' '^basename\b' '^dirname\b' '^stat\b'
  '^date\b' '^env$' '^printenv\b' '^export\b' '^set\b' '^source\b'
  '^test\b' '^\[' '^true$' '^false$'
  '^sed\b' '^awk\b' '^cut\b' '^sort\b' '^uniq\b' '^tr\b' '^tee\b'
  '^diff\b' '^md5sum\b' '^sha256sum\b' '^base64\b'
  '^jq\b' '^column\b' '^printf\b' '^read\b'
  '^sleep [0-5]$'
  '^find\b.*-maxdepth [12]\b'
)

# Commands that MUST use nohup (known long-running)
LONG_PATTERNS=(
  '^(sudo )?(apt|apt-get|dpkg|yum|dnf|pacman|snap)\b'
  '^pip3? install\b'
  '^npm (install|ci|test|run)\b' '^yarn\b' '^pnpm\b'
  '^cargo (build|test|install)\b' '^make\b' '^cmake\b'
  '^git (push|pull|fetch|clone|merge|rebase)\b'
  '^(python3?|bash|sh|perl|ruby|node) [^ ]' # script execution
  '^nmap\b' '^masscan\b' '^smbclient\b' '^rpcclient\b' '^netexec\b'
  '^curl\b' '^wget\b' '^scp\b' '^rsync\b' '^ssh\b'
  '^pytest\b' '^python3? -m pytest\b'
  '^docker\b' '^docker-compose\b'
  '^wine\b' '^wineboot\b' '^winetricks\b' '^Xvfb\b'
  '^hashcat\b' '^john\b'
  '^find / ' '^find /home\b' '^grep -r\b.*/' # broad searches
  '^terraform\b' '^ansible\b' '^kubectl\b'
)

# If the entire command is already wrapped in nohup, allow it
if echo "$CMD" | head -1 | grep -qE '^\s*nohup\b'; then
  exit 0
fi

# Check first meaningful command in the pipeline/sequence
# Extract the first command (before |, ;, &&, ||)
FIRST_CMD=$(echo "$CMD" | head -1 | sed 's/[[:space:]]*$//' | sed 's/\s*[|;&].*//')

# Strip leading whitespace
FIRST_CMD=$(echo "$FIRST_CMD" | sed 's/^[[:space:]]*//')

# Skip empty/comment lines
[[ -z "$FIRST_CMD" || "$FIRST_CMD" == \#* ]] && exit 0

# Check if it's a safe command
for pattern in "${SAFE_PATTERNS[@]}"; do
  if echo "$FIRST_CMD" | grep -qE "$pattern"; then
    exit 0
  fi
done

# Check if it matches a known long-running pattern
for pattern in "${LONG_PATTERNS[@]}"; do
  if echo "$FIRST_CMD" | grep -qE "$pattern"; then
    cat >&2 <<'FEEDBACK'
BLOCKED: This command may run for more than 2 seconds and must use nohup.

MANDATORY pattern:
  nohup bash -c '<command>' > /tmp/trace-<name>.log 2>&1 &
  echo "PID: $!"

Then check results in a SEPARATE tool call:
  tail -50 /tmp/trace-<name>.log

This prevents the user's prompt from being blocked by long-running commands.
FEEDBACK
    echo "Blocked command: $FIRST_CMD" >&2
    exit 2
  fi
done

# Check for bare backgrounding without nohup (& at end of line, not &&)
while IFS= read -r line; do
  trimmed=$(echo "$line" | sed 's/[[:space:]]*$//')
  [[ -z "$trimmed" || "$trimmed" == \#* ]] && continue
  if [[ "$trimmed" == *'&' && "$trimmed" != *'&&' ]]; then
    if ! echo "$trimmed" | grep -q 'nohup'; then
      cat >&2 <<'FEEDBACK'
BLOCKED: Command backgrounds a process without nohup.

MANDATORY pattern:
  nohup command < /dev/null > /tmp/trace-<name>.log 2>&1 &

Never background without nohup — if the user hits Ctrl+C, the process dies.
FEEDBACK
      echo "Blocked line: $trimmed" >&2
      exit 2
    fi
  fi
done <<< "$CMD"

# Unknown command — allow it (avoid false positives)
exit 0
```

Make it executable:

```bash
chmod +x .kiro/hooks/enforce-nohup.sh
```

### Step 2: Create the Agent Config

Create `.kiro/agents/default.json`:

```json
{
  "hooks": {
    "preToolUse": [
      {
        "matcher": "execute_bash",
        "command": "bash .kiro/hooks/enforce-nohup.sh"
      }
    ]
  }
}
```

If you already have a `default.json`, add the `preToolUse` entry to the existing `hooks` object.

The `matcher` accepts both `execute_bash` (canonical) and `shell` (alias). Per [Agent Configuration Reference](https://kiro.dev/docs/cli/custom-agents/configuration-reference#hooks-field).

### Step 3: Add a Steering Rule

Create `.kiro/steering/async-execution.md`:

```markdown
---
inclusion: always
---

# Async Execution — Nohup Mandatory (enforced by preToolUse hook)

A preToolUse hook blocks execute_bash calls that run long-running commands
without nohup. Violations are rejected before execution with feedback.

## RULE

**NEVER run a command directly that could take more than 2 seconds.** This includes:
- Script execution (python, bash, node, etc.)
- Package managers (apt, pip, npm, cargo)
- Git network ops (push, pull, fetch, clone, merge, rebase)
- Network tools (curl, wget, nmap, smbclient, rpcclient)
- Test suites (pytest, npm test, cargo test)
- Build tools (make, cargo build)

## MANDATORY PATTERN

    nohup bash -c '<command>' > /tmp/trace-<descriptive-name>.log 2>&1 &
    echo "PID: $!"
    echo "Trace: /tmp/trace-<descriptive-name>.log"

Rules:
- Use a STATIC trace path (no $(date ...) or subshells in the redirect target)
- STOP after launching. Report the PID and trace path. Do NOT chain a log read.
- Check results in a SEPARATE tool call in the NEXT response:
      tail -50 /tmp/trace-<name>.log

## SAFE COMMANDS (no nohup needed)

- ls, cat, head, tail, wc, echo, pwd, file, which
- git status, git branch, git log, git diff, git stash list
- python3 -m py_compile (instant syntax checks)
- mkdir, chmod, mv, cp, rm, ln, touch
- sed, awk, cut, sort, uniq, tr, jq
- ps, pgrep, kill
```

### Step 4: Restart Kiro CLI

Hooks load at startup. Exit and re-enter `kiro-cli chat`.

## How It Works

The hook evaluates commands in this order:

1. **Already nohup?** → If the command starts with `nohup`, allow it immediately.
2. **Safe command?** → Check against `SAFE_PATTERNS` (fast read-only commands like `ls`, `cat`, `git status`, `python3 -m py_compile`). If matched → allow.
3. **Known long-running?** → Check against `LONG_PATTERNS` (script execution, package managers, network tools, etc.). If matched → block with exit 2, STDERR tells the LLM exactly how to fix it.
4. **Bare backgrounding?** → Scan all lines for `&` at end-of-line without `nohup` → block.
5. **Unknown command?** → Allow it. The hook avoids false positives by only blocking known patterns.

## What Gets Blocked vs Allowed

| Command | Result | Why |
|---------|--------|-----|
| `python3 script.py` | BLOCKED | Script execution without nohup |
| `python3 -m py_compile script.py` | Allowed | Instant syntax check (safe list) |
| `python3 -c 'print(1)'` | Allowed | One-liner (safe list) |
| `python3 --version` | Allowed | Version check (safe list) |
| `pip install requests` | BLOCKED | Package manager |
| `sudo apt install -y jq` | BLOCKED | Package manager |
| `git push origin main` | BLOCKED | Network git op |
| `git status` | Allowed | Local git op (safe list) |
| `nohup bash -c 'python3 script.py' > /tmp/trace.log 2>&1 &` | Allowed | Properly wrapped |
| `Xvfb :99 &` | BLOCKED | Bare backgrounding without nohup |
| `ls -la /tmp \| grep trace` | Allowed | Safe command |

## Customizing

**To add a new long-running command:** Add a regex to the `LONG_PATTERNS` array.

```bash
LONG_PATTERNS=(
  # ... existing patterns ...
  '^my-slow-tool\b'    # add your pattern here
)
```

**To add a new safe command:** Add a regex to the `SAFE_PATTERNS` array.

```bash
SAFE_PATTERNS=(
  # ... existing patterns ...
  '^my-fast-tool\b'    # add your pattern here
)
```

Patterns are bash regex matched with `grep -E`. Use `\b` for word boundaries.

## Testing the Hook

Test without restarting Kiro by piping mock JSON events:

```bash
# Should BLOCK:
echo '{"tool_name":"execute_bash","tool_input":{"command":"python3 script.py"}}' \
  | bash .kiro/hooks/enforce-nohup.sh 2>&1; echo "EXIT: $?"

# Should ALLOW:
echo '{"tool_name":"execute_bash","tool_input":{"command":"cat /tmp/output.log"}}' \
  | bash .kiro/hooks/enforce-nohup.sh 2>&1; echo "EXIT: $?"
```

Exit code 2 = blocked. Exit code 0 = allowed.

## Dependencies

The hook requires `jq` for JSON parsing:

```bash
sudo apt install -y jq
```

## Sub-Project Workspaces

Kiro CLI loads hooks from the workspace's `.kiro/` directory. If you have sub-projects with their own `.kiro/` (e.g., a monorepo), symlink the hook and agent config into each sub-project:

```bash
# From the sub-project's .kiro/ directory:
mkdir -p agents hooks
ln -s ../../../.kiro/agents/default.json agents/default.json
ln -s ../../../.kiro/hooks/enforce-nohup.sh hooks/enforce-nohup.sh
```

Adjust the relative path depth to match your repo structure.

## Limitations

- **Blocklist, not a timeout.** The hook only catches commands that match `LONG_PATTERNS`. An unknown slow command (e.g., `./custom-tool`) passes through. Expand the pattern lists as you discover new offenders.
- **First command only.** The hook extracts the first command before any pipe/semicolon. `cat file | python3 slow.py` would be allowed because `cat` is the first command. In practice this is rare — the LLM almost always puts the main command first.
- **No Kiro-native timeout.** There's no `toolsSettings` timeout option for `execute_bash` as of March 2026. This hook is the best available workaround.

## References

- [Kiro CLI Hooks](https://kiro.dev/docs/cli/hooks/) — hook types, event format, exit codes
- [Agent Configuration Reference](https://kiro.dev/docs/cli/custom-agents/configuration-reference#hooks-field) — hooks field syntax
- [Built-in Tools](https://kiro.dev/docs/cli/reference/built-in-tools/) — execute_bash/shell tool settings
