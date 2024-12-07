{
  description = "Home Manager configuration of oscar";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    helix.url = "github:helix-editor/helix/master";
    nixcord.url = "github:kaylorben/nixcord";
    scls.url = "github:estin/simple-completion-language-server/main";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    nixcord,
    helix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."oscar" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        nixcord.homeManagerModules.nixcord
        nur.modules.homeManager.default
        ./home.nix
      ];
      extraSpecialArgs =
        inputs
        // {
          helix-master = helix;
          isTour = false;
          isPersonal = false;
        };
    };
  };
}
