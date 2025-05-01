{pkgs, ...}: {
  imports = [
    ./pkgs/bloat.nix
    ./pkgs/movies.nix
    ./pkgs/gaming.nix
    ./pkgs/chromium.nix
    ./pkgs/socials.nix
    ./pkgs/sway
    ./pkgs/i3
  ];

  home.packages = with pkgs; [
    # misc graphical programs
    noisetorch
    gparted

    man-pages
    man-pages-posix
  ];
}
