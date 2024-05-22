{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wezterm
    alacritty
    kitty
    cool-retro-term
  ];
}
