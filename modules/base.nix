{ inputs, ... }: {
	imports = [
		inputs.turnip.nixosModules.turnip
		inputs.stylix.nixosModules.stylix
		../stylix
		../turnip
		../modules/rust.nix
		({ inputs, pkgs, ... }: {
			environment.systemPackages = [ inputs.bald.defaultPackage.${pkgs.stdenv.hostPlatform.system} ];
		})
	];
}
