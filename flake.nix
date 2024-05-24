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
		ags.url = "github:Aylur/ags";
    };

    outputs = { self, nixpkgs, home-manager, ags, ...}@inputs:
		let system = "x86_64-linux";
		in {
        nixosConfigurations = {
            pocket-os = nixpkgs.lib.nixosSystem {
                system = "${system}";
                
                modules = [
                    ./configuration.nix

					home-manager.nixosModules.home-manager
          			{
            			home-manager.useGlobalPkgs = true;
            			home-manager.useUserPackages = true;
            			home-manager.backupFileExtension = "backup";

            			home-manager.users.proggerx = ./home-config/home.nix;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
          			}
                ];
            };
		};
    };
}
