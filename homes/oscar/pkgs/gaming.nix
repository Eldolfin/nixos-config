{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    smassh # monkey type in terminal
    lutris-free
    # wine
    winetricks
    # steam # installed as nixos module
    # gamescope
    # libusb1 # for minecraft
    # prismlauncher
    # gamemode
    # mangohud
  ];
}
