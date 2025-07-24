{pkgs, ...}: {
  imports = [
    ./pkgs/activitywatch.nix
    ./pkgs/bloat.nix
    ./pkgs/chromium.nix
    ./pkgs/clipse.nix
    ./pkgs/fuzzel.nix
    ./pkgs/gaming.nix
    ./pkgs/kitty.nix
    ./pkgs/mako.nix
    ./pkgs/media.nix
    ./pkgs/niri
    ./pkgs/socials.nix
    ./pkgs/swaylock.nix
    ./pkgs/waybar
    ./pkgs/wlsunset.nix
    ./pkgs/wpaperd.nix
  ];

  home.packages = with pkgs; [
    # misc graphical programs
    noisetorch
    gparted
    moonlight-qt

    man-pages
    man-pages-posix
  ];
}
