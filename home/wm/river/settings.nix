{ pkgs, sys, ... }: {
	border-width = 3;
	border-color-focused = "0x${sys.lib.stylix.colors.base0D}";
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
			"Super R" = "spawn 'rofi -show drun'";
			"Alt Space" = "spawn 'rofi -show run'";
			"Super+Control L" = "spawn ${pkgs.hyprlock}/bin/hyprlock";
			"Super U" = "toggle-fullscreen";
			"Super J" = "focus-view next";
			"Super K" = "focus-view previous";
			"Super+Shift J" = "swap next";
			"Super+Shift K" = "swap previous";
			"Super V" = ''spawn "cliphist list | rofi -dmenu -p ' 󰅌  ' | cliphist decode | wl-copy"'';
			"Super F" = "toggle-float";
			"Super+Alt H" = "move left 20";
			"Super+Alt J" = "move down 20";
			"Super+Alt K" = "move up 20";
			"Super+Alt L" = "move right 20";
			"Super+Shift+Alt H" = "resize horizontal -20";
			"Super+Shift+Alt J" = "resize vertical -20";
			"Super+Shift+Alt K" = "resize vertical 20";
			"Super+Shift+Alt L" = "resize horizontal 20";
		};
	};
	spawn = [
		"${pkgs.wpaperd}/bin/wpaperd"
		"'${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store'"
		"'rivertile -view-padding 6 -outer-padding 6'"
		"yandex-music"
		"${pkgs.telegram-desktop}/bin/telegram-desktop"
		"${pkgs.firefox-devedition}/bin/firefox-dev-edition"
	];
	default-layout = "rivertile";
	keyboard-layout = "-options grp:win_space_toggle us,ru";
	rule-add = {
		"-app-id" = {
			"'firefox'" = "tags 2";
			"'YandexMusic'" = "tags 512";
			"'org.telegram.desktop'" = "tags 8";
		};
	};
}
