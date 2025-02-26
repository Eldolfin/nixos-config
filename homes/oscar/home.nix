{
  lib,
  isPersonal,
  ...
}: {
  imports =
    [
      ./basePackages.nix
      ./services.nix

      ./pkgs/cliTools.nix
      ./pkgs/dev.nix
      ./pkgs/direnv.nix
      ./pkgs/firefox.nix
      ./pkgs/git.nix
      ./pkgs/helix
      ./pkgs/i3
      ./pkgs/scripts
      ./pkgs/socials.nix
      ./pkgs/sounds.nix
      # ./pkgs/zsh.nix
      ./pkgs/fish.nix
      ./pkgs/jujutsu.nix
      ./pkgs/niri
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

  #   stylix.enable = true;
  #   stylix.autoEnable = true;

  xdg = {
    mimeApps.defaultApplications = {
      "application/pdf" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
    };
    portal.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
