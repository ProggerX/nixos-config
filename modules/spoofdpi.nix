{ lib, pkgs, config, ... }: {
    options = {
        services.spoofdpi.enable = lib.mkEnableOption "Enable SpoofDPI";
    };
    config = lib.mkIf config.services.spoofdpi.enable {
        systemd.services.spoofdpi = {
            wantedBy = [ "multi-user.target" ];
            script = "${pkgs.spoofdpi}/bin/spoofdpi -port 8545";
        };
        networking.proxy.default = "http://127.0.0.1:8545";
    };
}
