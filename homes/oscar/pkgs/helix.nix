{ pkgs, ... }:
{
  home.packages = with pkgs; [ helix-gpt ];
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
        # whitespace.render = { newline = "all"; }; # thats ugly tho
        indent-guides = {
          render = true;
          skip-levels = 1;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };
      };
      keys.normal = {
        X = [
          "extend_line_up"
          "extend_to_line_bounds"
        ];
      };
      keys.select = {
        X = [
          "extend_line_up"
          "extend_to_line_bounds"
        ];
      };
    };
    languages = {
      language-server = {
        # gpt.command = "${pkgs.helix-gpt}/bin/helix-gpt"; # needs api (TODO: setup secrets in nix config)
        nil.command = "${pkgs.nil}/bin/nil";
        jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
      };

      language = [
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
          language-servers = [ "nil" ];
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
            command = "${pkgs.prettierd}/bin/prettierd";
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
            command = "${pkgs.prettierd}/bin/prettierd";
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
