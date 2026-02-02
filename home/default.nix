{ sys, ... }: {
	home.username = "proggerx";
	home.homeDirectory = "/home/proggerx";

	imports = [
		./pkgs.nix
		./other
		./wm
		./shell
	];

	home.stateVersion = "25.11";

	programs.home-manager.enable = true;

	programs.git = {
		enable = true;
		settings = {
			user.name = "ProggerX";
			user.email = "x@proggers.ru";
			user.signingKey = sys.age.secrets.pssh.path;
			commit.gpgsign = true;
			gpg.format = "ssh";
			init.defaultBranch = "master";
		};
	};
	programs.ssh = {
		enable = true;
		enableDefaultConfig = false;
		matchBlocks."*".identityFile = sys.age.secrets.pssh.path;
	};
}
