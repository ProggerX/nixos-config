{ pkgs, ... }:
let enableSound = false;
	close-sound = if enableSound then " && ${pkgs.mpv}/bin/mpv ${./minecraft-doors-close.mp3}" else "";
	open-sound = "${pkgs.mpv}/bin/mpv ${./minecraft-doors-open.mp3}";
in {
	services.hypridle = {
		enable = false;
		settings = {
			general = {
				before_sleep_cmd = "hyprlock --no-fade-in" + close-sound;
				after_sleep_cmd = if enableSound then open-sound else "";
				lock_cmd = "hyprlock --no-fade-in";
			};
		};
	};
	services.swayidle = {
		enable = true;
		events = [{
			event = "before-sleep";
			command = "${pkgs.swaylock}/bin/swaylock -f";
		}];
	};
}
