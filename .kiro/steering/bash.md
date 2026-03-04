---
inclusion: fileMatch
fileMatchPattern: "**/*.sh"
description: Enforces bash scripting standards including error handling, input validation, and portable syntax.
---

# Bash Standards

## CRITICAL RULES

- NEVER make up command flags, function names, or tool options
- NEVER guess — verify syntax and behavior before presenting solutions
- ALL scripts must include error handling
- Target bash 4.2+

## Script Header (MANDATORY)

```bash
#!/usr/bin/env bash
set -euo pipefail
```

## Required Elements

- Usage/help function accessible via --help or -h
- Input validation for all arguments
- Trap for cleanup on exit/interrupt
- Proper quoting: `"${var}"` not `$var`
- Functions for any repeated logic

## Error Handling

```bash
trap cleanup EXIT
trap 'printf "\n"; echo "Interrupted"; exit 130' INT TERM

cleanup() {
    local rc=$?
    # cleanup logic
    exit $rc
}
```

## Style

- Use `$()` not backticks for command substitution
- Use `[[ ]]` not `[ ]` for conditionals
- Use `printf` over `echo` for portable output
- Quote all variable expansions
- Use `local` for function variables
- Use `readonly` for constants
- Run `bash -n script.sh` before delivery
