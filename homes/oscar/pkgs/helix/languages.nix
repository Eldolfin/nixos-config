{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    extraPackages = with pkgs; [
      svelte-language-server
      yaml-language-server
      dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      vue-language-server
      pkgs.markdown-oxide
      pkgs.nil
      pkgs.jq-lsp
      metals
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
        kotlinls.command = lib.getExe pkgs.kotlin-language-server;
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
        jedi.command = "${pkgs.python3Packages.jedi-language-server}/bin/jedi-language-server";

        rust-analyzer = {
          command = "${pkgs.master.rust-analyzer}/bin/rust-analyzer";
          config = {
            checkOnSave.command = "clippy";
            cargo.allFeatures = true;
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
            "scls"
            "bashls"
            # "gpt"
          ];
        }
        {
          name = "c";
          auto-format = true;
          formatter.command = "${pkgs.clang-tools}/bin/clang-format";
          language-servers = [
            "scls"
            "clangd"
            # "gpt"
          ];
        }
        {
          name = "cpp";
          auto-format = true;
          formatter.command = "${pkgs.clang-tools}/bin/clang-format";
          language-servers = [
            "scls"
            "clangd"
            "gpt"
          ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
          language-servers = [
            "scls"
            "nixd"
            # "nil"
            # "gpt"
          ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = lib.getExe pkgs.rustfmt;
          language-servers = [
            "scls"
            "rust-analyzer"
            # "gpt"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            "scls"
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
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = [
            "scls"
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
        }
        {
          name = "typst";
          auto-format = true;
          language-servers = [
            "scls"
          ];
          formatter.command = lib.getExe pkgs.typstyle;
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "scls"
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
            "kotlinls"
            # "gpt"
          ];
        }

        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            "scls"
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
        }

        {
          name = "markdown";
          auto-format = true;
          language-servers = [
            "scls"
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
        }

        {
          name = "html";
          auto-format = true;
          language-servers = [
            "scls"
            "vscode-html-language-server"
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
