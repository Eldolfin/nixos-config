{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./i3status-rs.nix
    ./services.nix
  ];
  home.keyboard.layout = "fr";
  home.packages = with pkgs; [
    wl-clipboard
    fuzzel
  ];
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];

  programs.swaylock = {
    enable = true;
    settings = {
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    config = let
      lockAction = "exec --no-startup-id swaylock";
      mod = "Mod4";
    in {
      modifier = mod;
      defaultWorkspace = "workspace number 1";
      terminal = lib.getExe pkgs.alacritty;
      startup = [
        {command = lib.getExe pkgs.autotiling-rs;}
        {command = "${lib.getExe' pkgs.planify "io.github.alainm23.planify"} -b";}
        {
          command = "exec ${lib.getExe (import ./scripts/lower-brightness-if-night.nix pkgs)}";
          always = true;
        }
      ];
      floating = {
        criteria = [
          {
            class = "clipse";
          }
        ];
      };
      input = {
        "1008:1610:Primax_HP_USB_Keyboard" = {
          xkb_layout = "fr";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "gb";
        };
        "1267:51:Elan_Touchpad" = {
          scroll_factor = "3";
        };
        "*" = {
          repeat_delay = "250";
          repeat_rate = "50";
          xkb_options = "caps:escape";
          xkb_numlock = "enabled";
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
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "bottom";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "i3status-rs config-bottom.toml";
          fonts = {
            names = ["DejaVu Sans Mono" "JetBrainsMonoNerdFontMono"];
            style = "Bold Semi-Condensed";
            size = 11.0;
          };
          trayOutput = "*";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];

      bindswitches = {
        "lid:on" = {
          action = lockAction;
        };
      };
      keybindings = lib.mkOptionDefault {
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
        "${mod}+minus" = "workspace number 6";
        "${mod}+egrave" = "workspace number 7";
        "${mod}+underscore" = "workspace number 8";
        "${mod}+ccedilla" = "workspace number 9";
        "${mod}+agrave" = "workspace number 10";

        "${mod}+Shift+ampersand" = "move container to workspace number 1";
        "${mod}+Shift+eacute" = "move container to workspace number 2";
        "${mod}+Shift+quotedbl" = "move container to workspace number 3";
        "${mod}+Shift+apostrophe" = "move container to workspace number 4";
        "${mod}+Shift+parenleft" = "move container to workspace number 5";
        "${mod}+Shift+minus" = "move container to workspace number 6";
        "${mod}+Shift+egrave" = "move container to workspace number 7";
        "${mod}+Shift+underscore" = "move container to workspace number 8";
        "${mod}+Shift+ccedilla" = "move container to workspace number 9";
        "${mod}+Shift+agrave" = "move container to workspace number 10";

        "${mod}+Control+ampersand" = "move container to workspace number 1; workspace number 1";
        "${mod}+Control+eacute" = "move container to workspace number 2; workspace number 2";
        "${mod}+Control+quotedbl" = "move container to workspace number 3; workspace number 3";
        "${mod}+Control+apostrophe" = "move container to workspace number 4; workspace number 4";
        "${mod}+Control+parenleft" = "move container to workspace number 5; workspace number 5";
        "${mod}+Control+minus" = "move container to workspace number 6; workspace number 6";
        "${mod}+Control+egrave" = "move container to workspace number 7; workspace number 7";
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

        "${mod}+Shift+P" = "move scratchpad";
        "${mod}+p" = "scratchpad show";

        "${mod}+a" = "layout toggle tabbed splith splitv";
        "${mod}+Tab" = "workspace back_and_forth";

        # utils
        "${mod}+n" = "exec swaync-client --toggle-panel";
        "${mod}+b" = "exec ${lib.getExe pkgs.bemoji}";
        "${mod}+w" = "exec ${lib.getExe pkgs.woomer}";
        "${mod}+v" = ''exec kitty -e sh -c "swaymsg floating enable, move position center; swaymsg resize set 80ppt 80ppt && ${lib.getExe pkgs.clipse}"'';
        "${mod}+s" = "exec ${import ./scripts/swap-displays.nix pkgs}";

        ########################
        #  Programs Shortcuts  #
        ########################
        "${mod}+Return" = "exec kitty";
        "${mod}+e" = "exec firefox";
        "${mod}+Shift+e" = "exec firefox --private-window";

        "${mod}+d" = "exec fuzzel";
        "${mod}+Shift+x" = "exec \"${lib.getExe pkgs.rofi-wayland} -show p -modi p:'rofi-power-menu'\"";

        "${mod}+t" = "exec kitty -o font_size=8 -e btop";
        # "${mod}+Shift+b" = "exec --no-startup-id \"bluetoothctl connect 88:C9:E8:42:A0:B1\""; # crashes sway...
        "Shift+Print" = ''exec ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - | ${lib.getExe pkgs.swappy} -f -'';
        # "${mod}+Print" = "exec ${screenshotWindow}";
        "${mod}+Control+x" = lockAction;
        "${mod}+r" = "exec ${lib.getExe' pkgs.planify "io.github.alainm23.planify.quick-add"}";

        "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";

        ###################
        #  Media control  #
        ###################
        "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
        "XF86AudioPause" = "exec ${lib.getExe pkgs.playerctl} play-pause";

        "XF86AudioRaiseVolume" = "exec volumectl -u up";
        "XF86AudioLowerVolume" = "exec volumectl -u down";
        "XF86AudioMute" = "exec volumectl toggle-mute";
        "XF86AudioMicMute" = "exec volumectl -m toggle-mute";

        "XF86MonBrightnessUp" = "exec lightctl up";
        "XF86MonBrightnessDown" = "exec lightctl down";
        "${mod}+m" = "exec ${lib.getExe pkgs.brightnessctl} set 1";
      };
    };
  };
}
