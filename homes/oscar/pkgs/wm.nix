{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

  };
  programs.i3lock.enable = true;
  programs.i3blocks.enable = true;
  programs.swaylock.enable = true;

  home.packages = with pkgs; [
    # rofi-bluetooth # useless
    rofi-power-menu
    slock
    picom
    wl-clipboard-rs
    swaybg
  ];
}
