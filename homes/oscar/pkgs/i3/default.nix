{ lib, pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = lib.strings.fileContents ./config.old;
    config = {
      startup = [ { command = "${pkgs.i3-auto-layout}/bin/i3-auto-layout"; } ];
    };
  };
}
