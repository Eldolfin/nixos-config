{pkgs, ...}: {
  #  home.packages = with pkgs; [
  #  ];
  programs = {
    nushell = {
      enable = true;
      # for editing directly to config.nu
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "prefix"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100
             completer: $carapace_completer # check 'carapace_completer'
           }
         }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        append /usr/bin/env
        )

        def clone [] { pwd | alacritty -e nu -e $'echo $in'}
      '';
      shellAliases = {
        vi = "nvim";
        gct = "~/bin/scripts/commit-tag-push.sh";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
    };
  };

  # for using background tasks in nushell
  services.pueue.enable = true;
}
