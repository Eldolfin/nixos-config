#!/bin/sh

HM_DIR=~/nixos-config/homes/oscar

set -e

cd $HM_DIR
$EDITOR .
git add .
git commit -m "Home switch"
nh os switch $HM_DIR
git push
