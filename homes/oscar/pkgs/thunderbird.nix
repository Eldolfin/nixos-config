{ pkgs, lib, ... }:
{
  programs.thunderbird = {
    enable = true;
    settings = {
      "privacy.donottrackheader.enabled" = true;
    };
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
  accounts.email.accounts = {
    epita = {
      realName = "Oscar LE DAUPHIN";
      address = "oscar.le-dauphin@epita.fr";
      flavor = "outlook.office365.com"; # not sure
      primary = true;
      # might not be needed
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };
      # passwordCommand = "${lib.getExe pkgs.sops}";
    };
  };
}
