# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/dell/xps/15-9560/nvidia>
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      # GPU Passthrough
      # ./gpu-passthrough.nix


      (
        let rev = "main"; in
        import (builtins.fetchTarball {
          url = "https://gitlab.com/VandalByte/darkmatter-grub-theme/-/archive/${rev}/darkmatter-grub-theme-${rev}.tar.gz";
          sha256 = "1i6dwmddjh0cbrp6zgafdrji202alkz52rjisx0hs1bgjbrbwxdj";
        })
      )
    ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable cuda
  nixpkgs.config.cudaSupport = true;

  # Bootloader.

  # grub
  # systemd
  boot.loader = {
    # systemd-boot.enable = true;

    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = [ "nodev" ];
      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';

      darkmatter-theme = {
        enable = true;
        style = "nixos";
        icon = "color";
        resolution = "1080p";
      };
    };

    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Wifi EPITA
  networking = {
    interfaces = {
      #wlp59s0.ipv4.addresses = [{
      #  prefixLength = 64;
      #}];
    };
    wireless.networks.IONIS.auth = ''
      eap=PEAP
      identity="oscar.le-dauphin@epita.fr"
      password="vnzpeBAL"
    '';
  };


  # for gpu in docker containers
  systemd.enableUnifiedCgroupHierarchy = false;

  #  boot.initrd.luks.devices = {
  #    name = "nixos";
  #    device = "/dev/disk/by-uuid/9ACA-8EC6";
  #    preLVM = true;
  #  };

  networking.hostName = "nixos-portable"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

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

  services.xserver = {
    # Configure keymap in X11
    #layout = "fr";
    xkbVariant = "";

    enable = true;

    desktopManager = {
      # gnome.enable = true;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      defaultSession = "none+i3";
      # Use xfce as desktop manager but window manager is still i3
      # defaultSession = "xfce";
      # defaultSession = "gnome";
      # set correct scale 
      sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
          Xcursor.theme: Adwaita
          Xcursor.size: 256
            ''}
      '';

      # gdm.enable = true;
      # startx.enable = true;
      lightdm = {
        enable = true;
        greeter.enable = true;
        greeters.pantheon.enable = true;
        #        greeters.gtk.enable = true;
      };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
    };


    autoRepeatDelay = 250;
    autoRepeatInterval = 20;
  };

  # fix for i3blocks
  environment.pathsToLink = [ "/libexec" ];

  # for firefox to support touchscreen scroll
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };


  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.prime = {

    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  users.mutableUsers = false; # users cannot change password
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar Le Dauphin";
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c" "libvirtd" ];
    hashedPassword = "$y$j9T$CLXLAGMu18fDGm90VWDY0/$/K9714xLsq2iIaC1taF/AanvyL0PGNpgiyHDcXFKRr6";
    /* packages = with pkgs; [ ]; */
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "oscar";

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # cli tools
    #    git
    #    exa
    #    fd
    #    fzf
    #    mpv
    #    btop
    #    zsh
    #    neofetch
    #    wget
    #    chezmoi
    #    zoxide
    #    zellij
    #    gcc12
    #    lazygit
    #    feh
    #    bat
    #    gnumake
    #    pkgconfig
    #    killall
    #    cmake
    #    rust-analyzer
    #    usbutils
    #    android-tools
    #    tailscale
    #    ripgrep
    #    nix-index
    #
    ## libs
    #    nodejs
    #    rustup
    #    gcc12
    #    cudatoolkit
    #    openssl
    #    bluez
    #    clang
    #    clang-tools
    #    python311
    #    python311Packages.pip
    #    dnsmasq
    #    python310.pkgs.psutil
    #    python3Packages.psutil
    #
    ## gui apps
    #    alacritty
    #    librewolf
    #    flameshot
    #    emote
    #    xclip
    #    syncthing
    #    armcord
    #    bluez
    #    blueman
    #    dunst
    #    steam
    #    thunderbird
    #    redshift
    #    ddccontrol
    #    ddcutil
    #    ddcui
    #    qbittorrent
    #    libreoffice
    #    virt-manager
    #    mullvad-vpn
    #    noisetorch
    #    opensnitch-ui xorg.xbacklight
    #    cpufrequtils
    #
    #    # steam fix ??
    #    pango
    #    harfbuzz
    #    libthai
  ];

  services.illum.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.firejail.enable = true;

  programs.noisetorch.enable = true;
  programs.dconf.enable = true;

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

  # make nixos rebuild faster, using more ram and less disk
  # boot.tmp.useTmpfs = true;
  # boot.tmp.tmpfsSize = "95%";

  # tailscale
  services.tailscale.enable = true;

  # virt-manager
  virtualisation.libvirtd = {
    enable = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.ovmf.enable = true;
    qemu.runAsRoot = true;
  };

  # something something qemu single gpu passthrough blah blah blah
  systemd.services.libvirtd.preStart = ''
        mkdir -p /var/lib/libvirt
    # mkdir -p /var/lib/libvirt/vgabios


        rm -r /var/lib/libvirt/hooks
        ln -sf /etc/nixos/git-repo/hooks/ /var/lib/libvirt/
    # ln -sf /etc/nixos/git-repo/patched.rom /var/lib/libvirt/vgabios/patched.rom

        chmod -R +x /var/lib/libvirt/hooks/
    # chmod +x /var/lib/libvirt/hooks/kvm.conf
  '';

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
          ControllerMode = "bredr";
        };
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      setLdLibraryPath = true;
    };
  };
  services.blueman.enable = true;
  # multimedia server (for play pause keys)
  services.mmsd.enable = true;

  # fix for steam

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
    };
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };

    waydroid.enable = true;
  };

  # List services that you want to enable:

  # powerManagement.cpuFreqGovernor = "performance";

  # lol (800MHz)
  # powerManagement.cpufreq.max = 800;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable syncthing daemon
  services =
    {
      syncthing = {
        enable = true;
        user = "oscar";
      };
    };

  # touchscreen maybe

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    maxSpeed = "4.0";
    scrollDelta = -75;
  };

  services.xserver.dpi = 96;

  services.xserver.libinput.enable = false;
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
