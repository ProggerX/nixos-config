{ pkgs, ... }: {
	programs.ncmpcpp = {
		enable = true;
		package = pkgs.ncmpcpp.override {visualizerSupport = true;};
		settings = {
			lyrics_fetchers = "tags, plyrics, jah-lyrics";
			user_interface = "alternative";
			visualizer_data_source = "localhost:5555";
		};
	};
}
