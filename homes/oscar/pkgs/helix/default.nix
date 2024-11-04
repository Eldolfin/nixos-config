{
  pkgs,
  helix-master,
  ...
}: {
  imports = [./languages.nix];
  home.packages = with pkgs; [
    lldb
  ];
  programs.helix = {
    enable = true;
    package = helix-master.packages.${pkgs.system}.default;
    defaultEditor = true;

    settings = {
      theme = "gruber-darker";
      editor = {
        auto-format = true;
        color-modes = true;
        completion-timeout = 5; # instant according to the docs
        bufferline = "multiple";
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        soft-wrap.enable = true;
        whitespace.render = {
          # newline = "all"; # thats ugly tho
        };
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        lsp = {
          display-inlay-hints = true;
        };
        file-picker.hidden = false; # show hidden files
        statusline = {
          left = [
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = ["mode"];
          right = [
            "position-percentage"
            "spacer"
            "version-control"
            "spacer"
            "diagnostics"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
        };
      };
      keys = {
        normal = {
          X = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
          "C-s" = ":w";
          "A-f" = ":fmt";
        };
        select = {
          X = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
        };
        insert = {
          "C-s" = ":w";
          "A-f" = ":fmt";
        };
      };
    };
  };
}
