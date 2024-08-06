#!/bin/sh

set -e

cd /etc/nixos/
$EDITOR .
git add .
git commit -m "System switch"
nh os switch /etc/nixos
git push
