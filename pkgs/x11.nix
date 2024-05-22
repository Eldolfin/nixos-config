{ pkgs, ... }:

{
  # that's not x11...
  programs.sway.enable = true;

  # programs.sway.package = pkgs.swayfx;
  services.xserver = {
    # Configure keymap in X11
    xkbVariant = "";
    xkbOptions = "caps:escape";

    enable = true;

    displayManager =
      {
        defaultSession = "none+i3";
        setupCommands = ''
          LEFT='HDMI-1'
          RIGHT='DVI-D-1'
          ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --output $RIGHT --right-of $LEFT --pos 1920x-120 
        '';

        autoLogin = {
          user = "oscar";
        };
      };

    windowManager = {
      i3.enable = true;
    };
    desktopManager =
      {
        plasma5.enable = true;
        # plasma6.enable = true; # not available yet
        gnome.enable = true;
      };

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;
  };
}
