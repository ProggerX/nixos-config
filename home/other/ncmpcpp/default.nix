{ ... }: {
	programs.ncmpcpp = {
		enable = true;
		settings = {
			lyrics_fetchers = "tags, justsomelyrics";
		};
	};
}
