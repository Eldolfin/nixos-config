# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # GPU Passthrough
      # /etc/nixos/git-repo/gpu-passthrough.nix

      # musnix for jack mic
      /etc/nixos/git-repo/musnix

      /etc/nixos/git-repo/bootloader.nix
      /etc/nixos/git-repo/x11.nix
      /etc/nixos/git-repo/sddm.nix
      # /etc/nixos/git-repo/wayland.nix


      (
        let rev = "main"; in
        import (builtins.fetchTarball {
          url = "https://gitlab.com/VandalByte/darkmatter-grub-theme/-/archive/${rev}/darkmatter-grub-theme-${rev}.tar.gz";
          sha256 = "1i6dwmddjh0cbrp6zgafdrji202alkz52rjisx0hs1bgjbrbwxdj";
        })
      )
    ];

  musnix.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # enable cuda
  nixpkgs.config.cudaSupport = true;

  # for gpu in docker containers
  systemd.enableUnifiedCgroupHierarchy = false;

  networking.hostName = "nixos-tour"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

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


  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  users.mutableUsers = false; # users cannot change password
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar Le Dauphin";
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c" "libvirtd" "input" ];
    hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
  };

  users.users.noconfig = {
    isNormalUser = true;
    description = "No Config";
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c" "libvirtd" "user-with-access-to-virtualbox" ];
    hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
  };

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sunshine
    git
    alacritty
    librewolf
    chezmoi
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs = {
    firejail.enable = true;
    kdeconnect.enable = true;
    noisetorch.enable = true;
    dconf.enable = true;
  };

  # avahi for sunshine to work
  services.avahi.enable = true;
  services.avahi.publish.userServices = true;

  # enable mullvad-vpn
  services.mullvad-vpn.enable = true;

  # polkit
  security.polkit.enable = true;

  # external display brightness control requires
  # i2c to be enabled
  boot.kernelModules = [ "i2c-dev" ];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # tailscale
  services.tailscale.enable = true;


  # bluetooth/audio setup
  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          FastConnectable = "true";
        };
        Policy = {
          AutoEnable = "true";
        };
      };
    };
    ckb-next.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
      setLdLibraryPath = true;
    };
  };
  services.blueman.enable = true;
  # multimedia server (for play pause keys)
  services.mmsd.enable = true;

  # fish as default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
  ];

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      enableNvidia = true;
    };
    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings = {
        dns_enabled = true;
      };

      enableNvidia = true;
    };

    # virt-manager
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.ovmf.enable = true;
      qemu.runAsRoot = true;
    };
    virtualbox.host.enable = true;

    waydroid.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable syncthing daemon
  services =
    {
      syncthing = {
        enable = true;
        user = "oscar";
      };


      printing.enable = true;
      printing.drivers = [ pkgs.hplip ];
    };

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
