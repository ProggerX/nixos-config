{ lib, ... }: {
	imports = [ ../pocket-os/configuration.nix ];
	networking.hostName = lib.mkForce "laptop";
	services.thermald.enable = true;
	isLaptop = true;
	isNvidia = lib.mkForce false;
}
