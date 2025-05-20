{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    pinentry.package = pkgs.pinentry-tty;
  };
}
