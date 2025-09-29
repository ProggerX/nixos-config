{ config, ... }:
{
	services.nextcloud = {
		enable = true;
		hostName = "nc.bald.su";
		config.adminpassFile = "/nextcloud-pass";
		config.dbtype = "sqlite";
		extraApps = {
			inherit (config.services.nextcloud.package.packages.apps) calendar tasks;
		};
		extraAppsEnable = true;
	};
}
