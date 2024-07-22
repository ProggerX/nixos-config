{ inputs, lib, config, pkgs, ... }: {
	options = {
		server.emanote.enable = lib.mkEnableOption "emanote";
	};
	config = lib.mkIf config.server.emanote.enable {
		systemd.services.emanote = {
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				WorkingDirectory = "/var/lib/emanote";
				ExecStart = "${inputs.emanote.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/emanote run --port 8585";
			};
		};
	};
}
