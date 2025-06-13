{pkgs, ...}: {
  imports = [
    ./pkgs/bloat.nix
    ./pkgs/media.nix
    ./pkgs/gaming.nix
    ./pkgs/chromium.nix
    ./pkgs/socials.nix
    ./pkgs/sway
  ];

  home.packages = with pkgs; [
    # misc graphical programs
    noisetorch
    gparted

    man-pages
    man-pages-posix
  ];
}
