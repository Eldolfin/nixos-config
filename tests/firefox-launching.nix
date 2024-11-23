(import ./lib.nix) {
  name = "firefox-launching";

  testScript = ''
    from time import sleep

    start_all()
    c.wait_for_unit("graphical.target")
    c.wait_for_x()

    # Hide emote welcome window
    c.wait_until_succeeds("pgrep emote")
    sleep(2)
    c.execute("su oscar -c 'killall emote'")

    # Launch firefox
    c.send_key("meta_l-e")

    # Open btop
    c.send_key("meta_l-t")
    sleep(2)
    # Zoom out
    for i in range(6): c.send_key("ctrl-minus")

    # Open an editor
    c.send_key("meta_l-ret")
    sleep(3)
    c.send_chars("$EDITOR ~/bin/scripts/systemswitch.py\n")

    c.execute("""
      su oscar -c \"cool-retro-term -e sh -c \'nix run nixpkgs\#fortune | nix run nixpkgs\#cowsay; sleep infinity'\" >/dev/null 2>&1 &
    """)

    # Wait for everything to be ready
    sleep(10)

    c.screenshot("firefox_and_terminals")
  '';
}
