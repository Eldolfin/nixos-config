{
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };


  services.xserver.displayManager.defaultSession = "hyprland";
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;

    nvidia.modesetting.enable = true;
  };
}
