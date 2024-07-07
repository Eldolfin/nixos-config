{ pkgs, lib, ... }:
{

  programs.helix.languages = {
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
      nixd.command = "${pkgs.nixd}/bin/nixd";
      jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
      bashls = {
        command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
        args = [ "start" ];
      };
      # https://github.com/fufexan/dotfiles/blob/41dce2c7884a845887a4bc39ae85cef8bd1fe1fa/home/editors/helix/languages.nix
      deno-lsp = {
        command = lib.getExe pkgs.deno;
        args = [ "lsp" ];
        environment.NO_COLOR = "1";
        config.deno = {
          enable = true;
          lint = true;
          unstable = true;
          suggest = {
            completeFunctionCalls = false;
            imports = {
              hosts."https://deno.land" = true;
            };
          };
          inlayHints = {
            enumMemberValues.enabled = true;
            functionLikeReturnTypes.enabled = true;
            parameterNames.enabled = "all";
            parameterTypes.enabled = true;
            propertyDeclarationTypes.enabled = true;
            variableTypes.enabled = true;
          };
        };
      };

      dprint = {
        command = lib.getExe pkgs.dprint;
        args = [ "lsp" ];
      };
      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = [
          "${lib.getExe pkgs.alejandra}"
          "-q"
        ];
      };

      # maybe remove this idk if it does anything
      typescript-language-server = {
        command = lib.getExe pkgs.nodePackages.typescript-language-server;
        args = [ "--stdio" ];
        config =
          let
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          in
          {
            typescript-language-server.source = {
              addMissingImports.ts = true;
              fixAll.ts = true;
              organizeImports.ts = true;
              removeUnusedImports.ts = true;
              sortImports.ts = true;
            };

            typescript = {
              inherit inlayHints;
            };
            javascript = {
              inherit inlayHints;
            };

            hostInfo = "helix";
          };
      };
      vscode-html-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      vscode-json-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
      vscode-markdown-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-markdown-language-server";
    };

    language =
      let
        prettier = lang: {
          command = "${pkgs.prettierd}/bin/prettier";
          args = [
            "--parser"
            lang
          ];
        };
        addPrettierToLangs = map (lang: {
          name = lang;
          formatter = prettier lang;
          auto-format = true;
        });
        langsFormattedByPrettier = [
          "css"
          "html"
          "typescript"
          "javascript"
          "json"
          "markdown"
          "yaml"
        ];
      in
      [
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
          language-servers = [
            "gpt"
            "typescript-language-server"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = prettier "typescript";
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
        {
          name = "markdown";
          language-servers = [ "vscode-markdown-language-server" ];
        }
      ]
      ++ addPrettierToLangs langsFormattedByPrettier;
  };
}
