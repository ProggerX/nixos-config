{ pkgs, lib, ... }: {
	services.mopidy = {
		enable = true;
		extensionPackages = with pkgs; [ mopidy-mpd mopidy-subidy mopidy-mpris ];
		extraConfigFiles = [ "/mopidy.conf" ];
	};
	systemd.services.mopidy = {
        serviceConfig.User = lib.mkForce "proggerx";
        environment.XDG_RUNTIME_DIR = "/run/user/1000";
    };
}
