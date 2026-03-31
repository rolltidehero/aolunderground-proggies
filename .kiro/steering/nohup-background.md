---
inclusion: always
description: All long-running commands MUST use nohup and background execution. No exceptions.
---

# Nohup Background Execution — ABSOLUTE RULE

ANY command that takes more than 5 seconds MUST be run with `nohup` and `&`.

This includes but is not limited to:
- Code review submissions (bedrock API calls)
- Walkthrough runs (smart_walkthrough.py, capture_walkthrough.py)
- Decompile pipeline (single_decompile.py)
- Any VM interaction that polls or waits
- Any HTTP/API call

## Required Pattern

```bash
nohup <command> > /tmp/<descriptive-name>.log 2>&1 &
echo "PID: $!"
```

Then check with:
```bash
tail -20 /tmp/<descriptive-name>.log
```

## NEVER DO THIS

❌ Running long commands inline and waiting
❌ Using `sleep N && tail` in the same command (blocks the shell)
❌ Forgetting `nohup` (command dies on interrupt)
❌ Forgetting `&` (blocks until complete)
❌ Forgetting to redirect stderr (`2>&1`)
