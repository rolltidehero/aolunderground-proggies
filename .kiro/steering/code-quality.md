---
inclusion: auto
description: Requires pre-delivery method tracing to prevent breakage and encourages code reuse.
---

# Code Quality — Method Tracing & Reuse (MANDATORY)

## PRE-DELIVERY METHOD TRACING (REQUIRED)

Before committing any code that modifies, adds, or removes a function/method:

1. **Identify all modified functions** — list every function/method that was added, changed, or deleted.
2. **Trace callers** — for each modified function, find every call site in the repo.
3. **Trace callees** — for each modified function, identify every function it calls. Verify those callees still exist and their signatures haven't changed.
4. **Verify no breakage** — confirm that:
   - No caller passes arguments that no longer match the modified signature
   - No caller depends on return values that changed type or structure
   - No removed function is still referenced anywhere
   - No new function shadows or conflicts with an existing one
5. **Document the trace** — in the commit message body, briefly note which functions were traced and that callers/callees were verified.

If tracing reveals a breaking change, fix all affected call sites before committing.

## CODE DUPLICATION POLICY

- Before implementing any function, search for existing implementations in the repo
- If similar code exists in 2+ places, refactor into a shared module
- Flag duplication in code reviews and PR descriptions

## CROSS-LANGUAGE CODE GENERATION (Python → Bash/SQL)

When generating code in one language from another:

1. **ALWAYS inspect the generated output** for syntax correctness before deploying.
2. **Template files must be independently testable** in their native language.
3. **Brace-balance assertion** — after assembling any generated script from multiple template fragments, assert that delimiter pairs match.
4. **Never assume f-string vs regular string** — verify the `f` prefix on triple-quoted strings with `{{` and `}}`.
