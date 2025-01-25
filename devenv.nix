{pkgs, ...}: {
  packages = with pkgs; [
    act
    just
    nix-output-monitor
  ];
  languages.nix.enable = true;

  pre-commit.hooks = {
    # formatters
    alejandra.enable = true; # nix
    shfmt.enable = true; # shell
    denofmt.enable = true; # markdown
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;
    black.enable = true;

    # linters
    actionlint.enable = true;
    statix.enable = true;
    check-added-large-files.enable = true;
    check-merge-conflicts.enable = true;
    check-yaml.enable = true;
    deadnix.enable = true;
    markdownlint = {
      enable = true;
      settings.configuration = {
        MD013 = false; # line lenght check
      };
    };
    nil.enable = true;
    ripsecrets.enable = true;
    mypy.enable = true;
  };
}
