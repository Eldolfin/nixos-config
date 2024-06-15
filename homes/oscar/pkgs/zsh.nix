{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.atuin = {
    enableZshIntegration = true;
    enable = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
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
      fancy-ctrl-z () {
        if [[ $#BUFFER -eq 0 ]]; then
          bg
          zle redisplay
        else
          zle push-input
        fi
      }
      zle -N fancy-ctrl-z
      bindkey '^Z' fancy-ctrl-z 
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
  };
}
