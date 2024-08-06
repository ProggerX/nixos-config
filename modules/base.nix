{ inputs, pkgs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
		./starship
	];
}
