{
  config,
  lib,
  ...
}: {
  options = {
    server.wakapi.enable = lib.mkEnableOption "Enable wakapi";
  };
  config = lib.mkIf config.server.wakapi.enable {
    services.wakapi = {
      enable = true;
      passwordSaltFile = config.age.secrets.wakasalt.path;
      settings = {
        env = "production";
        server = {
          listen_ipv4 = "127.0.0.1";
          port = 8999;
        };
      };
      database.dialect = "sqlite3";
    };
    services.nginx = {
      enable = true;
      virtualHosts.wakapi = {
        addSSL = true;
        enableACME = true;
        serverName = "wak.proggers.ru";
        locations."/" = {
          proxyPass = "http://0.0.0.0:8999";
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "x@proggers.ru";
    };
  };
}
