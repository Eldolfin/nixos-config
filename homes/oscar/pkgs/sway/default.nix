{
  config,
  lib,
  pkgs,
  ...
}: {
  home.keyboard.layout = "gb";
  programs.swaylock.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "workspace number 1";
      terminal = lib.getExe pkgs.alacritty;
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${mod}+e" = "exec ${lib.getExe pkgs.firefox}";
          "${mod}+Shift+e" = "exec ${lib.getExe pkgs.firefox} --private-window";
          "${mod}+v" = "exec ${lib.getExe pkgs.copyq} show";
        };
    };
  };
}
