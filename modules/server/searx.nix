{
  config,
  lib,
  ...
}: {
  options = {
    server.searx.enable = lib.mkEnableOption "Enable searx";
  };
  config = lib.mkIf config.server.searx.enable {
    services.searx.enable = true;
    services.searx.settings.server.secret_key = "useless_key";
    services.searx.settings.server.base_url = "https://s.bald.su/";
    services.nginx = {
      enable = true;
      virtualHosts.searx = {
        addSSL = true;
        enableACME = true;
        serverName = "s.bald.su";
        locations."/" = {
          proxyPass = "http://0.0.0.0:8888";
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "x@proggers.ru";
    };
  };
}
