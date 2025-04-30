{
  lib,
  isPersonal,
  ...
}: {
  imports =
    [
      ./basePackages.nix
      ./services.nix

      ./pkgs/ai.nix
      ./pkgs/cliTools.nix
      ./pkgs/dev.nix
      ./pkgs/direnv.nix
      ./pkgs/firefox.nix
      ./pkgs/git.nix
      ./pkgs/helix
      ./pkgs/scripts
      ./pkgs/sounds.nix
      ./pkgs/fish.nix
      ./pkgs/stylix.nix
      ./pkgs/xdg.nix
    ]
    ++ lib.optionals isPersonal [./personalPackages.nix];

  home = {
    username = "oscar";
    homeDirectory = "/home/oscar";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # offline home manager manual :) (broken atm)
  manual.html.enable = false;

  home.stateVersion = "24.11";
}
