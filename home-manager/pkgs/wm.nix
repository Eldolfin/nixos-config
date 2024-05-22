{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-power-menu
    slock
    picom
    rofi
  ];
}
