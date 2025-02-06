{pkgs, ...}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    # used by zsh-notify
    grc
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

      # g = "git";
      h = "hx";
    };
  };
}
