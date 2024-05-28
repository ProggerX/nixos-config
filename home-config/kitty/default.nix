{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		settings = {
			font_family = "JetBrainsMono Nerd Font";
		};
	};
}
