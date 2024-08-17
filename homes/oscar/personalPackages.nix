{ pkgs, ... }:

{
  imports = [
    ./pkgs/bloat.nix
    ./pkgs/cliTools.nix
    ./pkgs/dev.nix
    ./pkgs/direnv.nix
    ./pkgs/firefox.nix
    ./pkgs/helix
    ./pkgs/i3
    ./pkgs/movies.nix
    ./pkgs/scripts
    ./pkgs/socials.nix
    ./pkgs/sounds.nix
    ./pkgs/zsh.nix
    # ./pkgs/gaming.nix
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
