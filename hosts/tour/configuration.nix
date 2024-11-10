{
  imports = [
    ../../common.nix
    # ../../pkgs/grub.nix
    ../../pkgs/steam.nix
    ../../pkgs/systemd-boot.nix # should make a gpt table first
  ];

  networking.hostName = "oscar-tour";
  services = {
    xserver = {
      xkb.layout = "fr";
      videoDrivers = ["nvidia"];
    };
    displayManager.autoLogin.enable = true;
    openssh.enable = true;
  };
  # networking.interfaces.enp5s0.wakeOnLan.enable = true;
  networking.wireless.enable = false;
  # hardware.ckb-next.enable = true;

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
}
