{ ... }: {
	services.paperless = {
		enable = true;
		address = "0.0.0.0";
		passwordFile = "/paperless-passwd";
		settings.PAPERLESS_ADMIN_USER = "proggerx";
	};
}
