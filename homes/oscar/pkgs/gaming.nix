{pkgs, ...}: {
  home.packages = with pkgs; [
    ttyper # monkey type in terminal
    gamemode
    lutris-free
    r2modman # steam games mods
    # dolphin-emu
    winetricks
    wine
    # hydralauncher
    # steam # installed as nixos module
    # libusb1 # for minecraft
    # prismlauncher
    # mangohud
    mindustry-wayland
  ];
}
