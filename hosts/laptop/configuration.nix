{ lib, ... }: {
	imports = [ ../snd-pc/configuration.nix ];
	networking.hostName = lib.mkForce "snd-lp";
	services.thermald.enable = true;
	isLaptop = true;
}
