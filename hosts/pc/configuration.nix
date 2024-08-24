{ config, lib, pkgs, ... }:
{
    imports = [
        ../../modules/dm.nix
        ../../modules/kanata.nix
        ../../modules/music.nix
    ];
    options = {
        isLaptop = lib.mkEnableOption ''Device is laptop'';
    };
    config = {
        virtualisation.waydroid.enable = true;
        services.atftpd.enable = true;
        fonts.packages = with pkgs; [
            (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
            noto-fonts
        ];
        boot.binfmt.emulatedSystems = ["aarch64-linux"];
        nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

        services.resolved.enable = true;

        programs.nix-ld.enable = true;

        nixpkgs.config.permittedInsecurePackages = [
            "electron-25.9.0"
        ];

        hardware.opentabletdriver.enable = true;
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };


        services.tailscale.enable = true;

        networking.hostName = "snd-pc";
        networking.nameservers = [ "100.126.179.69" ];
        networking.firewall = {
            allowedUDPPorts = [ 51820 ]; 
        };

                
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
        programs.wireshark.enable = true;
        
        time.timeZone = "Europe/Moscow";
        
        virtualisation.docker.enable = true;
        users.extraGroups.docker.members = [ "proggerx" ];
        users.extraGroups.wireshark.members = [ "proggerx" ];
        
        services.xserver.enable = true;
        services.libinput.enable = true;
        services.libinput.touchpad.tapping = true;
        services.libinput.touchpad.middleEmulation = true;
        
        services.displayManager.defaultSession = "sway";
                                
        programs.hyprland.enable = true;
        programs.river.enable = true;
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
        };
        users.defaultUserShell = pkgs.zsh;
        
        services.xserver.xkb.layout = "us";
        services.xserver.xkb.options = "eurosign:e,caps:escape";
        nixpkgs.config.allowUnfree = true;
        
        services.printing.enable = true;
        
        security.rtkit.enable = true;
        security.polkit.enable = true;
        security.pam.services.hyprlock = {};
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
            
        users.mutableUsers = false;
        users.users.proggerx = {
            isNormalUser = true;
            extraGroups = [ "wheel" "adbusers" ]; 
            hashedPassword = "$y$j9T$9Q.MJOUROTrVdApws9avH0$HYDJYm6RsP8o3AWoL7FHjOA.y/TPE2p4tbI1DXHhM.6";
        };
        
        services.dbus.enable = true;
        xdg.portal = {
            enable = true;
            wlr.enable = true;
        };
        
        environment.systemPackages = with pkgs; [
            vim 
            man-pages man-pages-posix
            wayvnc
            nh
            (pkgs.where-is-my-sddm-theme.override {
                themeConfig.General = {
                    background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
                    backgroundMode = "none";
                };
                variants = ["qt5"];
            })
            wget
            webkitgtk
            wireguard-tools
            polkit_gnome
            nettools
            catppuccin-gtk
            pinentry-curses
            libsForQt5.qt5.qtgraphicaleffects
            catppuccin-sddm-corners
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
            
        '';
        
        programs.adb.enable = true;
        
        networking.firewall.enable = false;
        networking.wireguard.enable = true;

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


        services.terraria.enable = false;
        services.frp = {
            enable = config.services.terraria.enable;
            role = "client";
            settings = {
                serverAddr = "5.35.87.192";
                serverPort = 7000;
                proxies = [
                    {
                        name = "terka";
                        type = "tcp";
                        localIP = "127.0.0.1";
                        localPort = 7777;
                        remotePort = 7777;
                    }
                ];
            };
        };
    };
}
