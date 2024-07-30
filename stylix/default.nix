{ pkgs, ... }:
{
	stylix = {
		enable = true;
		cursor = {
			name = "idk-cursor";
			size = 35;
			package = pkgs.capitaine-cursors-themed.overrideAttrs (old:{
				installPhase = old.installPhase + "cp -r $out/share/icons/'Capitaine Cursors (Gruvbox)' $out/share/icons/idk-cursor";
			});
		};
		opacity = {
			desktop = 0.8;
			terminal = 0.8;
			applications = 1;
		};
		fonts = {
			sizes = {
				terminal = 12;
				#desktop = 11;
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
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		image = ./walls.jpg;
	};
}
