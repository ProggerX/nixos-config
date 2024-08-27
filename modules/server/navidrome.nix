{ config, lib, ... }:
{
    options = {
        server.navidrome.enable = lib.mkEnableOption "Enable navidrome";
    };
    config = lib.mkIf config.server.navidrome.enable {
        services.navidrome = {
            enable = true;
            settings = {
                MusicFolder = "/music";
                Address = "0.0.0.0";
            };
        };
    };
}
