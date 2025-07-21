{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # used in specific directories
    nixpkgs-fmt
    steel # has interpreter and lsp
  ];
  programs.helix = {
    extraPackages = with pkgs; [
      # rarely used
      # svelte-language-server
      # vue-language-server
      yaml-language-server
      dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      markdown-oxide
      nil
      jq-lsp
      metals
      fish-lsp
      gopls
    ];
    languages = {
      language-server = {
        # github is not happy about this
        # gpt = {
        #   command = lib.getExe pkgs.helix-gpt;
        #   args = [
        #     "--handler"
        #     "copilot"
        #   ];
        # };
        gpt = {
          command = lib.getExe pkgs.helix-gpt;
          args = [
            "--handler"
            "codeium"
          ];
        };
        nixd.command = "${pkgs.nixd}/bin/nixd";
        jdtls.command = "${pkgs.jdt-language-server}/bin/jdtls";
        # kotlinls.command = lib.getExe' pkgs.kotlin-language-server "kotlin-language-server";
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
        vscode-html-language-server = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
          args = ["--stdio"];
        };
        vscode-css-language-server = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          args = ["--stdio"];
        };
        vscode-json-language-server = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
          args = ["--stdio"];
        };
        vscode-markdown-language-server = {
          command = "${pkgs.vscode-langservers-extracted}/bin/vscode-markdown-language-server";
          args = ["--stdio"];
        };

        pylsp.command = "${pkgs.python3Packages.python-lsp-server}/bin/pylsp";
        ruff.command = lib.getExe pkgs.ruff;

        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          config = {
            checkOnSave = true;
            cargo = {
              allFeatures = true;
              # makes it much more responsive when compiling on save externally, which I always do
              # by using a different target/ directory
              targetDir = true;
            };
          };
        };

        tinymist.command = lib.getExe pkgs.tinymist;

        docker-compose-language-service = {
          command = lib.getExe pkgs.docker-compose-language-service;
          args = ["--stdio"];
        };
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
            "scls"
          ];
        }
        {
          name = "cpp";
          auto-format = true;
          formatter.command = "${pkgs.clang-tools}/bin/clang-format";
          language-servers = [
            "clangd"
            "gpt"
            "scls"
          ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
          language-servers = [
            "nixd"
            # "nil"
            # "gpt"
            "scls"
          ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = lib.getExe pkgs.rustfmt;
          language-servers = [
            "rust-analyzer"
            # "gpt"
            "scls"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            # "gpt"
            "typescript-language-server"
            "scls"
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
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = [
            # "gpt"
            "typescript-language-server"
            "scls"
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
        }
        {
          name = "typst";
          auto-format = true;
          language-servers = [
            "tinymist"
            "scls"
          ];
          formatter.command = lib.getExe pkgs.typstyle;
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            # "gpt"
            "pylsp"
            "ruff"
            "scls"
          ];
          formatter = {
            command = lib.getExe pkgs.black;
            args = [
              "-"
              "--quiet"
              "--line-length=80"
            ];
          };
        }

        {
          name = "java";
          auto-format = true;
          language-servers = [
            "jdtls"
            # "gpt"
          ];
        }

        {
          name = "kotlin";
          auto-format = true;
          language-servers = [
            # "kotlinls"
            # "gpt"
          ];
        }

        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            # "gpt"
            "typescript-language-server"
            "scls"
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
        }

        {
          name = "markdown";
          auto-format = true;
          language-servers = [
            "vscode-markdown-language-server"
            # "gpt"
            "scls"
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
        }

        {
          name = "html";
          auto-format = true;
          language-servers = [
            "vscode-html-language-server"
            "scls"
          ];
        }

        {
          name = "json";
          auto-format = true;
          language-servers = ["scls"];
          formatter = {
            command = lib.getExe pkgs.deno;
            args = [
              "fmt"
              "-"
              "--ext"
              "json"
            ];
          };
        }

        {
          name = "git-commit";
          language-servers = ["scls"];
        }

        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.dprint;
            args = [
              "fmt"
              "--stdin"
              "toml"
            ];
          };
        }
        {
          name = "scala";
          auto-format = false;
          formatter = {
            command = lib.getExe pkgs.scalafmt;
            args = ["--stdin"];
          };
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = ["gpt" "svelteserver"];
        }
        {
          name = "docker-compose";
          auto-format = true;
          language-servers = ["docker-compose-language-service"];
        }
      ];
    };
  };
}
