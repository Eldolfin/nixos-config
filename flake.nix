{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      };
    in
    {
      nixosConfigurations."oscar-portable" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
            stylix.nixosModules.stylix
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./hosts/configuration-laptop.nix
          ./hosts/hardware-configuration-laptop.nix
        ];
      };

      nixosConfigurations."oscar-tour" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
            stylix.nixosModules.stylix
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./hosts/configuration-tour.nix
          ./hosts/hardware-configuration-tour.nix
        ];
      };
    };
}
