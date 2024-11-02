{pkgs, ...}: {
  imports = [
    ./pkgs/bloat.nix
    ./pkgs/movies.nix
    ./pkgs/gaming.nix
  ];

  home.packages = with pkgs; [
    # misc graphical programs
    noisetorch
    gparted

    man-pages
    man-pages-posix
  ];
}
