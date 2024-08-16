{ pkgs, config, lib, ... }:
{
	options = {
		server.minecraft.enable = lib.mkEnableOption "Enable minecraft server";
	};
	config = lib.mkIf config.server.minecraft.enable {
		services.frp.settings.proxies = [
			{
				name = "mine";
				type = "tcp";
				localIP = "127.0.0.1";
				localPort = 25565;
				remotePort = 25566;
			}
			{
				name = "bluemap";
				type = "tcp";
				localIP = "127.0.0.1";
				localPort = 8100;
				remotePort = 8100;
			}
			{
				name = "bedrock";
				type = "udp";
				localIP = "127.0.0.1";
				localPort = 19132;
				remotePort = 19132;
			}
		];
		systemd = let java = pkgs.openjdk; in {
		services.mine = {
				enable = true;
				description = "minecraft server";
				unitConfig = {
					Type = "simple";
				};
				serviceConfig = {
				WorkingDirectory = "/home/proggerx/minecraft/server";
					ExecStart = "${java}/bin/java -Dcom.mojang.eula.agree=true -jar paper-1.18.2-388.jar --nogui";
				};
				wantedBy = [ "multi-user.target" ];
			};
		};
	};
}
