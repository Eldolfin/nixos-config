{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, stylix, home-manager, ... }:
    let
      system = "x86_64-linux";
    commonModules = [
        stylix.nixosModules.stylix
      ./common.nix
          home-manager.nixosModules.home-manager
          {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.oscar = import ./home-manager/home.nix;
          }
      ];
    in
    {
      nixosConfigurations."oscar-portable" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/configuration-laptop.nix
          ./hosts/hardware-configuration-laptop.nix
        ];
      };

      nixosConfigurations."oscar-tour" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/configuration-tour.nix
          ./hosts/hardware-configuration-tour.nix
        ];
      };
    };
}
