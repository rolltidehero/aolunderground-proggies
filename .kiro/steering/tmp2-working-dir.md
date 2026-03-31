---
inclusion: always
---

# Working Directory — /tmp2 (MANDATORY)

## RULE: NEVER USE /tmp FOR WORKING FILES

All temporary files, trace logs, RC files, scan output, and scratch data
MUST go in `/tmp2/` — NEVER `/tmp/`.

`/tmp/` contains critical engagement data (trace logs, DNS exfil captures,
scan results) that must not be accidentally overwritten or cluttered.

## APPLIES TO

- Metasploit RC files → `/tmp2/`
- nohup trace logs → `/tmp2/trace-*.log`
- Temporary scan output → `/tmp2/`
- Any file created for short-term use → `/tmp2/`

## EXCEPTIONS

- Reading existing files already in `/tmp/` is fine
- Moving files FROM `/tmp/` to permanent storage is fine
- Never write NEW files to `/tmp/`
