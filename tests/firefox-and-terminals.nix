(import ./lib.nix) rec {
  name = "firefox-and-terminals";

  nodes.c = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.cowsay
      pkgs.fortune
    ];
  };

  testScript = ''
    from time import sleep

    bg=" >/dev/null 2>&1 &"
    def user(cmd):
      c.execute(f"su oscar -c \"{cmd}\"")

    start_all()
    c.wait_for_unit("graphical.target")
    c.wait_for_x()

    # Hide emote welcome window
    c.wait_for_text("emoji")
    user("killall emote")

    # Launch firefox
    # usefull in case its running locally in a previously used vm
    c.execute("rm -rf /home/oscar/.mozilla/firefox/homemanager/bookmarkbackups")
    c.send_key("meta_l-e")
    # Wait for firefox (this file is created after the window is visible)
    c.wait_for_file("/home/oscar/.mozilla/firefox/homemanager/bookmarkbackups")
    # Open an empty tab
    c.send_key("ctrl-t")

    # Open btop
    c.send_key("meta_l-t")
    c.wait_for_succeed("pgrep btop")
    sleep(5)
    # Zoom out
    for i in range(10): c.send_key("ctrl-minus", delay=0.2)
    sleep(1)

    user("alacritty -o 'font.size=9' -e hx ~/bin/scripts/systemswitch.py"+bg)
    user("cool-retro-term -e sh -c 'fortune -a | cowsay -r; sleep infinity'"+bg)

    # Wait for everything to be ready
    sleep(10)

    c.screenshot("${name}")
  '';
}
