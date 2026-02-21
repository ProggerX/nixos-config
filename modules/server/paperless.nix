{...}: {
  services.paperless = {
    enable = false;
    address = "0.0.0.0";
    passwordFile = "/paperless-passwd";
    settings.PAPERLESS_ADMIN_USER = "proggerx";
  };
}
