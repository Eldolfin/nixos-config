{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      stylix,
      home-manager,
      nur,
      sops-nix,
      nixpkgs-unstable,
      nix-index-database,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      commonModules = [
        ./common.nix
        stylix.nixosModules.stylix
        nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        {
          home-manager.backupFileExtension = "old";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.oscar = import ./homes/oscar/home.nix;

          home-manager.sharedModules = [
            nur.hmModules.nur
            nix-index-database.hmModules.nix-index
          ];
        }
        (
          { config, pkgs, ... }:
          {
            nixpkgs.overlays = [ overlay-unstable ];
          }
        )
      ];

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = false; # not needed
        };
      };
    in
    {
      nixosConfigurations."oscar-portable" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      nixosConfigurations."oscar-tour" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/tour/configuration.nix
          ./hosts/tour/hardware-configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      nixosConfigurations."oscar-iso" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [ ./hosts/iso/configuration.nix ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
