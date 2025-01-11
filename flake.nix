{
  description = "Nixos system configuration";

  inputs = {
    # only use master when a package is broken on unstable but fixed on master
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord/d5f2fbef2fad379190e0c7a0d2d2f12c4e4df034";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scls = {
      url = "github:estin/simple-completion-language-server/main";
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
    nixpkgs-master,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # common to standalone home config and nixos
    commonModules = [
      ./pkgs/cachix-subsituter.nix
      {
        nixpkgs.overlays = [
          # When applied, the unstable nixpkgs set (declared in the flake inputs) will
          # be accessible through 'pkgs.unstable'
          (_final: _prev: {
            master = import nixpkgs-master {
              inherit system;
              # config.allowUnfree = true;
            };
          })
        ];
      }
    ];
    nixosModulesServer = 
      commonModules
      ++ [
        ./common-server.nix
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
            nur.modules.homeManager.default
            nix-index-database.hmModules.nix-index
            nixcord.homeManagerModules.nixcord
          ];
        }
      ];
    nixosModules =
      nixosModulesServer
      ++ [
        ./common.nix
        stylix.nixosModules.stylix
{          home-manager.sharedModules = [
            {stylix.targets.helix.enable = false;}
          ];
}      ];
  in rec {
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
            nixosModules
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
            nixosModules
            ++ [
              ./hosts/tour/configuration.nix
              ./hosts/tour/hardware-configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          inherit specialArgs;
        };

      "oracle-x86" = let
        specialArgs =
          inputs
          // {
            isTour = false;
          };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            nixosModulesServer ++ 
            [
              ./hosts/oracle-x86/configuration.nix
              ./hosts/oracle-x86/hardware-configuration.nix
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
            nixosModules
            ++ [
              ./hosts/iso/configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          inherit specialArgs;
        };
    };

    homeConfigurations."oscar" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules =
        commonModules
        ++ [
          nixcord.homeManagerModules.nixcord
          nur.modules.homeManager.default
          ./homes/oscar/home.nix
        ];
      extraSpecialArgs =
        inputs
        // {
          helix-master = helix;
          isTour = false;
          isPersonal = false;
        };
    };
    # for github action runner
    homeConfigurations."runner" = homeConfigurations."oscar";

    checks.${system} = let
      specialArgs =
        inputs
        // {
          isTour = false;
        };

      checkArgs = {
        inherit specialArgs;
        pkgs = nixpkgs.legacyPackages.${system};
        commonModules =
          nixosModules
          ++ [
            {home-manager.extraSpecialArgs = specialArgs;}
          ];
      };
    in
      import ./tests checkArgs;
  };
}
