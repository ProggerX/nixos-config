{ config, pkgs, lib, ... }:

let
    interface = "wlan0";
    hostname = "server";
in {

	imports = [ ../../modules/server/wireguard.nix ];

    nixpkgs.config.allowUnfree = true;
    time.timeZone = "Europe/Moscow";


    virtualisation.docker.enable = true;

    # system.autoUpgrade = {
    #     enable = true;
    #     flake = "github:ProggerX/server-config/main";
    #     dates = "*-*-* *:*:00";
    #     flags = [
    #         "--option"
    #         "eval-cache"
    #         "false"
    #     ];
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
		wireguard-tools
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
        };
		users.music = {
			isNormalUser = true;
			shell = "/run/current-system/sw/bin/nologin";
		};
    };
    users.users.proggerx.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNzhtfJxQ3N+nfTRNFZ8LmZ12SF7qtl2YjyKHB9v+r88gLEOygxMA8UFgrJ36NGN16eQGb26Xqz+aNJOlUDHUugpiHLezOrYwBdGtiCVmy/V3Mh3+KmhWjlarO69nCfXsYYPNzmccLY987QFyiNmI4bbfJlc7Y/hboK4WNZRU6aNjuufjQ1edWIR9kettG531EI4ZCNoHvV3+1V1w0EfP70s+ztyuQO2BIB4D8eUGnpi8zdowMuP4IK1jhXZ09SNdH+i3cyhtBNod4RXR5Dn/u3HdT4nW645JlBERgIV3DAxyjRpNEmBBOPyzxCD3CbahgQ4VkyNEY357NCwu8Y41oCoadeCEcO5vRP3xw+rieLTqy/xPfad5CvMsTDmRStxrAlBpe+lgsx+5Cg/AkoeuOlHZuZh7EkliI5h0gSP1JCrQgUGSRg1RMMlPHjDrmecSROaNXvjseOKDSi+Mn9E7JIRWeqMGRkv27a02FTmGHLX3juwrucjg/ox353Pl+eUk= proggerx@pocket-os" ];
    users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNzhtfJxQ3N+nfTRNFZ8LmZ12SF7qtl2YjyKHB9v+r88gLEOygxMA8UFgrJ36NGN16eQGb26Xqz+aNJOlUDHUugpiHLezOrYwBdGtiCVmy/V3Mh3+KmhWjlarO69nCfXsYYPNzmccLY987QFyiNmI4bbfJlc7Y/hboK4WNZRU6aNjuufjQ1edWIR9kettG531EI4ZCNoHvV3+1V1w0EfP70s+ztyuQO2BIB4D8eUGnpi8zdowMuP4IK1jhXZ09SNdH+i3cyhtBNod4RXR5Dn/u3HdT4nW645JlBERgIV3DAxyjRpNEmBBOPyzxCD3CbahgQ4VkyNEY357NCwu8Y41oCoadeCEcO5vRP3xw+rieLTqy/xPfad5CvMsTDmRStxrAlBpe+lgsx+5Cg/AkoeuOlHZuZh7EkliI5h0gSP1JCrQgUGSRg1RMMlPHjDrmecSROaNXvjseOKDSi+Mn9E7JIRWeqMGRkv27a02FTmGHLX3juwrucjg/ox353Pl+eUk= proggerx@pocket-os" ];

    hardware.enableRedistributableFirmware = true;
    system.stateVersion = "25.11";

    networking = {
        nameservers = [
        	"217.10.39.4"
        	"217.10.36.5"
        	"217.10.32.4"
		];
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

	services.szurubooru.enable = false;
	services.szurubooru.server.settings.name = "Зачем ты здесь?";
	services.szurubooru.server.settings.domain = "https://арты.хаскеллпобеда.рф";
	services.szurubooru.server.port = 9000;
	services.szurubooru.server.settings.secretFile = "/run/secrets/szurubooru-server-secret";
	services.szurubooru.server.settings.delete_source_files = "yes";
	services.szurubooru.database.passwordFile = "/run/secrets/szurubooru-db-password";
	services.szurubooru.database.name = "boorubase";
	services.szurubooru.server.package = (pkgs.szurubooru.server.overrideAttrs (old: {
		propagatedBuildInputs = (old.propagatedBuildInputs ++ (with pkgs.python312Packages; [ pyyaml ]));
	})).override {
		python3 = pkgs.python312;
	};

	security.acme = {
		acceptTerms = true;
		defaults.email = "x@proggers.ru";
		certs = {
			booru = { domain = "xn--80a6ag0b.xn--80aacmdb6aja4akt4c.xn--p1ai"; webroot = "/var/lib/acme/acme-challenge"; group = "nginx"; };
		};
	};

    services.nginx = {
        enable = true;
        virtualHosts.aamain = {
            addSSL = true;
            enableACME = true;
            serverName = "bald.su";
            locations."/" = {
				root = "/nginx-root";
            };
        };
		virtualHosts.zzbooru = {
			addSSL = true;
			useACMEHost = "booru";
			serverName = "xn--80a6ag0b.xn--80aacmdb6aja4akt4c.xn--p1ai";
			locations = {
				"/api/".proxyPass = "http://localhost:9000/";
				"/data/".root = config.services.szurubooru.dataDir;
				"/" = {
					root = config.services.szurubooru.client.package;
					tryFiles = "$uri /index.htm";
				};
			};
			extraConfig = "client_max_body_size 100M;";
		};
    #     virtualHosts.fsui = {
    #         addSSL = true;
    #         enableACME = true;
    #         serverName = "f179i.bald.su";
    #         locations."/" = {
				# proxyPass = "http://justix:8080";
    #         };
    #     };
    };
}
