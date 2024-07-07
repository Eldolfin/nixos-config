{ pkgs, ... }:
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
}
