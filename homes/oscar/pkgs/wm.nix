{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
  };
  services.dunst.enable = true;

  xsession.numlock.enable = true;

  home.packages = with pkgs; [
    # rofi-bluetooth # useless
    i3lock-fancy-rapid
    i3-auto-layout
    rofi-power-menu
    slock
    wl-clipboard-rs
    swaybg
  ];
}
