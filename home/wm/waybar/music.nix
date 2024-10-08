{ pkgs, ... }:
pkgs.writeShellScriptBin "music_now_playing" ''
    while true
    do
        player_status=''$(${pkgs.playerctl}/bin/playerctl status -p spotify 2> /dev/null)
        if [ "$player_status" = "Playing" ]; then
            echo "''$(${pkgs.playerctl}/bin/playerctl metadata artist -p spotify) - ''$(${pkgs.playerctl}/bin/playerctl metadata title -p spotify)"
        else
            echo ""
        fi
        sleep 1
    done
''
