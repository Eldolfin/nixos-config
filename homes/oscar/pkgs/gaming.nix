{ pkgs, ... }:
{
  home.packages = with pkgs; [
    smassh # monkey type in terminal
    lutris-free
    winetricks
    # steam
    # gamescope
    # libusb1 # for minecraft
    # prismlauncher
    # gamemode
    # mangohud
  ];
}
