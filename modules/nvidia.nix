{ config, lib, ... }:
lib.mkIf config.isNvidia {
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.beta;
	};
	environment.sessionVariables = {
		WLR_NO_HARDWARE_CURSORS="1";
		WLR_RENDERER="vulkan";
		XWAYLAND_NO_GLAMOR="1";
	};
}
