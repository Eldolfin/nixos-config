(import ./lib.nix) rec {
  name = "lock-screen";
  testScript = ''
    c.wait_for_unit("graphical.target")
    c.wait_until_succeeds("pgrep swaybar")
    c.sleep(5)
    c.send_key("meta_l-ctrl-x")
    c.sleep(2)
    c.send_chars("a\n" * 10, delay=0.2)
    c.screenshot("${name}")
  '';
}
