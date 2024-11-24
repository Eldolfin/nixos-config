(import ./lib.nix) rec {
  name = "lock-screen";
  testScript = ''
    c.wait_for_x()
    c.sleep(5)
    c.send_key("meta_l-x")
    c.sleep(10)
    c.send_chars("a" * 8)
    c.sleep(5)
    c.screenshot("${name}")
  '';
}
