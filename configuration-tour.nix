{
  imports =
    [
      # musnix for jack mic
      /etc/nixos/git-repo/musnix
      /etc/nixos/git-repo/common.nix
    ];
  musnix.enable = true;

  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos-tour";
  services.xserver.layout = "fr";
  networking.interfaces.enp5s0.wakeOnLan.enable = true;
  networking.wireless.enable = false;
  services.xserver.displayManager.autoLogin.enable = true;
  hardware.ckb-next.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
