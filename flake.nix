{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix/master";
    nixcord.url = "github:kaylorben/nixcord";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    stylix,
    home-manager,
    nur,
    sops-nix,
    nix-index-database,
    helix,
    nixcord,
    lix-module,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    commonModules = [
      ./common.nix
      stylix.nixosModules.stylix
      nur.nixosModules.nur
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
      nix-index-database.nixosModules.nix-index
      lix-module.nixosModules.default
      {
        home-manager = {
          backupFileExtension = "old";
          useGlobalPkgs = true;
          useUserPackages = true;
          users.oscar = import ./homes/oscar/home.nix;
        };

        home-manager.extraSpecialArgs = {
          helix-master = helix;
          isPersonal = true;
        };
        home-manager.sharedModules = [
          nur.hmModules.nur
          nix-index-database.hmModules.nix-index
          nixcord.homeManagerModules.nixcord
          {stylix.targets.helix.enable = false;}
        ];
      }
    ];
  in {
    nixosConfigurations = {
      "oscar-portable" = let
        specialArgs = {
          isTour = false;
        };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            commonModules
            ++ [
              ./hosts/laptop/configuration.nix
              ./hosts/laptop/hardware-configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          specialArgs = inputs // specialArgs;
        };

      "oscar-tour" = let
        specialArgs = {
          isTour = true;
        };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            commonModules
            ++ [
              ./hosts/tour/configuration.nix
              ./hosts/tour/hardware-configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          specialArgs = inputs // specialArgs;
        };

      "oscar-iso" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [./hosts/iso/configuration.nix];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
