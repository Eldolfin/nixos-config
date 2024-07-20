#!/usr/bin/env bash

set -e

trap 'notify-send "System switch failed 😢"' ERR

pushd /etc/nixos/
$EDITOR .
echo "Rebuilding system..."
git add . && git commit -m "System switch"
nh os switch /etc/nixos
git push
popd

notify-send "System switch complete 🎉"
