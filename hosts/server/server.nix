{ inputs, ... }:
{
	imports = [
		inputs.site.nixosModules.site
		inputs.homepage.nixosModules.homepage
		inputs.notie.nixosModules.notie
		inputs.cwe.nixosModules.cwe_server
	];
	server.site.enable = true;
	server.adguard.enable = true;
	server.homepage.enable = true;
	server.searx.enable = true;
	server.minecraft.enable = true;
	server.notie.enable = true;
	server.jellyfin = {
		enable = true;
		transmission.enable = false;
	};
	server.cwe_server.enable = true;
}
