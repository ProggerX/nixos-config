{ lib, config, pkgs, ... }: {
    options = {
        server.minecraft.servers.main.enable = lib.mkEnableOption "main minecraft server";
    };
    imports = [
        ./frp.nix
        ./nginx.nix
    ];
    config = let cfg = config.server.minecraft.servers.main; in lib.mkIf cfg.enable {
        flux = {
            servers = {
                main = {
                    package = pkgs.mkMinecraftServer {
                        name = "main-minecraft-server";
                        src = ./config;
                        hash = "sha256-fHQ5YW9f98BWArFwSB+Mq8g76JK7xjM9PVQA6G0yrdQ=";
                    };
                    proxy.enable = false;
                };
            };
        };
    };
}
