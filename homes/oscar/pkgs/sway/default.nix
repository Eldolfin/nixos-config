{
  config,
  lib,
  pkgs,
  ...
}: {
  home.keyboard.layout = "fr";
  programs.swaylock = {
    enable = true;
    settings = {
      indicator-radius = 200;
      show-failed-attempts = true;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      terminal = lib.getExe pkgs.alacritty;
      input = {
        "1008:1610:Primax_HP_USB_Keyboard" = {
          xkb_layout = "fr";
        };
        "*" = {
          xkb_options = "caps:escape";
        };
      };
      output = {
        "DP-3" = {
          mode = "1920x1080@143.996Hz";
          pos = "0 0";
        };
        "DP-4" = {
          mode = "1920x1200@59.950Hz";
          pos = "1920 0";
        };
      };
      bindkeysToCode = true;
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
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

          "${mod}+ampersand" = "workspace number 1";
          "${mod}+eacute" = "workspace number 2";
          "${mod}+quotedbl" = "workspace number 3";
          "${mod}+apostrophe" = "workspace number 4";
          "${mod}+parenleft" = "workspace number 5";
          "${mod}+egrave" = "workspace number 6";
          "${mod}+minus" = "workspace number 7";
          "${mod}+underscore" = "workspace number 8";
          "${mod}+ccedilla" = "workspace number 9";
          "${mod}+agrave" = "workspace number 10";

          "${mod}+Shift+ampersand" = "move container to workspace number 1";
          "${mod}+Shift+eacute" = "move container to workspace number 2";
          "${mod}+Shift+quotedbl" = "move container to workspace number 3";
          "${mod}+Shift+apostrophe" = "move container to workspace number 4";
          "${mod}+Shift+parenleft" = "move container to workspace number 5";
          "${mod}+Shift+egrave" = "move container to workspace number 6";
          "${mod}+Shift+minus" = "move container to workspace number 7";
          "${mod}+Shift+underscore" = "move container to workspace number 8";
          "${mod}+Shift+ccedilla" = "move container to workspace number 9";
          "${mod}+Shift+agrave" = "move container to workspace number 10";

          "${mod}+Control+ampersand" = "move container to workspace number 1; workspace number 1";
          "${mod}+Control+eacute" = "move container to workspace number 2; workspace number 2";
          "${mod}+Control+quotedbl" = "move container to workspace number 3; workspace number 3";
          "${mod}+Control+apostrophe" = "move container to workspace number 4; workspace number 4";
          "${mod}+Control+parenleft" = "move container to workspace number 5; workspace number 5";
          "${mod}+Control+egrave" = "move container to workspace number 6; workspace number 6";
          "${mod}+Control+minus" = "move container to workspace number 7; workspace number 7";
          "${mod}+Control+underscore" = "move container to workspace number 8; workspace number 8";
          "${mod}+Control+ccedilla" = "move container to workspace number 9; workspace number 9";
          "${mod}+Control+agrave" = "move container to workspace number 10; workspace number 10";

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
          "${mod}+r" = "nop"; # useless

          "${mod}+Shift+P" = "move scratchpad";
          "${mod}+p" = "scratchpad show";

          "${mod}+a" = "layout toggle tabbed splith splitv";
          "${mod}+Tab" = "workspace back_and_forth";

          ########################
          #  Programs Shortcuts  #
          ########################
          "${mod}+Return" = "exec wezterm";
          "${mod}+e" = "exec firefox";
          "${mod}+Shift+e" = "exec firefox --private-window";
          "${mod}+v" = "exec ${lib.getExe pkgs.copyq} show";
          # "${mod}+m" = "exec /home/oscar/bin/scripts/toggle-lamp.sh";

          "${mod}+d" = "exec ${lib.getExe pkgs.rofi-wayland} -show drun";
          "${mod}+Shift+x" = "exec \"${lib.getExe pkgs.rofi-wayland} -show p -modi p:'rofi-power-menu'\"";

          "${mod}+t" = "exec wezterm --config font_size=10 -e btop";
          "${mod}+Shift+b" = "exec --no-startup-id \"bluetoothctl connect 88:C9:E8:42:A0:B1\"";
          "Shift+Print" = "exec flameshot gui";
          # "${mod}+Print" = "exec ${screenshotWindow}";
          "${mod}+Control+x" = "exec --no-startup-id swaylock";

          "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";
          "${mod}+w" = "exec ${lib.getExe pkgs.woomer}";

          ###################
          #  Media control  #
          ###################
          "XF86MonBrightnessUp" = "exec --no-startup-id ${lib.getExe pkgs.brightnessctl} s -e 10%+";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${lib.getExe pkgs.brightnessctl} s -e 10%-";

          "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioPause" = "exec ${lib.getExe pkgs.playerctl} play-pause";

          # TODO
          # "XF86AudioMute" = "exec ${volumeChange} t";
          # "XF86AudioLowerVolume" = "exec ${volumeChange} d";
          # "XF86AudioRaiseVolume" = "exec ${volumeChange} i";
          # "F2" = "exec ${volumeChange} d";
          # "F3" = "exec ${volumeChange} i";
        };
    };
  };
}
