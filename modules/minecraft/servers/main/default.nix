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
						name = "main-minecraft-server";
						src = ./config;
						hash = "sha256-KTd1F/vt+3n6m/ct4Ay4rKz8Zd0T7VqxLAqARx/CtT9=";
					};
					proxy.enable = false;
				};
			};
		};
	};
}
