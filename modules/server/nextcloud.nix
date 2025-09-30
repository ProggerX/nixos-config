{ config, ... }:
{
	virtualisation.oci-containers.containers.collabora = {
		image = "docker.io/collabora/code";
		ports = [ "9980:9980" ];
		autoStart = true;
		environment = {
			# This limits it to this NC instance AFAICT
			aliasgroup1 = "https://nc.bald.su:443";
			# Must disable SSL as it's behind a reverse proxy
			extra_params = "--o:ssl.enable=false";
		};
	};
	services.nginx = {
		enable = true;
		virtualHosts.office = {
			addSSL = true;
			enableACME = true;
			serverName = "office.bald.su";
			locations."/" = {
				proxyPass = "http://0.0.0.0:9980";
			};
			extraConfig = "client_max_body_size 5G;";
		};
	};

	services.nextcloud = {
		enable = true;
		hostName = "nc.bald.su";
		config.adminpassFile = "/nextcloud-pass";
		config.dbtype = "sqlite";
		https = true;
		extraApps = {
			inherit (config.services.nextcloud.package.packages.apps)
				calendar contacts notes mail forms whiteboard richdocuments;
		};
		extraAppsEnable = true;
	};
	services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
		forceSSL = true;
		enableACME = true;
	};
}
