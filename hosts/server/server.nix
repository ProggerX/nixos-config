{ inputs, ... }:
{
	imports = [
		inputs.site.nixosModules.site
		inputs.homepage.nixosModules.homepage
		inputs.notie.nixosModules.notie
	];
	server.site.enable = true;
	server.homepage.enable = true;
	server.searx.enable = true;
	server.minecraft.enable = true;
	server.notie.enable = true;
	server.jellyfin = {
		enable = true;
		transmission.enable = false;
	};
}
