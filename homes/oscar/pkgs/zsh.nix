{ pkgs, ... }:
{
  imports = [ ./starship.nix ];
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
  # programs.bash = {
  #   enable = true;
  #   # for when chsh is not runnable
  #   # or for nix-shells ?
  #   profileExtra = "exec ${pkgs.zsh}/bin/zsh || true"; # crashes i3???
  # };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      clone = ''alacritty -e zsh &!'';
      svi = "sudo -e";
      vimdiff = "nvim -d";
      ls = "exa";
      ll = "exa -lah";
      lg = "lazygit";
      tree = "exa --tree";
      make = "make -j$(nproc)";
      bell = "tput bel && ${pkgs.pulseaudio}/bin/paplay ~/Music/sounds/Tink.wav";

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
    };

    initExtra = ''
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      source ${pkgs.zsh-autopair.src}/zsh-autopair.plugin.zsh

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # ignore case in completion if no case-sensitive match were found
      zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}'

      # zsh-notify params
      zstyle ':notify:*' expire-time 5000 # notification stay for 5s
      zstyle ':notify:*' enable-on-ssh yes
      zstyle ':notify:*' success-sound "${pkgs.kdePackages.oxygen-sounds}/share/sounds/Oxygen-K3B-Finish-Success.ogg"
      zstyle ':notify:*' error-sound "${pkgs.kdePackages.oxygen-sounds}/share/sounds/Oxygen-K3B-Finish-Error.ogg"

      export COPILOT_API_KEY=$(cat /run/secrets/apis/COPILOT_API_KEY)
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "fancy-ctrl-z" ];
    };

    antidote = {
      enable = true;
      plugins = [
        "marzocchi/zsh-notify"
        "wfxr/forgit"
      ];
    };
  };
}
