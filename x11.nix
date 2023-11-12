{ pkgs, ... }:

{
  services.xserver = {
    # Configure keymap in X11
    layout = "fr";
    xkbVariant = "";
    xkbOptions = "caps:swapescape";

    enable = true;

    displayManager =
      {
        defaultSession = "none+i3";
        sessionCommands = ''
          ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
            Xcursor.theme: Adwaita
              ''}
        '';
        setupCommands = ''
          LEFT='HDMI-0'
          RIGHT='DVI-D-0'
          ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --output $RIGHT --right-of $LEFT --pos 1920x-120 
        '';

        # Enable automatic login for the user.
        autoLogin = {
          enable = true;
          user = "oscar";
        };
      };

    windowManager = {
      i3.enable = true;
      leftwm.enable = true;
    };

    videoDrivers = [ "nvidia" ];

    autoRepeatDelay = 250;
    autoRepeatInterval = 20;
  };
}
