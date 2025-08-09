{ lib, config, ... }: {
    options.server.calibre.enable = lib.mkEnableOption "calibre";
    config = lib.mkIf config.server.calibre.enable {
        services.nginx = {
            enable = true;
            virtualHosts.calibre-server = {
                addSSL = true;
                enableACME = true;
                serverName = "calibre-server.proggers.ru";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:1558";
                };
				extraConfig = "client_max_body_size 5G;";
            };
            virtualHosts.calibre-web = {
                addSSL = true;
                enableACME = true;
                serverName = "calibre-web.proggers.ru";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:1559";
                };
            };
        };
		
		services.calibre-server = {
			enable = true;
			user = "proggerx";
			libraries = [ "/books" ];
			port = 1558;
			auth.enable = true;
			auth.userDb = "/books/users.sqlite";
			auth.mode = "basic";
		};

		services.calibre-web = {
			enable = true;
			user = "proggerx";
			listen.ip = "0.0.0.0";
			listen.port = 1559;
			options.calibreLibrary = "/books";
		};

        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
        };
    };
}
