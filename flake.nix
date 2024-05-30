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
		stylix.url = "github:danth/stylix";
    };

    outputs = { self, nixpkgs, stylix, home-manager, ags, ...}@inputs:
		let system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
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
            			home-manager.backupFileExtension = "backup";

            			home-manager.users.proggerx = ./home-config;
						
						home-manager.extraSpecialArgs = { inherit inputs; };
          			}

					{
						stylix.cursor = {
							name = "Catppuccin-Mocha-Lavender-Cursors";
							size = 35;
							package = pkgs.catppuccin-cursors.mochaLavender;
						};
						stylix.opacity = {
							terminal = 0.7;
							applications = 0.8;
						};
						stylix.fonts = {
							serif = {
								package = pkgs.dejavu_fonts;
								name = "DejaVu Serif";
							};
							sansSerif = {
								package = pkgs.nerdfonts;
								name = "JetBrainsMono Nerd Font";
    						};
							monospace = {
								package = pkgs.nerdfonts;
								name = "JetBrainsMono Nerd Font Mono";
							};
						};
						stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
						stylix.image = "/home/proggerx/walls/two.jpg";
					}
                ];
            };
		};
    };
}
