#!/bin/sh

set -e

cd /etc/nixos/
$EDITOR .
git commit -a
nh os switch /etc/nixos
git push
