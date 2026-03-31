#!/usr/bin/env bash
# Tests for enforce-nohup.sh
source "$(dirname "$0")/helpers.sh"
setup_tmp

HOOK="$HOOKS_DIR/enforce-nohup.sh"

# ============================================================
# SAFE COMMANDS — no nohup needed
# ============================================================

for cmd in "ls -la" "cat /etc/hostname" "echo hello" "git status" "git log" \
           "grep foo bar" "ps aux" "mkdir -p /tmp/test" "chmod +x foo.sh" \
           "python3 -m py_compile foo.py" "python3 -c 'print(1)'" \
           "jq . file.json" "date" "sleep 3" "find /tmp -maxdepth 1 -name '*.log'" \
           "sed 's/foo/bar/' file.txt" "sort file.txt" "diff a.txt b.txt"; do
  run_hook "$HOOK" "$(json_bash_cmd "$cmd")"
  assert_exit 0 "safe: $cmd"
done

# --- non-bash tools pass through ---
run_hook "$HOOK" "$(json_non_bash)"
assert_exit 0 "non-bash passes"

# ============================================================
# LONG COMMANDS — blocked without nohup
# ============================================================

for cmd in "nmap -sS 10.0.0.1" "masscan 10.0.0.0/24 -p445" \
           "python3 scanner.py" "bash run_scan.sh" \
           "curl http://10.0.0.1/api" "wget http://example.com/file" \
           "smbclient //10.0.0.1/share" "rpcclient -U '' 10.0.0.1" \
           "pip3 install requests" "git push origin main" "git clone http://example.com/repo" \
           "hashcat -m 1000 hashes.txt wordlist.txt" \
           "pytest tests/" "docker build -t test ." \
           "ssh user@10.0.0.1" "scp file.txt user@10.0.0.1:/tmp/"; do
  run_hook "$HOOK" "$(json_bash_cmd "$cmd")"
  assert_exit 2 "blocked: $cmd"
  assert_stderr_contains "BLOCKED|nohup" "stderr mentions nohup: $cmd"
done

# ============================================================
# NOHUP-WRAPPED — allowed
# ============================================================

run_hook "$HOOK" "$(json_bash_cmd "nohup bash -c 'nmap -sS 10.0.0.1' > /tmp2/trace.log 2>&1 &")"
assert_exit 0 "nohup nmap allowed"

run_hook "$HOOK" "$(json_bash_cmd "nohup bash -c 'python3 scanner.py' > /tmp2/trace.log 2>&1 &")"
assert_exit 0 "nohup python allowed"

# ============================================================
# BARE BACKGROUNDING — blocked
# ============================================================

run_hook "$HOOK" "$(json_bash_cmd "python3 scanner.py &")"
assert_exit 2 "bare background blocked"
assert_stderr_contains "nohup" "stderr mentions nohup for bare bg"

# && is NOT backgrounding
run_hook "$HOOK" "$(json_bash_cmd "ls -la && echo done")"
assert_exit 0 "&& not treated as background"

# ============================================================
# MULTI-LINE — dangerous on any line blocks
# ============================================================

MULTI=$(printf 'echo hello\nnmap 10.0.0.1')
run_hook "$HOOK" "$(json_bash_cmd "$MULTI")"
assert_exit 2 "multi-line: nmap on line 2 blocked"

# ============================================================
# SLEEP BOUNDARY
# ============================================================

run_hook "$HOOK" "$(json_bash_cmd "sleep 5")"
assert_exit 0 "sleep 5 safe"

run_hook "$HOOK" "$(json_bash_cmd "sleep 6")"
# sleep 6 doesn't match safe pattern '^sleep [0-5]$' and doesn't match
# any long pattern either — so it falls through as unknown (allowed)
assert_exit 0 "sleep 6 unknown — allowed (not in long patterns)"

run_hook "$HOOK" "$(json_bash_cmd "sleep 300")"
assert_exit 0 "sleep 300 unknown — allowed (not in long patterns)"

# ============================================================
# WINDOWS — skipped (can't test OSTYPE easily)
# ============================================================

teardown_tmp
print_results "enforce-nohup"
