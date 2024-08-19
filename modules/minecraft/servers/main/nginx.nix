{ lib, config, ... }: let cfg = config.server.minecraft.servers.main; in lib.mkIf cfg.enable {
	services.nginx = {
		enable = true;
		virtualHosts.bluemap = {
			addSSL = true;
			enableACME = true;
			serverName = "map.bald.su";
			locations."/" = {
				proxyPass = "http://0.0.0.0:8100";
			};
		};
	};
	security.acme = {
		acceptTerms = true;
		defaults.email = "x@proggers.ru";
	};
}
