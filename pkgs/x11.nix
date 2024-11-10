{
  isTour,
  lib,
  ...
}: {
  imports = [./xfce.nix];
  services = {
    displayManager = {
      defaultSession = "xfce+i3";
      autoLogin = {
        user = "oscar";
      };
    };
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        options = "caps:escape";
      };

      windowManager = {
        i3.enable = true;
      };

      autoRepeatDelay = 250;
      autoRepeatInterval = 20;

      xrandrHeads = lib.mkIf isTour [
        {
          output = "DP-4";
          primary = true;
        }
        "DP-1"
      ];
    };
  };
}
