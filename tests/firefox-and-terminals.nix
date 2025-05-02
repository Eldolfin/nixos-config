(import ./lib.nix) rec {
  name = "firefox-and-terminals";

  nodes.c = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.cowsay
      pkgs.fortune
    ];
  };

  testScript = ''
    bg=" >/dev/null 2>&1 &"
    def user(cmd):
      c.execute(f"su oscar -c \"{cmd}\"")

    start_all()
    c.wait_for_unit("graphical.target")
    c.wait_until_succeeds("pgrep swaybar")

    c.sleep(20)

    # Launch firefox
    # usefull in case its running locally in a previously used vm
    c.execute("rm -rf /home/oscar/.mozilla/firefox/homemanager/bookmarkbackups")
    c.send_key("meta_l-e")
    # user("firefox"+bg)
    # Wait for firefox (this file is created after the window is visible)
    c.wait_for_file("/home/oscar/.mozilla/firefox/homemanager/bookmarkbackups")
    # Open an empty tab
    c.send_key("ctrl-t")

    # Open btop
    c.send_key("meta_l-t")
    c.wait_until_succeeds("pgrep btop")

    # Zoom out
    for i in range(10): c.send_key("ctrl-minus", delay=0.2)
    c.sleep(1)

    user("kitty -o font_size=7 -e hx ~/bin/scripts/systemswitch.py"+bg)
    user("cool-retro-term -e sh -c 'fortune -a | cowsay -r; sleep infinity'"+bg)
    # user("firefox https://github.com/eldolfin/nixos-config"+bg) # doesn't reuse the existing instance for some reason
    c.wait_until_succeeds("pgrep sleep")
    c.sleep(1)

    c.screenshot("${name}")
  '';
}
