# this file is common between tour and laptop
{
  imports = [
    ./common-server.nix
    ./pkgs/gdm.nix
    ./pkgs/sops.nix
    ./pkgs/sound.nix
    ./pkgs/stylix.nix
    ./pkgs/sway.nix
    ./pkgs/xdg.nix
    ./pkgs/systemd-boot.nix
    ./pkgs/steam.nix
    ./pkgs/flatpak.nix
    ./pkgs/kdeconnect.nix
    ./pkgs/mullvad.nix
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
    blueman.enable = true;
    # multimedia server (for play pause keys)
    mmsd.enable = true;
    # kills the app that uses the most memory when <10% is available
    # prevents freeze which requires a reboot
    earlyoom.enable = true;
    displayManager = {
      defaultSession = "sway-uwsm";
      autoLogin = {
        user = "oscar";
      };
    };
  };
}
