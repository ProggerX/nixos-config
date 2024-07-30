{ ... }: {
	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			lua.disabled = true;
			c.detect_extensions = ["cpp" "c" "h" "hpp"];
		};
	};
}
