{ inputs, pkgs, ... }: {
	environment.systemPackages = [
		inputs.bald.defaultPackage.${pkgs.stdenv.hostPlatform.system}
		inputs.cwe-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
}
