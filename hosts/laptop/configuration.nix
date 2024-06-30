{ lib, ... }: {
	imports = [ ../pocket-os/configuration.nix ];
	networking.hostName = lib.mkForce "laptop";
}
