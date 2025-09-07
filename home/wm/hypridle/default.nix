{ pkgs, ... }: {
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				before_sleep_cmd = "${pkgs.mpv}/bin/mpv ${./minecraft-doors-close.mp3} && hyprlock --no-fade-in";
				after_sleep_cmd = "${pkgs.mpv}/bin/mpv ${./minecraft-doors-open.mp3}";
				lock_cmd = "hyprlock --no-fade-in";
			};
		};
	};
}
