{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations."oscar" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            permittedInsecurePackages = [
              "nix-2.15.3"
            ];
          };
        };

        # pass inputs as specialArgs
        extraSpecialArgs = { inherit inputs; };

        # import your home.nix
        modules = [ ./home.nix ];
      };

      homeConfigurations."oscar.le-dauphin" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            permittedInsecurePackages = [
              "nix-2.15.3"
            ];
          };
        };

        # pass inputs as specialArgs
        extraSpecialArgs = { inherit inputs; };

        # import your home.nix
        modules = [ ./home.nix ];
      };
    };
}
