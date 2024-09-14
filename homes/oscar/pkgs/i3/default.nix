{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ./i3blocks ];
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
  };
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = lib.strings.fileContents ./config.old;
    config = {
      modifier = "Mod4";
      startup = [
        {
          command = "${pkgs.i3-auto-layout}/bin/i3-auto-layout";
          notification = false;
        }
      ];
      bars = [ { statusCommand = "${pkgs.i3blocks}/bin/i3blocks"; } ];
      defaultWorkspace = "workspace number 1";
      keybindings =
        let
          mod = config.xsession.windowManager.i3.config.modifier;
          volumeStep = toString 5;
          volumeChange = pkgs.writeShellScriptBin "volume-change" ''
            #!/bin/sh
            set -e

            if [ $# != 1 ]; then
            	echo "Usage: $0 [i|d]"
            	exit 1
            fi

            ${pkgs.pamixer}/bin/pamixer -"$1" ${volumeStep}
            VOL=$(${pkgs.pamixer}/bin/pamixer --get-volume)

            notify-send "Volume: $VOL" \
              -i ${pkgs.gnome-themes-extra}/share/icons/HighContrast/256x256/devices/audio-speakers.png \
              -h int:value:$VOL \
              -h string:synchronous:volume

            paplay ~/Music/sounds/audio-volume-change.oga
          '';
        in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec alacritty";
          "${mod}+e" = "exec firefox";
          "${mod}+Shift+e" = "exec firefox --private-window";
          "${mod}+d" = "exec rofi -show drun";
          "${mod}+v" = "exec copyq show";

          "${mod}+w" = "exec /home/oscar/.config/i3/scripts/i3-display-swap.sh";
          "${mod}+m" = "exec /home/oscar/bin/scripts/toggle-lamp.sh";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioLowerVolume" = "exec ${volumeChange} d";
          "XF86AudioRaiseVolume" = "exec ${volumeChange} i";
          "F2" = "exec ${volumeChange} d";
          "F3" = "exec ${volumeChange} i";

          # sound effects
          "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";
        };
    };
  };
}
