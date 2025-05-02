(import ./lib.nix) rec {
  name = "lock-screen";
  testScript = ''
    c.wait_for_unit("graphical.target")
    c.sleep(10)
    c.send_key("meta_l-ctrl-x")
    c.sleep(10)
    c.send_chars("a" * 8, delay=0.2)
    c.sleep(5)
    c.screenshot("${name}")
  '';
}
