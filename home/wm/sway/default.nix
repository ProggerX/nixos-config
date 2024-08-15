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
					xkb_options = "grp:win_space_toggle";
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
				"${mod}+y" = "exec ${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi";
				"${mod}+o" = "exec ${pkgs.neovide}/bin/neovide";
				"${mod}+shift+r" = ''mode "resize"'';
				"${mod}+c" = "kill";
				"${mod}+r" = "exec rofi -show drun";
				"alt+space" = "exec rofi -show run";
				"${mod}+v" = "exec cliphist list | rofi -dmenu -p ' 󰅌  ' | cliphist decode | wl-copy";
				"Print" = "exec grim -g\"$(slurp)\" - | wl-copy";
				"${mod}+u" = "fullscreen toggle";
				"${mod}+f" = "floating toggle";
				"${mod}+ctrl+l" = "exec ${pkgs.hyprlock}/bin/hyprlock";
				"XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
				"XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i2";
				"XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d2";
				"XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
				"XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
				"XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
				"XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
			};
			startup = [
				{ command = "${pkgs.waybar}/bin/waybar"; }
				{ command = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"; }
				{ command = "${pkgs.wpaperd}/bin/wpaperd"; }
				{ command = "${pkgs.firefox}/bin/firefox"; }
				{ command = "${pkgs.telegram-desktop}/bin/telegram-desktop"; }
				{ command = "${pkgs.vesktop}/bin/vesktop"; }
				{ command = "yandex-music"; }
				{ command = "sleep 5 && ${pkgs.systemd}/bin/systemctl --user start kanshi.service"; }
				{ command = "sleep 2 && ${pkgs.sway}/bin/swaymsg workspace 1"; }
			];
			assigns = {
				"2" = [{ app_id = "^firefox$"; }];
				"3" = [{ class = "^vesktop$"; }];
				"4" = [{ app_id = "^org.telegram.desktop$"; }];
				"10" = [{ class = "^Spotify$"; } { app_id = "^YandexMusic$"; }];
			};
		};
		extraConfig = ''
			default_border pixel 2
			default_floating_border pixel 2
		'';
	};

	services.kanshi = {
		enable = true;
		profiles = {
			laptop = {
				outputs = [
					{
						scale = 1.0;
						criteria = "eDP-1";
						status = "enable";
						mode = "1920x1080@60";
					}
				];
			};
			laptop-with-hdmi = {
				outputs = [
					{
						status = "enable";
						criteria = "eDP-1";
						mode = "1920x1080@60";
						scale = 1.0;
					}
					{
						status = "enable";
						criteria = "HDMI-A-1";
						scale = 1.0;
					}
				];
			};
			pc = {
				outputs = [
					{
						status = "enable";
						criteria = "HDMI-A-1";
						mode = "1920x1080@144";
						scale = 1.0;
					}
				];
			};
		};
	};
}
