{ config, ... }:
{
  imports =
    [
      ../common.nix
      ../services/sunshine.nix
      ../pkgs/bootloader.nix
    ];

  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "oscar-tour";
  services.xserver.layout = "fr";
  networking.interfaces.enp5s0.wakeOnLan.enable = true;
  networking.wireless.enable = false;
  services.xserver.displayManager.autoLogin.enable = true;
  hardware.ckb-next.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # enable cuda
  nixpkgs.config.cudaSupport = true;

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
