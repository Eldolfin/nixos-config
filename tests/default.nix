checkArgs: {
  firefox-launching = import ./firefox-launching.nix checkArgs;
  login-screen = import ./login-screen.nix checkArgs;
  lock-screen = import ./lock-screen.nix checkArgs;
}
