#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage $0 <tag>"
fi

TAG=$1

set -xe

git commit -m "$TAG" || true
git tag -ma "$TAG"
git push --follow-tags
