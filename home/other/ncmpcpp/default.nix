{ pkgs, sys, ... }: {
	programs.ncmpcpp = {
		enable = true;
		package = if !sys.isLaptop then pkgs.ncmpcpp.override {visualizerSupport = true;} else pkgs.ncmpcpp;
		settings = {
			lyrics_fetchers = "tags, plyrics";
			user_interface = "alternative";
		};
	};
}
