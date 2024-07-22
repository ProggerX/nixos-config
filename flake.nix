{
	description = "Pocket nixos flake";

	inputs = {
		# Main inputs
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		bald.url = "github:NotBalds/bald";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
		masterpkgs.url = "github:NixOS/nixpkgs/master";
		spicetify-nix.url = "github:the-argus/spicetify-nix";
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "masterpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		turnip = {
			url = "github:ProggerX/turnip";
		};
		stylix.url = "github:danth/stylix";
		deploy-rs.url = "github:serokell/deploy-rs";
		# Server inputs
		site = {
			url = "github:ProggerX/site";
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
		cwe = {
			url = "github:NotBalds/cwe_server";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, ...}@inputs: {
		nixosConfigurations = {
			pocket-os = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/base.nix
					./modules/home.nix
					./modules/gaming.nix
					./hosts/pocket-os/configuration.nix
					./hosts/pocket-os/hardware-configuration.nix
				];
			};
			laptop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/base.nix
					./modules/home.nix
					./hosts/laptop/configuration.nix
					./hosts/laptop/hardware-configuration.nix
				];
			};
			server = nixpkgs.lib.nixosSystem {
				system = "aarch64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					inputs.site.nixosModules.site
					inputs.homepage.nixosModules.homepage
					inputs.notie.nixosModules.notie
					inputs.cwe.nixosModules.cwe_server

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
