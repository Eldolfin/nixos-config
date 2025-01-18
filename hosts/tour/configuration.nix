{
  imports = [
    ../../common.nix
    ../../pkgs/steam.nix
    ../../pkgs/systemd-boot.nix
    # ../../pkgs/plymouth.nix
    ../../pkgs/wol-agent.nix
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
  networking = {
    wireless.enable = false;
  };
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
}
