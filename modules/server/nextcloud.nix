{config, ...}: {
  services.collabora-online = {
    enable = true;
    port = 9980;
    settings = {
      ssl = {
        enable = false;
        termination = true;
      };

      net = {
        listen = "loopback";
        post_allow.host = ["::1"];
      };

      storage.wopi = {
        "@allow" = true;
        host = ["nc.bald.su"];
      };

      server_name = "office.bald.su";
    };
  };
  services.nginx = {
    enable = true;
    virtualHosts."office.bald.su" = {
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://[::1]:${toString config.services.collabora-online.port}";
        proxyWebsockets = true;
      };
      extraConfig = "client_max_body_size 5G;";
    };
    virtualHosts."wb.bald.su" = {
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://0.0.0.0:3002";
        proxyWebsockets = true;
      };
      extraConfig = "client_max_body_size 5G;";
    };
  };

  services.nextcloud-whiteboard-server = {
    enable = true;
    settings = {NEXTCLOUD_URL = "https://nc.bald.su";};
    secrets = ["/nc-whiteboard-env"];
  };

  services.nextcloud = {
    enable = true;
    hostName = "nc.bald.su";
    config.adminpassFile = "/nextcloud-pass";
    config.dbtype = "sqlite";
    https = true;
    extraApps = {
      inherit
        (config.services.nextcloud.package.packages.apps)
        calendar
        contacts
        notes
        mail
        forms
        whiteboard
        richdocuments
        ;
    };
    extraAppsEnable = true;
  };
  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };
}
