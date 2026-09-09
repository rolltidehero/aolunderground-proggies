#!/usr/bin/env bash
# code-graph — wrapper for the aolunderground-proggies code graph.
#
# Usage:
#   bash tools/code-graph/code-graph.sh callers <function>
#   bash tools/code-graph/code-graph.sh callees <function>
#   bash tools/code-graph/code-graph.sh imports <name>
#   bash tools/code-graph/code-graph.sh impl <function>
#   bash tools/code-graph/code-graph.sh chain <source> <target>
#   bash tools/code-graph/code-graph.sh neighbors <file>
#   bash tools/code-graph/code-graph.sh stats
#   bash tools/code-graph/code-graph.sh rebuild
#
# Requires: pip install tree-sitter tree-sitter-python
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Check for tree-sitter availability
if ! python3 -c "import tree_sitter_python" 2>/dev/null; then
    echo "Installing tree-sitter dependencies..." >&2
    pip install tree-sitter tree-sitter-python -q
fi

# If no args or "build", run the builder
if [[ $# -eq 0 ]] || [[ "$1" == "build" ]]; then
    exec python3 "$SCRIPT_DIR/build_graph.py"
fi

# Otherwise run query.py
exec python3 "$SCRIPT_DIR/query.py" "$@"
