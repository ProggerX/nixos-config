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
		style = ''
			* {
			    font-family: "JetBrainsMono Nerd Font", FontAwesome, JetBrainsMono, sans-serif;
			    font-size: 12px;
				color: #b4befe;
			}
			
			window#waybar {
			    background-color: rgba(0, 0, 0, 0);
				border-radius: 10px;
				padding: 7px;
			    color: #b4befe;
			    transition-property: background-color;
			    transition-duration: .5s;
			    padding: 0;
			    margin: 0;
			}
			
			.modules-left > widget:first-child > #workspaces {
			    margin-left: 0;
			}
			
			.modules-right > widget:last-child > #workspaces {
			    margin-right: 0;
			}
			
			button {
			    margin: 0;
			    padding: 10;
			    background-color: #1e1e2e;
			    border-radius: 15;
			}
			
			button:hover {
			    margin: 0;
			    padding: 10;
				color: #1e1e2e;
			    background-color: #b4befe;
			    border-radius: 15;
			}
			
			button:focus {
			    margin: 0;
			    padding: 10;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#workspaces {
			    margin: 0;
			    margin: 5 0 5 0;
				background-color: #181825;
				border-radius: 15;
			}
			
			#workspaces button {
			    padding: 0 5;
				padding-left: 9px;
			    margin: 5;
			    border-radius: 16;
				background-color: #181825;
			}
			
			#workspaces button:hover {
				color: #1e1e2e;
				background-color: #b4befe;
			}
			
			#workspaces button.active {
			    background-color: #11111b;
			}
			
			#workspaces button.urgent {
			    background-color: #f38ba8;
			}
			
			#tray {
			    padding: 7;
			    margin: 5 0 5 0;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#tray > .passive {
			    -gtk-icon-effect: dim;
			}
			
			#tray > .needs-attention {
			    -gtk-icon-effect: highlight;
			}
			
			#custom-alsa {
			    padding: 0 15 0 15;
			    margin: 5px 0 5px 0;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#window {
			    padding: 0 15 0 15;
			    margin: 5px 0 5px 0;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#clock {
			    padding: 0 15 0 15;
			    margin: 5px 0 5px 0;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#mode,
			#custom-cava,
			#battery,
			#language,
			#custom-weather {
			    padding: 0 15 0 15;
			    margin: 5px 0 5px 0;
			    background-color: #181825;
			    border-radius: 15;
			}
			
			#keyboard-state {
			    padding: 0 0px;
			    margin: 0 5px;
			    min-width: 16px;
			}
			
			#keyboard-state > label {
			    padding: 0 0px;
			}
		'';
	};
}
