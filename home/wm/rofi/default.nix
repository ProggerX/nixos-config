{ pkgs, ... }: {
	stylix.targets.rofi.enable = false;
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		theme = "${./theme.rasi}";
		extraConfig = {
			display-ssh = " ";
			display-run = " ";
			display-drun = " ";
			display-window = " ";
			display-combi = " ";
			show-icons = true;
		};
	};
}
