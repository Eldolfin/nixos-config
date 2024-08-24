{ pkgs, lib, ... }:
{

  programs.helix.languages = {
    language-server = {
      # github is not happy about this
      # gpt = {
      #   command = lib.getExe pkgs.deno;
      #   args = [
      #     "run"
      #     "--allow-net"
      #     "--allow-env"
      #     "https://raw.githubusercontent.com/sigmaSd/helix-gpt/0.31-deno/src/app.ts"
      #   ];
      #   environment = {
      #     HANDLER = "codeium";
      #   };
      # };
      gpt = {
        command = lib.getExe pkgs.helix-gpt;
        args = [
          "--handler"
          "codeium"
        ];
      };
      nixd.command = "${pkgs.nixd}/bin/nixd";
      # jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
      bashls = {
        command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        args = [ "start" ];
      };

      nil.command = lib.getExe pkgs.nil;

      # maybe remove this idk if it does anything
      typescript-language-server = {
        command = lib.getExe pkgs.nodePackages.typescript-language-server;
        args = [ "--stdio" ];
        # config =
        #   let
        #     inlayHints = {
        #       includeInlayEnumMemberValueHints = true;
        #       includeInlayFunctionLikeReturnTypeHints = true;
        #       includeInlayFunctionParameterTypeHints = true;
        #       includeInlayParameterNameHints = "all";
        #       includeInlayParameterNameHintsWhenArgumentMatchesName = true;
        #       includeInlayPropertyDeclarationTypeHints = true;
        #       includeInlayVariableTypeHints = true;
        #     };
        #   in
        #   {
        #     typescript-language-server.source = {
        #       addMissingImports.ts = true;
        #       fixAll.ts = true;
        #       organizeImports.ts = true;
        #       removeUnusedImports.ts = true;
        #       sortImports.ts = true;
        #     };

        #     typescript = {
        #       inherit inlayHints;
        #     };
        #     javascript = {
        #       inherit inlayHints;
        #     };

        #     hostInfo = "helix";
        #   };
      };
      vscode-html-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      vscode-json-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      vscode-markdown-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-markdown-language-server";
      pylsp.command = "${pkgs.python311Packages.python-lsp-server}/bin/pylsp";

      rust-analyzer.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    };

    language = [
      {
        name = "bash";
        auto-format = true;
        formatter.command = lib.getExe pkgs.shfmt;
        language-servers = [
          "bashls"
          "gpt"
        ];
      }
      {
        name = "c";
        auto-format = true;
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        language-servers = [
          "clangd"
          "gpt"
        ];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        language-servers = [
          "nil"
          "nixd"
          "gpt"
        ];
      }
      {
        name = "rust";
        auto-format = true;
        formatter.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        language-servers = [
          "rust-analyzer"
          "gpt"
        ];
      }
      {
        name = "typescript";
        language-servers = [
          "gpt"
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
          "gpt"
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
          "gpt"
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
