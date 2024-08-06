#!/bin/sh

set -e

cd /etc/nixos
nix flake update
git add flake.lock
git commit -m "update flake.lock"
nh os switch /etc/nixos
git push
