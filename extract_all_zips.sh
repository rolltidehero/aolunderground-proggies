#!/usr/bin/env bash
set -euo pipefail

trap 'printf "\nInterrupted\n"; exit 130' INT TERM

usage() {
    printf "Usage: %s\n" "$(basename "$0")"
    printf "  Extracts all .zip files in the current directory tree\n"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
fi

cd "$(dirname "$0")"

count=0
failed=0

while IFS= read -r -d '' zipfile; do
    dir="$(dirname "${zipfile}")"
    base="$(basename "${zipfile}" .zip)"
    dest="${dir}/_extracted/${base}"
    mkdir -p "${dest}"
    if unzip -o -q "${zipfile}" -d "${dest}" 2>/dev/null; then
        ((count++))
    else
        printf "FAILED: %s\n" "${zipfile}"
        ((failed++))
    fi
done < <(find . -name "*.zip" -print0)

printf "Done. Extracted: %d, Failed: %d\n" "${count}" "${failed}"
