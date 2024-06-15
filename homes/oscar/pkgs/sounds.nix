{
  home.file."Music/sounds".source = builtins.fetchGit {
    url = "https://github.com/Eldolfin/sounds";
    rev = "c5ea349ac3f5a69c618c00aca7f68175918320a4";
  };
}
