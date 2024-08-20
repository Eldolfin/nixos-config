#!/usr/bin/env bash

set -xe

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
	pushd ~ || exit
	git clone https://github.com/Eldolfin/nixos-config
	popd

	echo Running initial home-manager switch
	# nix run home-manager/master -- switch --flake ~/nixos-config/homes/oscar
	nix run nixpkgs#nh home switch ~/nixos-config/homes/oscar
fi
