{ ... }: {
	programs.kitty = {
		enable = true;
		settings = {
			cursor_trail = 3;
			enable_audio_bell = "no";
		};
	};
}
