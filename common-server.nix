{pkgs, ...} @ inputs: {
  imports = [
    ./pkgs/uutils.nix
    ./pkgs/nh.nix
  ];
  # takes 2 min at each rebuild...
  documentation.man.generateCaches = false;

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

  environment.pathsToLink = [
    # required for xdg portal to work
    # see https://github.com/nix-community/home-manager/blob/53c587d263f94aaf6a281745923c76bbec62bcf3/modules/misc/xdg-portal.nix#L26
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

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

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];
  programs.nano.enable = false;

  virtualisation = {
    docker = {
      enable = true;
    };
  };
  services = {
    speechd.enable = false; # heavy and not used
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
