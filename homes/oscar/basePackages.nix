{pkgs, ...}: {
  imports = [
    ./pkgs/wm.nix
    ./pkgs/terminal.nix
    ./pkgs/essentialCliTools.nix
  ];
  home.packages = with pkgs; [
    # cli tools
    fastfetch
    # chezmoi
    inotify-tools

    # libraries
    libnotify
  ];
}
