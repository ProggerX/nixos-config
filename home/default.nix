{ sys, ... }: {
	home.username = "proggerx";
	home.homeDirectory = "/home/proggerx";

	imports = [
		./pkgs.nix
		./other
		./wm
		./shell
	];

	home.stateVersion = "24.11";

	programs.home-manager.enable = true;

	programs.git = {
		enable = true;
		userName = "ProggerX";
		userEmail = "x@proggers.ru";
		extraConfig = {
			user.signingKey = sys.age.secrets.pssh.path;
			commit.gpgsign = true;
			gpg.format = "ssh";
			init.defaultBranch = "master";
		};
	};
	programs.ssh = {
		enable = true;
		matchBlocks."*".identityFile = sys.age.secrets.pssh.path;
	};
}
