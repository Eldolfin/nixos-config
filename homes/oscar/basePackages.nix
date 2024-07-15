{ pkgs, ... }:
{
  imports = [
    ./pkgs/wm.nix
    ./pkgs/terminal.nix
    # ./pkgs/lazyvim.nix
    ./pkgs/essentialCliTools.nix
  ];
  home.packages = with pkgs; [
    # cli tools
    fastfetch
    chezmoi
    inotify-tools

    # graphical programs
    emote

    # libraries
    libnotify
    # why?
    # boost
    # armadillo
    # stdenv.cc.cc.lib
    # luajit
    # stylua
  ];
}
