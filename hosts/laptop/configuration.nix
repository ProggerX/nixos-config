{ lib, ... }: {
	imports = [ ../pocket-os/configuration.nix ];
	networking.hostName = lib.mkForce "puncakes";
	services.thermald.enable = true;
	isLaptop = true;
}
