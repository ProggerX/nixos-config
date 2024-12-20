{ pkgs, ... }:
pkgs.writeShellScriptBin "music_now_playing" ''
    while true
    do
        mp=$(${pkgs.mpc-cli}/bin/mpc current 2> /dev/null)
        if [ "$mp" = "" ]; then
            echo ""
        else
			echo "$mp"
        fi
        sleep 1
    done
''
