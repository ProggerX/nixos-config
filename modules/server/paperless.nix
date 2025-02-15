{ ... }: {
	services.paperless = {
		enable = true;
		settings.PAPERLESS_ADMIN_USER = "proggerx";
	};
}
