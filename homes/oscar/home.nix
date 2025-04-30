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
      ./pkgs/socials.nix
      ./pkgs/sounds.nix
      ./pkgs/fish.nix
      ./pkgs/sway
      # ./pkgs/niri
      # ./pkgs/i3
      # ./pkgs/zsh.nix
      # ./pkgs/jujutsu.nix
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

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      # I use gruber-darker instead
      helix.enable = false;
      # Currently generates invalid wezterm config
      wezterm.enable = false;
    };
  };

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
