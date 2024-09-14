{ lib, pkgs, ... }: {
    imports = [ ../pc/configuration.nix ];
    networking.hostName = lib.mkForce "snd-tp";
    
    services.xserver.videoDrivers = [ "intel" ];
	services.xserver.wacom.enable = true;
	hardware.trackpoint.enable = true;
	hardware.trackpoint.emulateWheel = true;
	hardware.trackpoint.fakeButtons = true;
	hardware.sensor.iio.enable = true;
	programs.iio-hyprland.enable = true;
	boot.loader.grub.efiInstallAsRemovable = lib.mkForce false;
    boot.loader.efi.canTouchEfiVariables = lib.mkForce true;
    isLaptop = true;
}
