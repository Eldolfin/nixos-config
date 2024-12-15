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
      hostPkgs = pkgs;
      # This speeds up the evaluation by skipping evaluating documentation
      defaults.documentation.enable = lib.mkDefault false;
      node.specialArgs = specialArgs;
      imports = [test];
      enableOCR = true;
      nodes = {
        c = _: {
          imports = commonModules;
          virtualisation = {
            memorySize = 4096;
            diskSize = 8192;
            cores = 4;
            resolution = {
              x = 1920;
              y = 1080;
            };
          };
          # avoid emote welcome screen (it crashes because the file format in incorrect)
          home-manager.users.oscar.home.file.".local/share/Emote/user_data".text = "";
        };
      };
    }
  )
  .config
  .result
