#!/usr/bin/env bash
set -euo pipefail

trap 'printf "\nInterrupted\n"; exit 130' INT TERM

usage() {
    printf "Usage: %s <filename>\n" "$(basename "$0")"
}

die() {
    printf "%s: Error: %s\n" "$0" "$*" >&2
    exit 1
}

(( "$#" == 1 )) || die "Wrong arguments.$(printf '\n\n')$(usage)"

readonly FILE="${1}"
readonly COMMIT_MESSAGE="autocommit"

[[ -f "${FILE}" ]] || die "File ${FILE} does not exist"

printf "adding %s to git..." "${FILE}"
git add "${FILE}" || die "git add ${FILE} has failed."
printf "done\n"

printf "committing %s to git...\n" "${FILE}"
git commit -m "${COMMIT_MESSAGE}" || die "git commit has failed."
# push handled by post-commit hook
