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
        lib,
        # inputs',
        # self',
        # system,
        ...
      }: let
        craneLib = crane.mkLib pkgs;

        commonArgs = {
          src = let
            unfilteredRoot = ./.; # The original, unfiltered source
          in
            lib.fileset.toSource {
              root = unfilteredRoot;
              fileset = lib.fileset.unions [
                (craneLib.fileset.commonCargoSources unfilteredRoot)
                (lib.fileset.maybeMissing ./assets)
              ];
            };

          strictDeps = true;

          nativeBuildInputs = [pkgs.installShellFiles];
        };

        systemswitch = craneLib.buildPackage (commonArgs
          // {
            cargoArtifacts = craneLib.buildDepsOnly commonArgs;

            preFixup = let
              ss = "$out/bin/systemswitch";
            in ''
              installShellCompletion --cmd systemswitch \
                --bash <(${ss} --generate-completions bash) \
                --fish <(${ss} --generate-completions fish) \
                --zsh <(${ss} --generate-completions zsh)
            '';
          });
      in {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        checks = {
          inherit systemswitch;
        };
        packages.default = systemswitch;

        apps.default = flake-utils.lib.mkApp {
          drv = systemswitch;
        };

        devenv.shells.default = {
          devenv.root = let
            devenvRootFileContent = builtins.readFile devenv-root.outPath;
          in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

          name = "systemswitch";

          packages = with pkgs; [
            config.packages.default
            bacon
          ];
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
