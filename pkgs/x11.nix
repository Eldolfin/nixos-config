{ pkgs, ... }:

{
  services.displayManager = {
    # defaultSession = "sway";
    # defaultSession = "hyprland";
    defaultSession = "none+i3";
    autoLogin = {
      user = "oscar";
    };
  };
  services.desktopManager = {
    # plasma6.enable = true; # useless :)
  };
  services.xserver = {
    # Configure keymap in X11
    xkb = {
      variant = "";
      options = "caps:escape";
    };

    enable = true;

    windowManager = {
      i3.enable = true;
    };
    desktopManager = {
      gnome.enable = true;
    };

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;
  };
}
