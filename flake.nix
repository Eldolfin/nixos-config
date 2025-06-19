{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old-gxml.url = "github:NixOS/nixpkgs/?rev=c792c60b8a97daa7efe41a6e4954497ae410e0c1";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
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
      url = "github:kaylorben/nixcord/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wol-api = {
      url = "github:Eldolfin/wol-api";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systemswitch = {
      url = "github:eldolfin/nixos-config/main?dir=custom-pkgs/systemswitch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    backgrounds = {
      url = "github:Eldolfin/windows_backgrounds";
      flake = false;
    };

    helix-steel = {
      url = "github:mattwparas/helix/steel-event-system";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    stylix,
    home-manager,
    nur,
    sops-nix,
    nix-index-database,
    nixcord,
    wol-api,
    pre-commit-hooks,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    system = "x86_64-linux";
    # common to standalone home config and nixos
    commonModules = [
      ./pkgs/cachix-subsituter.nix
    ];
    args = inputs // {inherit system;};
    nixosModulesServer =
      commonModules
      ++ [
        ./common-server.nix
        nur.modules.nixos.default
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        wol-api.nixosModules.default
        {
          home-manager = {
            backupFileExtension = "old";
            useGlobalPkgs = true;
            useUserPackages = true;
            users.oscar = import ./homes/oscar/home.nix;
          };

          home-manager.extraSpecialArgs = {
            isPersonal = true;
          };
          home-manager.sharedModules = [
            nur.modules.homeManager.default
            nix-index-database.hmModules.nix-index
            nixcord.homeModules.nixcord
          ];
          # nvidia, steam, ...
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [(import ./overlays args)];
          };
        }
      ];
    nixosModules =
      nixosModulesServer
      ++ [
        ./common.nix
        stylix.nixosModules.stylix
      ];
  in rec {
    nixosConfigurations = {
      "oscar-portable" = let
        specialArgs =
          args
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
          args
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
          args
          // {
            isTour = false;
          };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            nixosModules
            ++ [
              ./hosts/oracle-x86/configuration.nix
              ./hosts/oracle-x86/hardware-configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          inherit specialArgs;
        };

      "homeserver" = let
        specialArgs =
          args
          // {
            isTour = false;
          };
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            nixosModules
            ++ [
              ./hosts/homeserver/configuration.nix
              ./hosts/homeserver/hardware-configuration.nix
              {home-manager.extraSpecialArgs = specialArgs;}
            ];
          inherit specialArgs;
        };

      "oscar-iso" = let
        specialArgs =
          args
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
          stylix.homeManagerModules.stylix
          nixcord.homeModules.nixcord
          nur.modules.homeManager.default
          ./homes/oscar/home.nix
        ];
      extraSpecialArgs =
        args
        // {
          isTour = false;
          isPersonal = false;
        };
    };
    # for github action runner
    homeConfigurations."runner" = homeConfigurations."oscar";

    integration-tests = let
      specialArgs =
        args
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

    checks = forAllSystems (system:
      {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            # formatters
            alejandra.enable = true; # nix
            shfmt.enable = true; # shell
            denofmt.enable = true; # markdown
            end-of-file-fixer.enable = true;
            trim-trailing-whitespace.enable = true;
            black.enable = true;

            # linters
            actionlint.enable = true;
            statix.enable = true;
            check-added-large-files.enable = true;
            check-merge-conflicts.enable = true;
            check-yaml.enable = true;
            deadnix.enable = true;
            markdownlint = {
              enable = true;
              settings.configuration = {
                MD013 = false; # line lenght check
              };
            };
            nil.enable = true;
            ripsecrets.enable = true;
          };
        };
      }
      // integration-tests);

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs =
          (with pkgs; [
            act
            just
            nix-output-monitor
          ])
          ++ self.checks.${system}.pre-commit-check.enabledPackages;
      };
    });
  };
}
