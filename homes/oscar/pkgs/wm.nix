{ pkgs, ... }:

{
  programs.rofi.enable = true;
  programs.swaylock.enable = true;

  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-power-menu
    slock
    picom
    wl-clipboard-rs
    swaybg
  ];
}
