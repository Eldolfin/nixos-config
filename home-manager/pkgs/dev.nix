{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode-fhs
# jetbrains
    # jetbrains-toolbox

    # java
    # jetbrains.idea-community
    # jetbrains.idea-ultimate
    # jetbrains.pycharm-community
    # maven
    openjdk17

    # rust
    # evcxr
    rustup

    # for leptos
    trunk
    leptosfmt
    cargo-leptos
    cargo-generate
    sass # for css

    # c/c++
    # jetbrains.clion
    valgrind
    clang-tools

    # go
    go
    gopls
    gotools

    # python
    # jetbrains.pycharm-professional
    mypy
    poetry
    poethepoet
    python311Full
    python311Packages.pip
    python311Packages.python-lsp-server
    python311Packages.bpython
    python311Packages.scipy
    python311Packages.matplotlib
    python311Packages.jupyter-core
    python311Packages.notebook
    python311Packages.numpy
    python311Packages.pytest
    python311Packages.psutil

    # c#
    mono
    # jetbrains.rider
    dotnet-sdk_7

    # nix
    nixpkgs-fmt
    nil

    # kubernetes
    kubectl
    minikube

    # android
    # android-studio
    android-tools # adb, fastboot etc

    # Haskell
    ghc

    # ocaml
    ocaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat

    # Common lisp
    # sbcl

    # sql
    # sqlfluff
    # dbeaver

    # zig
    zig
    zls

    # php
    php83Packages.composer
    php83

    # Language servers
    lua-language-server

    # Arduino
    # arduino

    # misc
    # graphviz
    clang-tools_17
    nodePackages.live-server
    sshfs
  ];
  nixpkgs.config.allowBroken = true; # for ue4
}
