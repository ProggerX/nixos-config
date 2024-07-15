{ config, pkgs, lib, ... }:

let
	interface = "wlan0";
	hostname = "server";
in {

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
	services.tailscale.enable = true;
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

	networking = {
		nameservers = ["217.10.39.4"];
		bridges.br0.interfaces = [ "end0" ];
		interfaces."br0".ipv4.addresses= [{
			address = "192.168.0.17";
			prefixLength = 24;
		}];
		defaultGateway = "192.168.0.1";
	};

	containers.test = {
		privateNetwork = true;
		hostBridge = "br0";
		localAddress = "192.168.0.30/24";
		config = {
			system.stateVersion = "24.05";
			networking = {
				defaultGateway = "192.168.0.1";
				nameservers = ["217.10.39.4"];
				useHostResolvConf = lib.mkForce false;
			};
		};
	};
}
