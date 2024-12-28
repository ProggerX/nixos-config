{ pkgs, ... }: {
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				before_sleep_cmd = "hyprlock";
				lock_cmd = "hyprlock";
			};
		};
	};
}
