#!/bin/sh
set -eu

# Usage: git dlm [base]. Base defaults to origin's default branch, else the current branch.
current=$(git branch --show-current)
base=${1:-$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || echo "$current")}

git remote prune origin 2>/dev/null || true

git for-each-ref --merged="$base" --format='%(refname:short)' refs/heads/ |
    grep -vxF -e main -e master -e develop -e "$current" |
    xargs -r git branch -d
