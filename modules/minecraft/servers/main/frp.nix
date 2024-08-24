{ lib, config, ... }: let cfg = config.server.minecraft.servers.main; in lib.mkIf cfg.enable {
    services.frp.settings.proxies = [
        {
            name = "main-mine";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 25565;
            remotePort = 25565;
        }
        {
            name = "main-bluemap";
            type = "tcp";
            localIP = "127.0.0.1";
            localPort = 8100;
            remotePort = 8100;
        }
        {
            name = "main-bedrock";
            type = "udp";
            localIP = "127.0.0.1";
            localPort = 19132;
            remotePort = 19132;
        }
    ];
}
