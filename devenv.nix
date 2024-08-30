{ pkgs, ... }:

{
  packages = [ pkgs.git ];
  languages.nix.enable = true;

  pre-commit.hooks.nixfmt = {
    enable = true;
    package = pkgs.nixfmt-rfc-style;
  };
  pre-commit.hooks.shfmt.enable = true;
  # pre-commit.hooks.shellcheck.enable = true; # too restrictive
  pre-commit.hooks.typos.enable = true;
}
