{
  eldolfin.services.wol-agent = {
    enable = true;
    domain = "ws://192.168.1.1:3030";
  };
  networking = {
    interfaces.eno1.wakeOnLan.enable = true;
  };
}
