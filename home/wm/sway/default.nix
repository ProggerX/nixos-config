{ lib, pkgs, config, ... }:
{
	wayland.windowManager.sway = {
		enable = true;
		extraOptions = [
			"--unsupported-gpu"
		];
		config = {
			bars = [];
			input = {
				"*" = {
					xkb_layout = "us,ru";
					xkb_options = "caps:escape,grp:win_space_toggle";
				};
			};
			gaps = {
				outer = 5;
			};
			modifier = "Mod4";
			bindkeysToCode = true;
			keybindings = let
			mod = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
				"${mod}+c" = "kill";
				"${mod}+r" = "exec rofi -show drun";
				"alt+space" = "exec rofi -show run";
				"${mod}+v" = "exec cliphist list | rofi -dmenu | cliphist decode | wl-copy";
				"Print" = "exec grim -g\"$(slurp)\" - | wl-copy";
				"${mod}+u" = "fullscreen toggle";
				"${mod}+f" = "floating toggle";
				"${mod}+ctrl+l" = "exec ${pkgs.swaylock}";
			};
			startup = [
				{ command = "${pkgs.waybar}"; }
				{ command = "wl-paste --watch cliphist store"; }
				{ command = "${pkgs.wpaperd}"; }
				{ command = "${pkgs.firefox-devedition}"; }
				{ command = "${pkgs.telegram-desktop}"; }
				{ command = "${pkgs.vesktop}"; }
				{ command = "exec sleep 5; systemctl --user start kanshi.service"; }
			];
			assigns = {
				"2" = [{ app_id = "^firefox-devedition$"; }];
				"3" = [{ class = "^vesktop$"; }];
				"4" = [{ app_id = "^org.telegram.desktop$"; }];
			};
		};
	};
}
