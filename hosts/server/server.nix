{...}: {
  server.adguard.enable = false;
  server.calibre.enable = true;
  server.dufs.enable = true;
  server.fish-text.enable = false;
  server.navidrome.enable = true;
  server.hspobeda.enable = true;
  server.emanote.enable = false;
  server.seafile.enable = true;
  server.searx.enable = true;
  server.memos.enable = true;
  server.notie.enable = true;
  server.jellyfin = {
    enable = true;
    transmission.enable = false;
  };
  server.cwe_server.enable = true;
  server.wakapi.enable = true;
  services.adhd = {
    enable = true;
    configuration = ''
      {
        network = "13.37.0.0/16",
        serverIp = "13.37.67.67",
        gateway = "13.37.0.1",
        occupiedIps = [] : List Text,
        dns = ["13.37.67.67", "8.8.8.8"],
        beautifulBytes = [13,37,228,69,52,133,7]
      }
    '';
  };
}
