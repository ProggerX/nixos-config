{ pkgs, lib, ... }: {
    services.mopidy = {
        enable = true;
        extensionPackages = [ pkgs.mopidy-mpd ];
        configuration = ''
            [file]
            media_dirs = /music|music
        '';
    };
    systemd.services.mopidy = {
        serviceConfig.User = lib.mkForce "proggerx";
        environment.XDG_RUNTIME_DIR = "/run/user/1000";
    };
}
