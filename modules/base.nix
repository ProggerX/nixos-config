{ inputs, ... }: {
	imports = [
		inputs.turnip.nixosModules.turnip
		inputs.stylix.nixosModules.stylix
		../stylix
		../turnip
		../modules/rust.nix
	];
}
