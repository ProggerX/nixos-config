{ pkgs, ... }: {
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				before_sleep_cmd = "hyprlock --no-fade-in";
				lock_cmd = "hyprlock --no-fade-in";
			};
		};
	};
}
