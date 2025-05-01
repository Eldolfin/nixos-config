{pkgs, ...}: {
  home.packages = with pkgs; [
    # smassh # monkey type in terminal
    gamemode
    lutris-free
    # dolphin-emu
    winetricks
    wine
    hydralauncher
    # steam # installed as nixos module
    libusb1 # for minecraft
    prismlauncher
    gamemode
    # mangohud
  ];
}
