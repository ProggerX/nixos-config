# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];

nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
services.xserver.videoDrivers = ["nvidia" "intel"];
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

  };
networking.hostName = "pocket-os";

networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };

  # Use the systemd-boot EFI boot loader.
  # boot.plymouth.enable = true;
  boot.plymouth.themePackages = with pkgs; [ (catppuccin-plymouth.override {variant = "mocha";}) ];
  boot.plymouth.theme = "catppuccin-mocha"; # Не работает
  boot.initrd.systemd.enable = true;
  
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    theme = pkgs.stdenv.mkDerivation {
      name = "catppuccin-grub-theme";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
	repo = "grub";
	rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
	sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
      };
      installPhase = "cp -r src/catppuccin-mocha-grub-theme/ $out";
    };
  };
  boot.supportedFilesystems = [ "ntfs" ];
  #boot.loader.efi.installAsRemovable= true;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
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

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "proggerx" ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;
  services.xserver.libinput.touchpad.middleEmulation = true;
  # services.displayManager.defaultSession = "Hyprland";
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "catppuccin-sddm-corners";
#   systemd.services."getty@tty1" = {
#     serviceConfig = {
#       ExecStart = "-/sbin/agetty --noclear --autologin proggerx %I $TERM";
#       Type = "idle";
#     };
# };
  # services.getty.autologinUser = "proggerx";
  programs.hyprland.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.greenclip.enable = true;
  hardware.pulseaudio.enable = false;

  	

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

    services.gnome.gnome-keyring.enable = true;


  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.fish.enable = true;

  environment.sessionVariables = {
    PATH = [
        "/usr/bin/"
		"/home/proggerx/.local/bin/"
		"/home/proggerx/go/bin"
		# "/home/proggerx/.go/bin"
   ];
   EDITOR = "vim";
   DIRENV_LOG_FORMAT= "";
   # SHELL = "/run/current-system/sw/bin/fish";
   # BAT_THEME="Catppuccin-mocha";
   WLR_NO_HARDWARE_CURSORS="1";
  };
  users.defaultUserShell = pkgs.fish;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
# Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

# rtkit is optional but recommended
security.rtkit.enable = true;
security.polkit.enable = true;
security.pam.services.swaylock = {};
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
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

# environment.etc = {
# 	"os-release".text = ''
# NAME="Ubuntu"
# VERSION="20.04.1 LTS (Focal Fossa)"
# ID=ubuntu
# ID_LIKE=debian
# PRETTY_NAME="Ubuntu 20.04.1 LTS"
# VERSION_ID="20.04"
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# VERSION_CODENAME=focal
# UBUNTU_CODENAME=focal
# '';
# };

hardware.bluetooth.enable = true;   hardware.bluetooth.powerOnBoot = true; 
services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.proggerx = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    (pkgs.buildFHSUserEnv {
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


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
    #enable = true;
    #enableSSHSupport = true;
  #};
services.pcscd.enable = true;
programs.gnupg.agent = {
   enable = true;
   pinentryPackage = pkgs.pinentry-curses;
   enableSSHSupport = true;
};
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
 # 
}

