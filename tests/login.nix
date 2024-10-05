{ nixpkgs, ... }:
let
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };
in
pkgs.testers.runNixOSTest {
  name = "login-test";
  nodes.machine =
    { pkgs, ... }:
    {
      users.users.alice = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
          firefox
          tree
        ];
      };
      system.stateVersion = "24.05";
    };

  testScript = ''
    machine.wait_for_unit("default.target")
    machine.succeed("su -- alice -c 'which firefox'")
    machine.succeed("su -- root -c 'which firefox'")
  '';
}
