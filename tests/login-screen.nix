(import ./lib.nix) {
  name = "login-screen";
  nodes.c = _: {
    services.displayManager.autoLogin.enable = false;
  };
  testScript = ''
    c.wait_for_unit("graphical.target")
    c.sleep(10)
    c.screenshot("login_screen")
  '';
}
