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
	hardware.nvidia = {
		package = config.boot.kernelPackages.nvidiaPackages.beta;
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
	
	services.displayManager.defaultSession = "sway";
	services.displayManager.enable = true;
	services.xserver.displayManager.lightdm.greeters.mini.enable = true;
	services.xserver.displayManager.lightdm.greeters.mini.user = "proggerx";
	#services.xserver.desktopManager.gnome.enable = true;
	#services.displayManager.sddm.wayland.enable = true;
	#services.displayManager.sddm.theme = "catppuccin-sddm-corners";
	
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
		gnomeExtensions.burn-my-windows
		gnomeExtensions.compiz-windows-effect
		gnomeExtensions.pop-shell
		gnomeExtensions.clipboard-indicator
		gnomeExtensions.clipboard-history
		gnome3.gnome-tweaks
		gnomeExtensions.tray-icons-reloaded
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

	system.stateVersion = "24.11"; 
}
