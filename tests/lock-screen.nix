(import ./lib.nix) rec {
  name = "lock-screen";
  nodes.c = _: {
    services.displayManager.autoLogin.enable = true;
  };

  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.sleep(20)
    c.send_key("meta_l-ctrl-x")
    c.sleep(2)
    c.send_chars("azerty\n" * 3, delay=0.05)
    c.screenshot("${name}")
  '';
}
