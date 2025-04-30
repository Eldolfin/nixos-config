{
  pkgs,
  lib,
  ...
}: {
  programs = {
    rofi.terminal = lib.getExe pkgs.kitty;
    kitty = {
      enable = true;
    };
    #   wezterm = {
    #     enable = true;
    #   };
    #   ghostty = {
    #     enable = true;
    #     enableFishIntegration = true;
    #     settings = {
    #       window-vsync = false;
    #       gtk-titlebar = false;
    #       keybind = [
    #         "ctrl+enter=unbind" # defaults to toggle fullscreen
    #       ];
    #     };
    #   };
  };
  # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    cool-retro-term
  ];
}
