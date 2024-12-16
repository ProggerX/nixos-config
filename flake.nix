{
    description = "Pocket nixos flake";

    inputs = {
        # Main inputs
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		aagl.url = "github:ezKEa/aagl-gtk-on-nix";
		zen-browser.url = "github:ProggerX/zen-browser-flake";
        hyprland.url = "github:hyprwm/Hyprland";
        nur.url = "github:nix-community/NUR";
        bald.url = "github:NotBalds/bald";
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";
        masterpkgs.url = "github:NixOS/nixpkgs/master";
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";
        spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
		ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release?submodules=1";
        rust-overlay.url = "github:oxalica/rust-overlay";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        pabc-nix = {
            url = "github:ProggerX/pabc-nix/v1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix/release-24.11";
        deploy-rs.url = "github:serokell/deploy-rs";
        # Server inputs
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
        lazynix.url = "github:ProggerX/lazynix";
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
            hostname = "100.126.179.69";
            profiles.system = {
                user = "root";
                sshUser = "root";
                path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos inputs.self.nixosConfigurations.server;
            };
        };
    };
}
