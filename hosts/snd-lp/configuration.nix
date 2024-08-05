{ lib, ... }: {
	imports = [ ../pocket-os/configuration.nix ];
	networking.hostName = lib.mkForce "snd-lp";
	services.thermald.enable = true;
	isLaptop = true;
}
