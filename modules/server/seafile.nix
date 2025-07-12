{ config, lib, ... }:
{
    options = {
        server.seafile.enable = lib.mkEnableOption "Enable seafile";
    };
    config = lib.mkIf config.server.seafile.enable {
        services.seafile = {
            enable = true;
			adminEmail = "x@proggers.ru";
			initialAdminPassword = "123";
			ccnetSettings.General.SERVICE_URL = "https://sf.bald.su";
        };
        services.nginx = {
            enable = true;
            virtualHosts.seafile = {
                addSSL = true;
                enableACME = true;
                serverName = "sf.bald.su";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:8000";
                };
            };
        };
        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
        };
    };
}
