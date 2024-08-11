{ pkgs, sys, lib, ... }:
{
	imports = [
		./laptop.nix
	];
	programs.waybar	= {
		enable = true;
		style = with sys.lib.stylix.colors; ''
			* {
				border-radius: 10px;
			}
			#tags button.focused {
				border: 2px solid #${base05};
			}
		'';
		settings = {
			bar = {
				position = "top";
				margin-top = 5;
				height = 40;
				width = 1885;
				spacing = 10;

				modules-center	= ["custom/cava" "custom/spotify"];
				modules-left	= [ "hyprland/workspaces" "sway/workspaces" "river/tags" "hyprland/window" "sway/window" "river/window"];
				modules-right	= ["tray" "cpu" "memory" "custom/pipewire" "sway/language" "clock"];

				"sway/workspaces" = {
					format = "{icon}";
					on-scroll-up = "hyprctl dispatch workspace e+1";
					on-scroll-down = "hyprctl dispatch workspace e-1";
					on-click = "activate";
					all-outputs = false;
					format-icons = {
						"1" = "1";
						"2" = "2";
						"3" = "3";
						"4" = "4";
						"5" = "5";
						"6" = "6";
						"7" = "7";
						"8" = "8";
						"9" = "9";
						"10" = "0";
						urgent = "!";
					};
				};


				"network" = {
					"interface" = "wlp4s0";
					"format-wifi" = " ";
					"format-ethernet" = " ";
					"format-disconnected" = " ";
					"tooltip-format-wifi" = "{essid} ({signalStrength}%)  ";
					"tooltip-format-ethernet" = "{ifname}  ";
					"tooltip-format-disconnected" = "Disconnected";
				};
						
				"bluetooth" = {
					"format" = " ";
					"format-connected" = " ";
					"format-connected-battery" = " ";
					"tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
					"tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
					"tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
					"tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
				};

				"cpu" = {
					interval = 1;
					format = "    {usage}%";
					states = {
						"warning" = 70;
						"critical" = 90;
					};
				};

				"memory" = {
					"interval" = 5;
					"format" = " {}%";
					"states" = {
						"warning" = 70;
						"critical" = 90;
					};
				};

				"tray" = {
					spacing = 10;
					icon-size = 15;
				};

				"clock" = {
					"format" = "{:%H:%M} ";
					"format-alt" = "{:%Y-%m-%d} ";
				};

				"sway/window" = {
					format = "  {}";
					separate-outputs = false;
					max-length = 35;
				};

				"sway/language" = {
					format = "{}";
					format-us = "US";
					format-ru = "RU";
				};

				"custom/pipewire" = let pamixer = "${pkgs.pamixer}/bin/pamixer"; in {
					format = " {}";
					exec = "sleep 0.05 && echo $(${pamixer} --get-mute)$(${pamixer} --get-volume) | sed 's/true/ /' | sed 's/false/) /'";
					on-click = "${pamixer} -t; pkill -x -RTMIN+11 waybar";
					on-scroll-up = "${pamixer} -i2; pkill -x -RTMIN+11 waybar";
					on-scroll-down = "${pamixer} -d2; pkill -x -RTMIN+11 waybar";
					signal = 11;
					interval = 5;
					tooltip = false;
				};
				
				"custom/battery" = {
					format = " {} ";
					exec = "${./battery.sh}";
					interval = 5;
				};

				"custom/brightness" = {
					format = " {}";
					interval = 5;
					on-scroll-up = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness raise > /dev/null";
					on-scroll-down = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness lower > /dev/null";
					exec = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness get";
				};

				"custom/cava" = {
					format = "{} ";
					return-type = "text";
					max-length = 40;
					escape = true;
					tooltip = false;
					exec = "${import ./cava.nix { inherit pkgs; }}/bin/cava_waybar";
				};
				"custom/spotify" = {
					format = "  {}";
					return-type = "text";
					max-length = 40;
					escape = true;
					tooltip = false;
					exec = "${import ./spotify.nix { inherit pkgs; }}/bin/spotify_now_playing";
				};
				"river/window" = {
					max-length = 20;
				};
				"river/tags" = {
					num-tags = 10;
					tag-labels = lib.forEach [1 2 3 4 5 6 7 8 9 0] (x: toString x);
				};
			};
		};
	};
}
