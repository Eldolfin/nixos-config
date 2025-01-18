_: {
  eldolfin.services.wol-agent = {
    enable = true;
    domain = "wss://192.168.1.1";
    machine-name = "tour";
    # domain = "ws://192.168.1.167:3030";
    # machine-name = "reel";
  };
  networking = {
    interfaces.eno1.wakeOnLan.enable = true;
    # VDI
    firewall.allowedTCPPorts = [
      1122 # webtransport vdi
      1123 # websocket vdi
      5173 # dev
      3000 # dev wol-panel
      3030 # dev wol-api
    ];
    firewall.allowedUDPPorts = [
      1122 # webtransport vdi
    ];
  };
}
