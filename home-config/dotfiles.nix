{ config, ... }:
{
	home.file."${config.xdg.configHome}" = {
		source = ./dotfiles;
		recursive = true;
	};
}
