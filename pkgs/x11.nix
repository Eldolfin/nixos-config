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
      cinnamon.enable = true;
      # gnome.enable = true;
    };

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;

    xrandrHeads = [
      {
        output = "HDMI-0";
        primary = true;
      }
      "DVI-D-0"
    ];
  };
}
