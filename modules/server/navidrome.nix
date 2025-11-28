{ config, lib, pkgs, ... }:
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
		services.transmission = {
			enable = true;
			user = "proggerx";
			webHome = pkgs.flood-for-transmission;
			settings = {
				download-dir = "/music";
				rpc-bind-address = "10.7.0.6";
				rpc-whitelist = "127.0.0.1,10.7.0.4,10.7.0.5,10.7.0.8";
			};
		};
    };
}
