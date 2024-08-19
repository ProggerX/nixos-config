{ lib, config, pkgs, ... }: {
	options = {
		server.minecraft.servers.main.enable = lib.mkEnableOption "main minecraft server";
	};
	imports = [
		./frp.nix
	];
	config = let cfg = config.server.minecraft.servers.main; in lib.mkIf cfg.enable {
		flux = {
			servers = {
				main = {
					package = pkgs.mkMinecraftServer {
						name = "main-mine";
						src = ./config;
						hash = "";
					};
					proxy.enable = false;
				};
			};
		};
	};
}
