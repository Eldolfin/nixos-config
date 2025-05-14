{
  pkgs,
  systemswitch,
  ...
}: {
  programs.nix-index.enable = true;
  home.packages = with pkgs; [
    # TODO: cleanup, most of these are probably never used
    acpi
    bc
    bear
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
    navi
    ncdu
    nix-search-cli
    nmap
    ntfs3g
    nh
    openssl
    pulsemixer
    pciutils
    sops
    sysstat
    tealdeer
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

    systemswitch.packages.x86_64-linux.default
  ];
}
