---
inclusion: fileMatch
fileMatchPattern: "**/*.py"
description: Enforces production-grade Python standards including type hints, structured logging, and defensive error handling.
---

# Python Standards — AOL Underground Proggies Archive

## PRODUCTION GRADE REQUIREMENT

These scripts manage and index a historic archive of AOL programs. Data
integrity matters — incorrect indexing, lost metadata, or silent failures
mean proggies get misfiled or lost. Every script must be production grade:
defensive, well-tested, and fail-safe. When in doubt, fail loudly and safely
rather than silently proceeding with bad data.

## CRITICAL RULES (OVERRIDE ALL OTHERS)

- NEVER make up functions, methods, library APIs, or parameter names
- NEVER guess method signatures — verify they exist in the target library version
- NEVER present unverified solutions as working code
- ALL exceptions must be handled — no unhandled crashes in production tools
- State uncertainty directly: "I need to verify this" rather than guessing

## Language & Runtime

- Python 3.10+ (Kali ships 3.11+)
- Use `from __future__ import annotations` for forward references
- Use `pathlib.Path` instead of `os.path` for all file operations
- Maximum line length: 120 characters

## Script Structure (MANDATORY)

Every script must have:

```python
#!/usr/bin/env python3
"""Brief description of what this tool does."""
from __future__ import annotations

import argparse
import logging
import sys
from datetime import datetime
from pathlib import Path

logger = logging.getLogger(__name__)

def setup_logging(verbose: bool = False) -> None:
    """Configure timestamped logging to console and optional file."""
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    datefmt = "%Y-%m-%d %H:%M:%S"
    logging.basicConfig(level=level, format=fmt, datefmt=datefmt)

def main() -> int:
    parser = argparse.ArgumentParser(description="Tool description")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Enable verbose/debug logging")
    # ... other args
    args = parser.parse_args()

    setup_logging(verbose=args.verbose)
    logger.info("Starting %s", Path(__file__).name)

    try:
        # main logic
        pass
    except KeyboardInterrupt:
        logger.warning("Interrupted by user")
        return 130
    except Exception:
        logger.exception("Fatal error")
        return 1

    logger.info("Completed successfully")
    return 0

if __name__ == "__main__":
    sys.exit(main())
```

## Type Hints (MANDATORY)

- Type hints required on ALL function signatures and return types
- Use `str | None` syntax (Python 3.10+) or `Optional[str]` with import
- Use `list[str]` not `List[str]` (Python 3.9+ built-in generics)

```python
def scan_target(ip: str, port: int, timeout: float = 5.0) -> dict[str, str] | None:
    """Scan a single target and return results or None on failure."""
    ...
```

## Logging (MANDATORY — NO print())

- Use the `logging` module for ALL output — never `print()`
- All log entries include ISO 8601 timestamps automatically via format string
- Verbose trace logs on execution flow help debug field issues
- Log levels:
  - DEBUG: detailed trace of execution flow, variable values, timing
  - INFO: operational milestones (starting scan, target count, completion)
  - WARNING: anomalies that don't stop execution (timeout, retry, skip)
  - ERROR: failures that affect results
  - CRITICAL: failures that require immediate abort

```python
logger.debug("Connecting to %s:%d (timeout=%.1fs)", ip, port, timeout)
logger.info("Scanning %d targets with %d threads", len(targets), thread_count)
logger.warning("Target %s timed out after %.1fs, skipping", ip, timeout)
logger.error("Failed to write results to %s: %s", output_path, e)
```

### File Logging (for long-running tools)

```python
def setup_logging(verbose: bool = False, log_file: Path | None = None) -> None:
    level = logging.DEBUG if verbose else logging.INFO
    fmt = "%(asctime)s [%(levelname)-8s] %(name)s: %(message)s"
    datefmt = "%Y-%m-%d %H:%M:%S"

    handlers: list[logging.Handler] = [logging.StreamHandler()]
    if log_file:
        log_file.parent.mkdir(parents=True, exist_ok=True)
        handlers.append(logging.FileHandler(log_file, encoding="utf-8"))

    logging.basicConfig(level=level, format=fmt, datefmt=datefmt,
                        handlers=handlers)
```

## Error Handling (MANDATORY)

- All exceptions must be logged with full stack traces at DEBUG level
- User-facing errors logged at ERROR level with context
- Never silently swallow exceptions
- No bare `except:` — always catch specific exceptions
- Network/file operations must have timeouts and retries where appropriate

```python
# FORBIDDEN:
except:
    pass

except Exception:
    pass  # silently swallowed

# REQUIRED:
except ConnectionError as e:
    logger.error("Connection to %s failed: %s", target, e)
    logger.debug("Full traceback:", exc_info=True)
    return None

except (OSError, PermissionError) as e:
    logger.error("Cannot write to %s: %s", path, e)
    raise
```

## Anti-Patterns (FORBIDDEN)

- No bare `except:` clauses — always catch specific exceptions
- No mutable default arguments (`def f(x=[])` — use `None` and assign inside)
- No global mutable state — use function parameters or config objects
- No `print()` for output — use logging exclusively
- No hardcoded credentials, IPs, or secrets — use argparse or config files
- No `eval()` or `exec()` calls
- No `import *` wildcard imports
- No nested functions deeper than 2 levels
- No `os.system()` or `subprocess.call()` with `shell=True` — use
  `subprocess.run()` with argument lists
- **NEVER embed scripts from other languages (PowerShell, Bash, SQL, etc.)
  as Python string literals, f-strings, or triple-quoted strings inside
  Python source files.** This is an unmaintainable nightmare that:
  - Breaks syntax highlighting, linting, and IDE support for the embedded language
  - Creates brace/quote escaping hell (`{{` vs `{` in f-strings, `\\\\` for `\\`)
  - Makes bugs invisible (ISSUE-01: double braces in non-f-string produced
    invalid PS syntax that was a showstopper parse error — undetectable without
    manually reading the generated output)
  - Prevents the embedded script from being tested, validated, or reviewed
    independently of the Python wrapper
  - **Instead**: Store scripts as external `.ps1` / `.sh` / `.sql` template files
    in a `templates/` directory alongside the Python module. Use `__PLACEHOLDER__`
    dunder-style tokens with `.replace('__PLACEHOLDER__', value)` for substitution.
    Do NOT use `string.Template` — its `$variable` syntax collides with PowerShell
    `$variable` syntax and will silently corrupt the generated script. Load templates
    at runtime via `pathlib.Path` relative to the module file.

## Multi-Language Pipeline Safety (Python generating PS1/Bash/SQL)

When Python code generates scripts in another language:

- **f-string vs regular string confusion**: If a function returns a triple-quoted
  string with `{{` and `}}`, verify whether it has the `f` prefix. In a regular
  string (no `f`), `{{` outputs literally as `{{` — NOT as `{`. This was the root
  cause of ISSUE-01 (showstopper parse error that broke the entire tool).
- **Brace-balance assertion**: After assembling any generated script from multiple
  template fragments, ALWAYS assert brace balance before writing to disk:
  ```python
  assert script.count('{') == script.count('}'), f"Brace mismatch: {script.count('{')} open vs {script.count('}')} close"
  ```
- **Delimiter verification**: When building multi-language pipelines, count all
  delimiter pairs (braces, parens, brackets, quotes) in the generated output.
  A mismatch means a template or substitution is broken.
- **Template files must be independently testable**: You should be able to open a
  `.ps1` template in ISE (after manual placeholder replacement) and validate its
  syntax. If a template can't pass a syntax check in its native language, it's broken.
- **Cross-function structural dependencies**: If a `try` block opens in one template
  and `finally` closes in another, add prominent comments in BOTH templates documenting
  the dependency, AND add a brace-balance assertion in the Python assembly function.

## Thread Safety

- Use `concurrent.futures.ThreadPoolExecutor` for multithreading
- All shared state must use `threading.Lock` or `queue.Queue`
- HTTP client instances must be thread-safe or per-thread
- No daemon threads without proper cleanup in `finally` or `atexit`

```python
from concurrent.futures import ThreadPoolExecutor, as_completed

with ThreadPoolExecutor(max_workers=threads) as pool:
    futures = {pool.submit(scan_host, ip): ip for ip in targets}
    for future in as_completed(futures):
        ip = futures[future]
        try:
            result = future.result(timeout=30)
            logger.debug("Completed %s: %s", ip, result)
        except Exception:
            logger.exception("Failed scanning %s", ip)
```

## Network Operations

- Configurable timeouts (default: 10s connect, 30s read)
- TLS verification configurable (default: enabled, flag to disable for pentesting)
- Retry logic for transient failures (connection reset, timeout)
- Log connection attempts at DEBUG level with timing

```python
import socket

def check_port(ip: str, port: int, timeout: float = 5.0) -> bool:
    """Check if a TCP port is open."""
    logger.debug("Checking %s:%d (timeout=%.1fs)", ip, port, timeout)
    try:
        with socket.create_connection((ip, port), timeout=timeout):
            logger.debug("Port %d open on %s", port, ip)
            return True
    except (socket.timeout, ConnectionRefusedError, OSError) as e:
        logger.debug("Port %d closed/filtered on %s: %s", port, ip, e)
        return False
```

## Output & Reporting

- All results must be exportable to CSV or JSON
- Use timestamped output directories for scan results: `output/YYYY-MM-DD_HHMMSS/`
- Every script must support `-o`/`--output` for output path
- Use `csv.DictWriter` for CSV output (not manual string formatting)

## Data Structures

- Use `dataclasses` for structured data, not plain dicts
- Use `TypedDict` when dict structure must be documented
- Use `enum.Enum` for fixed sets of values

```python
from dataclasses import dataclass, field

@dataclass
class ScanResult:
    ip: str
    port: int
    status: str
    banner: str = ""
    timestamp: str = field(default_factory=lambda: datetime.now().isoformat())
```

## File Operations

```python
from pathlib import Path

# ALWAYS use pathlib
output_dir = Path(args.output)
output_dir.mkdir(parents=True, exist_ok=True)

# ALWAYS use context managers
with open(output_dir / "results.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["ip", "port", "status"])
    writer.writeheader()
    writer.writerows(results)
```

## Pre-Delivery Checklist

Before submitting any Python code:
- [ ] All function signatures have type hints and return types
- [ ] All exceptions caught specifically (no bare except)
- [ ] All output uses logging, not print()
- [ ] All file/network operations have error handling
- [ ] argparse with --help for all CLI scripts
- [ ] `if __name__ == "__main__"` guard present
- [ ] No hardcoded credentials or secrets
- [ ] No made-up library functions or method signatures
- [ ] Timeouts on all network operations
- [ ] Verbose/debug logging traces execution flow with timestamps
