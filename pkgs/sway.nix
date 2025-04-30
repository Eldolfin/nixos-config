{
  pkgs,
  lib,
  ...
}: {
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
        binPath = lib.getExe' pkgs.sway "sway";
      };
    };
  };

  environment.sessionVariables = {
    # If your cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    SWAYSOCK = "/tmp/sway-ipc.sock";
  };

  hardware.graphics.enable = true;
}
