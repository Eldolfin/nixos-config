{pkgs, ...}: {
  home.packages = with pkgs; [
    aichat # used in ai-commit.sh
    # never used
    # goose-cli
  ];
}
