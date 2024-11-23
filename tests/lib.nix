test: {pkgs, ...} @ inputs: let
  inherit (pkgs) lib;
  nixos-lib = import (pkgs.path + "/nixos/lib") {};
in
  (
    nixos-lib.runTest {
      hostPkgs = pkgs;
      # This speeds up the evaluation by skipping evaluating documentation
      defaults.documentation.enable = lib.mkDefault false;
      node.specialArgs = inputs;
      imports = [test];
      enableOCR = true;
      nodes = {
        c = {commonModules, ...}: {
          imports = commonModules;
          virtualisation = {
            memorySize = 4096;
            diskSize = 8192;
          };
        };
      };
    }
  )
  .config
  .result
