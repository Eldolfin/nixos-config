(import ./lib.nix) rec {
  name = "login-screen";
  nodes.c = _: {
    services.displayManager.autoLogin.enable = false;
  };
  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.sleep(10)
    c.screenshot("${name}")
  '';
}
