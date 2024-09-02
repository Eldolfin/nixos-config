{ pkgs, ... }:
{
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    acpi
    # appimage-run
    asciinema
    bc
    bear
    cachix
    cmake
    cron
    fd
    feh
    ffmpeg
    fzf
    gnumake
    gnupg
    hyperfine
    jq
    killall
    ltrace
    # mosquitto
    navi
    ncdu
    nix-tree
    nmap
    ntfs3g
    nh
    openssl
    pamixer
    pciutils
    # scrcpy
    sops
    sysstat
    tealdeer
    # testdisk
    unrar-wrapper
    unzip
    usbutils
    vim
    wget
    wireguard-tools
    xclip
    xdotool
    xorg.xmodmap
    zip
  ];
}
