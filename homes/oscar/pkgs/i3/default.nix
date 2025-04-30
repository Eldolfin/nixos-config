{
  lib,
  pkgs,
  isTour,
  ...
} @ inputs: {
  imports = [
    ./i3blocks
    ./services.nix
    ../activitywatch.nix
  ];
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
  };
  home.packages = with pkgs; [
    i3lock-fancy-rapid
    i3-auto-layout
    rofi-power-menu
    emote
  ];

  xsession.windowManager.i3 = let
    mod = "Mod4";
    volumeChange = import ./changeVolume.nix inputs;
    screenshotWindow = import ./screenshotWindow.nix inputs;
  in {
    enable = true;
    config = {
      modifier = mod;
      bars = [{statusCommand = "${lib.getExe pkgs.i3blocks}";}];
      gaps = {
        inner = 5;
        outer = 2;
        smartGaps = true;
        smartBorders = "on";
      };
      startup =
        [
          {
            command = "sh -c 'while true; do ${lib.getExe pkgs.i3-auto-layout}; done'";
            notification = false;
          }
          {
            command = lib.getExe pkgs.networkmanagerapplet;
            notification = false;
          }
          {
            command = lib.getExe' pkgs.blueman "blueman-applet";
            notification = false;
          }
          {
            command = lib.getExe pkgs.emote;
            notification = false;
          }
          # might be usefull
          # exec --no-startup-id dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus"
        ]
        ++ lib.optional isTour
        {
          command = let
            monitor1 = "DP-4";
            monitor2 = "DP-1";
          in "i3-msg 'workspace 1, move workspace to output ${monitor1}, workspace 2, move workspace to output ${monitor2}'";
        };
      floating.criteria = [{class = "copyq";}];
      modes = {};
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
        "${mod}+w" = "exec /home/oscar/.config/i3/scripts/i3-display-swap.sh";

        ########################
        #  Programs Shortcuts  #
        ########################
        "${mod}+Return" = "exec wezterm";
        "${mod}+e" = "exec firefox";
        "${mod}+Shift+e" = "exec firefox --private-window";
        "${mod}+v" = "exec ${lib.getExe pkgs.copyq} show";
        # "${mod}+m" = "exec /home/oscar/bin/scripts/toggle-lamp.sh";

        "${mod}+d" = "exec rofi -show drun";
        "${mod}+Shift+x" = "exec \"rofi -show p -modi p:'rofi-power-menu'\"";

        "${mod}+t" = "exec wezterm --config font_size=10 -e btop";
        "${mod}+Shift+b" = "exec --no-startup-id \"bluetoothctl connect 88:C9:E8:42:A0:B1\"";
        "Shift+Print" = "exec flameshot gui";
        "${mod}+Print" = "exec ${screenshotWindow}";
        # "${mod}+x" = "exec --no-startup-id i3lock-fancy-rapid 0 1";
        "${mod}+x" = "exec --no-startup-id ${pkgs.xscreensaver}/bin/xscreensaver-command -lock";
        "${mod}+c" = "exec --no-startup-id ${pkgs.xscreensaver}/bin/xscreensaver-command -next";

        "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";

        ###################
        #  Media control  #
        ###################
        "XF86MonBrightnessUp" = "exec --no-startup-id ${lib.getExe pkgs.brightnessctl} s -e 10%+";
        "XF86MonBrightnessDown" = "exec --no-startup-id ${lib.getExe pkgs.brightnessctl} s -e 10%-";

        "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
        "XF86AudioPause" = "exec ${lib.getExe pkgs.playerctl} play-pause";

        "XF86AudioMute" = "exec ${volumeChange} t";
        "XF86AudioLowerVolume" = "exec ${volumeChange} d";
        "XF86AudioRaiseVolume" = "exec ${volumeChange} i";
        "F2" = "exec ${volumeChange} d";
        "F3" = "exec ${volumeChange} i";
      };
    };
  };
}
