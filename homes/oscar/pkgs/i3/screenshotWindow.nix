{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScript "screenshot-window" ''
  #!/bin/sh
  set -xeu

  ${lib.getExe pkgs.scrot} -fpu '/home/oscar/Pictures/Screenshots/%Y-%m-%d_$W_$wx$h.png' -e '
    echo $f | ${lib.getExe pkgs.xclip} -selection clipboard
  ' &&
  ${lib.getExe pkgs.libnotify} "Screenshot path copied to clipboard"
''
