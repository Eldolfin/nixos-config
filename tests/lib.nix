test: {
  pkgs,
  specialArgs,
  commonModules,
  ...
}: let
  inherit (pkgs) lib;
  nixos-lib = import (pkgs.path + "/nixos/lib") {};
in
  (
    nixos-lib.runTest {
      inherit (test) name testScript;
      hostPkgs = pkgs;
      # This speeds up the evaluation by skipping evaluating documentation
      defaults.documentation.enable = lib.mkDefault false;
      node.specialArgs = specialArgs;
      enableOCR = true;
      nodes = {
        c = {pkgs, ...}: {
          imports = commonModules ++ [(test.nodeCfg {inherit pkgs;}) ../pkgs/systemd-boot.nix];
          virtualisation = {
            memorySize = 4096;
            diskSize = 8192;
            cores = 6;
            resolution = {
              x = 1920;
              y = 1080;
            };
          };
        };
      };
    }
  )
  .config
  .result
