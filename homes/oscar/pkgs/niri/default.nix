{
  pkgs,
  lib,
  config,
  isTour,
  ...
}: {
  # TODO:
  # - hide bitwarden windows from screensharing
  # - make binds layout independent
  home.packages = with pkgs; [
    clipse
    bemoji
    wl-clipboard

    # screenshot
    grim
    slurp
    swappy
  ];
  programs.niri.settings = with config.lib.niri.actions; let
    lockAction = spawn "swaylock";
  in {
    switch-events.lid-close.action = lockAction;
    prefer-no-csd = true; # aka hide window decoration
    gestures.hot-corners.enable = false;
    spawn-at-startup = [
      {command = ["${lib.getExe' pkgs.planify "io.github.alainm23.planify"}" "-b"];}
      {command = ["${lib.getExe pkgs.wl-clip-persist}" "--clipboard" "primary"];}
      {command = ["${lib.getExe pkgs.xwayland-satellite}"];}
    ];
    environment = {
      EDITOR = "hx";
      NIXOS_OZONE_WL = "1"; # for electron apps
      QT_QPA_PLATFORM = "wayland";
      DISPLAY = ":0";
    };
    layout = {
      gaps = 4;
      focus-ring.width = 2;
      always-center-single-column = true;
    };
    layer-rules = [
      {
        matches = [{namespace = "^notifications$";}];
        block-out-from = "screencast";
      }
    ];
    window-rules = [
      {
        open-floating = true;
        matches = [
          {app-id = "clipse";}
          {
            app-id = "firefox";
            title = "Picture-in-Picture";
          }
        ];
      }
    ];
    outputs = {
      DP-3 = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 143.996;
        };
        position = {
          x = 0;
          y = 0;
        };
      };
      DP-1 = {
        mode = {
          width = 1920;
          height = 1200;
          refresh = 59.950;
        };
        position = {
          x = 1920;
          y = 0;
        };
      };
    };
    input = {
      focus-follows-mouse.enable = true;
      # wrap-mouse-to-focus.enable = true;
      touchpad = {
        click-method = "clickfinger"; # two finger right click
      };
      keyboard = {
        numlock = true;
        repeat-delay = 250;
        repeat-rate = 50;
        xkb = {
          layout =
            if isTour
            then "fr"
            else "gb";
          options = "caps:escape";
        };
      };
    };
    binds = let
      sh = spawn "sh" "-c";
    in {
      # Programs
      "Mod+D".action = spawn "fuzzel";
      "Mod+E".action = spawn "firefox";
      "Mod+Shift+E".action = spawn "firefox" "--private-window";
      "Mod+Return".action = spawn "kitty";
      "Mod+B".action = spawn "bemoji";
      "Mod+T".action = spawn "kitty" "-o" "font_size=8" "-e" "btop";
      "Mod+V".action = spawn "kitty" "-o" "font_size=10" "--class=clipse" "-e" "clipse";
      "Mod+Shift+B".action = spawn "bluetoothctl" "connect" "88:C9:E8:42:A0:B1";
      "Mod+Shift+x".action = spawn "${lib.getExe pkgs.rofi-wayland}" "-show" "p" "-modi" "p:'rofi-power-menu'";
      "Super+Alt+L".action = lockAction;
      "Mod+N".action = spawn "${lib.getExe' pkgs.planify "io.github.alainm23.planify.quick-add"}";
      "Mod+Shift+Return".action = spawn "paplay" "/home/oscar/Music/sounds/boom.wav";

      # Screenshots
      "Print".action = sh ''grim -g "$(slurp)" - | swappy -f -'';
      "Alt+Print".action = screenshot;
      "Shift+Print".action = screenshot-window;

      # Media
      "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ && mpv ~/Music/sounds/audio-volume-change.oga";
      "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- && mpv ~/Music/sounds/audio-volume-change.oga";
      "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && mpv sounds/audio-volume-change.oga";
      "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      "XF86AudioPlay".action = spawn "${lib.getExe pkgs.playerctl}" "play-pause";
      "XF86AudioPause".action = spawn "${lib.getExe pkgs.playerctl}" "play-pause";

      # Movements
      "Mod+Shift+Colon".action = show-hotkey-overlay;
      "Mod+Q".action = close-window;
      "Mod+O".action = toggle-overview;
      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-right;
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
      "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;
      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;
      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;
      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action = focus-workspace-down;
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action = focus-workspace-up;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-down;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-up;
      };
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
      "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;
      "Mod+Ampersand".action = focus-workspace 1;
      "Mod+Eacute".action = focus-workspace 2;
      "Mod+Quotedbl".action = focus-workspace 3;
      "Mod+Apostrophe".action = focus-workspace 4;
      "Mod+ParenLeft".action = focus-workspace 5;
      "Mod+Minus".action = focus-workspace 6;
      "Mod+Egrave".action = focus-workspace 7;
      "Mod+Underscore".action = focus-workspace 8;
      "Mod+Ccedilla".action = focus-workspace 9;
      "Mod+Ctrl+Ampersand".action = move-column-to-index 1;
      "Mod+Ctrl+Eacute".action = move-column-to-index 2;
      "Mod+Ctrl+Quotedbl".action = move-column-to-index 3;
      "Mod+Ctrl+Apostrophe".action = move-column-to-index 4;
      "Mod+Ctrl+ParenLeft".action = move-column-to-index 5;
      "Mod+Ctrl+Minus".action = move-column-to-index 6;
      "Mod+Ctrl+Egrave".action = move-column-to-index 7;
      "Mod+Ctrl+Underscore".action = move-column-to-index 8;
      "Mod+Ctrl+Ccedilla".action = move-column-to-index 9;
      "Mod+Tab".action = focus-workspace-previous;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+SemiColon".action = expel-window-from-column;
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;
      "Mod+ParenRight".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+ParenRight".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";
      "Mod+Ctrl+E".action = quit;
      "Mod+Shift+P".action = power-off-monitors;
    };
  };
}
