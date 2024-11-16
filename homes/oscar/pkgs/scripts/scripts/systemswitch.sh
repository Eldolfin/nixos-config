#!/bin/sh

set -e

# TODO: parse args --amend, --build-only, -m <message>, ...

cd /etc/nixos/
$EDITOR .
git add .
git commit
nh os switch /etc/nixos
git push
