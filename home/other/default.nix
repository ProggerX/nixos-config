{ pkgs, ... }: {
    imports = [
		./ncmpcpp
		./tor-proxy
    ];
	stylix.iconTheme = {
		enable = true;
		package = pkgs.gruvbox-plus-icons;
		dark = "Gruvbox-Plus-Dark";
		light = "Gruvbox-Plus-Light";
	};
}
