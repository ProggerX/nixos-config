{ lib, pkgs, ... }: {
    imports = [ ../pc/configuration.nix ];
    networking.hostName = lib.mkForce "snd-tp";
    
    services.xserver.videoDrivers = [ "intel" ];
	services.xserver.wacom.enable = true;
	hardware.trackpoint.enable = true;
	hardware.trackpoint.emulateWheel = true;
	hardware.sensor.iio.enable = true;
	programs.iio-hyprland.enable = true;
    isLaptop = true;
}
