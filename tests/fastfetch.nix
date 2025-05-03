(import ./lib.nix) rec {
  name = "fastfetch";
  nodes.c = _: {
    services.displayManager.autoLogin.enable = true;
  };

  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.sleep(20)
    # open terminal
    c.send_key("meta_l-ret")
    c.sleep(3)
    # clear
    c.send_key("ctrl-l")
    # dezoom
    for _ in range(4): c.send_key("ctrl-shift-minus")
    c.send_chars("fastfetch\n")
    c.sleep(5)
    c.screenshot("${name}")
  '';
}
