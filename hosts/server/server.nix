{ inputs, ... }:
{
    server.adguard.enable = true;
	server.dufs.enable = true;
    server.navidrome.enable = true;
    server.emanote.enable = true;
    server.searx.enable = true;
	server.memos.enable = true;
    server.notie.enable = true;
    server.jellyfin = {
        enable = true;
        transmission.enable = false;
    };
    server.cwe_server.enable = true;
}
