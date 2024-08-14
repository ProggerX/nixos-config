{ lib, pkgs, ... }: {
	imports = [ ../pc/configuration.nix ];
	networking.hostName = lib.mkForce "snd-lp";
	
	services.xserver.videoDrivers = [ "intel" ];

	programs.sway.enable = true;
	programs.hyprland.enable = lib.mkForce false;
	services.greetd.settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway -r ";

	services.thermald.enable = true;
	isLaptop = true;
}
