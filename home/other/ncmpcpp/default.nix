{ pkgs, ... }: {
	programs.ncmpcpp = {
		enable = true;
		package = pkgs.ncmpcpp.override {visualizerSupport = true;};
		settings = {
			lyrics_fetchers = "tags, plyrics";
			user_interface = "alternative";
		};
	};
}
