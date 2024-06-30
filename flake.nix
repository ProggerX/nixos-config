{
	description = "Pocket nixos flake";

	inputs = {
		# Main inputs
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nvimpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		newpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "newpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nvimpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager/";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		turnip = {
			url = "github:ProggerX/turnip";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		stylix.url = "github:danth/stylix";
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
	};

	outputs = { nixpkgs, stylix, home-manager, ...}@inputs:
		let system = "x86_64-linux";
		in {
		nixosConfigurations =
		let base = [
			home-manager.nixosModules.home-manager
			inputs.turnip.nixosModules.turnip
			stylix.nixosModules.stylix
			./stylix
			./turnip

			({ ... }: {
				home-manager.useGlobalPkgs = true;
				home-manager.useUserPackages = true;
				home-manager.backupFileExtension = "old";
				home-manager.users.proggerx = ./home;
				home-manager.extraSpecialArgs = { inherit inputs; };
			})
			
			({ pkgs,  ... }: {
				nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
				environment.systemPackages = [
					(pkgs.rust-bin.selectLatestNightlyWith(toolchain: toolchain.default.override {
						extensions = [ "rust-analyzer" ];
					}))
				];
			})
		]; in {
			pocket-os = nixpkgs.lib.nixosSystem {
				system = "${system}";
				
				modules = base ++ [
					./hosts/pocket-os/gaming.nix
					./hosts/pocket-os/configuration.nix
					{
						imports = [ ./hosts/pocket-os/hardware-configuration.nix ];
					}
				];
			};
			laptop = nixpkgs.lib.nixosSystem {
				system = "${system}";
				modules = base ++ [
					./hosts/laptop/configuration.nix
					({ lib, ... }: {
						networking.hostName = lib.mkForce "laptop";
						imports = [ ./hosts/laptop/hardware-configuration.nix ];
					})
				];
			};
			server = nixpkgs.lib.nixosSystem {
				system = "aarch64-linux";
				modules = [
					inputs.turnip.nixosModules.turnip
					inputs.site.nixosModules.site
					inputs.homepage.nixosModules.homepage
					inputs.notie.nixosModules.notie
					inputs.stylix.nixosModules.stylix
					./modules/server
					./hosts/server/configuration.nix
					./hosts/server/server.nix
					./stylix
					./turnip
				];
			};
		};
	};
}
