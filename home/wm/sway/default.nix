{ lib, pkgs, config, ... }:
{
	wayland.windowManagers.sway = {
		enable = true;
		config = {
			bars = [];
			input = {
				"*" = {
					xkb_layout = "us,ru";
					xkb_options = "caps:escape, grp:win_space_toggle";
				};
			};
			modifier = "Mod4";
			keybindings = let
			mod = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
				"${mod}+c" = "kill";
				"${mod}+r" = "exec rofi -show drun";
				"alt+space" = "exec rofi -show run";
				"${mod}+v" = "exec cliphist list | rofi -dmenu | cliphist decode | wl-copy";
				"print" = "exec grim -g'$(slurp)' - | wl-copy";
			};
			startup = [
				{ command = "waybar"; }
				{ command = "wl-paste --watch cliphist store"; }
				{ command = "wpaperd"; }
				{ command = "exec sleep 5; systemctl --user start kanshi.service"; }
			];
		};
	};
}
