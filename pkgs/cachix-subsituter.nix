{pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["oscar" "root" "@admin" "@wheel"];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nixos-eldolfin.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixos-eldolfin.cachix.org-1:+9moa8pYw+2ie0kWZWjhhNu1Axa+G/2ssdSClvfE/7w="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
  };
}
