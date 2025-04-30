{
  isTour,
  lib,
  ...
}: {
  imports = [./xfce.nix];
  services = {
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
