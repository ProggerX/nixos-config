{ lib, config, inputs, pkgs, ... }: {
    options.server.hspobeda.enable = lib.mkEnableOption "hspobeda";
    config = lib.mkIf config.server.hspobeda.enable {
		systemd.services.hspobeda = {
			description = "Haskellpobeda";
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				type = "simple";
				ExecStart = "${inputs.haskellpobeda.packages.${pkgs.system}.default}/bin/haskellpobeda";
				WorkingDirectory = "${inputs.haskellpobeda.packages.${pkgs.system}.default.src}";
			};
		};
        services.nginx = {
            enable = true;
            virtualHosts.hspobeda = {
                addSSL = true;
                useACMEHost = "hspobeda";
                serverName = "хаскеллпобеда.рф";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:1339";
                };
            };
        };
        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
			certs = {
				hspobeda = { domain = "xn--80aacmdb6aja4akt4c.xn--p1ai"; webroot = "/var/lib/acme/acme-challenge"; group = "nginx"; };
			};
        };
    };
}
