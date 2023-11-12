{
  imports = [
    ./cri-sddm.nix
  ];
  services.xserver =
    {
      enable = true;
      displayManager =
        {
          sddm = {
            enable = true;
            #theme = ;
            autoNumlock = true;
          };
          lightdm.greeter.enable = false;
        };
    };
  cri.sddm = { enable = true; theme = "epita-acu-2024"; };
}
