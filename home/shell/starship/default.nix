{ ... }: {
	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			lua.disabled = true;
			c.detect_extensions = ["cpp" "c" "h" "hpp"];
			character.disabled = false;
			character.success_symbol = "[󱞪](bold fg:color_green)";
			character.error_symbol = "[󱞪](bold fg:color_red)";
			character.vimcmd_symbol = "[](bold fg:color_green)";
			character.vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
			character.vimcmd_replace_symbol = "[](bold fg:color_purple)";
			character.vimcmd_visual_symbol = "[](bold fg:color_yellow)";
		};
	};
}
