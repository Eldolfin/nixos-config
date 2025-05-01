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
    uwsm = {
      enable = true;

      waylandCompositors.sway = {
        prettyName = "sway";
        comment = "Sway";
        binPath = "/run/current-system/sw/bin/sway";
      };
    };
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # incorrect?
    # "WLR_RENDERER" = "pixman";
    # SWAYSOCK = "/tmp/sway-ipc.sock";
  };

  hardware.graphics.enable = true;
}
