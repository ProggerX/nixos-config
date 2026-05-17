{
  config,
  lib,
  ...
}: let
  cfg = config.server.ngircd;
in {
  options.server.ngircd.enable = lib.mkEnableOption "ngircd IRC server";

  config = lib.mkIf cfg.enable {
    services.ngircd = {
      enable = true;
      config = ''
        [Global]
          Name = bald.su
          Info = bald's irc server
          MotdFile = /etc/ngircd/ngircd.motd
          Listen = 127.0.0.1
          Ports = 16667
          AdminInfo1 = bald
          AdminInfo2 = planet earth
          AdminEMail = x@proggers.ru

        [Channel]
          Name = #general
          Topic = Welcome to bald's IRC
      '';
    };

    environment.etc."ngircd/ngircd.motd".text = ''
      [1;33m      ___           ___           ___           ___
         /\__\         /\  \         /\__\         /\  \
        /:/ _/_        \:\  \       /:/ _/_       /::\  \
       /:/ /\__\        \:\  \     /:/ /\  \     /:/\:\__\
      /:/ /:/ _/_   ___ /::\  \   /:/ /::\  \   /:/ /:/  /
     /:/_/:/ /\__\ /\  /:/\:\__\ /:/_/:/\:\__\ /:/_/:/__/___
     \:\/:/ /:/  / \:\/:/  \/__/ \:\/:/ /:/  / \:\/:::::/  /
      \::/_/:/  /   \::/__/       \::/_/:/  /   \::/~~/~~~~
       \:\/:/  /     \:\  \        \:\/:/  /     \:\  \
        \::/  /       \:\__\        \::/  /       \:\__\
         \/__/         \/__/         \/__/         \/__/
      [0m
      Welcome to bald's IRC server (bald.su:6697)
      Channel: #general
      ---
      [1;31mConnection instructions: 6697 ssl required![0m
    '';

    services.nginx.streamConfig = ''
      server {
        listen 6697 ssl;
        proxy_pass 127.0.0.1:16667;

        ssl_certificate /var/lib/acme/bald/fullchain.pem;
        ssl_certificate_key /var/lib/acme/bald/key.pem;
      }
    '';
  };
}
