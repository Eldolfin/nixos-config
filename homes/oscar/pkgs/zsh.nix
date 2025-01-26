{
  pkgs,
  lib,
  ...
}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    # used by zsh-notify
    wmctrl
    pulseaudio
  ];
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    # fzf = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };
    skim = {
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
  programs.zsh = {
    # zprof.enable = true; # enable profiling
    enable = true;
    enableVteIntegration = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      clone = ''${lib.getExe pkgs.ghostty} -e zsh >/dev/null 2>&1 &!'';
      svi = "sudo -e";
      vimdiff = "nvim -d";
      ls = "exa";
      ll = "exa -lah";
      lg = "lazygit";
      tree = "exa --tree";
      make = "make -j$(nproc)";
      bell = "tput bel && ${pkgs.pulseaudio}/bin/paplay ~/Music/sounds/Tink.wav";
      gh-repo-here = "gh repo new $(basename $(pwd)) --private --source=.";

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

      # text search in home dir
      coderg = ''sk -i -c "rg '{}' --color=always ~/Prog /etc/nixos ~/.config" --ansi'';

      g = "git";
      h = "hx";
    };

    initExtra = ''
      source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
      zsh-defer source ${pkgs.zsh-autopair.src}/zsh-autopair.plugin.zsh
      zsh-defer source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # ignore case in completion if no case-sensitive match were found
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}'

      # zsh-notify params
      zstyle ':notify:*' expire-time 5000 # notification stay for 5s
      zstyle ':notify:*' enable-on-ssh yes
      zstyle ':notify:*' success-sound "${pkgs.kdePackages.oxygen-sounds}/share/sounds/Oxygen-K3B-Finish-Success.ogg"
      zstyle ':notify:*' error-sound "${pkgs.kdePackages.oxygen-sounds}/share/sounds/Oxygen-K3B-Finish-Error.ogg"
      zstyle ':notify:*' error-log /dev/null

      export COPILOT_API_KEY=$(cat /run/secrets/apis/COPILOT_API_KEY)
      export CACHIX_AUTH_TOKEN=$(cat /run/secrets/apis/CACHIX_AUTH_TOKEN)
    '';

    antidote = {
      enable = true;
      plugins = [
        "marzocchi/zsh-notify               kind:defer"
        "MichaelAquilina/zsh-you-should-use kind:defer"
        "getantidote/use-omz                kind:defer"
        "ohmyzsh/ohmyzsh                    kind:defer path:plugins/fancy-ctrl-z"
        "ohmyzsh/ohmyzsh                    kind:defer path:plugins/magic-enter"
      ];
    };
    prezto = {
      # TODO: make it lazy loaded so we can use more features
      enable = true;
      caseSensitive = false;
      pmodules = [
        # "environment"
        # "editor"
        "directory"
        # "spectrum"
        # "utility"
        # "syntax-highlighting" # slow
      ];
      editor.dotExpansion = true;
    };
  };
}
