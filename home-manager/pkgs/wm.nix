{ pkgs, ... }:

{
  programs.rofi.enable = true;
  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-power-menu
    slock
    picom
  ];
}
