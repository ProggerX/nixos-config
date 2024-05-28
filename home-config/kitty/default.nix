{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		font = pkgs.nerdfonts.JetBrainsMono;
	};
}
