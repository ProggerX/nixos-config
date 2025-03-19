{ lib, pkgs, ... }:
let theme = pkgs.fetchFromGitHub {
	owner = "YouStones";
	repo = "ultrakill-grub-theme";
	rev = "6df32df10aaa79c14d39775d5a5e44416fcb7078";
	sha256 = "sha256-PgQu1m7H11O8QveVvnofdZDqfs08mJqTMsaJk9Th+GQ=";
}; in {
    isLaptop = true;
    imports = [ ../pc/configuration.nix ];
    networking.hostName = lib.mkForce "snd-tp";
    
	services.hypridle.enable = true;
    services.xserver.videoDrivers = [ "intel" ];
	services.xserver.wacom.enable = true;
	services.logind.powerKey = lib.mkForce "ignore";
	hardware.sensor.iio.enable = true;
	programs.iio-hyprland.enable = true;
	boot.loader.grub = {
		efiInstallAsRemovable = lib.mkForce false;
		extraConfig = lib.mkForce "";
		extraEntries = ''
			menuentry "Android" {
				set root=(hd0,gpt9)
				linux /android-8.1-r6/kernel
				initrd /android-8.1-r6/initrd.img
				boot
			}
			menuentry "Windows" --class windows --class os {
				insmod ntfs
				search --no-floppy --set=root --fs-uuid 28B9-E112
				chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
			}
		'';
		theme = lib.mkForce theme;
	};
    boot.loader.efi.canTouchEfiVariables = lib.mkForce true;
}
