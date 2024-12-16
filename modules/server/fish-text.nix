{ lib, config, inputs, pkgs, ... }: {
    options.server.fish-text.enable = lib.mkEnableOption "Enable FishText";
    config = lib.mkIf config.server.fish-text.enable {
		systemd.services.fish-text = {
			script = "${inputs.fish-text.packages.${pkgs.system}.default}/bin/fish-text";
			serviceConfig = {
				WorkingDirectory = "/var/lib/fish-text";
			};
			wantedBy = [ "multi-user.target" ];
		};
    };
}
