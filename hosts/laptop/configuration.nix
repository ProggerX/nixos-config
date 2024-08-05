{ lib, ... }: {
	imports = [ ../pc/configuration.nix ];
	networking.hostName = lib.mkForce "snd-lp";
	services.thermald.enable = true;
	isLaptop = true;
}
