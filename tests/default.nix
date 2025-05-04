checkArgs: {
  clipboard-emojis = import ./clipboard-emojis.nix checkArgs;
  fastfetch = import ./fastfetch.nix checkArgs;
  firefox-and-terminals = import ./firefox-and-terminals.nix checkArgs;
  lock-screen = import ./lock-screen.nix checkArgs;
  login-screen = import ./login-screen.nix checkArgs;
  notifications = import ./notifications.nix checkArgs;
}
