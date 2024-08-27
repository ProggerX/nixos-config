{ pkgs, ... }:
pkgs.writeShellScriptBin "music_now_playing" ''
    while true
    do
        echo "$(${pkgs.mpc-cli}/bin/mpc | head -n 1 | sed 's/volume:.*//')"
        sleep 1
    done
''
