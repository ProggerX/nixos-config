{ inputs, pkgs, ... }: {
	imports = [
		inputs.stylix.nixosModules.stylix
		../stylix
		./rust.nix
		./starship
	];
	config = {
		environment.systemPackages = [
			inputs.bald.defaultPackage.${pkgs.stdenv.hostPlatform.system}
			inputs.cwe-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};
}
