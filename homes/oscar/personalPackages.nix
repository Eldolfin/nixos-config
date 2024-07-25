{ pkgs, ... }:

{
  imports = [
    ./pkgs/dev.nix
    ./pkgs/gaming.nix
    ./pkgs/movies.nix
    ./pkgs/zsh.nix
    ./pkgs/cliTools.nix
    ./pkgs/helix
    ./pkgs/firefox.nix
    ./pkgs/sounds.nix
    ./pkgs/bloat.nix
    ./pkgs/direnv.nix
    ./pkgs/i3
    ./pkgs/scripts
    ./pkgs/chromium.nix
    ./pkgs/thunderbird.nix
    # ./pkgs/lazyvim.nix
    # ./pkgs/editing.nix
    # ./pkgs/nixvim.nix
    # ./pkgs/hyprland.nix
  ];

  programs.emacs.enable = true;

  home.packages = with pkgs; [
    # graphical programs
    signal-desktop
    corectrl
    gimp
    kdeconnect
    bitwarden
    dorion # discord client in tauri (rust)
    # webcord-vencord
    flameshot
    emote
    gparted
    popcorntime

    # libraries
    glfw
    gnumake
    libnotify
    armadillo
    pre-commit
    stdenv.cc.cc.lib
    luajit
    wine
    stylua
    gpp
    gamemode
    mangohud
    winetricks
    pyright
    xorg.libXtst.out
    nix-tree
    redshift
    qbittorrent
    libreoffice
    noisetorch
    xorg.xbacklight
    cpufrequtils

    man-pages
    man-pages-posix

    # libs
    openssl
  ];
}
