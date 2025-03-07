{ lib, config, ... }: {
    options.server.dufs.enable = lib.mkEnableOption "dufs";
    config = lib.mkIf config.server.dufs.enable {
		virtualisation.oci-containers.containers.dufs = {
			image = "sigoden/dufs";
			cmd = [ "/files" ];
			volumes = [ "/var/lib/dufs:/data" "/var/lib/dufs-files:/files" ];
			ports = [ "5000:5000" ];
		};
        services.nginx = {
            enable = true;
            virtualHosts.dufs = {
                addSSL = true;
                enableACME = true;
                serverName = "dufs.bald.su";
                locations."/" = {
                    proxyPass = "http://0.0.0.0:5000";
                };
				extraConfig = "client_max_body_size 5G;";
            };
        };
        security.acme = {
            acceptTerms = true;
            defaults.email = "x@proggers.ru";
        };
    };
}
