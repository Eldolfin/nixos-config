# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # GPU Passthrough
      ./gpu-passthrough.nix
    ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable cuda
  nixpkgs.config.cudaSupport = true;

  # Bootloader.

  # grub
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/nvme0n1";
  # boot.loader.grub.useOSProber = true;

  # systemd
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  #  boot.initrd.luks.devices = {
  #    name = "nixos";
  #    device = "/dev/disk/by-uuid/9ACA-8EC6";
  #    preLVM = true;
  #  };

  networking.hostName = "nixos-tour"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
    layout = "fr";
    xkbVariant = "";

    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      # set correct scale 
      sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
          Xcursor.theme: Adwaita
            ''}
      '';
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;
      #      extraPackages = with pkgs; [
      #      ];
    };

    videoDrivers = [ "nvidia" ];
  };

  # fix for i3blocks
  environment.pathsToLink = [ "/libexec" ];


  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar Le Dauphin";
    extraGroups = [ "networkmanager" "wheel" "docker" "i2c" "libvirtd" ];
    /* packages = with pkgs; [ ]; */
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "oscar";

  # disable sudo password
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    /* neovim */
    # unstable.helix
    git
    exa
    fd
    fzf
    mpv
    btop
    zsh
    alacritty
    librewolf
    neofetch
    wget
    chezmoi
    nodejs
    unzip
    rustup
    zoxide
    zellij
    gcc12
    lazygit
    feh
    flameshot
    emote
    bat
    gnumake
    openssl
    pkgconfig
    xclip
    syncthing
    armcord
    bluez
    blueman
    dunst
    steam
    thunderbird
    redshift
    killall
    cmake
    clang
    clang-tools
    ddccontrol
    ddcutil
    ddcui
    rust-analyzer
    usbutils
    android-tools
    python311
    python311Packages.pip
    qbittorrent
    ripgrep
    libreoffice
    nix-index
    tailscale
    virt-manager
    dnsmasq
    python310.pkgs.psutil
    mullvad-vpn

    # steam fix ?? 
    pango
    harfbuzz
    libthai

  ];

  # enable mullvad-vpn
  services.mullvad-vpn.enable = true;

  # polkit
  security.polkit.enable = true;

  # hyprland (wm)
  # programs.hyprland.enable = true;

  # external display brightness control requires
  # i2c to be enabled
  boot.kernelModules = [ "i2c-dev" ];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # tailscale
  services.tailscale.enable = true;

  # virt-manager
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu.ovmf.enable = true;
    qemu.runAsRoot = true;
  };
  programs.dconf.enable = true;

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
        };
      };
    };
  };
  services.blueman.enable = true;

  # fix for steam
  hardware.opengl.driSupport32Bit = true;

  # zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
  ];

  # docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
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
