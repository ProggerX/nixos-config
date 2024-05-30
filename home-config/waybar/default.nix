{ ... }:
{
	programs.waybar  = {
		enable = true;
		settings = {
    		position = "top";

    		height = 35;
    		width = 1895;
    		spacing = 10;

    		modules-center  = ["hyprland/window"];
    		modules-left  = ["hyprland/workspaces"];
    		modules-right  = ["tray" "custom/alsa" "battery" "hyprland/language" "clock"];

			"hyprland/workspaces" = {
				format = "{icon}";
				on-scroll-up = "hyprctl dispatch workspace e+1";
				on-scroll-down = "hyprctl dispatch workspace e-1";
				on-click = "activate";
				all-outputs = false;
				format-icons = {
        			"1" = "1 ";
					"2" = "2 ";
					"3" = "3 ";
					"4" = "4 ";
					"5" = "5 ";
					"6" = "6 ";
					"7" = "7 ";
					"8" = "8 ";
					"9" = "9 ";
					"10" = "0 ";
					urgent = "! ";
    			};
			};

			"tray" = {
        		spacing = 10;
        		icon-size = 15;
    		};

			"clock" = {
        		"format" = "{ =%H =%M}";
        		"format-alt" = "{ =%Y-%m-%d}";
    		};

			"hyprland/window" = {
    			format = "{}";
    			separate-outputs = false;
    			max-length = 20;
			};

			"hyprland/language" = {
    			format = "{}";
    			format-us = "US";
    			format-ru = "RU";
			};

			"custom/alsa" = {
    			format = "{}";
				exec = "echo $(pamixer --get-mute)$(pamixer --get-volume) | sed 's/true/ /' | sed 's/false/) /'";
				on-click = "pamixer -t; pkill -x -RTMIN+11 waybar";
				on-scroll-up = "pamixer -i2; pkill -x -RTMIN+11 waybar";
				on-scroll-down = "pamixer -d2; pkill -x -RTMIN+11 waybar";
				signal = 11;
				interval = 10;
				tooltip = true;
    		};

			"battery" = {
				bat = "BAT0";
	    		interval = 5;
				states = {
					warning = 30;
					critical = 15;
				};
				format = "{capacity}% {icon}";
				format-icons = ["" "" "" "" ""];
	    		max-length = 25;
			};
		};
	};
};
