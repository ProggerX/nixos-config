{ modulesPath, pkgs, ... }: {
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        (modulesPath + "/profiles/qemu-guest.nix")
        ./disko.nix
    ];
    time.timeZone = "Europe/Moscow";
    services.getty.autologinUser = "proggerx";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    networking.firewall.enable = false;

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    networking = {
        hostName = "vps";
        nameservers = [ "1.1.1.1" "1.0.0.1" ];
        useDHCP = false;
        interfaces.ens3.ipv4.addresses = [{
            address = "5.35.87.192";
            prefixLength = 24;
        }];
    };


    systemd.services.networkfix = let ip = "${pkgs.busybox}/bin/busybox ip"; in {
        wantedBy = [ "multi-user.target" ];
        after = [ "network-setup.service" ];
        serviceConfig = {
            ExecStart = "-${pkgs.busybox}/bin/busybox sh -c '${ip} route add 100.100.1.1 dev ens3; ${ip} route add default via 100.100.1.1'";
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
        };
        users.root.hashedPassword = "$y$j9T$LlnoZEiavO/3VJBkvRjpw/$tBXS1qc8w9AQYddWJzJmFaoDgZ/a6An6UCUwGOCXmy3";
    };
    users.users.proggerx.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNzhtfJxQ3N+nfTRNFZ8LmZ12SF7qtl2YjyKHB9v+r88gLEOygxMA8UFgrJ36NGN16eQGb26Xqz+aNJOlUDHUugpiHLezOrYwBdGtiCVmy/V3Mh3+KmhWjlarO69nCfXsYYPNzmccLY987QFyiNmI4bbfJlc7Y/hboK4WNZRU6aNjuufjQ1edWIR9kettG531EI4ZCNoHvV3+1V1w0EfP70s+ztyuQO2BIB4D8eUGnpi8zdowMuP4IK1jhXZ09SNdH+i3cyhtBNod4RXR5Dn/u3HdT4nW645JlBERgIV3DAxyjRpNEmBBOPyzxCD3CbahgQ4VkyNEY357NCwu8Y41oCoadeCEcO5vRP3xw+rieLTqy/xPfad5CvMsTDmRStxrAlBpe+lgsx+5Cg/AkoeuOlHZuZh7EkliI5h0gSP1JCrQgUGSRg1RMMlPHjDrmecSROaNXvjseOKDSi+Mn9E7JIRWeqMGRkv27a02FTmGHLX3juwrucjg/ox353Pl+eUk= proggerx@pocket-os" ];
    users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNzhtfJxQ3N+nfTRNFZ8LmZ12SF7qtl2YjyKHB9v+r88gLEOygxMA8UFgrJ36NGN16eQGb26Xqz+aNJOlUDHUugpiHLezOrYwBdGtiCVmy/V3Mh3+KmhWjlarO69nCfXsYYPNzmccLY987QFyiNmI4bbfJlc7Y/hboK4WNZRU6aNjuufjQ1edWIR9kettG531EI4ZCNoHvV3+1V1w0EfP70s+ztyuQO2BIB4D8eUGnpi8zdowMuP4IK1jhXZ09SNdH+i3cyhtBNod4RXR5Dn/u3HdT4nW645JlBERgIV3DAxyjRpNEmBBOPyzxCD3CbahgQ4VkyNEY357NCwu8Y41oCoadeCEcO5vRP3xw+rieLTqy/xPfad5CvMsTDmRStxrAlBpe+lgsx+5Cg/AkoeuOlHZuZh7EkliI5h0gSP1JCrQgUGSRg1RMMlPHjDrmecSROaNXvjseOKDSi+Mn9E7JIRWeqMGRkv27a02FTmGHLX3juwrucjg/ox353Pl+eUk= proggerx@pocket-os" ];

    hardware.enableRedistributableFirmware = true;
    system.stateVersion = "24.05";
    services.frp.enable = true;
    services.frp.role = "server";
    services.frp.settings = { bindPort = 7000; };
}
