{
  programs.git = {
    enable = true;
    userEmail = "90446228+Eldolfin@users.noreply.github.com";
    userName = "Oscar Le Dauphin";
    lfs.enable = true;
    extraConfig = {
      core = {
        autocrlf = true;
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
  programs.git.difftastic.enable = true;
}
