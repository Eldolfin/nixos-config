(import ./lib.nix) {
  name = "firefox-launching";

  testScript = ''
    from time import sleep

    start_all()
    c.wait_for_unit("graphical.target")
    c.wait_for_x()

    # Hide emote welcome window
    c.wait_until_succeeds("pgrep emote")
    c.execute("su oscar -c sh -c 'killall emote'")

    # Launch firefox
    c.send_key("meta_l-e")

    # Wait for firefox to be ready
    c.succeed("""
        until su oscar -c sh -c 'xwininfo -root -tree | grep firefox'; do
            sleep 0.5
        done
    """)
    sleep(5)
    c.succeed("pgrep firefox")

    # Open btop
    c.send_key("meta_l-t")
    sleep(1)
    # Zoom out
    for i in range(6): c.send_key("ctrl-minus")

    # Open an editor
    c.send_key("meta_l-ret")
    sleep(1)
    c.send_chars("$EDITOR ~/bin/scripts/systemswitch.py\n")

    # Open a few other terminals
    for i in range(4): c.send_key("meta_l-ret")

    # Wait for everything to be ready
    sleep(10)

    c.screenshot("firefox_and_terminals")
  '';
}
