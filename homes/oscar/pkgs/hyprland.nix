{pkgs, ...}: {
  imports = [./ags.nix];
  home.packages = with pkgs; [
    waybar
    swww
    rofi-wayland
    # wl-clipboard
    # wl-clipboard-x11
    grimblast
  ];
}
