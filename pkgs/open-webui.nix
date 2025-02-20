{
  services = let
    webui-port = 8081;
  in {
    ollama = {
      enable = true;
      loadModels = ["deepseek-r1:1.5b" "deepseek-r1:8b"];
      # acceleration = "cuda"; # (by default)
    };
    open-webui = {
      enable = true;
      environment.OLLAMA_API_BASE_URL = "http://localhost:11434";
      port = webui-port;
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "https://chat.internal.eldolfin.top" = {
          extraConfig = ''
            tls internal
            reverse_proxy localhost:${toString webui-port}
          '';
        };
        "http://chat.internal.eldolfin.top" = {
          extraConfig = ''
            reverse_proxy localhost:${toString webui-port}
          '';
        };
      };
    };
  };
}
