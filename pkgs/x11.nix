{ isTour, lib, ... }:
{
  services = {
    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        user = "oscar";
      };
    };
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        variant = "";
        options = "caps:escape";
      };

      windowManager = {
        i3.enable = true;
      };
      desktopManager = {
        xfce = {
          enable = true;
          # noDesktop = true;
          enableXfwm = false;
        };
      };

      autoRepeatDelay = 250;
      autoRepeatInterval = 20;

      xrandrHeads = lib.mkIf isTour [
        {
          output = "HDMI-0";
          primary = true;
        }
        "DVI-D-0"
      ];
    };
  };
}
