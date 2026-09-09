#!/usr/bin/env bash
# git-ship.sh — Branch, stage, validate, commit, merge to main, push, cleanup.
#
# Adapted for this repo's branch-based workflow with gate enforcement.
#
# Usage:
#   bash tools/git-ship.sh <branch-name> <commit-message> [files...] [flags...]
#
# Examples:
#   # Stage specific files
#   bash tools/git-ship.sh feat/new-tool "feat: add decompiler helper" tools/new_tool.py tests/test_new_tool.py
#
#   # Stage all changes (no files listed = git add -A)
#   bash tools/git-ship.sh fix/typo "fix: typo in README"
#
#   # With gate flags
#   bash tools/git-ship.sh feat/classifier "feat: add vb version classifier" tools/detect_vb_version.py \
#       --adr-ack "0001:extends" \
#       --quality-check "sauron:pass,boyscout:pass"
#
#   # Trivial fix (bypass all gates)
#   bash tools/git-ship.sh fix/typo "fix: typo in readme" README.md \
#       --quality-bypass "trivial: typo" \
#       --test-bypass "trivial: no code change"
#
# What it does (in order):
#   1. Creates branch from main (or uses current if already on it)
#   2. Stages specified files (or all with git add -A)
#   3. Rebuilds code graph (so Annie has fresh caller data)
#   4. Runs adr_check.py with enforcement layers:
#      - Layer 0: ADR creation gate (signal detection)
#      - Layer 1: ADR scope matching (hard gate)
#      - Layer 2: BM25 relevance (informational)
#      - Layer 4: Quality attestation (Annie orphan check + Sauron/Boyscout)
#      - Layer 5: Test co-change enforcement
#   5. Commits with trailers recording all bypass/ack decisions
#   6. Pushes branch to origin
#   7. Merges to main (--no-ff)
#   8. Pushes main
#   9. Deletes the feature branch locally and remotely

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

die() { echo -e "${RED}ERROR: $1${NC}" >&2; exit 1; }
info() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }

# --- Args ---
if [ $# -lt 2 ]; then
    echo "Usage: $0 <branch-name> <commit-message> [files...] [flags...]"
    echo ""
    echo "  branch-name     feat/xxx, fix/xxx, docs/xxx, refactor/xxx, chore/xxx, test/xxx"
    echo "  commit-message  Conventional commit message"
    echo "  files...        Files to stage (optional, default: all changes)"
    echo ""
    echo "Flags:"
    echo "  --adr-ack \"NNNN:disposition\"    Acknowledge ADR scope match"
    echo "  --adr-bypass \"reason\"            Bypass ADR creation gate"
    echo "  --quality-check \"sauron:pass,...\" Attest quality rule compliance"
    echo "  --quality-bypass \"reason\"         Bypass quality attestation"
    echo "  --test-bypass \"reason\"            Bypass test co-change requirement"
    exit 1
fi

BRANCH="$1"
COMMIT_MSG="$2"
shift 2

# Extract flags from remaining args
ADR_ACK=""
ADR_BYPASS=""
QUALITY_CHECK=""
QUALITY_BYPASS=""
TEST_BYPASS=""
FILES=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --adr-ack=*)     ADR_ACK="${1#--adr-ack=}" ;;
        --adr-ack)       shift; ADR_ACK="${1:-}" ;;
        --adr-bypass=*)  ADR_BYPASS="${1#--adr-bypass=}" ;;
        --adr-bypass)    shift; ADR_BYPASS="${1:-}" ;;
        --quality-check=*)  QUALITY_CHECK="${1#--quality-check=}" ;;
        --quality-check)    shift; QUALITY_CHECK="${1:-}" ;;
        --quality-bypass=*) QUALITY_BYPASS="${1#--quality-bypass=}" ;;
        --quality-bypass)   shift; QUALITY_BYPASS="${1:-}" ;;
        --test-bypass=*)    TEST_BYPASS="${1#--test-bypass=}" ;;
        --test-bypass)      shift; TEST_BYPASS="${1:-}" ;;
        *)                  FILES+=("$1") ;;
    esac
    shift
done

# --- Validate branch name ---
if [[ ! "$BRANCH" =~ ^(feat|fix|docs|refactor|chore|test)/ ]]; then
    die "Branch name must start with feat/, fix/, docs/, refactor/, chore/, or test/"
fi

# --- Detect default branch ---
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "")
if [[ -z "$DEFAULT_BRANCH" ]]; then
    if git show-ref --verify --quiet refs/heads/main; then
        DEFAULT_BRANCH="main"
    else
        DEFAULT_BRANCH="master"
    fi
fi

# --- Block direct commits to default branch ---
CURRENT=$(git branch --show-current)

if [ "$CURRENT" = "$DEFAULT_BRANCH" ]; then
    info "Creating branch: $BRANCH"
    git checkout -b "$BRANCH"
elif [ "$CURRENT" = "$BRANCH" ]; then
    info "Already on branch: $BRANCH"
else
    die "Currently on '$CURRENT' — expected '$DEFAULT_BRANCH' or '$BRANCH'"
fi

# --- Stage ---
if [ ${#FILES[@]} -eq 0 ]; then
    warn "No files specified — staging all changes"
    git add -A
else
    git add "${FILES[@]}"
fi

# --- Check something is staged ---
if git diff --cached --quiet; then
    die "Nothing staged to commit"
fi

# --- Rebuild code graph BEFORE checks (Annie needs current callers) ---
REPO_ROOT="$(git rev-parse --show-toplevel)"
if [[ -f "$REPO_ROOT/tools/code-graph/build_graph.py" ]]; then
    info "Rebuilding code graph..."
    python3 "$REPO_ROOT/tools/code-graph/build_graph.py" 2>/dev/null || true
fi

# --- ADR + Quality + Test checks ---
STAGED_FILES=$(git diff --cached --name-only)
ADR_CHECK="$REPO_ROOT/tools/adr_check.py"

if [[ -f "$ADR_CHECK" ]]; then
    DIFF_TEXT=$(git diff --cached --unified=0)
    NEW_FILES=$(git diff --cached --diff-filter=A --name-only)

    ADR_ARGS=(--staged-files $STAGED_FILES --commit-msg "$COMMIT_MSG")
    ADR_ARGS+=(--diff "$DIFF_TEXT")
    if [[ -n "$NEW_FILES" ]]; then
        ADR_ARGS+=(--new-files $NEW_FILES)
    fi
    [[ -n "$ADR_ACK" ]]        && ADR_ARGS+=(--adr-ack "$ADR_ACK")
    [[ -n "$ADR_BYPASS" ]]     && ADR_ARGS+=(--adr-bypass "$ADR_BYPASS")
    [[ -n "$QUALITY_CHECK" ]]  && ADR_ARGS+=(--quality-check "$QUALITY_CHECK")
    [[ -n "$QUALITY_BYPASS" ]] && ADR_ARGS+=(--quality-bypass "$QUALITY_BYPASS")
    [[ -n "$TEST_BYPASS" ]]    && ADR_ARGS+=(--test-bypass "$TEST_BYPASS")

    if ! python3 "$ADR_CHECK" "${ADR_ARGS[@]}"; then
        die "Gate check failed. See above for required flags."
    fi
fi

# --- Build commit message with trailers ---
TRAILERS=""
[[ -n "$ADR_BYPASS" ]]     && TRAILERS="${TRAILERS}\n\nADR-Bypass: ${ADR_BYPASS}"
[[ -n "$QUALITY_CHECK" ]]  && TRAILERS="${TRAILERS}\n\nQuality-Check: ${QUALITY_CHECK}"
[[ -n "$QUALITY_BYPASS" ]] && TRAILERS="${TRAILERS}\n\nQuality-Bypass: ${QUALITY_BYPASS}"
[[ -n "$TEST_BYPASS" ]]    && TRAILERS="${TRAILERS}\n\nTest-Bypass: ${TEST_BYPASS}"

if [[ -n "$TRAILERS" ]]; then
    COMMIT_MSG="${COMMIT_MSG}${TRAILERS}"
fi

info "Committing: $(echo -e "$COMMIT_MSG" | head -1)"
git commit -m "$(echo -e "$COMMIT_MSG")"

# --- Push branch to origin ---
info "Pushing branch to origin..."
git push -u origin "$BRANCH"

# --- Merge into default branch ---
info "Merging $BRANCH into $DEFAULT_BRANCH..."
git checkout "$DEFAULT_BRANCH"
git merge --no-ff "$BRANCH" -m "Merge branch '$BRANCH'"

# --- Push default branch ---
info "Pushing $DEFAULT_BRANCH to origin..."
git push origin "$DEFAULT_BRANCH"

# --- Delete branch ---
info "Deleting branch $BRANCH..."
git branch -d "$BRANCH"
if git ls-remote --exit-code --heads origin "$BRANCH" &>/dev/null; then
    git push origin --delete "$BRANCH"
fi

info "Done. Merged $BRANCH → $DEFAULT_BRANCH and pushed."
