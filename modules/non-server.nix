{ inputs, pkgs, ... }: {
	environment.systemPackages = [
		inputs.bald.packages.${pkgs.stdenv.hostPlatform.system}.default
		inputs.cwe-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
}
