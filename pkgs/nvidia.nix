{
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.cudaSupport = true;
  hardware.nvidia = {
    modesetting.enable = true;
    # nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver = {
    videoDrivers = ["nvidia"];
  };
}
