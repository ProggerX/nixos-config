{ inputs, system, ... }:
{
	systemd.user.services.msh = {
        Unit = {
          PartOf = [ "tray.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };

        Service = {
          ExecStart = "${inputs.msh.packages.${system}.default}/bin/msh";
          Restart = "on-failure";
          KillMode = "mixed";
        };

        Install.WantedBy = [ "tray.target" ];
    };
}
