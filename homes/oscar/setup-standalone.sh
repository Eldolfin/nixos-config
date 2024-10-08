#!/usr/bin/env bash

set -e

if ! (command -v curl && command -v git); then
	echo curl and git are required to run this script.
	exit
fi

if command -v nix; then
	echo Nix is already installed, skipping
else
	echo Installing nix using the determinate nix installer https://github.com/DeterminateSystems/nix-installer
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -d ~/nixos-config ]; then
	echo Eldolfin/nixos-config is already cloned, skipping
else
	cd ~
	git clone https://github.com/Eldolfin/nixos-config

	echo Running initial home-manager switch
	nix run nixpkgs#nh home switch ~/nixos-config/homes/oscar
fi
