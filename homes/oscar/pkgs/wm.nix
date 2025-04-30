{pkgs, ...}: {
  xsession.numlock.enable = true;

  home.packages = with pkgs; [
    rofi-power-menu
  ];
}
