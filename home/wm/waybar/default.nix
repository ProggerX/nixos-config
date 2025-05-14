{ pkgs, sys, ... }:
{
    imports = [
        ./laptop.nix
    ];
    stylix.targets.waybar.enable = false;
    programs.waybar    = {
        enable = true;
        systemd.enable = true;
        style = with sys.lib.stylix.colors; ''
			#window {
				margin-left: 4px;
				border-radius: 6px;
			}
			#window * {
				background-color: #${base01};
				padding: 0;
				margin-bottom: 4px;
				margin-left: 0px;
				padding-left: 10px;
				padding-right: 10px;
			}
			#clock {
				margin-right: 10px;
			}
            * {
				border-bottom-right-radius: 10px;
				border-bottom-left-radius: 10px;
                background-color: #${base00};
                color: #${base05};
                font-family: "${sys.stylix.fonts.sansSerif.name}";
                font-size: 10pt;
            }
			#workspaces button {
				padding: 4px;
			}
			#workspaces button.active {
				border-radius: 10px;
				border: 2px solid #${base05};
				margin-top: 2px;
				margin-bottom: 2px;
			}
        '';
        settings = {
            bar = {
                position = "top";
                margin-top = 0;
                height = 15;
                spacing = 20;

                modules-center = [ "mpd" "custom/cava" "custom/lyrics" ];
                modules-left = [ "hyprland/window" "hyprland/workspaces" ];
                modules-right = [ "tray" "custom/pipewire" "hyprland/language" "clock" ];
                
                "hyprland/language" = {
                    format-ru = "ru";
                    format-en = "us";
                };

                "hyprland/window" = {
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
