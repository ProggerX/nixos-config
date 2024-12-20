{ pkgs, lib, ... }: {
	services.mopidy = {
		enable = true;
		extensionPackages = [ pkgs.mopidy-mpd pkgs.mopidy-subidy ];
		extraConfigFiles = [ "/mopidy.conf" ];
	};
	systemd.services.mopidy = {
        serviceConfig.User = lib.mkForce "proggerx";
        environment.XDG_RUNTIME_DIR = "/run/user/1000";
    };
}
