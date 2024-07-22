{ inputs, pkgs, ... }: {
	imports = [
		inputs.turnip.nixosModules.turnip
		inputs.stylix.nixosModules.stylix
		../stylix
		../turnip
		../modules/rust.nix
	];
	config = {
		environment.systemPackages = [ inputs.bald.defaultPackage.${pkgs.stdenv.hostPlatform.system} ];
		turnip.enable = true;
	};
}
