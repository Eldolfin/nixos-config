{ pkgs, ... }:
{
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    acpi
    # appimage-run
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
    nmap
    ntfs3g
    nh
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
