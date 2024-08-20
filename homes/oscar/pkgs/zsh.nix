{ pkgs, ... }:
{
  imports = [ ./starship.nix ];
  home.packages = with pkgs; [
    wmctrl # used by zsh-notify
  ];
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      git = true;
      enableZshIntegration = true;
    };
  };

  home.sessionPath = [
    "/home/oscar/bin/scripts/"
    "/home/oscar/bin/executables/"
  ];
  programs.bash = {
    enable = true;
    # for when chsh is not runnable
    # or for nix-shells ?
    # profileExtra = "exec ${pkgs.zsh}";
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      clone = ''alacritty -e zsh -c "cd $(pwd); zsh -i"&!'';
      svi = "sudo -e";
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

    plugins = [
      # {
      #   name = "vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      # }
    ];

    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # ignore case in completion if no case-sensitive match were found
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}'

      # zsh-notify params
      zstyle ':notify:*' expire-time 5000 # notification stay for 5s
      zstyle ':notify:*' enable-on-ssh yes

      # anoying
      # clear
      # fastfetch

      # export COPILOT_API_KEY=$(cat /run/secrets/apis/COPILOT_API_KEY)
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "fancy-ctrl-z" ];
    };

    antidote = {
      enable = true;
      plugins = [ "marzocchi/zsh-notify" ];
    };
    # for home manager standalone where chsh is not available
    # and nix-shell ?
  };
}
