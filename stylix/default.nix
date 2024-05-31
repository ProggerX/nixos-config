{ pkgs, ... }:
{
	stylix = {

	cursor = {
		name = "Catppuccin-Mocha-Lavender-Cursors";
		size = 35;
		package = pkgs.catppuccin-cursors.mochaLavender;
	};
	opacity = {
		terminal = 0.7;
		applications = 0.8;
	};
	fonts = {
		sizes = {
			terminal = 17;
		};
		serif = {
			package = pkgs.dejavu_fonts;
			name = "DejaVu Serif";
		};
		sansSerif = {
			package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
			name = "JetBrainsMono Nerd Font";
		};
		monospace = {
			package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
			name = "JetBrainsMono Nerd Font Mono";
		};
		emoji = {
			package = pkgs.noto-fonts-color-emoji;
			name = "Noto Color Emoji";
		};
	};
	base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
	image = ./walls.jpg;
	};
}
