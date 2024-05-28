{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		font = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
	};
}
