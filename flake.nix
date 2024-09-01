{
    description = "Pocket nixos flake";

    inputs = {
        # Main inputs
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		zen-browser.url = "github:MarceColl/zen-browser-flake";
        hyprland.url = "github:hyprwm/Hyprland";
        nur.url = "github:nix-community/NUR";
        bald.url = "github:NotBalds/bald";
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";
        masterpkgs.url = "github:NixOS/nixpkgs/master";
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
        spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
        rust-overlay = {
            url = "github:oxalica/rust-overlay";
        };
        home-manager = {
            url = "github:nix-community/home-manager/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";
        deploy-rs.url = "github:serokell/deploy-rs";
        # Server inputs
        flux.url = "github:Bananad3v/flux";
        emanote = {
            url = "github:srid/emanote";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        site = {
            url = "github:ProggerX/ProggerX-old-site";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        homepage = {
            url = "github:ProggerX/homepage";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        notie = {
            url = "github:ProggerX/notie";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        notbalds.url = "github:NotBalds/nix";
        lazynix.url = "github:ProggerX/lazynix";
    };

    outputs = { nixpkgs, ...}@inputs: {
        nixosConfigurations = {
            snd-pc = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./modules/base.nix
                    ./modules/home.nix
                    ./modules/nvidia.nix
                    ./hosts/pc/configuration.nix
                    ./hosts/pc/hardware-configuration.nix
                    ./modules/non-server.nix
                ];
            };
            snd-lp = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./modules/base.nix
                    ./modules/home.nix
                    ./hosts/laptop/configuration.nix
                    ./hosts/laptop/hardware-configuration.nix
                    ./modules/non-server.nix
                ];
            };
            server = nixpkgs.lib.nixosSystem {
                system = "aarch64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    inputs.site.nixosModules.site
                    inputs.homepage.nixosModules.homepage
                    inputs.notie.nixosModules.notie
                    inputs.notbalds.nixosModules.cwe-server

                    ./modules/base.nix
                    ./modules/server
                    ./hosts/server/configuration.nix
                    ./hosts/server/server.nix
                ];
            };
            vps = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    inputs.disko.nixosModules.disko
                    ./hosts/vps/configuration.nix
                ];
            };
        };
        deploy.nodes.server = {
            hostname = "100.126.179.69";
            profiles.system = {
                user = "root";
                sshUser = "root";
                path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos inputs.self.nixosConfigurations.server;
            };
        };
        deploy.nodes.vps = {
            hostname = "5.35.87.192";
            profiles.system = {
                user = "root";
                sshUser = "root";
                path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.vps;
            };
        };
    };
}
