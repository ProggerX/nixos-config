{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		theme = "Catppuccin-Mocha";
		settings = {
			font_family = "JetBrainsMono Nerd Font";
			font_size = 15;
			background_opacity = 0.7;
		};
	};
}
