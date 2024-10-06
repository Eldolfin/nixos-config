{ pkgs, lib, ... }:
{
  environment.xfce.excludePackages = with pkgs.xfce; [
    exo
    mousepad
    parole
    xfce4-appfinder
    xfce4-power-manager
    xfce4-screenshooter
    xfce4-settings
    xfce4-taskmanager
    xfce4-terminal
    xfce4-volumed-pulse
    xfce4-notifyd
  ];
  programs.thunar.enable = lib.mkForce false;
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
