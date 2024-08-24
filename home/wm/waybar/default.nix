{ pkgs, sys, ... }:
{
    imports = [
        ./laptop.nix
    ];
    stylix.targets.waybar.enable = false;
    programs.waybar    = {
        enable = true;
        style = with sys.lib.stylix.colors; ''
            * {
                background-color: #${base00};
                color: #${base05};
                font-family: "${sys.stylix.fonts.sansSerif.name}";
                font-size: 10pt;
                border-radius: 30px;
            }

            #workspaces {
                background-color: #${base01};
                margin-left: 6px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
            }

            #workspaces * {
                background-color: #${base01};
            }

            #workspaces button {
                margin: 2px;
                padding-left: 7px;
                padding-right: 7px;
                border-radius: 22px;
            }

            #workspaces button.active {
                border: 2px solid #${base05};
            }

            #window {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #window * {
                background-color: #${base01};
            }

            #custom-music {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #custom-pipewire {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #custom-battery {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #custom-brightness {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #language {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #clock {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 6px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #tray {
                background-color: #${base01};
                border-radius: 24px;
                box-shadow: 0 0 3px #${base05};
                margin-left: 10px; margin-right: 10px; margin-top: 6px; margin-bottom: 6px;
                padding: 6px;
                padding-left: 8px;
                padding-right: 8px;
            }

            #tray * {
                background-color: #${base01};
            }
        '';
        settings = {
            bar = {
                position = "top";
                margin-top = 5;
                height = 52;
                width = 1900;
                spacing = 10;

                modules-center    = [ "custom/music" ];
                modules-left    = [ "hyprland/workspaces" "hyprland/window" ];
                modules-right    = [ "tray" "custom/pipewire" "hyprland/language" "clock" ];

                "hyprland/language" = {
                    format-ru = "ru";
                    format-en = "us";
                };

                "hyprland/window" = {
                    max-length = 30;
                };

                "tray" = {
                    spacing = 10;
                    icon-size = 15;
                };

                "clock" = {
                    "format" = "{:%H:%M}";
                    "format-alt" = "{:%Y-%m-%d}";
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
                    exec = "${import ./battery.nix { inherit pkgs; }}/bin/waybar_brightness";
                    interval = 5;
                };

                "custom/brightness" = {
                    format = "{}";
                    interval = 5;
                    on-scroll-up = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness raise > /dev/null";
                    on-scroll-down = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness lower > /dev/null";
                    exec = "${import ./brightness.nix { inherit pkgs; }}/bin/waybar-brightness get";
                };

                "custom/music" = {
                    format = "  {}";
                    return-type = "text";
                    escape = true;
                    tooltip = false;
                    exec = "${import ./music.nix { inherit pkgs; }}/bin/music_now_playing";
                };
            };
        };
    };
}
