{ config, pkgs, ... }:

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

	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	services.xserver.videoDrivers = ["nvidia" "intel"];
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
			patches = [ rcu_patch ];
	};
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
	};

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
	
	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.wayland.enable = true;
	services.displayManager.sddm.theme = "catppuccin-sddm-corners";
	
	programs.hyprland.enable = true;
	services.xserver.desktopManager.cinnamon.enable = true;
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
	users.defaultUserShell = pkgs.fish;
	
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
	xdg.portal = {
		enable = true;
		wlr.enable = true;
	};
	
	environment.systemPackages = with pkgs; [
		vim 
		wget
		webkitgtk
		wireguard-tools
		polkit_gnome
		xdg-desktop-portal-hyprland
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

	system.stateVersion = "24.05"; 
}
