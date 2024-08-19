{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  home.sessionVariables = {
    DIRENV_SKIP_TIMEOUT = "TRUE";
  };
}
