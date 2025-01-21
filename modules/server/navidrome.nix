{ config, lib, ... }:
{
    options = {
        server.navidrome.enable = lib.mkEnableOption "Enable navidrome";
    };
    config = lib.mkIf config.server.navidrome.enable {
		systemd.services.navidrome.serviceConfig.EnvironmentFile = "/navidrome-env.conf";
        services.navidrome = {
            enable = true;
            settings = {
                MusicFolder = "/music";
                Address = "0.0.0.0";
            };
        };
        services.nginx = {
            enable = true;
            virtualHosts.navidrome = {
                addSSL = true;
                enableACME = true;
                serverName = "music.bald.su";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:4533";
                };
            };
        };
        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
        };
    };
}
