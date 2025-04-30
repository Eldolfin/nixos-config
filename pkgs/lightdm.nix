{
  # TODO: switch to a wayland display-manager?
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeter.enable = true;
      greeters.slick.enable = true;
    };
  };
}
