{ pkgs, ... }:

{
  imports = [
    ./pkgs/dev.nix
    # ./pkgs/gaming.nix
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
    # ./pkgs/chromium.nix
    # ./pkgs/sway
    # ./pkgs/thunderbird.nix
    # ./pkgs/lazyvim.nix
    # ./pkgs/editing.nix
    # ./pkgs/nixvim.nix
    # ./pkgs/hyprland.nix
  ];

  # programs.emacs.enable = true; # cringe?

  home.packages = with pkgs; [
    # graphical programs
    thunderbird
    signal-desktop
    corectrl
    gimp
    # bitwarden
    dorion # discord client in tauri (rust)
    glib-networking # needed by dorion...
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
    stylua
    gpp
    pyright
    xorg.libXtst.out
    nix-tree
    qbittorrent
    noisetorch
    xorg.xbacklight
    cpufrequtils

    man-pages
    man-pages-posix

    # libs
    openssl
  ];
}
