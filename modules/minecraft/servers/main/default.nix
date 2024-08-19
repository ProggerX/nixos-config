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
						hash = "sha256-3wBMLOspzrEUbxt/s8waI7Lanf4E43J+Jc5BJKovC4w=";
					};
					proxy.enable = false;
				};
			};
		};
	};
}
