{ pkgs, lib, ... }:
{
	programs.kitty = {
		enable = true;
		font.package = lib.mkForce (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
		font.name = lib.mkForce "JetBrainsMono Nerd Font";
	};
}
