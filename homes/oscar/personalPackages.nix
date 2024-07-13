{ pkgs, ... }:

{
  imports = [
    # ./pkgs/lazyvim.nix
    ./pkgs/dev.nix
    ./pkgs/gaming.nix
    # ./pkgs/hyprland.nix
    ./pkgs/movies.nix
    ./pkgs/zsh.nix
    ./pkgs/cliTools.nix
    ./pkgs/helix
    ./pkgs/firefox.nix
    # ./pkgs/editing.nix
    # ./pkgs/nixvim.nix
    ./pkgs/sounds.nix
    ./pkgs/bloat.nix
    ./pkgs/direnv.nix
    ./pkgs/i3
    ./pkgs/scripts
  ];

  programs.emacs.enable = true;

  home.packages = with pkgs; [
    # graphical programs
    signal-desktop
    corectrl
    gimp
    ungoogled-chromium
    kdeconnect
    bitwarden
    webcord-vencord
    flameshot
    emote

    # libraries
    glfw
    libllvm
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
    thunderbird
    redshift
    qbittorrent
    libreoffice
    noisetorch
    xorg.xbacklight
    cpufrequtils

    # font
    # source-code-pro
    # meslo-lgs-nf

    man-pages
    man-pages-posix

    # libs
    openssl
  ];
}
