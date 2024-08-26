{ config, ... }: {
    services.mpd = {
        enable = true;
        musicDirectory = "/music";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "pip"
            }
        '';
        user = "proggerx";
    };
    systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
    };
}
