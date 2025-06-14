{pkgs, ...}: {
  home.packages = with pkgs; [
    aichat
    goose-cli
  ];
}
