{ lib, pkgs, config, ... }: {
    options = {
        services.spoofdpi.enable = lib.mkEnableOption "Enable SpoofDPI";
    };
    config = lib.mkIf config.services.spoofdpi.enable {
        systemd.services.spoofdpi = {
            wantedBy = [ "multi-user.target" ];
            script = "${pkgs.spoofdpi}/bin/spoofdpi -port 8545";
        };
    };
}
