{ pkgs, ... }:
{
	boot.kernelParams = [ "console=tty2" ];
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway -r ";
				user = "greeter";
			};
		};
	};
}
