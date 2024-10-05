{ pkgs, ... }:
{
  environment.xfce.excludePackages = [
    pkgs.xfce.xfce4-volumed-pulse
    pkgs.xfce.parole
    pkgs.xfce.mousepad
  ];
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
          enableScreensaver = false;
        };
      };
    };
    xscreensaver.enable = true;
  };
}
