{ pkgs, ... }:
{
  program.firefox = {
    package = pkgs.librewolf;
  };
}
