{ config, lib, ... }:
{
    options = {
        server.jellyfin.enable = lib.mkEnableOption "Enable jellyfin";
        server.jellyfin.transmission.enable = lib.mkEnableOption "Enable transmission daemon for jellyfin movies";
    };
    config = lib.mkIf config.server.jellyfin.enable {
        services.jellyfin.enable = true;
        services.nginx = {
            enable = true;
            virtualHosts.jellyfin = {
                addSSL = true;
                enableACME = true;
                serverName = "jelly.bald.su";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:8096";
                };
            };
        };
        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
        };
        services.transmission = lib.mkIf config.server.jellyfin.transmission.enable {
            enable = true;
            settings = {
                watch-dir-enabled = true;
                watch-dir = "/movies";
                incomplete-dir = "/movies";
            };
        };
    };
}
