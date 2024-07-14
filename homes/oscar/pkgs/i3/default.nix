{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ./i3blocks.nix ];
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
          "${mod}+Return" = "exec ${lib.getExe pkgs.alacritty}";
          "${mod}+e" = "exec ${lib.getExe pkgs.firefox}";
          "${mod}+Shift+e" = "exec ${lib.getExe pkgs.firefox} --private-window";
          "${mod}+d" = "exec ${lib.getExe pkgs.rofi} -show drun";
          "${mod}+v" = "exec ${lib.getExe pkgs.copyq} show";
          # TODO: move these scripts to home manager config too
          "${mod}+w" = "exec /home/oscar/.config/i3/scripts/i3-display-swap.sh";

          "${mod}+h" = "move left";
          "${mod}+j" = "move down";
          "${mod}+k" = "move up";
          "${mod}+l" = "move right";
        };
    };
  };
}
