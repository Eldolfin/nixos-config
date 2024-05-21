{
  description = "Nixos system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, stylix, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."oscar-portable" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
            stylix.nixosModules.stylix
          ./hosts/configuration-laptop.nix
          ./hosts/hardware-configuration-laptop.nix
        ];
      };

      nixosConfigurations."oscar-tour" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
            stylix.nixosModules.stylix
          ./hosts/configuration-tour.nix
          ./hosts/hardware-configuration-tour.nix
        ];
      };
    };
}
