{ config, ... }: {
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
	services.sunshine = {
		enable = true;
		capSysAdmin = true;
	};
    services.xserver.videoDrivers = [ "nvidia" ];
}
