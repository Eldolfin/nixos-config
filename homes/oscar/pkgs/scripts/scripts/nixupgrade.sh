#!/bin/sh

pushd /etc/nixos
nix flake update
git add flake.lock
git commit -m "update flake.lock"
nh os switch /etc/nixos
popd
