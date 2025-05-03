#!/usr/bin/env bash

sha=$(readlink latest | head -c10)

magick montage latest/*.png -tile 3x -pointsize 48 -set label '%f' -frame 5 -shadow -geometry +20+20 montage_raw.png

magick montage_raw.png \
	-resize 1920x1920\> \
	-gravity North -fill white -stroke black -strokewidth 2 -pointsize 64 -annotate +0+040 "commit: $sha" \
	latest.png
