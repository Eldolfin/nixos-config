(import ./lib.nix) rec {
  name = "notifications";
  nodeCfg = _: {
    services.displayManager.autoLogin.enable = true;
  };

  testScript = ''
    start_all()
    c.wait_for_unit("graphical.target")
    c.sleep(60)
    # send fake notifications
    c.execute("""
    echo '
    notify-send -a thunderbird "Received 255 notifications"  "[COMMUNICATION] événements à venir sur l Intracom !"
    notify-send -a kitty       "Done in 36s"                 "/etc/nixos gh run watch"
    notify-send -a steam       "Someone invited you to play" "Click to join nixos-ricing.exe"
    ' > /home/oscar/send-notifs.sh
    chmod +x /home/oscar/send-notifs.sh
    """)
    c.send_key("meta_l-ret")
    c.sleep(3)
    c.send_chars("./send-notifs.sh\nexit\n")
    # open notification panel
    c.send_key("meta_l-n", delay=0.1)
    c.sleep(30)
    c.screenshot("${name}")
  '';
}
