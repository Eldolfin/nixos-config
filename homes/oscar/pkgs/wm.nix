{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
  };
  programs.i3blocks.enable = true;
  programs.swaylock.enable = true;

  xsession.numlock.enable = true;

  home.packages = with pkgs; [
    # rofi-bluetooth # useless
    i3lock-fancy-rapid
    rofi-power-menu
    slock
    picom
    wl-clipboard-rs
    swaybg
  ];
}
