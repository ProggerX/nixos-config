{ lib, pkgs, inputs, config, sys, ... }:
{
	imports = [inputs.mangowc.hmModules.mango];
	wayland.windowManager.mango = {
		enable = true;
		settings = builtins.readFile ./config.conf;
		autostart_sh = 
			builtins.concatStringsSep "\n" ([
				(builtins.readFile ./autostart.sh)
				"${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"
				"firefox-nightly"
				"${pkgs.telegram-desktop}/bin/Telegram"
				"sshfs 10.7.0.6:/music /home/proggerx/music"
				"easyeffects --gapplication-service"
				"${pkgs.networkmanagerapplet}/bin/nm-applet"
				] ++ (if sys.isLaptop then [
					"${pkgs.wlsunset}/bin/wlsunset -T 5500"
				] else []));
	};
	services.swayosd.enable = true;
}
