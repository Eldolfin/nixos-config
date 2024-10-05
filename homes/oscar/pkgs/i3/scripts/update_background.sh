#!/usr/bin/env bash
files=(~/.backgrounds/*)
WALLPAPER=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
feh -B white --bg-fill "$WALLPAPER"
