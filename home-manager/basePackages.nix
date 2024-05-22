{ pkgs, ... }:
{
  imports = [
    ./pkgs/wm.nix
    ./pkgs/terminal.nix
    ./pkgs/lazyvim.nix

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
    fzf
    btop
    zsh
    fish
    neofetch
    chezmoi
    zoxide
    zellij
    lazygit
    bat
    ripgrep
    cargo-watch
    inotify-tools
    # scrot # full screen-shot
    cloc
    # wol

    # graphical programs
    copyq
    emote
    dunst
    redshift
    neovide
    picom
    moonlight-embedded

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
