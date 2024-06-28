{
    description = "Pocket nixos flake";

    inputs = {
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
    };

    outputs = { nixpkgs, stylix, home-manager, rust-overlay, ...}@inputs:
		let system = "x86_64-linux";
		in {
        nixosConfigurations = {
            pocket-os = nixpkgs.lib.nixosSystem {
                system = "${system}";
                
                modules = [
                    ./configuration.nix

					home-manager.nixosModules.home-manager
					inputs.turnip.nixosModules.turnip
					stylix.nixosModules.stylix
					./stylix
					./turnip
					./gaming.nix

					{
						imports = [ ./hardware-configuration.nix ];
					}

					({ pkgs, ... }: {
						nixpkgs.overlays = [ rust-overlay.overlays.default ];
						environment.systemPackages = [
							(pkgs.rust-bin.selectLatestNightlyWith(toolchain: toolchain.default.override {
								extensions = [ "rust-analyzer" ];
							}))
						];
					})

					{
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "old";

            			home-manager.users.proggerx = ./home;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
					}
                ];
            };
            laptop = nixpkgs.lib.nixosSystem {
                system = "${system}";
                
                modules = [
                    ./configuration.nix

					home-manager.nixosModules.home-manager
					inputs.turnip.nixosModules.turnip
					stylix.nixosModules.stylix
					./stylix
					./turnip

					({ pkgs, ... }: {
						nixpkgs.overlays = [ rust-overlay.overlays.default ];
						environment.systemPackages = [
							(pkgs.rust-bin.selectLatestNightlyWith(toolchain: toolchain.default.override {
								extensions = [ "rust-analyzer" ];
							}))
						];
					})

					({ lib, ... }: {
						networking.hostName = lib.mkForce "laptop";
						imports = [ ./laptop-hardware-configuration.nix ];
					})

					{
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "old";

            			home-manager.users.proggerx = ./home;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
					}
                ];
            };
		};
    };
}
