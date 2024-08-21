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
        };
    };
  };
}
