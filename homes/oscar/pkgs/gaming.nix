{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    steam
    gamescope
    libusb1 # for minecraft
    prismlauncher
  ];
}
