{config,...}:
{
	home.file."${config.xdg.configHome}" = {
		source = ./dotfiles;
		recursive = true;
	};
	home.file.".local/" = {
		source = ./localfiles;
		recursive = true;
	};
}
