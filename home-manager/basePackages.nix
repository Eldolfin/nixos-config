{ pkgs, ... }:
{
  imports = [
    ./pkgs/wm.nix
    ./pkgs/terminal.nix
    ./pkgs/lazyvim.nix
    ./pkgs/essentialCliTools.nix
  ];
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  home.packages = with pkgs; [
    # kitty
    neovim
    # i3 etc
    # i3lock-fancy-rapid
    i3lock
    i3blocks
    # polybarFull

    # cli tools
    fastfetch
    eza
    # tealdeer
    skim
    jq
    joshuto
    dive
    ncdu
    git-lfs
    fd
    fish
    neofetch
    chezmoi
    zoxide
    zellij
    ripgrep
    inotify-tools
    cloc
    # wol

    # graphical programs
    copyq
    emote
    dunst
    redshift
    neovide
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
