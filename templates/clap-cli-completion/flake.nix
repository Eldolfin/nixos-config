{
  description = "A template cli project in rust with completions";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    crane.url = "github:ipetkov/crane";
    flake-utils.url = "github:numtide/flake-utils";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs @ {
    flake-parts,
    devenv-root,
    crane,
    flake-utils,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = ["x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

      perSystem = {
        config,
        pkgs,
        # self',
        # inputs',
        # system,
        ...
      }: let
        craneLib = crane.mkLib pkgs;

        # Common arguments can be set here to avoid repeating them later
        # Note: changes here will rebuild all dependency crates
        commonArgs = {
          src = craneLib.cleanCargoSource ./.;
          strictDeps = true;

          # buildInputs =
          #   [
          #     # Add additional build inputs here
          #   ]
          #   ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
          #     # Additional darwin specific inputs can be set here
          #   ];
        };

        cli-completion = craneLib.buildPackage (commonArgs
          // {
            cargoArtifacts = craneLib.buildDepsOnly commonArgs;

            postInstall = ''
              mkdir -p $out/share/cli-completion/contrib/completion
              $out/bin/cli-completion --generate-completions bash > $out/share/cli-completion/contrib/completion/cli-completion-completion.bash
              $out/bin/cli-completion --generate-completions zsh > $out/share/cli-completion/contrib/completion/cli-completion-completion.zsh
              $out/bin/cli-completion --generate-completions fish > $out/share/cli-completion/contrib/completion/cli-completion-completion.fish
            '';
            # Additional environment variables or build phases/hooks can be set
            # here *without* rebuilding all dependency crates
            # MY_CUSTOM_VAR = "some value";
          });
      in {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        checks = {
          inherit cli-completion;
        };
        packages.default = cli-completion;

        apps.default = flake-utils.lib.mkApp {
          drv = cli-completion;
        };

        devenv.shells.default = {
          devenv.root = let
            devenvRootFileContent = builtins.readFile devenv-root.outPath;
          in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

          name = "cli-completion";

          imports = [
            # This is just like the imports in devenv.nix.
            # See https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
            # ./devenv-foo.nix
          ];

          # https://devenv.sh/reference/options/
          packages = [config.packages.default];

          # # enterShell = ''
          # #   hello
          # # '';

          # processes.hello.exec = "hello";
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
