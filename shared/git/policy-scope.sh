#!/usr/bin/env bash
set -euo pipefail

git=${POLICY_SCOPE_GIT:-git}
read -r -a owners <<<"${POLICY_SCOPE_OWNERS:-}"

[ ${#owners[@]} -eq 0 ] && exit 0

owned() {
    local u=${1%/}
    case $u in /* | .* | file://*) return 0 ;; esac
    u=${u%.git}
    u=${u%/*}
    u=${u##*[:/]}
    local o
    for o in "${owners[@]}"; do
        [ "${u,,}" = "${o,,}" ] && return 0
    done
    return 1
}

while read -r _ url; do
    owned "$url" || exit 1
done < <("$git" config --get-regexp '^remote\..*\.url$' || true)

exit 0
