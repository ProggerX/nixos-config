{ lib, pkgs, inputs, config, sys, ... }:
{
	imports = [inputs.mangowc.hmModules.mango];
	wayland.windowManager.mango = {
		enable = true;
		settings = builtins.readFile ./config.conf;
		autostart_sh = builtins.readFile ./autostart.sh;
	};
	services.swayosd.enable = true;
}
