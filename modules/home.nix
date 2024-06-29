{ inputs, ... }: {
	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.backupFileExtension = "old";

	home-manager.users.proggerx = ./home;
	
	home-manager.extraSpecialArgs = { inherit inputs; };
}
