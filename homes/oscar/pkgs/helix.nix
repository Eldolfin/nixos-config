{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      # now in stylix config
      # theme = "tokyonight_moon";
      # theme = "gruvbox";
      editor = {
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
          display-inlay-hints = false;
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
          "C-space" = "signature_help";
          a = [
            "append_mode"
            "collapse_selection"
          ];
        };
        select = {
          X = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
        };
        insert = {
          "C-s" = ":w";
          C-space = "signature_help";
        };
      };
    };
    languages = {
      language-server = {
        # github is not happy about this
        # gpt = {
        #   command = "/home/oscar/.bun/bin/bun";
        #   args = [
        #     "run"
        #     "/home/oscar/Prog/helix-gpt-tmp/src/app.ts"
        #     "--handler"
        #     "copilot"
        #   ];
        #   # broken atm
        #   # command = "${pkgs.helix-gpt}/bin/helix-gpt";
        #   # args = [
        #   #   "--handler"
        #   #   "codeium"
        #   # ];
        # };
        nil.command = "${pkgs.nil}/bin/nil";
        nixd.command = "${pkgs.nixd}/bin/nixd";
        jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
        bashls = {
          command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
          args = [ "start" ];
        };
      };

      language = [
        {
          name = "bash";
          auto-format = true;
          formatter.command = "${pkgs.shfmt}/bin/shfmt";
          language-servers = [ "bashls" ];
        }
        {
          name = "c";
          auto-format = true;
          formatter.command = "${pkgs.clang-tools}/bin/clang-format";
          language-servers = [ "clangd" ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          language-servers = [
            "nil"
            "nixd"
          ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "${pkgs.prettierd}/bin/prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
          language-servers = [
            "gpt"
            "typescript-language-server"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = {
            command = "${pkgs.prettierd}/bin/prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
          language-servers = [
            "gpt"
            "typescript-language-server"
          ];
        }
        {
          name = "python";
          language-servers = [
            "gpt"
            "pylsp"
          ];
        }
        {
          name = "javascript";
          language-servers = [
            "gpt"
            "typescript-language-server"
          ];
        }
      ];
    };
  };
}
