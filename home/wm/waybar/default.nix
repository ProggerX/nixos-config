{ pkgs, sys, ... }:
{
    imports = [
        ./laptop.nix
    ];
    stylix.targets.waybar.enable = false;
    programs.waybar    = {
        enable = true;
        systemd.enable = false;
        style = with sys.lib.stylix.colors; ''
/* Parts of style are stolen from https://github.com/diinki/diinki-aero */

#window {
	margin-left: 10px;
}

#clock {
	margin-right: 10px;
}

* {
	min-height: 0;
	font-weight: bold;
	font-size: 14px;
	background-color: #${base00};
	color: #${base05};
	font-family: "${sys.stylix.fonts.sansSerif.name}";
    font-size: 10pt;
}
#clock,
#custom-pipewire,
#custom-battery,
#custom-brightness,
#custom-cava,
#language,
#tray,
#workspaces,
#window,
#mpd {
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10;
	box-shadow: 0px 0px 3px rgba(0,0,0,0.34);
	border-style: none;
	border-bottom-style: solid;
	border-top-style: solid;
	border-bottom-color: rgba(255,255,255,0.15);
	border-top-color: rgba(255,255,255,0.45);
	border-width: 1px;
}

#tray menu {
	background-color: #${base00};
}

#workspaces button {
	transition-duration: 100ms;
	all: initial;
	min-width: 0;
	margin-right: 5px;
	margin-left: 5px;
}

#workspaces button.focused * {
	color: #${base0D};
}

#workspaces button:hover {
	transition-duration: 120ms;
	text-shadow: 0px 0px 8px aqua;
}
        '';
        settings = {
            bar = {
                position = "top";
                margin-top = 5;
                height = 15;
                spacing = 20;

                modules-center = [ "mpd" "custom/cava" ];
                modules-left = [ "sway/window" "sway/workspaces" ];
                modules-right = [ "tray" "custom/pipewire" "sway/language" "clock" ];
                
                "sway/language" = {
                    format-ru = "ru";
                    format-en = "us";
                };

                "sway/window" = {
					on-click = "rofi -show drun";
                    max-length = 30;
					min-length = 30;
					align = 0;
					format = "  {title}";
                };

                "tray" = {
                    spacing = 10;
                    icon-size = 15;
                };

                "clock" = {
                    "format" = "{:%H:%M}";
                    "format-alt" = "{:%d-%m-%Y}";
                };

                "custom/pipewire" = let pamixer = "${pkgs.pamixer}/bin/pamixer"; in {
                    format = "{}";
                    exec = "sleep 0.05 && echo $(${pamixer} --get-mute)$(${pamixer} --get-volume) | sed 's/true/ /' | sed 's/false/) /'";
                    on-click = "${pamixer} -t; pkill -x -RTMIN+11 waybar";
                    on-scroll-up = "${pamixer} -i2; pkill -x -RTMIN+11 waybar";
                    on-scroll-down = "${pamixer} -d2; pkill -x -RTMIN+11 waybar";
                    signal = 11;
                    interval = 5;
                    tooltip = false;
                };
                
                "custom/battery" = {
                    format = "{}";
                    exec = "${import ./battery.nix { inherit pkgs; }}/bin/waybar_battery";
                    interval = 5;
                };

                "custom/brightness" = {
                    format = "{}";
                    interval = 5;
                    on-scroll-up = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness raise > /dev/null";
                    on-scroll-down = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness lower > /dev/null";
                    exec = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness get";
                };

				"custom/lyrics" = {
					format = "{}";
					return-type = "text";
					exec = "${pkgs.callPackage ./lrcsnc.nix {}}/bin/lrcsnc --config ${./lrcsnc-config}";
				};

                "mpd" = {
                    format = "  {artist} - {title}";
					format-paused = " {artist} - {title}";
					format-stopped = "";
					on-click = "${pkgs.mpc-cli}/bin/mpc prev";
					on-click-right = "${pkgs.mpc-cli}/bin/mpc next";
					on-click-middle = "${pkgs.mpc-cli}/bin/mpc toggle";
                };

                "custom/cava" = {
                    format = "{}";
                    return-type = "text";
                    max-length = 50;
                    escape = true;
                    tooltip = false;
                    exec = "${import ./cava.nix { inherit pkgs; }}/bin/cava_waybar";
                };
            };
        };
    };
}
