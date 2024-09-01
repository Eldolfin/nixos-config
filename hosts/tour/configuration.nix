{
  imports = [
    ../../common.nix
    ../../pkgs/grub.nix
    ../../pkgs/steam.nix
    # ../../pkgs/systemd-boot.nix # should make a gpt table first
  ];

  networking.hostName = "oscar-tour";
  services.xserver.xkb.layout = "fr";
  # networking.interfaces.enp5s0.wakeOnLan.enable = true;
  networking.wireless.enable = false;
  services.displayManager.autoLogin.enable = true;
  # hardware.ckb-next.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # enable cuda
  nixpkgs.config.cudaSupport = true;

  powerManagement.cpuFreqGovernor = "performance";
  hardware.nvidia = {
    modesetting.enable = true;
    # nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };
  hardware.nvidia-container-toolkit.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
