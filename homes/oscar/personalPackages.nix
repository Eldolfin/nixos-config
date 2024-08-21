{ pkgs, ... }:

{
  imports = [
    ./pkgs/bloat.nix
    ./pkgs/movies.nix
    ./pkgs/gaming.nix
    # ./pkgs/chromium.nix
    # ./pkgs/sway
    # ./pkgs/thunderbird.nix
    # ./pkgs/lazyvim.nix
    # ./pkgs/editing.nix
    # ./pkgs/nixvim.nix
    # ./pkgs/hyprland.nix
  ];

  home.packages = with pkgs; [
    # misc graphical programs
    noisetorch
    gparted
    # bitwarden

    man-pages
    man-pages-posix
  ];
}
