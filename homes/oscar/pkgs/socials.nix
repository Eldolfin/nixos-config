{ pkgs, ... }:
{
  imports = [ ./discord.nix ];
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
  ];
}
