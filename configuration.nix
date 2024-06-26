{ config, pkgs, lib, ... }:

{
	imports = [ 
		./hardware-configuration.nix
	];

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		noto-fonts
	];

	nixpkgs.config.permittedInsecurePackages = [
		"electron-25.9.0"
	];

	hardware.opentabletdriver.enable = true;
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

# hardware.nvidia = {
#
#     # Modesetting is required.
#     modesetting.enable = true;
#
#     # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
#     # Enable this if you have graphical corruption issues or application crashes after waking
#     # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
#     # of just the bare essentials.
#     powerManagement.enable = false;
#
#     # Fine-grained power management. Turns off GPU when not in use.
#     # Experimental and only works on modern Nvidia GPUs (Turing or newer).
#     powerManagement.finegrained = false;
#
#     # Use the NVidia open source kernel module (not to be confused with the
#     # independent third-party "nouveau" open source driver).
#     # Support is limited to the Turing and later architectures. Full list of 
#     # supported GPUs is at: 
#     # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
#     # Only available from driver 515.43.04+
#     # Currently alpha-quality/buggy, so false is currently the recommended setting.
#     open = false;
#
#     # Enable the Nvidia settings menu,
# 	# accessible via `nvidia-settings`.
#     nvidiaSettings = true;
#
#     # Optionally, you may need to select the appropriate driver version for your specific GPU.
#     package = config.boot.kernelPackages.nvidiaPackages.beta;
#   };
#

	services.xserver.videoDrivers = ["nouveau" "intel"];
	services.tailscale.enable = true;

	networking.hostName = "pocket-os";
	networking.firewall = {
		allowedUDPPorts = [ 51820 ]; 
	};

	boot.plymouth.themePackages = with pkgs; [ (catppuccin-plymouth.override {variant = "mocha";}) ];
	boot.plymouth.theme = "catppuccin-mocha"; 
	boot.initrd.systemd.enable = true;
	
	boot.loader.systemd-boot.enable = false;
	boot.loader.efi.canTouchEfiVariables = false;
	boot.loader.grub.efiInstallAsRemovable = true;
	boot.loader.grub = {
		enable = true;
		efiSupport = true;
		device = "nodev";
	};
	boot.supportedFilesystems = [ "ntfs" ];
	
	boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
	boot.kernelModules = [ "nouveau" ];
	
	networking.networkmanager.enable = true;	
	nix.settings.experimental-features = ["nix-command" "flakes"];
		
	boot.binfmt.registrations.appimage = {
		wrapInterpreterInShell = false;
		interpreter = "${pkgs.appimage-run}/bin/appimage-run";
		recognitionType = "magic";
		offset = 0;
		mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
		magicOrExtension = ''\x7fELF....AI\x02'';
	};
	
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;
	
	time.timeZone = "Europe/Moscow";
	
	virtualisation.docker.enable = true;
	users.extraGroups.docker.members = [ "proggerx" ];
	
	services.xserver.enable = true;
	services.libinput.enable = true;
	services.libinput.touchpad.tapping = true;
	services.libinput.touchpad.middleEmulation = true;
	
	services.displayManager.defaultSession = "sway";
	services.displayManager.sddm.enable = true;
#	services.xserver.displayManager.lightdm.greeters.mini.enable = true;
#	services.xserver.displayManager.lightdm.greeters.mini.user = "proggerx";
	#services.xserver.desktopManager.gnome.enable = true;
	services.displayManager.sddm.wayland.enable = true;
	services.displayManager.sddm.theme = "where_is_my_sddm_theme_qt5";
	
	programs.sway.enable = true;
	services.xserver.windowManager.qtile.enable = true;
	services.greenclip.enable = true;
	hardware.pulseaudio.enable = false;
	
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; 
		dedicatedServer.openFirewall = true; 
	};

	services.gnome.gnome-keyring.enable = true;
		
	programs.fish.enable = true;
	programs.zsh.enable = true;
	environment.pathsToLink = [ "/share/zsh" ];
	environment.sessionVariables = {
		PATH = [
			"/usr/bin/"
			"/home/proggerx/.local/bin/"
			"/home/proggerx/go/bin"
		];
		EDITOR = "vim";
		DIRENV_LOG_FORMAT= "";
		WLR_NO_HARDWARE_CURSORS="1";
	};
	users.defaultUserShell = pkgs.zsh;
	
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.options = "eurosign:e,caps:escape";
	nixpkgs.config.allowUnfree = true;
	
	services.printing.enable = true;
	
	security.rtkit.enable = true;
	security.polkit.enable = true;
	security.pam.services.swaylock = {};
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
	services.pipewire.wireplumber.configPackages = [
		(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
			bluez_monitor.properties = {
				["bluez5.enable-sbc-xq"] = true,
				["bluez5.enable-msbc"] = true,
				["bluez5.enable-hw-volume"] = true,
				["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
			}
		'')
	];
	
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true; 
	services.blueman.enable = true;
		
	users.users.proggerx = {
		isNormalUser = true;
		extraGroups = [ "wheel" "adbusers" ]; 
	};
	
	services.dbus.enable = true;
	services.gnome.gnome-remote-desktop.enable = true;
	xdg.portal = {
		enable = true;
	};
	
	environment.systemPackages = with pkgs; [
		vim 
		(pkgs.where-is-my-sddm-theme.override {
			themeConfig.General = {
				background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
				backgroundMode = "none";
			};
			variants = ["qt5"];
		})
		gnome3.gnome-tweaks
		wget
		webkitgtk
		wireguard-tools
		polkit_gnome
		nettools
		catppuccin-gtk
		pinentry-curses
		libsForQt5.qt5.qtgraphicaleffects
		catppuccin-sddm-corners
		catppuccin-plymouth
		(
			buildFHSUserEnv {
				name = "fhs";
				targetPkgs = pkgs : with pkgs; [
					alsa-lib atk cairo cups curl dbus expat file fish fontconfig freetype
					fuse glib gtk3 libGL libnotify libxml2 libxslt netcat nspr nss openjdk8
					openssl.dev pango pkg-config strace udev vulkan-loader watch wget which
					xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXcursor
					xorg.libXdamage xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr
					xorg.libXrender xorg.libXScrnSaver xorg.libxshmfence xorg.libXtst
					xorg.xcbutilkeysyms zlib fontconfig.lib
				];
			 })
		curl
	];
	
	services.pcscd.enable = true;
	programs.gnupg.agent = {
		 enable = true;
		 pinentryPackage = pkgs.pinentry-curses;
		 enableSSHSupport = true;
	};
		
	services.openssh.enable = true;
	services.flatpak.enable = true;
	programs.dconf.enable = true;
	
	systemd = {
		user.services.kanshi = {
			description = "kanshi daemon";
			serviceConfig = {
				Type = "simple";
				ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ${./kanshi.conf}'';
			};
		};
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
					Type = "simple";
					ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
					Restart = "on-failure";
					RestartSec = 1;
					TimeoutStopSec = 10;
				};
		};
	};
	
	networking.extraHosts = ''
		31.129.99.206 git
	'';
	
	programs.adb.enable = true;
	
	networking.firewall.enable = false;

	fileSystems."/temp" = {
		device = "tmpfs";
		fsType = "tmpfs";
		options = [
			"size=5G"
			"users"
			"nofail"
		];
	};

	swapDevices = [
		{
			device = "/dev/disk/by-label/NIXSWAP";
		}
	];
	zramSwap.enable = true;

	system.stateVersion = "24.11"; 

	specialisation = {
		gaming.configuration = {
			services.xserver.videoDrivers = lib.mkForce ["nvidia"];
  
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
# Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
  hardware.nvidia.package = let 
  rcu_patch = pkgs.fetchpatch {
    url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
    hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
  };
in config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "535.154.05";
    sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
    sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
    openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
    settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
    persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

    #version = "550.40.07";
    #sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
    #sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
    #openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
    #settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
    #persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

    patches = [ rcu_patch ];
 };

services.xserver.desktopManager.gnome.enable = true;
services.displayManager.defaultSession = lib.mkForce "gnome";
	services.terraria.enable = true;
	services.terraria.port = 5555;
services.frp = {
		enable = true;
		role = "client";
		settings = {
			serverAddr = "5.35.87.192";
			serverPort = 7000;
			proxies = [
				{
					name = "terka";
					type = "tcp";
					localIP = "127.0.0.1";
					localPort = 5555;
					remotePort = 5555;
				}
			];
		};
	};
	};
	};
}
