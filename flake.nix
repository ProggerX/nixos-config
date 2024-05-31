{
    description = "Pocket nixos flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nvimpkgs.url = "github:NixOS/nixpkgs/817c3eccc985907e3cf8137232aa9a9715f695c8";
		nixvim = {
        	url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nvimpkgs";
    	};
        home-manager = {
            url = "github:nix-community/home-manager/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
		stylix.url = "github:danth/stylix";
    };

    outputs = { nixpkgs, stylix, home-manager, ...}@inputs:
		let system = "x86_64-linux";
		in {
        nixosConfigurations = {
            pocket-os = nixpkgs.lib.nixosSystem {
                system = "${system}";
                
                modules = [
                    ./configuration.nix

					home-manager.nixosModules.home-manager
					stylix.nixosModules.stylix

					{
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "bkp";

            			home-manager.users.proggerx = ./home-config;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
					}

					./stylix
                ];
            };
		};
    };
}
