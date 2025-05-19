#!/usr/bin/env bash
set -xe

PROMPT="
- Given the git diff and the last few commits, propose a commit message following the project commit format.
- Output only the commit message nothing more.
- Do not describe the commit message afterward
- Do not generate commit messages longer than 80 characters
- Do not put quotes or stars around the commit message
"

TMP_LAST_COMMITS='/tmp/aichat-last-commits.txt'
TMP_GIT_DIFF='/tmp/aichat-git-diff.txt'
TMP_GITCOMMIT='/tmp/aichat-gitcommit.txt'

git log --oneline | head -n 10 >$TMP_LAST_COMMITS
git diff --no-ext-diff --staged >$TMP_GIT_DIFF
aichat \
	--model mistral:open-mistral-nemo \
	--file $TMP_GIT_DIFF --file $TMP_LAST_COMMITS \
	"$PROMPT" |
	tr -d \" >$TMP_GITCOMMIT

git commit -F $TMP_GITCOMMIT --edit
