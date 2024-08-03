{
  services = {
    flameshot.enable = true;
    # bluetooth media control
    mpris-proxy.enable = true;
    picom = {
      enable = false;
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

    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };

    copyq.enable = true;
    # safeeyes.enable = true;
  };
}
