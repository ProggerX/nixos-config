{ inputs, ... }:
{
    server.adguard.enable = true;
    server.navidrome.enable = true;
    server.emanote.enable = true;
    server.searx.enable = true;
    server.minecraft.enable = true;
    server.minecraft.servers.main.enable = true;
    server.notie.enable = true;
    server.jellyfin = {
        enable = true;
        transmission.enable = false;
    };
    server.cwe_server.enable = true;
}
