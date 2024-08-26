{ config, ... }: {
    services.mpd = {
        enable = true;
        musicDirectory = "/music";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "PipeWire"
            }
        '';
        user = "proggerx";
    };
    systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.proggerx.uid}";
    };
}
