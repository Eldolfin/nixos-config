{ pkgs, ... }:
{
  home.packages = with pkgs; [
    smassh # monkey type in terminal
    gamemode
    # lutris-free
    # winetricks
    # wine
    # steam # installed as nixos module
    # gamescope
    # libusb1 # for minecraft
    # prismlauncher
    # gamemode
    # mangohud
  ];
}
