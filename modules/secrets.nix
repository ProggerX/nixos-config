{ inputs, pkgs, ... }:
{
	environment.systemPackages = [
		inputs.agenix.packages.${pkgs.system}.default
	];

	age.identityPaths = [ "/etc/ssh/id_secrets" ];
	age.secrets = {
		wg-laptop.file = ../secrets/wg-laptop.age;
		wg-pc.file = ../secrets/wg-pc.age;
		wg-server.file = ../secrets/wg-server.age;
		password.file = ../secrets/password.age;
		wakasalt.file = ../secrets/wakasalt.age;
		pssh = rec {
			file = ../secrets/pssh.age;
			mode = "700";
			owner = "proggerx";
			group = "users";
			path = "/home/${owner}/.ssh/id_ssh";
		};
	};
}
