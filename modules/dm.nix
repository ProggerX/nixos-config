{ ... }:
{
	boot.kernelParams = [ "console=tty2" ];
	services.greetd = {
		enable = true;
		settings = {
			default_session = {
				# command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -r ";
				command = "Hyprland";
				user = "proggerx";
			};
		};
	};
}
