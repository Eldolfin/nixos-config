{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.act
  ];
  languages.nix.enable = true;

  pre-commit.hooks.nixfmt = {
    enable = true;
    package = pkgs.nixfmt-rfc-style;
  };
  pre-commit.hooks.shfmt.enable = true;
}
