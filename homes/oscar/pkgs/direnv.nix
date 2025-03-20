{
  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
  home.sessionVariables = {
    # disable direnv is taking a while to execute. Use CTRL-C to give up.
    DIRENV_WARN_TIMEOUT = 0;
  };
}
