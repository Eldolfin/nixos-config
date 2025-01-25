{pkgs, ...} @ inputs: {
  programs = {
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

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
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

      substituters = [
        "https://helix.cachix.org"

        "https://nixos-eldolfin.cachix.org"
      ];
      trusted-public-keys = [
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="

        "nixos-eldolfin.cachix.org-1:+9moa8pYw+2ie0kWZWjhhNu1Axa+G/2ssdSClvfE/7w="
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
