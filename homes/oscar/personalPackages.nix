{ pkgs, ... }:

{
  imports = [
    ./pkgs/lazyvim.nix # switched to nixvim
    ./pkgs/dev.nix
    ./pkgs/gaming.nix
    # ./pkgs/hyprland.nix
    ./pkgs/movies.nix
    ./pkgs/zsh.nix
    ./pkgs/cliTools.nix
    ./pkgs/helix.nix
    ./pkgs/firefox.nix
    # ./pkgs/editing.nix
    # ./pkgs/nixvim.nix
    ./pkgs/sounds.nix
    ./pkgs/bloat.nix
  ];

  programs.emacs.enable = true;

  home.packages = with pkgs; [
    # graphical programs
    prismlauncher
    virt-manager
    gparted
    signal-desktop
    # ckb-next
    corectrl
    godot_4
    gimp
    # mumble
    ungoogled-chromium
    # barrier
    kdeconnect
    insomnia # never used
    # freetube
    bitwarden
    # mattermost-desktop
    nextcloud-client
    # armcord
    # discord
    webcord-vencord
    wdisplays
    flameshot
    emote

    # libraries
    glfw
    libllvm
    gnumake
    libnotify
    dotnet-sdk_7
    # omnisharp-roslyn
    # clang
    boost
    armadillo
    pre-commit
    stdenv.cc.cc.lib
    luajit
    wine
    stylua
    gpp
    gamemode
    mangohud
    deno
    winetricks
    pyright
    xorg.libXtst.out
    mold
    # graalvm-ce
    tree-sitter
    luajitPackages.luarocks
    parallel
    black
    nix-tree
    libguestfs
    kdocker
    gitea-actions-runner

    # font
    source-code-pro
    meslo-lgs-nf

    man-pages
    man-pages-posix

    fusuma

    # libs
    nodejs
    openssl
    dnsmasq
    criterion
    gtest
    gcovr

    # gui apps
    # syncthing
    dunst
    thunderbird
    redshift
    # ddccontrol
    # ddcutil
    # ddcui
    qbittorrent
    libreoffice
    virt-manager
    # mullvad-vpn
    noisetorch
    opensnitch-ui
    xorg.xbacklight
    cpufrequtils
    pkg-config
    whatsapp-for-linux
    # blender
  ];
}
