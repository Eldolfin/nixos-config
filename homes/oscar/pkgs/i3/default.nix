{ lib, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    config = { };
    extraConfig = lib.strings.fileContents ./config.old;
  };
}
