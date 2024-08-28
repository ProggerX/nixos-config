{ pkgs, ... }:
pkgs.writeShellScriptBin "music_now_playing" ''
    while true
    do
        player_status=''$(${pkgs.playerctl}/bin/playerctl status -p io.github.Rirusha.Cassette 2> /dev/null)
        if [ "$player_status" = "Playing" ]; then
            echo "''$(${pkgs.playerctl}/bin/playerctl metadata artist -p io.github.Rirusha.Cassette) - ''$(${pkgs.playerctl}/bin/playerctl metadata title -p io.github.Rirusha.Cassette)"
        else
            echo ""
        fi
        sleep 1
    done
''
