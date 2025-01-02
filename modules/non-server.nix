{ inputs, pkgs, ... }: {
    imports = [
        ./spoofdpi.nix
        ./dm.nix
		./mopidy.nix
    ];
    services.spoofdpi.enable = true;
    environment.systemPackages = [
        inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.bald
        inputs.notbalds.packages.${pkgs.stdenv.hostPlatform.system}.cwe-client-cli
    ];
	hardware.xpadneo.enable = true;
}
