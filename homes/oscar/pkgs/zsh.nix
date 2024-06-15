{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    atuin = {
      enableZshIntegration = true;
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
    };
    thefuck.enable = true;
  };

  home.sessionPath = [
    "/home/oscar/bin/scripts/"
    "/home/oscar/bin/executables/"
  ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      clone = ''alacritty -e zsh -c "cd $(pwd); zsh -i"&!'';
      # vi = "nvim";
      vi = "hx";
      svi = "sudo -E -s nvim";
      vimdiff = "nvim -d";
      top = "btop";
      ls = "exa";
      ll = "exa -lah";
      tree = "exa --tree";
      make = "make -j$(nproc)";
      bell = "tput bel && aplay ~/Music/sounds/Tink.wav";

      gctp = "commit-tag-push.sh";
      gl = "git pull";
      gp = "git push --verbose";
      gcl = "git clone --recurse-submodules";
      gst = "git status --short";
      gup = "git pull --rebase";
      gsta = "git stash push";
      gstp = "git stash pop";
      gaa = "git add --all";
      ga = "git add";
      gpv = "git push -v";
      gov = "git push -v"; # common mistake
      gcsm = "git commit -m";

      editconf = "chezmoi edit --watch --apply --color=true --progress=true";
    };

    initExtra = ''
      bindkey '^Z' fancy-ctrl-z 
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "fancy-ctrl-z" ];
    };
  };
}
