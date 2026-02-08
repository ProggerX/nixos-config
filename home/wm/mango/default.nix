{ lib, pkgs, inputs, config, sys, ... }:
{
	imports = [inputs.mangowc.hmModules.mango];
	wayland.windowManager.mango = {
		enable = false;
		settings = builtins.readFile ./config.conf;
		autostart_sh = 
			builtins.concatStringsSep "\n" ([
				"kanshi -c /kanshi.cfg &"
				"${pkgs.xdg-desktop-portal-wlr}/libexec/xdg-desktop-portal-wlr &"
				"systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots && systemctl --user restart xdg-desktop-portal &"
				"${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store &"
				"firefox-nightly &"
				"${pkgs.telegram-desktop}/bin/Telegram &"
				"sshfs 10.7.0.6:/music /home/proggerx/music &"
				"easyeffects --gapplication-service &"
				"${pkgs.networkmanagerapplet}/bin/nm-applet &"
				"${pkgs.swaybg}/bin/swaybg -i ${sys.stylix.image} &"
				"waybar &"
				] ++ (if sys.isLaptop then [
					"${pkgs.wlsunset}/bin/wlsunset -T 5500 &"
				] else []));
	};
	services.swayosd.enable = true;
}
