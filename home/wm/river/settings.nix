{ pkgs, lib, ... }: {
	border-width = 2;
	map = {
		normal = {
			"Super Return" = "spawn ${pkgs.kitty}/bin/kitty";
			"Super C" = "close";
			"Super 1" = "set-focused-tags 1";
			"Super 2" = "set-focused-tags 2";
			"Super 3" = "set-focused-tags 4";
			"Super 4" = "set-focused-tags 8";
			"Super 5" = "set-focused-tags 16";
			"Super 6" = "set-focused-tags 32";
			"Super 7" = "set-focused-tags 64";
			"Super 8" = "set-focused-tags 128";
			"Super 9" = "set-focused-tags 256";
			"Super 0" = "set-focused-tags 512";
			"Super+Shift 1" = "set-view-tags 1";
			"Super+Shift 2" = "set-view-tags 2";
			"Super+Shift 3" = "set-view-tags 4";
			"Super+Shift 4" = "set-view-tags 8";
			"Super+Shift 5" = "set-view-tags 16";
			"Super+Shift 6" = "set-view-tags 32";
			"Super+Shift 7" = "set-view-tags 64";
			"Super+Shift 8" = "set-view-tags 128";
			"Super+Shift 9" = "set-view-tags 256";
			"Super+Shift 0" = "set-view-tags 512";
			"Super+Shift E" = "exit";
			"Super R" = "spawn rofi -show drun";
			"Alt Space" = "spawn rofi -show run";
			"Super+Control L" = "spawn ${pkgs.hyprlock}/bin/hyprlock";
			"Super U" = "toggle-fullscreen";
			"Super J" = "focus-view next";
			"Super K" = "focus-view previous";
			"Super+Shift J" = "swap next";
			"Super+Shift K" = "swap previous";
		};
	};
	spawn = [
		"wpaperd"
	];
	default-layout = "rivertile";
}
