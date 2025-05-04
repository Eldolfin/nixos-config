{
  programs = {
    sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraOptions = [
        # "--verbose"
        # "--debug"
        "--unsupported-gpu"
      ];
    };
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware.graphics.enable = true;
}
