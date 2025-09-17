{ lib, pkgs, config, ... }:
{
    wayland.windowManager.sway = {
        enable = true;
        config = {
            input = {
                "*" = {
                    xkb_layout = "us,ru";
                    xkb_options = "grp:win_space_toggle,caps:escape";
                };
            };
            gaps = {
                outer = 5;
                inner = 5;
            };
            modifier = "Mod4";
            bindkeysToCode = true;
            keybindings = let
            mod = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {
                "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
                "${mod}+y" = "exec ${pkgs.kitty}/bin/kitty ${pkgs.vifm}/bin/vifm";
                "${mod}+shift+r" = ''mode "resize"'';
                "${mod}+c" = "kill";
                "${mod}+r" = "exec rofi -show drun";
                "alt+space" = "exec rofi -show run";
                "${mod}+v" = "exec cliphist list | rofi -dmenu -p ' 󰅌  ' | cliphist decode | wl-copy";
                "Print" = "exec grim -g\"$(slurp)\" - | wl-copy";
                "${mod}+u" = "fullscreen toggle";
                "${mod}+f" = "floating toggle";
                "${mod}+ctrl+l" = "exec ${pkgs.hyprlock}/bin/hyprlock";
                "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
                "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i2";
                "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d2";
                "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
                "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
                "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
            };
            startup = [
                { command = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store"; }
                { command = "firefox-nightly"; }
                { command = "${pkgs.telegram-desktop}/bin/telegram-desktop"; }
                { command = "sleep 2 && ${pkgs.sway}/bin/swaymsg workspace 1"; }
            ];
            assigns = {
                "2" = [{ app_id = "^firefox-nightly$"; }];
                "3" = [{ class = "^vesktop$"; }];
                "4" = [{ app_id = "^org.telegram.desktop$"; }];
                "10" = [{ class = "^Spotify$"; } { app_id = "^YandexMusic$"; }];
            };
        };
        extraConfig = ''
            default_border pixel 2
            default_floating_border pixel 2
        '';
    };
}
