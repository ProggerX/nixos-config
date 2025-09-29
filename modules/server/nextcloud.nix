{ config, ... }:
{
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
