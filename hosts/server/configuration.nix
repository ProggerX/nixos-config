{ config, pkgs, lib, ... }:

let
	interface = "wlan0";
	hostname = "server";
in {
	imports = [
	];

	time.timeZone = "Europe/Moscow";

	virtualisation.docker.enable = true;

	# system.autoUpgrade = {
	# 	enable = true;
	# 	flake = "github:ProggerX/server-config/main";
	# 	dates = "*-*-* *:*:00";
	# 	flags = [
	# 		"--option"
	# 		"eval-cache"
	# 		"false"
	# 	];
	# };


	boot = {
		kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
		initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
		loader = {
			grub.enable = false;
			generic-extlinux-compatible.enable = true;
		};
	};

	services.getty.autologinUser = "proggerx";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	networking.firewall.enable = false;

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-label/NIXOS_SD";
			fsType = "ext4";
			options = [ "noatime" ];
		};
	};

	networking = {
		hostName = hostname;
		wireless = {
			enable = false;
			networks."ssid".psk = "password_here";
			interfaces = [ interface ];
		};
	};

	environment.systemPackages = with pkgs; [ 
		vim 
		git
		tmux
		curl
		wget
		neovim
	];

	services.openssh = {
		enable = true;
		settings.PasswordAuthentication = false;
	};

	users = {
		users.proggerx = {
			isNormalUser = true;
			extraGroups = [ "wheel" "docker" ];
			openssh = {
				authorizedKeys.keys = [
					"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4SSBiwy+ZoyA+waniAK0J6/afMIUYfcdYi9ppQYqO4 x@proggers.ru"
				];
			};
		};
	};

	hardware.enableRedistributableFirmware = true;
	system.stateVersion = "24.05";
}
