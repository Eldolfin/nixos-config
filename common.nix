# this file is common between tour and laptop
{
  imports = [
    ./pkgs/x11.nix
    ./pkgs/stylix.nix
    ./pkgs/lightdm.nix
    ./pkgs/sops.nix
    ./pkgs/sound.nix
    ./common-server.nix
  ];

  boot.loader.timeout = 0;
  programs = {
    adb.enable = true;
  };

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.i2c.enable = true;

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  # polkit
  security.polkit.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services = {
    # tailscale.enable = true;
    blueman.enable = true;
    # multimedia server (for play pause keys)
    mmsd.enable = true;
    # kills the app that uses the most memory when <10% is available
    # prevents freeze which requires a reboot
    earlyoom.enable = true;
  };
}
