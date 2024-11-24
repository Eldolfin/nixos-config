(import ./lib.nix) rec {
  name = "login-screen";
  nodes.c = _: {
    services.displayManager.autoLogin.enable = false;
  };
  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.wait_for_text("Oscar Le Dauphin")
    c.screenshot("${name}")
  '';
}
