checkArgs: {
  firefox-and-terminals = import ./firefox-and-terminals.nix checkArgs;
  login-screen = import ./login-screen.nix checkArgs;
  lock-screen = import ./lock-screen.nix checkArgs;
  fastfetch = import ./fastfetch.nix checkArgs;
  notifications = import ./notifications.nix checkArgs;
}
