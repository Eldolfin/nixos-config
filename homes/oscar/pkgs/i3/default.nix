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
          volumeChange = import ./changeVolume.nix pkgs;
        in
        lib.mkOptionDefault {
          #######################
          #  Window Management  #
          #######################
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Control+1" = "move container to workspace number 1; workspace number 1";
          "${mod}+Control+2" = "move container to workspace number 2; workspace number 2";
          "${mod}+Control+3" = "move container to workspace number 3; workspace number 3";
          "${mod}+Control+4" = "move container to workspace number 4; workspace number 4";
          "${mod}+Control+5" = "move container to workspace number 5; workspace number 5";
          "${mod}+Control+6" = "move container to workspace number 6; workspace number 6";
          "${mod}+Control+7" = "move container to workspace number 7; workspace number 7";
          "${mod}+Control+8" = "move container to workspace number 8; workspace number 8";
          "${mod}+Control+9" = "move container to workspace number 9; workspace number 9";
          "${mod}+Control+0" = "move container to workspace number 10; workspace number 10";

          "${mod}+Control+h" = "move workspace to output left";
          "${mod}+Control+j" = "move workspace to output down";
          "${mod}+Control+k" = "move workspace to output up";
          "${mod}+Control+l" = "move workspace to output right";

          "${mod}+y" = "resize shrink width 10 px or 10 ppt";
          "${mod}+u" = "resize grow height 10 px or 10 ppt";
          "${mod}+i" = "resize shrink height 10 px or 10 ppt";
          "${mod}+o" = "resize grow width 10 px or 10 ppt";

          "${mod}+Shift+P" = "move scratchpad";
          "${mod}+p" = "scratchpad show";

          "${mod}+a" = "layout toggle tabbed splith splitv";
          "${mod}+Tab" = "workspace back_and_forth";
          "${mod}+w" = "exec /home/oscar/.config/i3/scripts/i3-display-swap.sh";

          ########################
          #  Programs Shortcuts  #
          ########################
          "${mod}+Return" = "exec alacritty";
          "${mod}+e" = "exec firefox";
          "${mod}+Shift+e" = "exec firefox --private-window";
          "${mod}+v" = "exec copyq show";
          "${mod}+m" = "exec /home/oscar/bin/scripts/toggle-lamp.sh";

          "${mod}+d" = "exec rofi -show drun";
          "${mod}+Shift+x" = "exec \"rofi -show p -modi p:'rofi-power-menu'\"";

          "${mod}+t" = "exec $term -e btop -p 1";
          "${mod}+Shift+b" = "exec --no-startup-id \"bluetoothctl connect 88:C9:E8:42:A0:B1\"";
          "Shift+Print" = "exec flameshot gui";
          "${mod}+x" = "exec --no-startup-id i3lock-fancy-rapid 0 1";

          "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";

          ###################
          #  Media control  #
          ###################
          "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s -e 10%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl s -e 10%-";

          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";

          "XF86AudioMute" = "exec ${volumeChange}/bin/volume-change t";
          "XF86AudioLowerVolume" = "exec ${volumeChange}/bin/volume-change d";
          "XF86AudioRaiseVolume" = "exec ${volumeChange}/bin/volume-change i";
          "F2" = "exec ${volumeChange}/bin/volume-change d";
          "F3" = "exec ${volumeChange}/bin/volume-change i";
        };
    };
  };
}
