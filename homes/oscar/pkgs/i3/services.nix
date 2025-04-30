{
  # Fix for `Unit tray.target not found` when restarting flameshot when switching config
  # see: https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
  programs.rofi = {
    enable = true;
  };

  services = {
    flameshot.enable = true;
    copyq.enable = true;
    dunst.enable = true;
    redshift = {
      enable = true;
      tray = true;
      provider = "manual";
      latitude = 48.864716;
      longitude = 2.349014;
    };
    picom = {
      enable = true;
      shadow = true;
      # inactiveOpacity = 0.97;
      inactiveOpacity = 1;
      # opacityRules = [ "100:class_g = 'polybar'" ];
      fade = true;
      fadeSteps = [
        0.2
        0.2
      ];
      backend = "glx";
      settings = {
        "corner-radius" = 10;
        "rounded-corners-exclude" = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];
        "blur-background-exclude" = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];
      };
    };
  };
}
