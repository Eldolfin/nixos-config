{ pkgs, ... }:
{
  home.packages = with pkgs; [
    smassh # monkey type in terminal
    lutris-free
    winetricks
    # steam # installed as nixos module
    # gamescope
    # libusb1 # for minecraft
    # prismlauncher
    # gamemode
    # mangohud
  ];
}
