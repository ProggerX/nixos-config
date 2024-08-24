{ inputs, lib, config, pkgs, ... }: {
    options = {
        server.emanote.enable = lib.mkEnableOption "emanote";
    };
    config = lib.mkIf config.server.emanote.enable {
        systemd.services.emanote = {
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                WorkingDirectory = "/var/lib/emanote";
                ExecStart = "${inputs.emanote.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/emanote run --port 8585";
            };
        };
        services.frp.settings.proxies = [
            {
                type = "tcp";
                name = "emanote";
                localPort = 8585;
                remotePort = 8585;
                localIP = "127.0.0.1";
            }
        ];
    };
}
