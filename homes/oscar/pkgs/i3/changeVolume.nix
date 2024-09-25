pkgs:
let
  volumeStep = toString 5;
in
pkgs.writeShellScriptBin "volume-change" ''
  #!/bin/sh
  set -e

  if [ $# != 1 ]; then
  	echo "Usage: ./volume-change.sh [i|d|t]"
  	echo "i: increase volume"
  	echo "d: decrease volume"
  	echo "t: toggle mute"
  	exit 1
  fi

  ${pkgs.pamixer}/bin/pamixer -"$1" ${volumeStep}
  ${pkgs.pulseaudio}/bin/paplay ~/Music/sounds/audio-volume-change.oga &

  VOL=$(${pkgs.pamixer}/bin/pamixer --get-volume)
  ICON=
  if [ "$(${pkgs.pamixer}/bin/pamixer --get-mute)" = "true" ]; then
  	ICON="${pkgs.gnome-themes-extra}/share/icons/HighContrast/256x256/status/audio-volume-muted.png"
  else
  	ICON="${pkgs.gnome-themes-extra}/share/icons/HighContrast/256x256/devices/audio-speakers.png"
  fi

  ${pkgs.libnotify}/bin/notify-send "Volume: $VOL" \
    -t 1000 \
    -i "$ICON" \
    -h int:value:$VOL \
    -h string:synchronous:volume
''
