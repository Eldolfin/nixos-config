(import ./lib.nix) rec {
  name = "firefox-and-terminals";

  nodes.c = {pkgs, ...}: {
    services.displayManager.autoLogin.enable = true;
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
    c.wait_for_unit("activitywatch-watcher-awatcher.service", user="oscar")

    # Launch firefox
    c.send_key("meta_l-e")

    c.sleep(10)

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
    user("firefox https://github.com/eldolfin/nixos-config"+bg)
    c.wait_until_succeeds("pgrep sleep")
    c.sleep(1)

    c.screenshot("${name}")
  '';
}
