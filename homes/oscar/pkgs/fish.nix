{pkgs, ...}: {
  imports = [./starship.nix];
  home.packages = with pkgs; [
    # used by zsh-notify
    grc

    # nicer df replacement
    dysk
  ];
  # fix missing completions for nix commands https://discourse.nixos.org/t/how-to-use-completion-fish-with-home-manager/23356
  xdg.configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";

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
      # check this if prompt is slow to appear
      # {
      #   name = "async-prompt";
      #   src = async-prompt.src;
      # }
    ];
    shellAbbrs = {
      sw = "systemswitch";
      clone = ''kitty -e $SHELL &>/dev/null & disown'';

      ls = "exa";
      ll = "exa -lah";
      lg = "lazygit";
      tree = "exa --tree";
      df = "dysk";
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

      gitentr = "git ls-files | entr -c";
      g = "git";
      h = "hx";
      dc = "docker compose";
      ssh = "TERM=xterm ssh";
    };
    interactiveShellInit = ''
      set -U fish_greeting
      bind \cz 'fg 2>/dev/null; commandline -f repaint'

      # yazi wrapper which cd to where yazi is quitted
      function y
      	set tmp (mktemp -t "yazi-cwd.XXXXXX")
      	yazi $argv --cwd-file="$tmp"
      	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      		builtin cd -- "$cwd"
      	end
      	rm -f -- "$tmp"
      end

      # print and copy current working dir
      function cwd
              pwd | tr -d '\n' | fish_clipboard_copy
              pwd
      end

      function wol
        set available_commands wake shutdown

        if test $(count $argv) -ne 2
            echo "wrong number of arguments"
            echo "usage: wol <wake|shutdown> <MACHINE_NAME>"
            return 1
        end
        if not contains $argv[1] $available_commands
            echo "first argument should be in [$available_commands]"
            return 1
        end

        echo "Sending '$argv[1]' command to '$argv[2]'..."
        curl --retry 10 "https://wol.internal.eldolfin.top/api/machine/$argv[2]/$argv[1]" \
            --request POST --insecure
      end
    '';
  };
}
