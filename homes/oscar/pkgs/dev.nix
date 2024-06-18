{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode-fhs
    # jetbrains
    # jetbrains-toolbox

    # java
    # jetbrains.idea-community
    jetbrains.idea-ultimate
    # jetbrains.pycharm-community
    maven
    openjdk17

    # rust
    # evcxr
    # rust-analyzer
    rustup

    # for leptos
    # trunk
    # leptosfmt
    # cargo-leptos
    # cargo-generate
    # sass # for css

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
    # jupyter-all
    mypy
    poetry
    poethepoet

    (pkgs.python311Full.withPackages (ppkgs: [
      ppkgs.pip
      ppkgs.python-lsp-server
      ppkgs.bpython
      ppkgs.scipy
      ppkgs.matplotlib
      ppkgs.notebook
      ppkgs.numpy
      ppkgs.pytest
      ppkgs.psutil
      ppkgs.grip # github markdown preview
    ]))

    # c#
    mono
    jetbrains.rider
    dotnet-sdk_7

    # js
    yarn
    typescript

    # nix
    nixpkgs-fmt
    nil

    # kubernetes
    # kubectl
    # minikube

    # android
    # android-studio
    android-tools # adb, fastboot etc

    # Haskell
    # ghc

    # ocaml
    # ocamlPackages.ocaml-lsp
    # ocamlPackages.ocamlformat

    # Common lisp
    # sbcl

    # sql
    # sqlfluff
    # dbeaver

    # zig
    # zig
    # zls

    # php
    # php83Packages.composer
    # php83

    # Language servers
    lua-language-server
    nodePackages_latest.typescript-language-server
    docker-compose-language-service
    yaml-language-server
    dockerfile-language-server-nodejs

    # Arduino
    # arduino

    # misc
    # graphviz
    clang-tools_17
    nodePackages.live-server
    sshfs
    gh
    git
  ];
}
