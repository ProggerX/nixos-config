{ inputs, pkgs, ... }:
{
	imports = [ inputs.vicinae.homeManagerModules.default ];

	home.packages = [ inputs.vicinae.packages.${pkgs.system}.default ];

	services.vicinae = {
		enable = true;
		autoStart = true;
		settings = {
			faviconService = "twenty";
			font.size = 14;
			popToRootOnClose = false;
			rootSearch.searchFiles = false;
			theme.name = "gruvbox_material_medium_dark";
			window = {
				csd = true;
				opacity = 1.0;
				rounding = 10;
			};
		};
	};
}
