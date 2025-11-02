{ inputs, pkgs, ... }:
{
	environment.systemPackages = [
		inputs.agenix.packages.${pkgs.system}.default
	];

	age.identityPaths = [ "/etc/ssh/id_secrets" ];
	age.secrets.wg-laptop.file = ../secrets/wg-laptop.age;
	age.secrets.wg-pc.file = ../secrets/wg-pc.age;
	age.secrets.wg-server.file = ../secrets/wg-server.age;
}
