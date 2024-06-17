{ pkgs, ... }:
{
  imports = [
    ./pkgs/wm.nix
    ./pkgs/terminal.nix
    ./pkgs/lazyvim.nix
    ./pkgs/essentialCliTools.nix
    ./pkgs/helix.nix
  ];
  home.packages = with pkgs; [
    neovim

    # cli tools
    fastfetch
    eza
    skim
    jq
    git-lfs
    fd
    chezmoi
    zoxide
    zellij
    ripgrep
    inotify-tools
    cloc

    # graphical programs
    emote
    dunst
    picom

    # libraries
    libnotify
    boost
    armadillo
    stdenv.cc.cc.lib
    luajit
    stylua

    # font
    meslo-lgs-nf
    fusuma
  ];
}
