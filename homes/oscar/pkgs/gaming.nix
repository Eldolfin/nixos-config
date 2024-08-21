{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
