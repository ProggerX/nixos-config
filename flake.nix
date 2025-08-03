{
    description = "Pocket nixos flake";

    inputs = {
        # Main inputs
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		stable.url = "github:NixOS/nixpkgs/nixos-24.11";
		aagl.url = "github:ezKEa/aagl-gtk-on-nix";
        rust-overlay.url = "github:oxalica/rust-overlay";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        pabc-nix = {
            url = "github:ProggerX/pabc-nix/v3";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";
        deploy-rs.url = "github:serokell/deploy-rs";
		winapps.url = "github:winapps-org/winapps";
        # Server inputs
		haskellpobeda.url = "github:ProggerX/haskellpobeda";
		fish-text.url = "github:ProggerX/fish-text";
        flux.url = "github:Bananad3v/flux";
        emanote = {
            url = "github:srid/emanote";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        notie = {
            url = "github:ProggerX/notie";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        notbalds.url = "github:NotBalds/nix";
		firefox.url = "github:nix-community/flake-firefox-nightly";
    };

    outputs = { nixpkgs, ...}@inputs: {
        nixosConfigurations = {
            snd-pc = nixpkgs.lib.nixosSystem rec {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; inherit system; };
                modules = [
                    ./modules/base.nix
                    ./modules/home.nix
					./modules/aagl.nix
                    ./modules/nvidia.nix
                    ./hosts/pc/configuration.nix
                    ./hosts/pc/hardware-configuration.nix
                    ./modules/non-server.nix
                ];
            };
            snd-lp = nixpkgs.lib.nixosSystem rec {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; inherit system; };
                modules = [
                    ./modules/base.nix
                    ./modules/home.nix
                    ./hosts/laptop/configuration.nix
                    ./hosts/laptop/hardware-configuration.nix
                    ./modules/non-server.nix
                ];
            };
            snd-tp = nixpkgs.lib.nixosSystem rec {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; inherit system; };
                modules = [
                    ./modules/base.nix
                    ./modules/home.nix
                    ./hosts/thinkpad/configuration.nix
                    ./hosts/thinkpad/hardware-configuration.nix
                    ./modules/non-server.nix
                ];
            };
            server = nixpkgs.lib.nixosSystem rec {
                system = "aarch64-linux";
                specialArgs = { inherit inputs; inherit system; };
                modules = [
                    inputs.notie.nixosModules.notie
                    inputs.notbalds.nixosModules.cwe-server

                    ./modules/base.nix
                    ./modules/server
                    ./hosts/server/configuration.nix
                    ./hosts/server/server.nix
                ];
            };
        };
        deploy.nodes.server = {
            hostname = "10.7.0.6";
            profiles.system = {
                user = "root";
                sshUser = "root";
                path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos inputs.self.nixosConfigurations.server;
            };
        };
    };
}
