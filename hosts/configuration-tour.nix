{ config, ... }:
{
  imports =
    [
      ../common.nix
      ../pkgs/sddm.nix
    ];

  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos-tour";
  services.xserver.layout = "fr";
  networking.interfaces.enp5s0.wakeOnLan.enable = true;
  networking.wireless.enable = false;
  services.xserver.displayManager.autoLogin.enable = true;
  hardware.ckb-next.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
