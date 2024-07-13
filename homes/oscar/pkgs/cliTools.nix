{ pkgs, ... }:
{
  home.packages = with pkgs; [
    acpi
    appimage-run
    bc
    bear
    cmake
    comma
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
    nix-index
    nmap
    ntfs3g
    nh
    pamixer
    pciutils
    ripgrep
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
