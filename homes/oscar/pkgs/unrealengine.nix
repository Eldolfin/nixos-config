{ config, pkgs, ... }:
{
  import = [
    ./unrealengine.nix
  ];
  home.packages = with pkgs; [
    ue4
  ];
}
