{
  pkgs,
  scls,
  lib,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
  sclsPkg = scls.defaultPackage.x86_64-linux;
in {
  home.packages = [sclsPkg];

  programs.helix.languages. language-server . scls.command = lib.getExe' sclsPkg "simple-completion-language-server";

  xdg.configFile."helix/external-snippets.toml".source = tomlFormat.generate "scls-snippets" {
    sources = [
      {
        name = "friendly-snippets";
        git = "https://github.com/rafamadriz/friendly-snippets.git";
        paths = [
          {
            scope = ["python"];
            path = "snippets/python/";
          }
          {
            scope = ["rust"];
            path = "snippets/rust";
          }
          {
            scope = ["nix"];
            path = "snippets/nix.json";
          }
          {
            scope = ["go"];
            path = "snippets/go.json";
          }
          {
            scope = ["bash"];
            path = "snippets/shell";
          }
          {
            scope = ["vue"];
            path = "snippets/frameworks/vue";
          }
          {
            scope = ["c"];
            path = "snippets/c";
          }
          {
            scope = ["cpp"];
            path = "snippets/cpp";
          }
          {
            scope = ["dockerfile"];
            path = "snippets/docker/docker_file.json";
          }
          {
            scope = ["docker-compose"];
            path = "snippets/docker/docker-compose.json";
          }
          {
            scope = ["java"];
            path = "snippets/java";
          }
          {
            scope = ["html"];
            path = "snippets/html.json";
          }
          {
            scope = ["typescript"];
            path = "snippets/javascript/typescript.json";
          }
          {
            scope = ["typescript"];
            path = "snippets/javascript/tsdoc.json";
          }
          {
            scope = ["markdown"];
            path = "snippets/markdown.json";
          }
          {
            scope = ["javascript" "typescript"];
            path = "snippets/javascript/javascript.json";
          }
          {
            scope = ["git-commit"];
            path = "snippets/gitcommit.json";
          }
          {
            scope = ["python" "rust" "go" "vue" "c" "cpp" "java"];
            path = "snippets/loremipsum.json";
          }
        ];
      }
    ];
  };
}
