{ pkgs, ... }:
{
	home.packages = [ (import ./cava.nix {inherit pkgs;}) ];
	
	programs.waybar  = {
		enable = true;
		style = ''
			* {
				border-radius: 10;
			}
		'';
		settings = {
			bar = {
    			position = "top";

    			height = 35;
    			width = 1895;
    			spacing = 10;

    			modules-center  = ["custom/cava"];
    			modules-left  = ["sway/workspaces" "sway/window"];
    			modules-right  = ["tray" "custom/alsa" "custom/battery" "sway/language" "clock"];

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

				"tray" = {
        			spacing = 10;
        			icon-size = 15;
    			};

				"clock" = {
        			"format" = "{:%H:%M}";
        			"format-alt" = "{:%Y-%m-%d}";
    			};

				"sway/window" = {
    				format = "{}";
    				separate-outputs = false;
    				max-length = 20;
				};

				"sway/language" = {
    				format = "{}";
    				format-us = "US";
    				format-ru = "RU";
				};

				"custom/alsa" = {
    				format = "{}";
					exec = "sleep 0.05 && echo $(pamixer --get-mute)$(pamixer --get-volume) | sed 's/true/ /' | sed 's/false/) /'";
					on-click = "pamixer -t; pkill -x -RTMIN+11 waybar";
					on-scroll-up = "pamixer -i2; pkill -x -RTMIN+11 waybar";
					on-scroll-down = "pamixer -d2; pkill -x -RTMIN+11 waybar";
					signal = 11;
					interval = 5;
					tooltip = false;
    			};
				
				"custom/battery" = {
					format = "{} ";
					exec = "${./battery.sh}";
					interval = 5;
				};

				"custom/cava" = {
					format = "{}";
					return-type = "text";
					max-length = 40;
					escape = true;
					tooltip = false;
					exec = "cava_waybar";
    			};
			};
		};
	};
}
