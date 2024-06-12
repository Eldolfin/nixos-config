{ pkgs, ... }:
{
  programs.firefox = {
    package = pkgs.librewolf;
  };
}
