{ lib, pkgs, config, sys, ... }:
{
	wayland.windowManager.sway = {
		enable = true;
		config = {
			bars = [{
				position = "top";
				statusCommand = "${pkgs.i3status}/bin/i3status";
				trayOutput = "none";
			}];
			input = {
				"*" = {
					xkb_layout = "us,ru";
					xkb_options = "grp:win_space_toggle,caps:escape";
				};
			};
			gaps = {
				outer = 5;
				inner = 5;
			};
			modifier = "Mod4";
			bindkeysToCode = true;
			keybindings = let
			mod = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
				"${mod}+y" = "exec ${pkgs.kitty}/bin/kitty ${pkgs.vifm}/bin/vifm";
				"${mod}+shift+r" = ''mode "resize"'';
				"${mod}+c" = "kill";
				"${mod}+r" = "exec rofi -show drun";
				"alt+space" = "exec rofi -show run";
				"${mod}+v" = "exec cliphist list | rofi -dmenu -p ' 󰅌	' | cliphist decode | wl-copy";
				"${mod}+t" = "vicinae";
				"Print" = "exec grim -g\"$(slurp)\" - | wl-copy";
				"${mod}+u" = "fullscreen toggle";
				"${mod}+f" = "floating toggle";
				"${mod}+ctrl+l" = "exec ${pkgs.hyprlock}/bin/hyprlock";
				"ctrl+shift+space" = "exec hexecute";
				"XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
				"XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
				"XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
				"XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
			};
			startup = map (x: { command = x; }) ([
				"sh -c \"sleep 5; systemctl --user start kanshi.service\""
				"${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"
				"firefox-nightly"
				"${pkgs.telegram-desktop}/bin/Telegram"
				"sleep 2 && ${pkgs.sway}/bin/swaymsg workspace 1"
				"sshfs 10.7.0.6:/music /home/proggerx/music"
				"easyeffects --gapplication-service"
				"${pkgs.networkmanagerapplet}/bin/nm-applet"
				] ++ (if sys.isLaptop then [
					"iio-sway"
					"${pkgs.wlsunset}/bin/wlsunset -T 5500"
				] else []));
			
			assigns = {
				"2" = [{ app_id = "^firefox-nightly$"; }];
				"3" = [{ class = "^vesktop$"; }];
				"4" = [{ app_id = "^org.telegram.desktop$"; }];
				"10" = [{ class = "^Spotify$"; } { app_id = "^YandexMusic$"; }];
			};
		};
		extraConfig = ''
			default_border pixel 2
			default_floating_border pixel 2
		'' + builtins.readFile ./swayosd;
	};
	systemd.user.services.kanshi = {
		Service = {
			Type = "simple";
			Environment = [
				"WAYLAND_DISPLAY=\"wayland-1\""
				"DISPLAY=\":0\""

			];
			ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /kanshi.cfg'';
		};
	};
	services.swayosd.enable = true;
}
