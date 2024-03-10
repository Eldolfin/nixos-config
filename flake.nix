{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations."oscar-laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
