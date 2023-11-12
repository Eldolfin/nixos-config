{
  imports =
    [
      # musnix for jack mic
      /etc/nixos/git-repo/musnix
      /etc/nixos/git-repo/common.nix
    ];

  musnix.enable = true;

  services.xserver.layout = "fr";
  networking.hostName = "nixos-tour"; # Define your hostname.
  networking.interfaces.enp5s0.wakeOnLan.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;

  hardware.ckb-next.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
