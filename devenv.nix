{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.act
  ];
  languages.nix.enable = true;

  pre-commit.hooks.nixfmt-rfc-style.enable = true;
  pre-commit.hooks.shfmt.enable = true;
}
