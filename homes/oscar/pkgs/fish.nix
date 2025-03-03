{pkgs, ...}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    # used by zsh-notify
    grc
  ];
  # fix missing completions for nix commands https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356
  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
  home.sessionPath = [
    "/home/oscar/bin/scripts/"
  ];

  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "grc";
        inherit (pkgs.fishPlugins.grc) src;
      }
      {
        name = "plugin-grc";
        inherit (fzf-fish) src;
      }
      {
        name = "forgit";
        inherit (forgit) src;
      }
      {
        name = "fish-you-should-use";
        inherit (fish-you-should-use) src;
      }
      {
        name = "done";
        inherit (done) src;
      } # automatically receive notifications when long processes finish
      {
        name = "colored-man-pages";
        inherit (colored-man-pages) src;
      }
      {
        name = "autopair";
        inherit (autopair) src;
      } # alternative: pisces https://github.com/laughedelic/pisces
      # TODO: check if prompt is slow to appear
      # {
      #   name = "async-prompt";
      #   src = async-prompt.src;
      # }
    ];
    shellAbbrs = {
      sw = "systemswitch";
      clone = ''$TERM_PROGRAM -e $SHELL &>/dev/null & disown'';

      ls = "exa";
      ll = "exa -lah";
      lg = "lazygit";
      tree = "exa --tree";
      make = "make -j$(nproc)";
      bell = "tput bel && ${pkgs.pulseaudio}/bin/paplay ~/Music/sounds/Tink.wav";
      gh-repo-here = "gh repo new $(basename $(pwd)) --private --source=.";

      # text search in home dir
      coderg = ''sk -i -c "rg '{}' --color=always ~/Prog /etc/nixos ~/.config" --ansi'';

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

      g = "git";
      h = "hx";
    };
    interactiveShellInit = ''
      set -U fish_greeting
      bind \cz 'fg 2>/dev/null; commandline -f repaint'
    '';
  };
}
