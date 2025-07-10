{
  home.file."Music/sounds".source = builtins.fetchGit {
    url = "https://github.com/Eldolfin/sounds";
    rev = "9115b6a20376745971c9f32f8e499af6d519ba28";
  };
}
