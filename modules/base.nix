{ inputs, pkgs, ... }: {
	imports = [
		inputs.turnip.nixosModules.turnip
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
	];
	config = {
		environment.systemPackages = [ inputs.bald.defaultPackage.${pkgs.stdenv.hostPlatform.system} ];
		turnip = {
			enable = true;
			colorscheme = "catppuccin";
			custom = {
				colorschemes.catppuccin.settings.transparent_background = true;
			};
		};
	};
}
