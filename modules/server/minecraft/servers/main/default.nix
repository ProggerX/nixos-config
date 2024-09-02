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
                        hash = "sha256-zT2kM2Ix+j9PZzA4pvfqf56VxBoUGIKCi0MiLD0tVJA=";
                    };
                    proxy.enable = false;
                };
            };
        };
    };
}
