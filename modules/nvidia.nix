{ pkgs, ... }: {
	systemd.tmpfiles.rules = 
	  let
		rocmEnv = pkgs.symlinkJoin {
		  name = "rocm-combined";
		  paths = with pkgs.rocmPackages; [
			rocblas
			hipblas
			clr
		  ];
		};
	  in [
		"L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
	  ];
	environment.systemPackages = with pkgs; [ blender-hip ];
	services.lact.enable = true;
	hardware.amdgpu.overdrive.enable = true;

	services.ollama = {
		enable = true;
		package = pkgs.ollama-rocm;
		acceleration = "rocm";
		host = "0.0.0.0";
	};

	services.open-webui.enable = true;
	services.open-webui.host = "0.0.0.0";
}
