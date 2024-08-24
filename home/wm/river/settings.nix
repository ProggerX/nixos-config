{ pkgs, sys, lib, ... }: {
    border-width = 3;
    border-color-focused = "0x${sys.lib.stylix.colors.base0D}";
    map = {
        normal = lib.mkMerge [{
            "Super Return" = "spawn ${pkgs.kitty}/bin/kitty";
            "Super C" = "close";
        }
        (builtins.listToAttrs (
            lib.forEach [[1 1] [2 2] [3 4] [4 8] [5 16] [6 32] [7 64] [8 128] [9 256] [0 512]] (x: {
                name = "Super ${toString (builtins.elemAt x 0)}";
                value = "set-focused-tags ${toString (builtins.elemAt x 1)}";
            })
        ))
        (builtins.listToAttrs (
            lib.forEach [[1 1] [2 2] [3 4] [4 8] [5 16] [6 32] [7 64] [8 128] [9 256] [0 512]] (x: {
                name = "Super+Shift ${toString (builtins.elemAt x 0)}";
                value = "set-view-tags ${toString (builtins.elemAt x 1)}";
            })
        ))
        (builtins.listToAttrs (
            lib.forEach [[1 1] [2 2] [3 4] [4 8] [5 16] [6 32] [7 64] [8 128] [9 256] [0 512]] (x: {
                name = "Super+Control ${toString (builtins.elemAt x 0)}";
                value = "toggle-focused-tags ${toString (builtins.elemAt x 1)}";
            })
        ))
        {
            "Super+Shift E" = "exit";
            "Super R" = "spawn 'rofi -show drun'";
            "Alt Space" = "spawn 'rofi -show run'";
            "Super+Control L" = "spawn ${pkgs.swaylock}/bin/hyprlock";
            "Super U" = "toggle-fullscreen";
            "Super J" = "focus-view next";
            "Super K" = "focus-view previous";
            "Super+Shift J" = "swap next";
            "Super+Shift K" = "swap previous";
            "Super V" = ''spawn "cliphist list | rofi -dmenu -p ' 󰅌  ' | cliphist decode | wl-copy"'';
            "Super F" = "toggle-float";
            "Super+Alt H" = "move left 20";
            "Super+Alt J" = "move down 20";
            "Super+Alt K" = "move up 20";
            "Super+Alt L" = "move right 20";
            "Super+Shift+Alt H" = "resize horizontal -20";
            "Super+Shift+Alt J" = "resize vertical -20";
            "Super+Shift+Alt K" = "resize vertical 20";
            "Super+Shift+Alt L" = "resize horizontal 20";
            "None Print" = "spawn 'grim -g\"$(slurp)\" - | wl-copy'";
            "None XF86AudioMute" = "spawn ${pkgs.pamixer}/bin/pamixer -t";
            "None XF86AudioRaiseVolume" = "spawn '${pkgs.pamixer}/bin/pamixer -i2'";
            "None XF86AudioLowerVolume" = "spawn '${pkgs.pamixer}/bin/pamixer -d2'";
            "None XF86AudioPause" = "spawn '${pkgs.playerctl}/bin/playerctl play-pause'";
            "None XF86AudioPlay" = "spawn '${pkgs.playerctl}/bin/playerctl play'";
            "None XF86AudioPrev" = "spawn '${pkgs.playerctl}/bin/playerctl previous'";
            "None XF86AudioNext" = "spawn '${pkgs.playerctl}/bin/playerctl next'";
        }];
    };
    spawn = [
        "${pkgs.wpaperd}/bin/wpaperd"
        "'${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store'"
        "'rivertile -view-padding 6 -outer-padding 6'"
        "yandex-music"
        "${pkgs.telegram-desktop}/bin/telegram-desktop"
        "${pkgs.firefox}/bin/firefox"
        "${pkgs.waybar}/bin/waybar"
    ];
    default-layout = "rivertile";
    keyboard-layout = "-options grp:win_space_toggle us,ru";
    focus-follows-cursor = "normal";
    rule-add = {
        "-app-id" = {
            "'firefox'" = "tags 2";
            "'YandexMusic'" = "tags 512";
            "'org.telegram.desktop'" = "tags 8";
        };
    };
}
