{ pkgs, ... }:

{
  services.desktopManager = {
    # plasma6.enable = true; # useless :)
      defaultSession = "none+sway";
  };
  services.xserver = { # Configure keymap in X11
    xkb = {
      variant = "";
       options = "caps:escape";
    };

    enable = true;

    displayManager = {
      setupCommands = ''
        LEFT='HDMI-1'
        RIGHT='DVI-D-1'
        ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --output $RIGHT --right-of $LEFT --pos 1920x-120 
      '';

      autoLogin = { user = "oscar"; };
    };

    windowManager = { i3.enable = true; };
    desktopManager = {
      gnome.enable = true;
    };

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;
  };
}
