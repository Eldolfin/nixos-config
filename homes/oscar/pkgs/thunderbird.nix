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
      flavor = "outlook.office365.com";
      primary = true;
      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };
    };
  };
}
