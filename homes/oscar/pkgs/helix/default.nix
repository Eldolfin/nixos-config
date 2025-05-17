{pkgs, ...}: {
  imports = [./languages.nix ./scls.nix];
  home = {
    packages = with pkgs; [
      lldb
    ];
    sessionVariables = {
      VISUAL = "hx";
      EDITOR = "hx";
    };
  };
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruber-darker";
      editor = {
        auto-format = true;
        color-modes = true;
        completion-replace = true;
        completion-trigger-len = 0;
        completion-timeout = 5; # instant according to the docs
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
        };
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
          "K" = "hover";
          "A-k" = "keep_selections";
          "C-g" = [
            ":write-all"
            ":insert-output lazygit >/dev/tty"
            ":redraw"
            ":reload-all"
          ];
          space = {
            E = [
              ":sh rm -f /tmp/yazi-helix-opened-file"
              ":insert-output yazi '%{workspace_directory}' --chooser-file=/tmp/yazi-helix-opened-file"
              ":insert-output echo \"x1b[?1049h\" > /dev/tty"
              ":open %sh{cat /tmp/yazi-helix-opened-file}"
              ":redraw"
            ];
          };
        };
        select = {
          X = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
          g = {
            e = "goto_file_end";
          };
        };
        insert = {
          "C-s" = ":w";
          "A-f" = ":fmt";
          "C-backspace" = "delete_word_backward";
        };
      };
    };
  };
}
