{ ... }: {
	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			lua.disabled = true;
			c.detect_extensions = ["cpp" "c" "h" "hpp"];
			format = "[](color_orange)$username[](bg:color_yellow fg:color_orange)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$docker_context$conda[](fg:color_bg3 bg:color_bg1)$time[ ](fg:color_bg1)$line_break$character";

			palette = "gruvbox_dark";
			palettes.gruvbox_dark.color_fg0 = "#fbf1c7";
			palettes.gruvbox_dark.color_bg1 = "#3c3836";
			palettes.gruvbox_dark.color_bg3 = "#665c54";
			palettes.gruvbox_dark.color_blue = "#458588";
			palettes.gruvbox_dark.color_aqua = "#689d6a";
			palettes.gruvbox_dark.color_green = "#98971a";
			palettes.gruvbox_dark.color_orange = "#d65d0e";
			palettes.gruvbox_dark.color_purple = "#b16286";
			palettes.gruvbox_dark.color_red = "#cc241d";
			palettes.gruvbox_dark.color_yellow = "#d79921";

			username.show_always = true;
			username.style_user = "bg:color_orange fg:color_fg0";
			username.style_root = "bg:color_orange fg:color_fg0";
			username.format = "[ $user ]($style)";
			
			directory.style = "fg:color_fg0 bg:color_yellow";
			directory.format = "[ $path ]($style)";
			directory.truncation_length = 3;
			directory.truncation_symbol = "…/";
			
			git_branch.symbol = "";
			git_branch.style = "bg:color_aqua";
			git_branch.format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
			
			git_status.style = "bg:color_aqua";
			git_status.format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
			
			nodejs.symbol = "";
			nodejs.style = "bg:color_blue";
			nodejs.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			c.symbol = " ";
			c.style = "bg:color_blue";
			c.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			rust.symbol = "";
			rust.style = "bg:color_blue";
			rust.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			golang.symbol = "";
			golang.style = "bg:color_blue";
			golang.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			php.symbol = "";
			php.style = "bg:color_blue";
			php.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			java.symbol = " ";
			java.style = "bg:color_blue";
			java.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			kotlin.symbol = "";
			kotlin.style = "bg:color_blue";
			kotlin.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			haskell.symbol = "";
			haskell.style = "bg:color_blue";
			haskell.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			python.symbol = "";
			python.style = "bg:color_blue";
			python.format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			
			docker_context.symbol = "";
			docker_context.style = "bg:color_bg3";
			docker_context.format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
			
			conda.style = "bg:color_bg3";
			conda.format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
			
			time.disabled = false;
			time.time_format = "%R";
			time.style = "bg:color_bg1";
			time.format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
			
			line_break.disabled = false;
			
			character.disabled = false;
			character.success_symbol = "[>](bold fg:color_green)";
			character.error_symbol = "[>](bold fg:color_red)";
			character.vimcmd_symbol = "[<](bold fg:color_green)";
			character.vimcmd_replace_one_symbol = "[<](bold fg:color_purple)";
			character.vimcmd_replace_symbol = "[<](bold fg:color_purple)";
			character.vimcmd_visual_symbol = "[<](bold fg:color_yellow)";
		};
	};
}
