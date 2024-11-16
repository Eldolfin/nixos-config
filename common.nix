# this file is common between tour and laptop
{pkgs, ...} @ inputs: {
  imports = [
    ./pkgs/x11.nix
    ./pkgs/stylix.nix
    ./pkgs/lightdm.nix
    ./pkgs/sops.nix
    ./pkgs/sound.nix
    ./pkgs/plymouth.nix
    ./pkgs/hyprland.nix
  ];

  programs = {
    adb.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 1d";
        dates = "daily";
      };
    };
    nix-index-database.comma.enable = true;
    zsh.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # fix for i3blocks
  environment.pathsToLink = ["/libexec"];

  users = {
    mutableUsers = false; # users cannot change password
    users.oscar = {
      isNormalUser = true;
      description = "Oscar Le Dauphin";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "libvirtd"
        "input"
        "plugdev"
        "adbusers"
        "i2c" # used for external display brightness control
      ];
      hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
    };
  };
  hardware.i2c.enable = true;

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

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
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
  programs.nano.enable = false;

  virtualisation = {
    docker = {
      enable = true;
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
    speechd.enable = false; # heavy and not used
    libinput.touchpad.naturalScrolling = true;
    # needed for wireguard
    resolved.enable = true;
  };

  # enable flakes
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = [
        "root"
        "oscar"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
