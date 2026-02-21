{
  lib,
  config,
  ...
}: {
  options = {
    server.memos.enable = lib.mkEnableOption "memos";
  };
  config = lib.mkIf config.server.memos.enable {
    virtualisation.oci-containers.containers.memos = {
      image = "neosmemo/memos:stable";
      volumes = ["/var/lib/memos:/var/opt/memos"];
      ports = ["5230:5230"];
    };
    services.nginx = {
      enable = true;
      virtualHosts.memos = {
        addSSL = true;
        enableACME = true;
        serverName = "mem.bald.su";
        locations."/" = {
          proxyPass = "http://0.0.0.0:5230";
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "x@proggers.ru";
    };
  };
}
