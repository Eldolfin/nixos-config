{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [(lib.hiPrio pkgs.uutils-coreutils-noprefix)];
}
