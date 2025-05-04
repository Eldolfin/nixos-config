(import ./lib.nix) rec {
  name = "clipboard-emojis";
  nodeCfg = _: {
    services.displayManager.autoLogin.enable = true;
  };

  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.sleep(60)

    for emoji in ["fire", "sungl", "wfl"]:
      # open emoji picker
      c.send_key("meta_l-b", delay=1)
      c.send_chars(f"{emoji}\n", delay=0.3)
    c.send_key("meta_l-v", delay=1)
    # dezoom
    for _ in range(4): c.send_key("ctrl-shift-minus", delay=0.3)
    c.send_key("meta_l-b", delay=1)
    c.send_chars("explo", delay=0.3)
    c.sleep(5)
    c.screenshot("${name}")
  '';
}
