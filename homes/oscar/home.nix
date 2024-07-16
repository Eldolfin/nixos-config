{ pkgs, ... }:
{
  imports = [
    ./personalPackages.nix
    ./basePackages.nix
    ./services.nix
  ];
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # offline home manager manual :)
  manual.html.enable = true;

  stylix.enable = true;
  stylix.autoEnable = true;
}
