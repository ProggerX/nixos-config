{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.minecraft.nixosModules.minecraft-servers
  ];
  nixpkgs.overlays = [inputs.minecraft.overlay];
  services.frp = {
    settings = {
      proxies = [
        {
          name = "mc";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 25565;
          remotePort = 25566;
        }
      ];
    };
  };
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.main = {
      enable = true;
      package = pkgs.paperServers.paper-1_21_10;
      serverProperties = {
        online-mode = false;
      };
    };
  };
}
