# this file is common between tour and laptor
{ pkgs, inputs, ... }:
{
  imports = [
    ./pkgs/x11.nix
    # ./pkgs/hyprland.nix
    ./pkgs/stylix.nix
    # ./pkgs/wayland.nix
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "./secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oscar/.config/sops/age/keys.txt";
    secrets = {
      example-key = { };
      "myservice/my_subdir/my_secret" = { };
    };
  };

  # periodic store optimisation
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # for gpu in docker containers
  # systemd.enableUnifiedCgroupHierarchy = false;

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
  environment.pathsToLink = [ "/libexec" ];

  users.mutableUsers = false; # users cannot change password
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar Le Dauphin";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "i2c"
      "libvirtd"
      "input"
      "plugdev"
      "adbusers"
    ];
    hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
  };

  users.users.noconfig = {
    isNormalUser = true;
    description = "No Config";
    extraGroups = [
      "networkmanager"
      "docker"
      "i2c"
      "libvirtd"
    ];
    hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
  };
  nix.settings.trusted-users = [
    "root"
    "oscar"
  ];

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  # environment.systemPackages = with pkgs; [ ];

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  programs = {
    firejail.enable = true;
    kdeconnect.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    # direnv = {
    #   enable = true;
    # };
  };

  # polkit
  security.polkit.enable = true;

  # external display brightness control requires
  # i2c to be enabled
  # boot.kernelModules = [ "i2c-dev" ];
  # services.udev.extraRules = ''
  #   KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  # '';

  # pipewire is a newer alternative to alsa/pulseaudio
  # rtkit is optional but recommended
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;
  #   wireplumber.enable = true;
  # };

  # # bluetooth/audio setup
  sound.enable = true;
  # pipewire bluetooth
  # environment.etc = {
  #   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #     		bluez_monitor.properties = {
  #     			["bluez5.enable-sbc-xq"] = true,
  #     			["bluez5.enable-msbc"] = true,
  #     			["bluez5.enable-hw-volume"] = true,
  #     			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
  #     		}
  #     	'';
  # };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          # FastConnectable = "true";
          # Experimental = true; # show the headset battery percentage
        };
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      # setLdLibraryPath = true;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "UbuntuMono" ]; }) ];

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      # enableNvidia = true;
    };

    podman = {
      enable = true;
    };
    # virt-manager
    # libvirtd = {
    #   enable = true;
    #   onBoot = "ignore";
    #   onShutdown = "shutdown";
    #   qemu.ovmf.enable = true;
    #   qemu.runAsRoot = true;
    # };
    # virtualbox.host.enable = true;

    # waydroid.enable = true; # wayland only
  };

  xdg.portal = {
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services = {
    # printing.enable = true;
    # printing.drivers = [ pkgs.hplip ];
    # tailscale
    tailscale.enable = true;
    blueman.enable = true;
    # multimedia server (for play pause keys)
    mmsd.enable = true;
  };

  programs.adb.enable = true;

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # default apps
  xdg.mime.defaultApplications = {
    "application/pdf" = "librewolf.desktop";
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
  };

  # fix a conflicting value with plasma and something else
  # programs.ssh.askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
