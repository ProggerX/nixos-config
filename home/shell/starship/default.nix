{ ... }: {
  programs.starship =
    {
      enable = true;
      settings = {
        # Other config here
        add_newline = true;
		lua.disabled = true;
		c.detect_extensions = ["cpp" "c" "h" "hpp"];
		character = {
			format = "\n$symbol ";
			success_symbol = "[󰁔](bold green)";
			error_symbol = "[󰁔](bold red)";
			vimcmd_symbol = "[vi](bold blue)";
		};
        format = "$all"; # Remove this line to disable the default prompt format
    };
	};
}
