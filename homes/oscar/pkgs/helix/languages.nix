{
  pkgs,
  lib,
  ...
}: {
  programs.helix.languages = {
    language-server = {
      # github is not happy about this
      # gpt = {
      #   command = lib.getExe pkgs.helix-gpt;
      #   args = [
      #     "--handler"
      #     "copilot"
      #   ];
      # };
      nixd.command = "${pkgs.nixd}/bin/nixd";
      # jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
      bashls = {
        command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        args = ["start"];
      };

      # nil.command = lib.getExe pkgs.nil;

      # maybe remove this idk if it does anything
      typescript-language-server = {
        command = lib.getExe pkgs.nodePackages.typescript-language-server;
        args = ["--stdio"];
      };
      vscode-html-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      vscode-json-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      vscode-markdown-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-markdown-language-server";

      pylsp.command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
      jedi.command = "${pkgs.python3Packages.jedi-language-server}/bin/jedi-language-server";

      rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";

      tinymist.command = lib.getExe pkgs.tinymist;
    };

    language = [
      {
        name = "bash";
        auto-format = true;
        formatter.command = lib.getExe pkgs.shfmt;
        language-servers = [
          "bashls"
          # "gpt"
        ];
      }
      {
        name = "c";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        language-servers = [
          "clangd"
          # "gpt"
        ];
      }
      {
        name = "cpp";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        language-servers = [
          "clangd"
          # "gpt"
        ];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.alejandra}/bin/alejandra";
        language-servers = [
          "nixd"
          # "nil"
          # "gpt"
        ];
      }
      {
        name = "rust";
        auto-format = true;
        formatter.command = "${pkgs.rustfmt}/bin/rustfmt";
        language-servers = [
          "rust-analyzer"
          # "gpt"
        ];
      }
      {
        name = "typescript";
        language-servers = [
          # "gpt"
          "typescript-language-server"
        ];
        formatter = {
          command = lib.getExe pkgs.deno;
          args = [
            "fmt"
            "-"
            "--ext"
            "ts"
          ];
        };
        auto-format = true;
      }
      {
        name = "tsx";
        language-servers = [
          # "gpt"
          "typescript-language-server"
        ];
        formatter = {
          command = lib.getExe pkgs.deno;
          args = [
            "fmt"
            "-"
            "--ext"
            "tsx"
          ];
        };
        auto-format = true;
      }
      {
        name = "typst";
        formatter.command = lib.getExe pkgs.typstyle;
        auto-format = true;
      }
      {
        name = "python";
        language-servers = [
          # "gpt"
          "pylsp"
          "jedi"
        ];
        formatter = {
          command = lib.getExe pkgs.black;
          args = [
            "-"
            "--quiet"
            "--line-length=80"
          ];
        };
        auto-format = true;
      }
      {
        name = "javascript";
        language-servers = [
          # "gpt"
          "typescript-language-server"
        ];
        formatter = {
          command = lib.getExe pkgs.deno;
          args = [
            "fmt"
            "-"
            "--ext"
            "js"
          ];
        };
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [
          "vscode-markdown-language-server"
          # "gpt"
        ];
        formatter = {
          command = lib.getExe pkgs.deno;
          args = [
            "fmt"
            "-"
            "--ext"
            "md"
          ];
        };
        auto-format = true;
      }
      {
        name = "json";
        formatter = {
          command = lib.getExe pkgs.deno;
          args = [
            "fmt"
            "-"
            "--ext"
            "json"
          ];
        };
        auto-format = true;
      }
    ];
  };
}
