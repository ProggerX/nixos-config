{ pkgs, ... }:
{
	systemd.services.greetd.serviceConfig.After = "multi-user.target";
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway -r ";
				user = "greeter";
			};
			terminal = {
				vt = 3;
			};
		};
	};
}
