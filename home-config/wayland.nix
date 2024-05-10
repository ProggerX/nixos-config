{ pkgs, config, ... }:
{
	wayland.windowManager.sway = {
		enable = true;
		config = rec {
			modifier = "Mod4";
			terminal = "alacritty"; 
			startup = [
				{command = "firefox";}
				{command = "waybar";}
			];
		};
	};

	programs.waybar = {
		enable = true;
	};

	programs.wpaperd = {
		enable = true;
		settings = {
			default = {
				path = "/home/proggerx/walls";
			};
		};
	};

	programs.wofi = {
		enable = true;
		style = ''
		window {
			background-color: #1e1e2e;
		}
		'';
	};
}
