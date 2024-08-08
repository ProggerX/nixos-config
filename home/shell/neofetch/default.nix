{ ... }: {
	xdg.configFile."neofetch/config.conf".source = ./config.conf;
	xdg.configFile."neofetch/logo.jpg" = {
		source = ./logo.jpg;
		executable = true;
		recursive = true;
	};
}
