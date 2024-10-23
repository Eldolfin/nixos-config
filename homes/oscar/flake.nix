{
  description = "Home Manager configuration of oscar";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    helix.url = "github:helix-editor/helix/master";
    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    nixcord,
    helix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."oscar" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        nixcord.homeManagerModules.nixcord
        nur.hmModules.nur
        ./home.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        helix-master = helix;

        isTour = false;
        isPersonal = false;
      };
    };
  };
}
