{ lib, config, ... }: {
    options.server.adguard.enable = lib.mkEnableOption "Enable AdGuardHome";
    config = lib.mkIf config.server.adguard.enable {
        services.adguardhome = {
            enable = true;
            port = 9576;
            settings = {
                http.address = "0.0.0.0:9576";
                schema_version = 21;
                dns = {
                    ratelimit = 0;
                    bind_hosts = ["0.0.0.0"];
                    bootstrap_dns = [
                        "217.10.39.4"
                        "217.10.36.5"
                        "217.10.32.4"
                    ];
                    upstream_dns = [
                        "217.10.39.4"
                        "217.10.36.5"
                        "217.10.32.4"
                    ];
                };
            };
        };
    };
}
