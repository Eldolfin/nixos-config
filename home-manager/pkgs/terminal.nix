{ config, pkgs, ... }:
{
    programs.alacritty.enable = true;
    # programs.wezterm.enable = true;
  home.packages = with pkgs; [
    # kitty
    cool-retro-term
  ];
}
