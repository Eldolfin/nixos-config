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
          "${mod}+Return" = "exec alacritty";
          "${mod}+e" = "exec firefox";
          "${mod}+Shift+e" = "exec firefox --private-window";
          "${mod}+d" = "exec rofi -show drun";
          "${mod}+v" = "exec copyq show";

          "${mod}+w" = "exec /home/oscar/.config/i3/scripts/i3-display-swap.sh";
          "${mod}+m" = "exec /home/oscar/bin/scripts/toggle-lamp.sh";

          "XF86AudioMute" = "exec ${volumeChange}/bin/volume-change t";
          "XF86AudioLowerVolume" = "exec ${volumeChange}/bin/volume-change d";
          "XF86AudioRaiseVolume" = "exec ${volumeChange}/bin/volume-change i";
          "F2" = "exec ${volumeChange}/bin/volume-change d";
          "F3" = "exec ${volumeChange}/bin/volume-change i";

          # sound effects
          "${mod}+Shift+Return" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/paplay Music/sounds/boom.wav";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+a" = "layout toggle tabbed splith splitv";

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
        };
    };
  };
}
