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
    noisetorch
    thunderbird
    signal-desktop
    vencord
    flameshot
    emote
    gparted
    # bitwarden

    man-pages
    man-pages-posix
  ];
}
