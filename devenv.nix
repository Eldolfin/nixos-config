{pkgs, ...}: {
  packages = [
    pkgs.git
    pkgs.act
  ];
  languages.nix.enable = true;

  pre-commit.hooks.alejandra.enable = true;
  pre-commit.hooks.shfmt.enable = true;
}
