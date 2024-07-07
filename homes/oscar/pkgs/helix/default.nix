{ ... }:
{
  imports = [ ./languages.nix ];
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        auto-format = true;
        color-modes = true;
        completion-timeout = 5; # instant according to the docs
        popup-border = "all";
        bufferline = "multiple";
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        whitespace.render = {
          newline = "all"; # thats ugly tho
        };
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        lsp = {
          display-inlay-hints = false;
        };
        file-picker.hidden = false; # show hidden files
        statusline = {
          left = [
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = [ "mode" ];
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
        };
        select = {
          X = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
        };
        insert = {
          "C-s" = ":w";
        };
      };
    };
  };
}
