{
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.cudaSupport = true;
  hardware = {
    nvidia = {
      modesetting.enable = false;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
    };
    nvidia-container-toolkit.enable = true;
  };
  boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia_drm.fbdev=0"];
  virtualisation.docker.enableNvidia = true;
  services.xserver = {
    videoDrivers = ["nvidia"];
  };
}
