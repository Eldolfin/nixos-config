(import ./lib.nix) rec {
  name = "firefox-and-terminals";

  nodeCfg = {pkgs, ...}: {
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
    c.sleep(60)

    # Launch firefox
    c.send_key("meta_l-e", delay=1)

    c.sleep(30)

    # Open an empty tab
    c.send_key("ctrl-t", delay=1)

    # Open btop
    c.send_key("meta_l-t", delay=1)
    c.sleep(5)

    # Zoom out
    for i in range(10): c.send_key("ctrl-shift-minus", delay=0.2)
    c.sleep(1)

    user("kitty -o font_size=7 -e hx"+bg)
    user("cool-retro-term -e sh -c 'fortune -a | cowsay -r; sleep infinity'"+bg)
    c.wait_until_succeeds("pgrep sleep")
    c.sleep(10)

    c.screenshot("${name}")
  '';
}
