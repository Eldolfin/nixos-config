# this file is common between tour and laptop
{lib, ...}: {
  imports = [
    ./common-server.nix
    ./pkgs/greetd.nix
    ./pkgs/sops.nix
    ./pkgs/sound.nix
    ./pkgs/stylix.nix
    ./pkgs/xdg.nix
    ./pkgs/steam.nix
    ./pkgs/flatpak.nix
    ./pkgs/kdeconnect.nix
    ./pkgs/mullvad.nix
    ./pkgs/niri.nix
    ./pkgs/gnome.nix
    ./pkgs/kmscon.nix
  ];

  boot.loader.timeout = lib.mkDefault 0;
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
      defaultSession = "niri";
      autoLogin = {
        enable = lib.mkDefault true;
        user = "oscar";
      };
    };
  };
}
