# ADR 0003: Git-Ship Enforcement Pipeline

## Status

Accepted

## Context

As the codebase grows beyond solo hacking (AI-assisted development,
multiple Kiro sessions, batch refactoring), code quality requires
mechanical enforcement rather than manual discipline. Problems observed:
- Orphaned functions added during refactors (no callers)
- Duplicate code paths for the same operation
- Code changes without corresponding test updates
- Architectural decisions made implicitly, never documented

## Decision

We will use `tools/git-ship.sh` as the mandatory commit pipeline. All
commits go through git-ship, which enforces:

- **Layer 0**: ADR creation gate — blocks when commit signals suggest a
  new architectural decision (thresholds, MANDATORY rules, validators)
- **Layer 1**: ADR scope matching — blocks when staged files fall under
  an existing ADR's declared scope
- **Layer 2**: BM25 relevance — informational, shows related ADRs
- **Layer 4**: Quality attestation — Annie (orphan detection via
  code-graph), Sauron/Boyscout attestation
- **Layer 5**: Test co-change — blocks when code file has a test file
  that wasn't updated in the same commit

All gates have bypass flags (`--adr-bypass`, `--quality-bypass`,
`--test-bypass`) with size-checked trivial claims. Bypass reasons are
recorded as commit message trailers for audit.

## Scope

- `tools/git-ship.sh`
- `tools/adr_check.py`
- `docs/adr/`

## Considered Options

1. Pre-commit hooks only — rejected: hooks are local, not portable,
   and easy to bypass with `--no-verify`. git-ship is the documented
   process.
2. GitHub Actions CI — rejected: runs post-push, too late. Enforcement
   must happen before the commit is created.
3. No enforcement — rejected: demonstrated failure mode of orphaned
   code, missing tests, undocumented decisions across sessions.

## Consequences

- (+) Every commit has an audit trail of gate decisions
- (+) Orphaned functions caught at commit time via code-graph
- (+) Architectural decisions documented incrementally via ADR gate
- (+) Test co-change prevents code/test drift
- (-) Higher commit ceremony — trivial fixes need bypass flags
- (-) adr_check.py is 1300 lines of enforcement logic to maintain
- (~) Bypasses are allowed but recorded — trust-but-verify model

## Evidence

- CONFIRMED: Annie check catches orphaned functions using code-graph
  callers query (tested over 6 months in production use).
- INFERRED: ADR creation gate will reduce implicit decisions based on
  signal detection of thresholds and MANDATORY keywords.

## References

- ARCHITECTURE.md — Key Design Decisions section
