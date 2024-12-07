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
    nixcord.url = "github:kaylorben/nixcord";

    helix.url = "github:helix-editor/helix/master";
    scls.url = "github:estin/simple-completion-language-server/main";
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
    ...
  } @ inputs: let
    system = "x86_64-linux";
    commonModules = [
      ./common.nix
      stylix.nixosModules.stylix
      nur.modules.nixos.default
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
      nix-index-database.nixosModules.nix-index
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
          nur.modules.home-manager.default
          nix-index-database.hmModules.nix-index
          nixcord.homeManagerModules.nixcord
          {stylix.targets.helix.enable = false;}
        ];
      }
    ];
  in {
    nixosConfigurations = {
      "oscar-portable" = let
        specialArgs =
          inputs
          // {
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
          inherit specialArgs;
        };

      "oscar-tour" = let
        specialArgs =
          inputs
          // {
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
          inherit specialArgs;
        };

      "oscar-iso" = let
        specialArgs =
          inputs
          // {
            isTour = false;
          };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            commonModules
            ++ [
              ./hosts/iso/configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          inherit specialArgs;
        };
    };
    checks.${system} = let
      specialArgs =
        inputs
        // {
          isTour = false;
        };

      checkArgs =
        specialArgs
        // {
          pkgs = nixpkgs.legacyPackages.${system};
          commonModules =
            commonModules
            ++ [
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
        };
    in
      import ./tests checkArgs;
  };
}
