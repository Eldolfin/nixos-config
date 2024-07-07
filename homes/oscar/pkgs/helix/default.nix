{ ... }:
{
  imports = [ ./languages.nix ];
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
      auto-format = true;
      color-modes =true;
      completion-timeout = 5; # instant according to the docs
      popup-border = true;
        bufferline = "multiple";
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        whitespace.render = {
          newline = "all";
        }; # thats ugly tho
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        file-picker.hidden = false; # show hidden files
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
