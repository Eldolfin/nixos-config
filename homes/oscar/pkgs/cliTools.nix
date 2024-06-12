{ pkgs, ... }:
{
  home.packages = with pkgs; [
    acpi
    act
    apksigner
    appimage-run
    bacon
    bc
    bear
    bun
    chezmoi
    cinnamon.nemo
    cmake
    comma
    conda
    cron
    dash
    difftastic
    dig
    dive
    entr
    eza
    fd
    feh
    ffmpeg
    fzf
    gcc12
    gdb
    git
    git-lfs
    gnumake
    gnupg
    hyperfine
    joshuto
    jq
    killall
    ltrace
    mosquitto
    navi
    ncdu
    ninja
    niv
    nix-index
    nmap
    ntfs3g
    nh
    # ollama
    pamixer
    pciutils
    # podman-compose
    ripgrep
    scrcpy
    skim
    # speedcrunch
    sysstat
    tailscale
    tealdeer
    testdisk
    tree
    unrar-wrapper
    unzip
    usbutils
    vim
    wget
    wireguard-tools
    xclip
    xdotool
    xorg.xmodmap
    zellij
    zip
    zoxide
  ];
}
