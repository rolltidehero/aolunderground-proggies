# ADR 0001: SQLite for All Structured Data

## Status

Accepted

## Context

The project needs to store and query three categories of structured data:
proggie metadata (names, authors, versions, dependencies), extracted
executable strings (11.6M rows), and decompilation output (forms,
controls, API references). The data is read-heavy — generated once, then
queried thousands of times during HTML generation and interactive search.

The project runs on a single developer machine with no server
infrastructure. The archive is distributed via GitHub with Git LFS for
large files. External database servers would add deployment complexity
and prevent offline operation.

## Decision

We will use SQLite for all structured data storage. `proggie_db.sqlite`
holds metadata. `exe_strings.db` holds extracted strings. Both are WAL
mode for concurrent reads during generation. The strings DB is distributed
as a zip via Git LFS (301MB compressed, 2.4GB uncompressed).

## Scope

- `tools/build_proggie_db.py`
- `tools/build_strings_db.py`
- `tools/query_proggies.py`
- `tools/query_strings.py`
- `tools/search_strings.py`
- `tools/generate_analysis.py`
- `proggie_db.sqlite`

## Considered Options

1. PostgreSQL — rejected: requires server, prevents offline operation,
   overkill for single-user read-heavy workload.
2. JSON files — rejected: 11.6M strings cannot be efficiently queried
   from flat JSON. No indexing, no FTS.
3. Parquet/DuckDB — rejected: good for analytics but adds unfamiliar
   dependency. SQLite is universally available on Python.

## Consequences

- (+) Zero deployment overhead — SQLite ships with Python's stdlib
- (+) Full SQL query capability including FTS5 if needed
- (+) WAL mode supports concurrent reads during batch generation
- (+) Single file per database — easy to backup, copy, distribute
- (-) strings DB is 2.4GB uncompressed — requires Git LFS
- (-) No multi-user concurrent writes (not needed for this project)
- (~) Schema migrations must be manual (PRAGMA user_version)

## Evidence

- CONFIRMED: strings DB handles 11.6M rows with sub-second queries
  using indexed lookups on exe_path column.
- CONFIRMED: WAL mode allows `generate_analysis.py` to read while
  `build_proggie_db.py` writes without blocking.

## References

- [SQLite: When to Use](https://www.sqlite.org/whentouse.html)
- ARCHITECTURE.md — Data Layer section
